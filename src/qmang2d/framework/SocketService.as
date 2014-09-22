package qmang2d.framework
{
	import com.adobe.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import game.events.bus.GameBus;
	import game.service.CommandFactory;
	
	import qmang2d.framework.command.IIncomming;
	
	
	/**
	 * 单例，客户端socket通信，业务对象用json打包
	 * 
	 * 暂不考虑断线重连
	 * <p> 2013-3-5 上午10:33:59
	 */
	public class SocketService
	{
		private static var _instance :SocketService;
		
		protected  var _cmdCallBack :Array;
		
		//Socket建立传输控制协议 (TCP) 套接字连接
		private var _socket :Socket;
		
		//json解析方法
		private var _decode :Function;
		
		//json打包方法
		private var _encode :Function;
		
		//接受（发送）数据
		private var _data :ByteArray;
		
		//接受包的包长
		private var _dataLength :uint;
		
		//判断一个包是否读取完整，ture完整，false不完整
		private var _needReadHead:Boolean = true;
		
		//频率锁，申请后只有响应才能再次申请
		//private var _rateLock :Object;
		
		//接收事件集
		private var _receiveEvents :Object;
		
		//临时接收事件类型一
		private var _tFirstType :int;
		
		//临时接收事件类型二
		private var _tSecondType :int;
		
		//构造函数
		public function SocketService($singlton:SIngltonEnfocer)
		{
			if($singlton)
			{
				
				
				//JSON打包（解析）方法
				_decode = com.adobe.json.JSON.decode;
				_encode = com.adobe.json.JSON.encode;
				
				//发送（接收）数据临时容器
				_data = new ByteArray();
				_data.length = 255;
				
				_socket = new Socket();
				_cmdCallBack = [];
				
				_socket.addEventListener(Event.CONNECT, onConnectComplete);
				_socket.addEventListener(Event.CLOSE,onClose);
				_socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
				_socket.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
				_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
				
				//设置策略文件
				Security.loadPolicyFile("assets/core/crossdomain.xml");
				
				initEventRelated();
				
			}
		}
		
		public static function getInstance():SocketService
		{
			_instance ||= new SocketService(new SIngltonEnfocer());
			return _instance;
		}
		
		/**
		 * 增加一个Scommand监听（服务器向客户端派发）
		 * @param cmdId cmd代号id
		 * @param fun 回调的函数
		 * 
		 */		
		public function addCmdListener(cmdId:int, fun:Function):void
		{
			if (_cmdCallBack[cmdId] == null)
				_cmdCallBack[cmdId] = [];
			
			if (_cmdCallBack[cmdId].indexOf(fun) == -1)
				_cmdCallBack[cmdId].push(fun);
		}
		
		/**
		 * 移除一个Scommand监听
		 * @param cmdId cmd代号id
		 * @param fun 回调的函数
		 * 
		 */		
		public function removeCmdListener(cmdId:int, fun:Function):void
		{
			var len:int;
			var funs:Array = _cmdCallBack[cmdId];
			if (funs && funs.length > 0)
			{
				len = (funs.length - 1)
				while (len >= 0) 
				{
					if (fun == funs[len])
					{
						funs.splice(len, 1);
					}
					len--
				}
			}
		}
		
		/**
		 * 连接服务器
		 * @param ip
		 * @param port
		 */		
		public function connect(ip:String, port:int):void
		{
			trace("开始连接socket\n" +
				"IP：" + ip + " port：" + port, "SocketService");
			
			_socket.connect(ip, port);
			
		}
		
		//在建立网络连接后调度
		private function onConnectComplete(e:Event):void
		{
			trace("Socket 连接成功", "SocketService");
			
			CommandFactory.getIntance().bindAll();
			GameDispatcher.getInstance().dispatchEvent(new Event(GameBus.CONNECT_COMPLETE));
		}
		
		//在服务器关闭套接字连接时调度
		private function onClose(e:Event):void
		{
			trace("服务器关闭套接字", "SocketService");
			
			_socket.removeEventListener(Event.CONNECT,onConnectComplete);
			_socket.removeEventListener(Event.CLOSE,onClose);
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR,onIoError);
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		
		//在出现输入/输出错误并导致发送或加载操作失败时调度
		private function onIoError(e:IOErrorEvent):void
		{
			trace("IP / Port 出现错误信息", "SocketService");
			
			//dispatch(new Event(GameInitializeEvent.DISCONNECT));
		}
		
		/*若对 Socket.connect() 的调用尝试连接到调用方安全沙箱外部的服务器
		或端口号低于 1024 的端口，则进行调度*/
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			trace("调用尝试连接到调用方安全沙箱外部的服务器或端口号低于 1024 的端口", "SocketService");
			
			//dispatch(new Event(GameInitializeEvent.DISCONNECT));
		}
		
		//在套接字接收到数据后调度
		private function onSocketData(e:ProgressEvent):void
		{
			while(_socket.bytesAvailable)
			{
				if(_needReadHead)
				{
					_dataLength = _socket.readShort();
					_needReadHead = false;
				}
				
				if(!_needReadHead)
				{
					if(_socket.bytesAvailable >= _dataLength){//通过包长判断，保证数据交互正确
						_data.position = 0;
						_socket.readBytes(_data, 0, _dataLength);
						_data.position = 0;
						
						parseData();
						_needReadHead = true;
					}else{
						trace("未知包长:" + _socket.bytesAvailable,
							"SocketService", true);
						break;
					}
				}
			}
		}
		
		//解析数据
		private function parseData():void
		{
			_tFirstType = _data.readByte();
			//_tSecondType = _data.readByte();
			trace("收到包",_tFirstType);
			
			process(_tFirstType,_decode(_data.readUTFBytes(_dataLength-1)));
			
		}
		
		/**
		 *解析并发送数据 
		 * @param id1
		 * @param obj
		 * 
		 */		
		private function process(id1:uint,obj:Object):void
		{
			var incomme:IIncomming = CommandFactory.getIntance().getCommandMode(id1);
			if(null == incomme) return;
			
			//对象解析数据
			incomme.fill(obj);
			
			//开始回调函数
			riseCallback(id1, incomme);
		}
		
		
		private function riseCallback(id:int, incomme:IIncomming):void
		{
			var funs :Array = _cmdCallBack[id];
			for each (var fun:Function in funs) 
			{
				fun(incomme);
			}
		}
		
		/**
		 * 数据发送
		 * @param object 业务对象
		 * @param firstType 业务类型一
		 * @param secondType 业务类型二
		 */		
		public function sendJSON(object:Object,  secondType:int):void
		{
			//写入数据
			_data.position = 0;
			//_data.writeByte(firstType);
			_data.writeByte(secondType);
			object && _data.writeUTFBytes(_encode(object));//只是对发送的信息json编码，type和长度没有
			
			//写入socket，并发送
			_socket.writeShort(_data.position);//length
			_socket.writeBytes(_data, 0, _data.position);//byte(byte) byte(byte) utfbyte(reader.readline)
			_socket.flush();
			
			trace("发送包：", secondType);
		}
		
		//初始化事件相关
		private function initEventRelated():void
		{
		}
		
	}
}
internal class SIngltonEnfocer{}
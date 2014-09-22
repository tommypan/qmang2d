package  qmang2d.framework.command
{
	import flash.utils.*;
	
	import qmang2d.framework.SocketService;
	
	
	/**
	 *CCMD应被继承的父类，内置Socket对象,send方法必须重写 
	 * @author panhao
	 * 
	 */	
	public class OutgoingBase extends CommandBase implements IOutgoing
	{
		protected var _socket :SocketService;
		
		public function OutgoingBase(id1:uint)
		{
			super(id1);
			_socket = SocketService.getInstance();
		}
		
		
		/**
		 *发送数据至服务器 
		 * 
		 */	
		public function send():void
		{
		}
		
	}
}

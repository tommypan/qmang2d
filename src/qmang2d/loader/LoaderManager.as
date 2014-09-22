package qmang2d.loader
{
	
	import qmang2d.qmang2d;
	import qmang2d.cacher.SmartSourceCacher;
	import qmang2d.deng.fzip.FZip;
	import qmang2d.display.BitmapCacher;
	import qmang2d.display.BitmapFrameInfo;
	import qmang2d.display.BitmapMovie;
	import qmang2d.security.xml.SecurityTool;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	
	
	use namespace qmang2d;
	
	/**
	 * <p>提供简单方便的加载方法接口</p>
	 * <p>管理正在执行的加载工具</p>
	 * <p>管理资源缓存与释放</p>
	 * <p>限制同时在执行的加载工具数量</p>
	 * <p>待改进：缓存后的资源释放问题</p>
	 * <p>接口参数设置融合</p>
	 * <p>registerClassAlias进行amf编码</p>
	 * <p>changeSwfToBitmapMovie()	对很小的位图进行缩放，渲染效果不及原生movieClip。 ||已改进
	 *  最后因为找到了时缩放的原因导致的，所以这个问题解决</p>
	 * <p>bitmap测试内存释放，Co，So通过；movieClip测试内存释放，Co，So，动画播放通过；
	 * 资源模块加载以及进度展示通过；xml加载缓存通过；测试充分展现二进制储存占用内存小的好处</p>
	 * <p>共识：一个文件若先二进制加载然后才加载，这样一般只是对二进制加载进行进度显示</p>
	 * <p>不是所有资源都要先加载为二进制好，比如模块资源完全不需要先加载为二进制，直接用displayLoader更好（错，要考虑到安全沙箱的问题）</p>
	 * <p>其实在一般游戏里面就只有一个timer管理渲染及其跑图，业务逻辑。不过对时间要求高时就是通过心跳机制</p>
	 * <p>游戏不管玩多久，其内存做多也只是维持在一个水平，策略问题。包括即时跑图加载的地图，在一定范围外时也会dispose掉</p>
	 * <p>当会重复刷同样的怪时，要将其存入内存，其它的就没必要。然后在一张地图时，npc资源只是简单的移除掉，而后切换地图将其统一释放</p>
	 * @author as3Lover_ph
	 *@date 2013-1-22
	 */
	public class LoaderManager extends EventDispatcher
	{
		private static var _instance :LoaderManager;
		
		/**
		 *显示加载器 
		 */		
		private var _displayLoader :DisplayLoader;
		
		/**
		 *非显示加载器 ,一般用二进制
		 */		
		private var _bytesLoader :BytesLoader;
		
		/**资源库资源,仅为一个指向*/
		private var _cacher:SmartSourceCacher;
		
		/**对于已经在加载到加载域中的资源，此资源存储true或者false*/
		private var _swfPackDic :Dictionary;
		
		/**不能实例化此类，仅为一个指向*/
		private var _sharedObj :SharedObject;
		
		/**二进制加载链队列实例*/
		private var _bytesLoaderQueue :LoaderQueue;
		
		/**显示加载链队列实例*/
		private var _displayLoaderQueue :LoaderQueue;
		
		
		public function LoaderManager(singltonEnforcer:SingltonEnforcer)
		{
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				_bytesLoaderQueue = new LoaderQueue();
				_displayLoaderQueue = new LoaderQueue();
				
				_bytesLoader = new BytesLoader(_bytesLoaderQueue,_displayLoaderQueue);
				_displayLoader = new DisplayLoader(_displayLoaderQueue);
				
				
				_cacher = SmartSourceCacher.getInstance();
				_swfPackDic = new Dictionary();
				
				_sharedObj = _cacher.global;
				if(_sharedObj.data["ph"] != null)
				{
					trace("再次进入引擎---上次储存的资源是:"+_sharedObj.data["ph"]);
				}else{
					_sharedObj.data["ph"] = "欢迎来到中国钓鱼岛观光";
					trace("首次进入引擎");
				}
			}
			
		}  
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():LoaderManager
		{
			_instance ||= new LoaderManager( new SingltonEnforcer());
			return _instance;
		}
		
		/**
		 * 加载bitmap资源
		 * <p>注：当不需要bitmap资源释放资源时，请直接将调用其bitmapData.dispose()方法，这跟isCo_和isSo_没有影响</p>
		 *设置此方法参数请注意策略
		 * **************************************************************************************************
		 * @param url_ 资源地址
		 * @param $bitmap 已经实例（new）过的bitmap对象，传引用时，一定要先实例bitmap，否则会报错，里面不想加以判断
		 * @param isCo_ 是否存入内存(留个备份，方便相同资源下次申请以省去加载环节)，不一定要什么资源都存入资源库内存。
		 * 但是像几个模块经常用的图片就要存入，比如背包图片，技能图片等
		 * @param isSo_ 是否存在用户磁盘上，下次打开游戏以变直接从用户电脑磁盘读取数据。当然这得用户同意我存储才行
		 * @param isUseDefRe_ 是否使用默认资源
		 * 
		 */			
		public function getBitmap (url_:String,$bitmap:Bitmap,isCo_:Boolean=false,isSo_:Boolean=false,
								   isUseDefRe_:Boolean=false):void
		{
			if(isUseDefRe_)  $bitmap.bitmapData = _cacher.getValue("request.png") as BitmapData; // 默认资源为png，没必要进行大小缩放
			
			var node :LoaderQueueNode = new LoaderQueueNode();
			var nodeData :Object = node.data;
			
			nodeData.bitmap = $bitmap;
			nodeData.url = url_;
			
			nodeData.handleFun = handleBitmap;
			
			nodeData.type = LoaderType.BITMAP;
			nodeData.isCo = isCo_;
			nodeData.isSo = isSo_;
			
			if(_cacher.contain(url_)) //内存中查找
			{
				nodeData.bytesArray = _cacher.getValue(url_) as ByteArray;
				startDisplayLoader(node);
				
			}else if(_sharedObj.data[url_]){ //本地中查找(第二次进入游戏)
				
				nodeData.bytesArray = _sharedObj.data[url_] as ByteArray;
				startDisplayLoader(node);
				
			}else{ // 都没找到就加入到加载队列中
				
				_bytesLoaderQueue.enQueue(node);
				
				if(!_bytesLoader.isLoading)
					_bytesLoader.load(url_,tryBytesLoad);
			}
			
		}
		
		
		/**
		 * 加载影片剪辑（movieClip）
		 * <p> 注：缓存，cpu占用与资源释放问题已经经过一系列测试.安全，绿色，无污染，请放心使用</p>
		 * <p>如果想完全释放此bitmapMovie内存请调用bitmapMovie.recycle()方法并将bitmapMovie赋为null，这根isCo_和isSo_没有影响</p>
		 * 设置此方法参数请注意策略
		 * ******************************************************************************************************************
		 * @param url_资源地址 
		 * @param $container 已经实例（new）过的bitmapMovie对象，传引用时，一定要先实例bitmapMovie，否则会报错，里面不想加以判断
		 * @param isCo_是否存在内存(留个备份，方便相同资源下次申请省去加载环节)但是isCo有讲究，如果只是出现一次的movieClip资源不用存入内存留个备份，isSo_就更没必要了
		 * @param isSo_ 是否存在用户磁盘上，下次打开游戏以变直接从用户电脑磁盘读取数据。当然这得用户同意我存储才行
		 * @param isSaveFrameInfo_是否以帧形式存储，当希望得到资源一样的资源时，请将此参数设为true，下次申请资源时使用默认参数就行，引擎内部进行渲染优化
		 * @param $callBack 加载完成后的回调函数，当出现一样的资源在同一地方重复使用时，可以先加载一个资源，并且传入回调函数，这样在这个回调函数里面在去new 其它一样资源对象。这样比较高效，节省网络资源
		 * 
		 */		
		public function getMovieClip(url_:String,$container:BitmapMovie,isCo_:Boolean=false,//回调参数再想一下
									 isSo_:Boolean=false,isSaveFrameInfo_:Boolean=false,$callBack:Function=null):void
		{
			
			//可以直接返回一个
			
			var node :LoaderQueueNode = new LoaderQueueNode();
			var nodeData :Object = node.data;
			
			nodeData.container = $container;
			nodeData.url = url_;
			
			nodeData.callBack = $callBack;
			nodeData.handleFun = handleMovieClip;
			
			nodeData.type = LoaderType.MOVIECLIP;
			nodeData.isCo = isCo_;
			nodeData.isSo = isSo_;
			nodeData.isRepeatSource_ = isSaveFrameInfo_;
			
			if(_cacher.contain(url_) as ByteArray)//从内存中获取
			{
				nodeData.bytesArray = _cacher.getValue(url_) as ByteArray;
				startDisplayLoader(node);
				
			}else if(_cacher.getValue(url_) as Vector.<BitmapFrameInfo>){//渲染优化
				
				$container.frameInfo =  _cacher.getValue(url_) as Vector.<BitmapFrameInfo>;
				$container.lables =  _cacher.getValue(url_+'1') as Array;
				
			}else if(_sharedObj.data[url_]){//从上次游戏获取
				
				nodeData.bytesArray = _sharedObj.data[url_] as ByteArray;
				startDisplayLoader(node);
				
			}else{
				_bytesLoaderQueue.enQueue(node);
				
				if(!_bytesLoader.isLoading)
					_bytesLoader.load(url_,tryBytesLoad);
			}
			
		}
		
		/**
		 * 加载加密后的xml数据。文件暂定为ct格式即xx.ct。此文件格式请用xmlBulrEditor进行加密。具体用法：外部有示例
		 * @param url_资源地址
		 * @param $callBack回调函数
		 * @param isCo_是否资源库内存。有很多都是不用存入的
		 * @param isSo_是否存入用户磁盘
		 * 
		 */		
		public function getBlurXml(url_:String,$callBack:Function=null,isCo_:Boolean=false,isSo_:Boolean=false):void
		{
			
			if(_cacher.contain(url_)) 
			{
				if($callBack is Function)		parseBlurXml(_cacher.getValue(url_) as ByteArray,$callBack);
			}else if(_sharedObj.data[url_]){
				if($callBack is Function) 	parseBlurXml(_sharedObj.data[url_] as ByteArray,$callBack);
			}else{
				
				
				var node :LoaderQueueNode = new LoaderQueueNode();
				var nodeData :Object = node.data;
				
				nodeData.url = url_;
				nodeData.type = LoaderType.BLUR_XML;
				
				nodeData.callBack = $callBack;
				nodeData.handleFun = handleBlurXml;
				
				nodeData.isCo = isCo_;
				nodeData.isSo = isSo_;
				
				_bytesLoaderQueue.enQueue(node);
				//trace("加密后的xml被放入加载队列")
				
				if(!_bytesLoader.isLoading)
					_bytesLoader.load(url_,tryBytesLoad);
			}
		}
		
		/**
		 * 加载未加密的xml数据。主要方便前期快速开发，不用配置加密后的xml，到了后期，请使用getBLurXml方法
		 * @param url_资源地址
		 * @param $callBack回调函数
		 * @param isCo_是否资源库内存。有很多都是不用存入的
		 * @param isSo_是否存入用户磁盘
		 * 
		 */		
		public function getXml(url_:String,$callBack:Function=null,isCo_:Boolean=false,isSo_:Boolean=false):void
		{
			
			if(_cacher.contain(url_)) 
			{
				if($callBack is Function)		$callBack(new XML(_cacher.getValue(url_)));
			}else if(_sharedObj.data[url_]){
				if($callBack is Function) 	$callBack(new XML(_sharedObj.data[url_] ));
			}else{
				
				
				var node :LoaderQueueNode = new LoaderQueueNode();
				var nodeData :Object = node.data;
				
				nodeData.url = url_;
				nodeData.type = LoaderType.XML;
				
				nodeData.callBack = $callBack;
				nodeData.handleFun = handleXml;
				
				nodeData.isCo = isCo_;
				nodeData.isSo = isSo_;
				
				_bytesLoaderQueue.enQueue(node);
				//trace("xml被放入加载队列")
				
				if(!_bytesLoader.isLoading)
					_bytesLoader.load(url_,tryBytesLoad);
			}
		}
		
		
		/**
		 * <p>加载模块资源（swf中包含游戏音乐或者模块中的零碎图片）</p>
		 * <p>需要mp3资源时直接调用Soundmanager提供的接口就行</p>
		 * <p>模块加载的资源通常是一个功能模块的零碎资源，这样方便加载和管理。使用时将其加载进来。</p>
		 * 一般模块资源直接放在当期加载域当中，然后通过Reflection反射机制得到想要的资源
		 * ************************************************************************************************************************
		 * @param url资源地址
		 * @param $callBack回调函数。 可选参数，默认为否.可以提供预加载服务：即在游戏还没有用到某个模块时，先提前加载，但不传入回调函数，当需要加载时，直接调用此方法，传入函数解析模块
		 * 
		 */		
		public function getModualSwf(url_:String,$callBack:Function=null):void//待定
		{						
			if(_swfPackDic[url_] == true)
			{
				$callBack && $callBack();
			}else{
				
				var node :LoaderQueueNode = new LoaderQueueNode();
				var nodeData :Object = node.data;
				
				nodeData.url = url_;
				nodeData.type = LoaderType.MODUAL_SWF_RESOURCE;
				
				nodeData.callBack = $callBack;
				nodeData.handleFun = handleModualSWF;
				
				
				_bytesLoaderQueue.enQueue(node);
				// trace("swf模块资源被放入加载队列");
				
				if(!_bytesLoader.isLoading)
					_bytesLoader.load(url_,tryBytesLoad);
				
			}
		}
		
		
		/**
		 *将类反射取出后的影片剪辑转换为位图进行渲染 
		 * @param $movieClip待转换的影片剪辑
		 * @param isSaveFrameInfo_是否缓存帧信息
		 * @param key缓存的键
		 * @return 
		 * 
		 */		
		public function changeMcToBitmapMovie($movieClip:MovieClip,isSaveFrameInfo_:Boolean,key :String):BitmapMovie
		{
			var bitmapMovie :BitmapMovie = new BitmapMovie();
			if(_cacher.getValue(key) as Vector.<BitmapFrameInfo>)
			{
				bitmapMovie.frameInfo =  _cacher.getValue(key) as Vector.<BitmapFrameInfo>;
				bitmapMovie.lables = _cacher.getValue(key+'1') as Array;
				return bitmapMovie;
			}
			
			bitmapMovie.frameInfo = BitmapCacher.cacheBitmapMovie($movieClip);
			bitmapMovie.lables = $movieClip.currentLabels;
			
			if(isSaveFrameInfo_)
			{
				_cacher.add(key,bitmapMovie.frameInfo);
				_cacher.add(key+'1',bitmapMovie.lables);
				bitmapMovie.url = key;
			}
			
			return bitmapMovie;
		}
		
		/**开启displayLoader加载*/
		private function startDisplayLoader(node :LoaderQueueNode):void
		{
			_displayLoaderQueue.enQueue(node);
			
			if(!_displayLoader.isLoading)
				_displayLoader.loadBytes(node.data.bytesArray,tryDisplayLoad);
		}
		
		/**加载完bitmap资源后的回调*/
		private function handleBitmap($node:LoaderQueueNode,$bmpd:BitmapData):void
		{
			var nodeData :Object = $node.data;
			nodeData.bitmap.bitmapData = $bmpd;
			
			if(nodeData.isCo)	
				_cacher.add(nodeData.url,nodeData.bytesArray);
			if(nodeData.isSo)	
				_sharedObj.data[nodeData.url] = nodeData.bytesArray;
			
			$node.data = null;
			$bmpd = null;
		}		
		
		/**加载完movieClip之后的回调*/
		private function handleMovieClip($node:LoaderQueueNode,$mc:MovieClip):void
		{
			
			$node.data.container.frameInfo = BitmapCacher.cacheBitmapMovie($mc);
			$node.data.container.lables = $mc.currentLabels;//如果不存在labels则为[]
			
			var nodeData :Object = $node.data;
			
			if(nodeData.isRepeatSource_)
			{
				if(nodeData.isCo)	
				{
					_cacher.add(nodeData.url,$node.data.container.frameInfo);
					_cacher.add(nodeData.url+'1',$node.data.container.lables);
				}
			}else{
				if(nodeData.isCo)	
					_cacher.add(nodeData.url,nodeData.bytesArray);
				if(nodeData.isSo)	
					_sharedObj.data[nodeData.url] = nodeData.bytesArray;
			}
			$mc = null;
		}
		
		/**加载完模块资源后的回调*/
		private function handleModualSWF($node:LoaderQueueNode):void
		{
			_swfPackDic[$node.data.url] = true;
			
		}
		
		/**加载完xml资源后的回调*/
		private function handleXml($node:LoaderQueueNode):void
		{
			var nodeData :Object = $node.data;
			
			var callBack :Function = nodeData.callBack;
			if(callBack != null) callBack(new XML(nodeData.data));
			
			if(nodeData.isCo)	
				_cacher.add(nodeData.url,nodeData.data);
			
			if(nodeData.isSo)	
				_sharedObj.data[nodeData.url] = nodeData.data;
			
		}
		
		/**加载完加密后的xml资源后的回调*/
		private function handleBlurXml($node:LoaderQueueNode):void
		{
			var nodeData :Object = $node.data;
			
			
			var bytesArray :ByteArray = SecurityTool.decode(nodeData.data);
			
			parseBlurXml(bytesArray,nodeData.callBack);
			
			if(nodeData.isCo)	
				_cacher.add(nodeData.url,bytesArray);
			
			if(nodeData.isSo)	
				_sharedObj.data[nodeData.url] = bytesArray;
			
		}
		
		private function parseBlurXml(bytesArray :ByteArray,callBack:Function=null):void
		{
			if(callBack != null)
			{
				bytesArray.position = 0;
				var head:uint=bytesArray.readShort();
				if(head == 0x504B)
				{
					var xmlZip :FZip = new FZip();
					xmlZip.addEventListener(Event.COMPLETE,onComplete);
					xmlZip.loadBytes(bytesArray);
					
					function onComplete(event:Event):void
					{
						xmlZip.removeEventListener(Event.COMPLETE, onComplete);
						callBack(xmlZip);
					}		
				}else{
					throw new IllegalOperationError("请使用加密后的xml配置文件");
				}
			}
		}
		
		/**
		 *每次当一个资源加载完成后都应该执行此函数判断是否还有加载对象 
		 * 
		 */		
		private function tryDisplayLoad():void
		{
			if(_displayLoaderQueue.length>0)
			{				
				
				var bytesArray :ByteArray = _displayLoaderQueue.getFirstNode().data.bytesArray;
				_displayLoader.loadBytes(bytesArray,tryDisplayLoad);
				
			}
		}
		
		
		
		
		/**
		 *每次当一个资源二进制加载完成后都应该执行此函数判断是否还有二进制加载对象 
		 * 
		 */		
		private function tryBytesLoad():void
		{
			if(!_displayLoader.isLoading)	tryDisplayLoad();
			
			
			if(_bytesLoaderQueue.length>0) 
			{
				var firstNodeData :Object = _bytesLoaderQueue.getFirstNode().data;
				// trace("继续二进制加载资源");
				_bytesLoader.load(firstNodeData.url,tryBytesLoad);
			}
			
		}
		
		//*************************************** function over *******************************
	}  
}  
internal class SingltonEnforcer{}

package qmang2d.loader
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import qmang2d.qmang2d;
	import qmang2d.protocol.EnhancedProgressEvent;
	
	use namespace qmang2d;
	
	/**
	 * 和资源服务器进行通信
	 *@author as3Lover_ph
	 *@date 2013-1-22
	 */
	public class BytesLoader
	{
		
		private var _urlLoader :URLLoader;
		
		private var _urlRequest :URLRequest;
		
		/**此回调函数是加载完一个资源后对资源显示，数据使用设定的函数*/
		//private var _callBack :Function;
		
		/**此回调函数是加载完某个资源后，要判断链队列是否还有加载元素*/
		private var _tryLoad :Function;
		
		private var _bytesQueue :LoaderQueue;
		
		private var _displayQueue :LoaderQueue;
		
		private var _isLoading : Boolean;
		
		
		
		public function BytesLoader($queueInstance:LoaderQueue,$displayLoaderQueue:LoaderQueue)
		{
			_bytesQueue = $queueInstance;
			_displayQueue = $displayLoaderQueue;
			_urlLoader = new URLLoader();
			_urlRequest = new URLRequest();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE, onLoadedComplete);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onHandleError);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS,  onHandleProgress);
		}
		
		
		public function load(url_ :String,$tryLoad:Function,context :LoaderContext=null):void
		{
			_urlRequest.url = url_;
			_urlLoader.load(_urlRequest);
			_isLoading = true;
			_tryLoad  = $tryLoad;
			
		}
		
		public function dispose ():void
		{
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onHandleError);
			_urlLoader.removeEventListener(Event.COMPLETE, onLoadedComplete);
			_urlLoader.removeEventListener(ProgressEvent.PROGRESS,  onHandleProgress);
			_urlLoader = null;
			_urlRequest = null;
		}
		
		public function onLoadedComplete(event:Event):void
		{
			_isLoading = false;
			
			var firstNode :LoaderQueueNode = _bytesQueue.deQueue();
			var firstNodeData :Object = firstNode.data;
			
			if(firstNodeData.type == LoaderType.BLUR_XML || firstNodeData.type == LoaderType.XML)
			{
				firstNodeData.data = event.target.data as ByteArray;
				firstNodeData.handleFun(firstNode);
				
			}else{

				firstNodeData.bytesArray = event.target.data as ByteArray;
				_displayQueue.enQueue(firstNode);
				//trace("RESOURCE弹出URLLoader加载队列，被放入Loader加载队列");
			}
			_tryLoad();
		}
		
		public function onHandleError(event:IOErrorEvent):void
		{
			throw new Error("加载资源异常，其地址为："+_urlRequest.url);
			//以后游戏肯定就用下面的方法处理异常，测试时，使用上面，直接抛出错误
			
			//Test.instance.traceShowLog("加载资源异常，其地址为："+_urlRequest.url);
			//LoaderQueue.getInstance().deQueue();
			//_tryLoad();
			
		}
		
		protected function onHandleProgress(event:ProgressEvent):void
		{
			if(_urlRequest.url.indexOf('?') != -1)
			{
				
				_urlRequest.url = _urlRequest.url.slice(0,_urlRequest.url.indexOf('?'));
			}
		
			//trace("我正在努力加载"+_describtion+"资源,已经加载了"+event.bytesLoaded/event.bytesTotal);
			LoaderManager.getInstance().dispatchEvent( new EnhancedProgressEvent(ProgressEvent.PROGRESS,_urlRequest.url,false,false,event.bytesLoaded,event.bytesTotal));
		}
		
		public function get isLoading():Boolean
		{
			return _isLoading;
		}
		
		
	}
}
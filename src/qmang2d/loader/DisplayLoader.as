package qmang2d.loader
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import qmang2d.qmang2d;
	
	use namespace qmang2d;
	
	/**
	 * 和资源服务器进行通信
	 *@author as3Lover_ph
	 *@date 2013-1-22
	 */
	public class DisplayLoader
	{
		private var _loader :Loader;
		
		private var _urlRequest:URLRequest;
		
		
		/**此回调函数是加载完一个资源后对资源显示，数据使用设定的函数*/
		//private var _callBack :Function;
		
		/**此回调函数是加载完某个资源后，要判断链队列是否还有加载元素*/
		private var _tryLoad :Function;
		
		
		private var _defaultContext:LoaderContext;
		
		private var _context :LoaderContext;
		
		
		private var _displayQueue :LoaderQueue;
		
		private var _isLoading : Boolean;
		
		public function DisplayLoader($displayLoaderQueue:LoaderQueue)
		{
			_loader = new Loader();
			_urlRequest = new URLRequest();
			_displayQueue = $displayLoaderQueue;
			_defaultContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			_defaultContext.allowCodeImport = true;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onHandleError);
			
		}
		
		
		
		public function loadBytes(bytes_ :ByteArray,$tryLoad:Function):void
		{
			_isLoading = true;
			_loader.loadBytes(bytes_,_defaultContext);
			_tryLoad = $tryLoad;
		}
		
		public function dispose ():void
		{
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onHandleError);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadedComplete);
			_loader = null;
			_urlRequest = null;
		}
		
		public function onLoadedComplete(event:Event):void
		{
			var loadedData :*;
			var firstNode :LoaderQueueNode = _displayQueue.deQueue();
			var firstNodeData :Object = firstNode.data;
			_isLoading = false;
			
			if(firstNodeData.type == LoaderType.BITMAP)
			{
				loadedData = event.target.content["bitmapData"] as BitmapData;
				firstNodeData.handleFun(firstNode,loadedData);
				//trace("Bitmap弹出Loader加载器");
				
			}else if(firstNodeData.type == LoaderType.MOVIECLIP){
				
				loadedData = event.target.content as MovieClip;
				firstNodeData.handleFun(firstNode,loadedData);
				if(firstNodeData.callBack!=null)  firstNodeData.callBack();//callBack和handleFun位置不能换
				//trace("MovieClip弹出Loader加载器");
				
			}else if(firstNodeData.type == LoaderType.MODUAL_SWF_RESOURCE){
				
				firstNodeData.handleFun(firstNode);
				if(firstNodeData.callBack!=null)  firstNodeData.callBack();
				//trace("ModualSWF弹出Loader加载器");
				
			} 
			_tryLoad();
			
		}
		
		
		public function onHandleError(event:IOErrorEvent):void
		{
			throw new Error("加载资源异常，其地址为："+_urlRequest.url);
			
			//以后游戏肯定就用下面的方法处理异常，测试时，使用上面，直接抛出错误
			
			//Test.instance.traceShowLog("加载资源异常，其地址为："+_urlRequest.url);
			//_queueInstance.deQueue();
			//_tryLoad();
		}
		
		protected function onHandleProgress(event:ProgressEvent):void
		{
			//trace("我正在努力加载"+_describtion+"资源,已经加载了"+event.bytesLoaded/event.bytesTotal);
			// 等UI写好了，直接传入参数让其显示出来
		}
		
		public function get isLoading():Boolean
		{
			return _isLoading;
		}
		
		
	}
}
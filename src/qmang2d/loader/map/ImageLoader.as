package qmang2d.loader.map
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import qmang2d.protocol.VersionManager;
	
	/**
	 * 地图加载器，地图加载较为简单且考虑到加载优先级问题。所以不用使用较为重量级的LoaderManager.
	 * <p>使用方法，由于地图加载要求加载速度较快，这个时候。外部可以用数组Array或者Dictionary存放，在外部加一个new一个
	 * 当加载完毕后。一定要对加载器各种监听及时进行释放</p>
	 *@author as3Lover_ph
	 *@date 2013-3-12
	 */
	public class ImageLoader extends Loader
	{
		private var _path :String;
		private var _callBack :Function;
		
		public function ImageLoader(path_:String,$callBack :Function=null)
		{
			_path = path_;
			_callBack = $callBack;
			
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError)
		}
		
		/**
		 *加载地图数据 
		 * 
		 */		
		public function loadData():void
		{
			load(new URLRequest( VersionManager.encode(_path)));
		}
		
		/**
		 *重置加载 。注：并没有移除监听等
		 * 
		 */		
		public function reset():void
		{
			unload();
			_path = null;
			_callBack = null;
		}
		
		private function onComplete(event:Event):void
		{
			if(_callBack !=null)
				_callBack();
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			trace("地图资源加载出错");
		}
		
	}
}
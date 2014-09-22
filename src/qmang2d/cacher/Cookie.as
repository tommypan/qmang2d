package qmang2d.cacher
{
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	
	/**
	 * 这个类主要是以后通过SO方法做一些缓存（一般就存储String等较简单的类型）
	 * <p>功能类似于浏览器的cookie，记录一些信息。当用户第二次登录时有用，关闭打开音乐，修炼时间记录，好友名字记录</p>
	 *@author as3Lover_ph
	 *@date 2013-3-6
	 */
	public class Cookie
	{
		
		private var _so:SharedObject;
		
		/**
		 *设置cookie名 ，程序会根据cookie名得到相应的sharedObject，这样可以在此cookie下面通过键值获取相应的值
		 * @param cookieName_ cookie名字
		 * 
		 */		
		public function Cookie(cookieName_:String)
		{
			if (cookieName_ == "")
			{
				throw new Error("name must not be empty!!!");
			}
			
			_so = SharedObject.getLocal(cookieName_,'/');//允许级别最高
			_so.addEventListener(NetStatusEvent.NET_STATUS, handler);
		}
		
		private function handler(param1:NetStatusEvent) : void
		{
		}
		
		/**
		 *存入cookie资源 
		 * @param name_ cookie key值
		 * @param value_ 欲存入的资源
		 * 
		 */		
		public function setCookie(name_:String, value_:Object) : void
		{
			//if(SmartSourceCacher.getInstance().isAllowSo)//防止那个无聊的面板
			//{
			var name:String = name_;
			var value:Object = value_;
			
			try
			{
				_so.data[name] = value;
				_so.flush();
			}catch (e:Error){
			}
			
			//}
		}
		
		/**
		 *通过索引得到cookie值 
		 * @param name_
		 * @return 
		 * 
		 */		
		public function getCookie(name_:String) : Object
		{
			return _so.data[name_];
		}
		
		/**
		 *清理cookie，若不传入参数，则为深度清理，清理所有cookie资源 
		 * @param name_
		 * 
		 */		
		public function clear(name_:String = "") : void
		{
			if (name_)
			{
				_so.data[name_] = "";
			}else{
				_so.clear();
			}
		}
		
		/**
		 *是否包含该索引的cookie资源 
		 * @param name_
		 * @return 
		 * 
		 */		
		public function contains(name_:String):Boolean{
			return (_so.data[name_]);
		}
		
	}
}
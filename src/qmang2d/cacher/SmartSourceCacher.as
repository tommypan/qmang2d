package qmang2d.cacher 
{
	import flash.display.*;
	import flash.errors.*;
	import flash.events.NetStatusEvent;
	import flash.net.*;
	import flash.system.*;
	
	import qmang2d.cacher.interfaces.ICacher;
	import qmang2d.utils.ClassManager;
	
	/**
	 * 资源库缓存器，具有内存和本地储存功能.组合使用了LocalCacher。单例
	 *@author as3Lover_ph
	 *@date 2013-2-22
	 */	
	public class SmartSourceCacher implements ICacher
	{
		private var _cacher:ICacher;
		
		private static var _instance:SmartSourceCacher;
		
		public var global:SharedObject;
		
		public function SmartSourceCacher($singltonEnforcer:SingltonEnforcer)
		{
			if(!$singltonEnforcer)
			{
				
				throw new IllegalOperationError("不能直接实例化SmartSourceCacher类");
				
			}else{
				try
				{
					// 获取外存
					global = SharedObject.getLocal("phResCQUPT2013");
					global.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusHandler);
					global.flush(10000000000);
					_cacher = new LocalCacher();
				}catch (e:Error){
					
				}
				
			}
		}
		
		protected function onNetStatusHandler(event:NetStatusEvent):void
		{
			var codeInfo :String = event.info.code;
			
			if(codeInfo == "SharedObject.Flush.Success")
			{
				trace("用户允许在其计算机上存储信息");
				
			}else if(codeInfo == "SharedObject.Flush.Failed"){
				
				trace("用户不允许在其计算机上存储信息");
			}
			
			
		}
		
		/**
		 *获得单例 
		 * @return SmartSourceCacher 
		 * 
		 */
		public static function getInstance() : SmartSourceCacher
		{
			_instance ||= new SmartSourceCacher( new SingltonEnforcer())
			return _instance;
		}
		
		public function add(key_:Object,value_:Object, fun:Function = null) : void
		{
			_cacher.add(key_, value_, fun);
			return;
		}
		
		public function getValue(key:Object) : Object
		{
			return _cacher.getValue(key);
		}
		
		/**
		 * 开始进入游戏时，会预加载一些资源，比如：ui皮肤资源等
		 * <p>此方法就是获取已经加载进游戏的bitmapData资源</p>
		 * @param key bitMapData键值
		 * @param applicationDomain ApplicationDomain
		 * @return 若有则直接返回值，没有就创造一个实例，并存入内存
		 * 
		 */		
		public function getPreloadBitmapData(key:String, applicationDomain:ApplicationDomain = null) : BitmapData
		{
			var bitmapData:BitmapData = _cacher.getValue(key) as BitmapData;
			
			if (bitmapData)
				return bitmapData;
			
			bitmapData = ClassManager.createBitmapDataInstance(key, applicationDomain);
			add(key, bitmapData);
			
			return bitmapData;
		}
		
		public function remove(key:Object) : void
		{
			_cacher.remove(key);
			return;
		}
		
		public function deleteAll() : void
		{
			_cacher.deleteAll();
			return;
		}
		
		public function contain(key:Object) : Boolean
		{
			return _cacher.contain(key);
		}
		
		
		
	}
}
internal class SingltonEnforcer{}

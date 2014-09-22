package qmang2d.utils {
	import flash.display.*;
	import flash.system.*;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 反射机制
	 * <p>注：模块资源默认放在当前加载域当中</p>
	 * @author as3Lover_ph
	 * 
	 */	
	public class ClassManager {
		
		/**
		 * 当资源加载进来时，通常用此方法返回值最后强制转换为Sprite，若只获取bitmapData而不想其成为
		 * 较重量级的Sprite，请使用createBitmapDataInstance方法
		 * @param name_
		 * @param applicationDomain
		 * @return 
		 * 
		 */		
		public static function createDisplayObjectInstance(name_:String, applicationDomain:ApplicationDomain=null):DisplayObject
		{
			return ((createInstance(name_, applicationDomain) as DisplayObject));
		}
		
		/**
		 *创造实例，一般用于获取加载域中的声音 
		 * 一般不直接使用，使用SoundManager的提供的方法就行
		 * @param name_
		 * @param applicationDomain
		 * @return 
		 * 
		 */		
		public static function createInstance(name_:String, applicationDomain:ApplicationDomain=null):*
		{
			var obj:*;
			var $class:Class = getClass(name_, applicationDomain);
			if ($class)
			{
				obj = new ($class)();
				
				//因为获取的资源不是矢量图，没必要进行位图缓存。否则，内存会增大，而且，没做一次位图变化
				//都会进行重绘渲染。内存与cpu都得不偿失
				if (obj is Sprite)
					(obj as Sprite).cacheAsBitmap = false;
				
				return (obj);
			};
			return (null);
		}
		
		/**
		 *得到BitmapData实例 
		 * @param name_Bitmap绑定的名字
		 * @param applicationDomain加载域，如果为null，则加载到全局域中
		 * @return 如果存在返回bitmapData，不存在则返回null
		 * 
		 */		
		public static function createBitmapDataInstance(name_:String, applicationDomain:ApplicationDomain=null):BitmapData
		{
			var $class:Class = getClass(name_, applicationDomain);
			
			if ($class)
				return new $class(0, 0);
			return null;
		}
		
		/**
		 *得到加载域中类，一般直接用于组件中皮肤。注意：前提是已经被放到相应加载域中才能获取
		 * @param name_
		 * @param applicationDomain
		 * @return 
		 * 
		 */		
		public static function getClass(name_:String, applicationDomain:ApplicationDomain=null):Class
		{
			if (!applicationDomain)
				applicationDomain =ApplicationDomain.currentDomain;
			
			var $class:Class = (applicationDomain.getDefinition(name_) as Class);
			return ($class);
		}
		
		/**
		 *通过类的对象获取类全名 
		 * @param value 对象
		 * @return 类全名
		 * 
		 */		
		public static function getFullClassName(value:Object):String{
			return (getQualifiedClassName(value));
		}
		
		
	}
}

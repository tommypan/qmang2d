package qmang2d.utils {
	import flash.utils.*;
	
	/**
	 * 深度克隆对象，由于as3采用了不同于c++的引用参数传递机制，
	 * 此类主要为深度克隆比如数组等，返回一个全新的对象
	 * <p> ps:我就在这上面遭了一次，害的我逃课找了一天bug(-_-)
	 * @author as3Lover_ph
	 * 
	 */	
	public class CloneObject 
	{
		
		/**
		 *深度克隆数组，由于as采用的是引用传递，所以这里提供一个深度克隆方法，克隆后的数组与原数组没有影响 
		 * @param arr 待克隆的数组
		 * @return 克隆后得到的数组
		 * 
		 */		
		public static function deepCopyArr(arr:Array):Array
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(arr);
			byteArray.position = 0;
			var cloneArray:Array = (byteArray.readObject() as Array);
			return (cloneArray);
		}
		
		/**
		 *深度克隆数组，由于as采用的是引用传递，所以这里提供一个深度克隆方法，克隆后的数组与原数组没有影响 
		 * <p>在利用多态转型的情况下，还是很有用的
		 * @param vec 待克隆的数组
		 * @return 克隆后得到的数组
		 * 
		 */		
		public static function deepCopyVec(vec:Vector.<Object>):Vector.<Object>
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(vec);
			byteArray.position = 0;
			var cloneArray: Vector.<Object> = (byteArray.readObject() as Vector.<Object>);
			return (cloneArray);
		}
		
		/**
		 *深度克隆对象 
		 * @param source 对象
		 * @return 克隆后得到的对象
		 * 
		 */		
		public static function deepCloneObject(source:Object):Object
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(source);
			byteArray.position = 0;
			return(byteArray.readObject());
		}
		
	}
}

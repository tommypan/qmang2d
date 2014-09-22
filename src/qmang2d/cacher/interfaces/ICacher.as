package qmang2d.cacher.interfaces
{
	/**
	 *@author as3Lover_ph
	 *@date 2013-2-22
	 */	
	public interface ICacher
	{
		public function ICacher();
		
		/**
		 * 增加一个资源
		 * @param key_键
		 * @param value_值
		 * @param fun回调函数
		 * 
		 */		
		function add(key_:Object,value_:Object, fun:Function = null):void;
		
		/**
		 * 移除一个资源
		 * @param key_键
		 * 
		 */		
		function remove(key_:Object):void;
		
		/**
		 * 从资源库中取出一个资源
		 * @param key_键
		 * 
		 */		
		function getValue(key_:Object):Object;
		
		/**
		 * 是否包含此资源
		 * @param key_键
		 * 
		 */		
		function contain(key_:Object):Boolean;
		
		/**
		 *删除所有，深度清理 
		 * 
		 */		
		function deleteAll() : void;
	}
}
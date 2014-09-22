package qmang2d.cacher
{
	import flash.utils.*;
	
	import qmang2d.cacher.interfaces.ICacher;
	
			
	
	/**
	 * 吸收了迭代器模式
	 * <p>基本缓存类。此类类似于HashMap，但是在其它地方想使用此功能时，个人建议直接使用Dictionary更为方便快捷。</p>
	 *@author as3Lover_ph
	 *@date 2013-2-22
	 */	
	public class LocalCacher implements ICacher
	{
		private var _dic:Dictionary;
		
		public function LocalCacher()
		{
			this._dic = new Dictionary();
			return;
		}
		
		public function add(key_:Object,value_:Object, fun:Function = null) : void
		{
			this._dic[key_] = value_;
			if (fun != null)
			{
				fun();
			}
			return;
		}
		
		public function getValue(key_:Object):Object
		{
			return this._dic[key_];
		}
		
		public function remove(key:Object) : void
		{
			this._dic[key] = null;
			delete this._dic[key];
			return;
		}
		
		public function deleteAll() : void
		{
			var _loc_1:Object = null;
			for (_loc_1 in this._dic)
			{
				
				this._dic[_loc_1] = null;
			}
			this._dic = new Dictionary();
			return;
		}
		
		public function contain(key_:Object):Boolean
		{
			return this._dic.hasOwnProperty(key_);
		}
		
	}
}

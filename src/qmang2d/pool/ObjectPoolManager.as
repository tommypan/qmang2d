package qmang2d.pool
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	
	/**
	 * 对对象池进行管理
	 *@author as3Lover_ph
	 *@date 2013-3-30
	 */
	public class ObjectPoolManager
	{
		private static var _instance :ObjectPoolManager;
		
		/**
		 * 对象池字典,键为类，值为相应对象池
		 * */
		private var _objectPoolDict:Dictionary;
		
		public function ObjectPoolManager($singlton :singltonEnforcer)
		{
			if(!$singlton)
				throw new IllegalOperationError("这是单例");
			else
			{
				_objectPoolDict = new Dictionary();
			}
		}
		
		public static function getInstance():ObjectPoolManager
		{
			_instance ||= new ObjectPoolManager(new singltonEnforcer());
			
			return _instance;
		}
		
		/**
		 * 得到相应对象池 
		 * @param $class索引键
		 * @param initAmount_对象池初始化容量
		 * @param growupAmount_对象池对象单位增长容量
		 * @return 返回一个对象池
		 * 
		 */		
		public function getObjectPool($class:Class,initAmount_:int=3, growupAmount_:int=1):ObjectPool
		{
			
			
			if (!_objectPoolDict[$class])	_objectPoolDict[$class] = new ObjectPool($class,initAmount_,growupAmount_);
			
			var objPool:ObjectPool;
			objPool = _objectPoolDict[$class];
			
			return (objPool);
		}
		
		/**
		 *移除相应对象池 
		 * @param $class 索引键
		 * 
		 */		
		public function removeObjectPool($class:Class):void
		{
			if (_objectPoolDict[$class])
			{
				var objPool:ObjectPool;
				objPool = this._objectPoolDict[$class];
				delete this._objectPoolDict[$class];
			}
		}
		
		
	}
}
internal class singltonEnforcer{}
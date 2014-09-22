package  qmang2d.pool
{
	import flash.utils.*;
	
	import qmang2d.pool.interfaces.IPool;
	
	/**
	 * 对象池，不同的对象应该实例化不同的对象池，然后通过ObjectPoolManager统一进行管理
	 * @author as3Lover_ph
	 * 
	 */	
	public class ObjectPool
	{
		
		private var _objectDict:Dictionary;
		
		/**
		 * 对象池中储存的对象线性表
		 * */
		private var _objectList:Array;
		
		/**
		 * 种子类，即这个对象池对应的对象类
		 * */
		private var _seedClass:Class;
		
		/**
		 * 对象池初始化容量
		 * */
		private var _initAmount:int;
		
		/**
		 * 对象池对象单位增长容量
		 * */
		private var _growupAmount:int;
		
		
		public function ObjectPool($seedClass:Class, initAmount_:int=3, growupAmount_:int=1)
		{
			_objectList = new Array();
			_seedClass = $seedClass;
			_initAmount = initAmount_;
			_growupAmount = growupAmount_;
			_objectDict = new Dictionary(true);
			
			createInstance(_initAmount);
		}
		
		/**
		 *通过实例的参数得到对象
		 * <p>借用对象 
		 * @param objParams 实例参数
		 * @return 
		 * 
		 */		
		public function getObject(objParams:Object=null):IPool
		{
			if (length == 0)
			{
				createInstance(_growupAmount);//没有了就先造默认个对象
			}
			var obj:IPool = (_objectList.pop() as IPool);
			return (obj);
		}
		
		/**
		 * 对象池当中的对象用完后就调用此方法归还对象。这个不是清理，清理调用clear方法，此方法会始终在对象池中存有一定对象
		 * <p>还回对象
		 * @param obj 对象
		 * 
		 */		
		public function releaseObject(obj:IPool):void
		{
			if (_objectList.indexOf(obj) != -1)//如果有就直接返回，如果对象池中没有对象了就存入
			{
				return;
			}
			_objectList.push(obj);
		}
		
		
		/**
		 *释放对象池所有资源 
		 * 
		 */		
		public function clear():void
		{
			var key:*;
			for (key in _objectDict)
				delete _objectDict[key];
			
			_objectList.length = 0;
		}
		
		/**
		 *创造实例 
		 * @param gownAmount 允许增长数
		 * 
		 */		
		private function createInstance(gownAmount:int):void
		{
			var object:IPool;
			var index:int;
			while (index < gownAmount) 
			{
				object = new _seedClass();
				_objectList.push(object);
				index++;
			}
		}
		
		//------------------华丽的分割线，读写器-----------------
		public function get length():uint
		{
			return (_objectList.length);
		}
		
		
	}
} 

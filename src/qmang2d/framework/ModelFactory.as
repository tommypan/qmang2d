package qmang2d.framework
{
	import flash.utils.Dictionary;

	/**
	 *模型工厂 
	 * @author panhao
	 * 
	 */	
	public class ModelFactory
	{
		private static var _instance:ModelFactory;
		private var _modelDic :Dictionary;
		
		public function ModelFactory($singltonEnforcer:singltonEnforcer)
		{
			if($singltonEnforcer)
				_modelDic = new Dictionary();
		}
		
		public  static function getInstance():ModelFactory
		{
			_instance ||= new ModelFactory(new singltonEnforcer());
			return _instance;
		}
		
		/**
		 *获取模型工厂里面的实例 
		 * @param clazz 模型类的引用
		 * @return 相应对象
		 * 
		 */		
		public function getModelInstance(clazz:Class):Object
		{
			var obj :Object;
			
			if(_modelDic[clazz])
			{
				obj = _modelDic[clazz]
			}else{
				obj = new clazz();
				_modelDic[clazz] = obj;
			}
			
			return obj;
		}
		
		
	}
}
class singltonEnforcer{}
package  game.model.vo
{
	/**
	 *不用定义成动态类，一般不需要再运行过程中添加新的属性 
	 * @author panhao
	 * 
	 */	
	public class MonsterVo
	{
		/**
		 *id号 
		 */		
		public var id :int;
		
		/**
		 *类型 
		 */		
		public var type :int;
		
		/**
		 *等级 
		 */		
		public var level :int;
		
		/**
		 *波数 
		 */		
		public var wave :int;
		
		/**
		 *时间 
		 */		
		public var time :Number=0;
		
		/**
		 *线路id。通过lineId确定二位数组下标 
		 */		
		public var lineId :int;
		
		/**
		 *血量 
		 */		
		public var blood :Number=0;
		
		/**
		 *行走速度 
		 */		
		public var speed :Number=0;
		
		/**
		 *攻击力 
		 */		
		public var attackPower :Number=0;
		
		/**
		 *防御力 
		 */		
		public var defencePower :Number=0;
		
		/**
		 *类反射姓名 
		 */		
		public var reflectName :String;
		
		/**
		 *当前状态 
		 */		
		public var state :String;
		
		/**
		 * 描述
		 */		
		public var describe :String;
		
		public var isFlying :Boolean;
		
		/**
		 *死亡后获得的金钱 
		 */		
		public var money :int;
		
		//不采用object传值方式了。object效率偏低，且太松藕容易出错		
		public function MonsterVo()
		{
			
		}
		
	}
}
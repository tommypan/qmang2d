package game.model.vo
{
	import flash.geom.Point;
	
	import game.view.monster.Monster;
	
	public class TowerVo
	{
		/**
		 *id 
		 */		
		public var id :int;
		
		/**
		 *类型 
		 */		
		public var type :String;
		/**
		 *等级 
		 */		
		public var level :int;
		
		/**
		 *攻击范围 
		 */		
		public var attackRadius :Number = 0;
		
		/**
		 *攻击力最大值 
		 */		
		public var attackPowerMax :int;
		
		/**
		 *攻击力最小值 
		 */		
		public var attackPowerMin :int;
		
		/**
		 *建造时间 
		 */		
		public var buildTime :Number = 0;
		
		/**
		 *升级金钱 
		 */		
		public var bootMoney :int;
		
		
		/**
		 *冷却时间 
		 */		
		public var coolTime :int;
		
		
		//public var towerPoint :Point;
		
		/**
		 *是否攻击飞行怪物 
		 * <p>0代表false，1代表true
		 */		
		public var isAttackFlying :int;
		
		/**
		 *攻击所暂时绑定的怪物 
		 */		
		public var bindMonster :Monster;
		
//		/**
//		 * 攻击所暂时绑定的怪物 2
//		 * <p>针对弓箭手有效和士兵
//		 */		
//		public var bindMonster2 :Monster;
//		
//		/**
//		 * 攻击所暂时绑定的怪物 2
//		 * <p>针对士兵有效
//		 */		
//		public var bindMonster3 :Monster;
		
		/**
		 *士兵攻击范围，针对士兵有效 
		 */		
		public var soilderAttackRadius :Number=0;
		
		/**
		 *士兵防御值，针对士兵有效 
		 */		
		public var soilderDefencePower :int=0;
		
		public function TowerVo()
		{
			
		}
	}
}
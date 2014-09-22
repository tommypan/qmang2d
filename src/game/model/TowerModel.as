package game.model
{
	import game.model.vo.TowerVo;
	
	import org.robotlegs.mvcs.Actor;
	
	import qmang2d.loader.LoaderManager;
	
	public class TowerModel extends Actor
	{
		/**
		 *通过塔的类型，等级确定其属性
		 */		
		public var towerVos :Vector.<TowerVo>;
		
		public function TowerModel()
		{
			LoaderManager.getInstance().getXml("res/commom/tower.xml",onInitModel);
		}
		
		private function onInitModel(xml:XML):void
		{
			var towerVo :TowerVo;
			towerVos = new Vector.<TowerVo>();
			
			for each (var i:XML in xml.item) 
			{
				towerVo = new TowerVo();
				towerVo.type = i.@type;
				towerVo.level = i.level;
				towerVo.attackRadius = i.attackRadius;
				towerVo.attackPowerMax = i.attackPowerMax;
				towerVo.attackPowerMin = i.attackPowerMin;
				towerVo.buildTime = i.buildTime;
				towerVo.bootMoney = i.bootMoney1;
				towerVo.coolTime = i.coolTime;
				towerVo.isAttackFlying = i.isAttackFlying;
				towerVos.push(towerVo);
			}
			
			//for (var j:int = 0; j < towerVos.length; j++) 
			//{
			//trace("towerVos:",towerVos[j].type,towerVos[j].level,towerVos[j].coolTime);
			//}
			
		}
		
		
	}
}
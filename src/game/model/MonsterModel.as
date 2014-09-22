package  game.model
{
	import game.model.vo.MonsterVo;
	
	import org.robotlegs.mvcs.Actor;
	
	import qmang2d.loader.LoaderManager;
	
	public class MonsterModel extends Actor
	{
		/**
		 *通过monsterId和等级确定其属性 
		 */		
		public var monsterVos :Vector.<MonsterVo>;
		
		public function MonsterModel()
		{
			LoaderManager.getInstance().getXml("res/commom/monster.xml",onInitModel);
		}
		
		private function onInitModel(xml:XML):void
		{
			var monsterVo :MonsterVo;
			monsterVos = new Vector.<MonsterVo>();
			
			for each (var i:XML in xml.item) 
			{
				monsterVo = new MonsterVo();
				
				monsterVo.type = i.@type;
				monsterVo.level = i.level;
				monsterVo.blood = i.bllod;//配置文件写错了(-.-)
				monsterVo.attackPower = i.attckPower;
				monsterVo.describe = i.describe;
				monsterVo.speed = i.speed;
				monsterVo.reflectName = i.reflectName;
				monsterVo.money = i.money;
				
				(i.isflying == 0) ? (monsterVo.isFlying = false) :
					(monsterVo.isFlying = true);
				monsterVos.push(monsterVo);
			}
			
		}
		
		
	}
}
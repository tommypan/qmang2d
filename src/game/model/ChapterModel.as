package game.model
{
	import game.model.vo.MonsterVo;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 经过数据匹配后的每章信息
	 * @author panhao
	 * @date 2013-7-31
	 */	
	public class ChapterModel extends Actor
	{
		/**进行匹配后(通过id和level进行匹配)每一关怪物详细信息配置*/
		public var monsterChapterVos :Vector.<MonsterVo> = new Vector.<MonsterVo>();
		
		public function ChapterModel()
		{
			
		}
		
		/**
		 * 增加一个EnemyVo
		 * @param $enemyVo
		 * 
		 */		
		public function addEnemy($monsterVo :MonsterVo):void
		{
			this.monsterChapterVos.push($monsterVo);
		}
		
		
		/**
		 * 清理所有EnemyChapterVo
		 * 
		 */		
		public function removeAll():void
		{
			var len :int =  monsterChapterVos.length;
			for (var i:int = 0; i < len; i++) 
			{
				monsterChapterVos.pop();
			}
			
		}
		
		//		/**
		//		 * 根据索引得到EnemyVo
		//		 * @param id索引
		//		 * @return 
		//		 * 
		//		 */		
		//		public function getEnemyChapterVo_id(id:String):EnemyVo
		//		{
		//			for each(var enemyVo:EnemyVo in enemyChapterVos)
		//			{
		//				if(enemyVo.id == id)
		//				{
		//					return enemyVo;
		//				}
		//			}
		//			return null;
		//		}
		//		
		//		/**
		//		 * 遍历返回每个EnemyChapterVo属性
		//		 * @return EnemyChapterVo
		//		 * 
		//		 */		
		//		public function getEnemyChapterVo():EnemyVo
		//		{
		//			for each(var enemyVo:EnemyVo in enemyChapterVos)
		//			{
		//				return enemyVo;
		//			}
		//			return null;
		//		}
		
		
		/**
		 *获得敌军数量 
		 * @return 敌军数量 
		 * 
		 */		
		public function getLength():int
		{
			return monsterChapterVos.length;
		}
		
		
	}
}
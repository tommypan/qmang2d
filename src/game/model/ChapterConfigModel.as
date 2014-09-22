package game.model
{
	import flash.geom.Point;
	
	import game.model.vo.ChapterMonsterVo;
	import game.model.vo.ChapterPlayerVo;
	import game.model.vo.PointVo;
	
	import org.robotlegs.mvcs.Actor;
	
	import qmang2d.loader.LoaderManager;
	
	/**
	 *每一个关卡应该拥有的配置信息。包括：每关的怪物配置，每关的玩家原始资源信息 
	 * @author panhao
	 * 
	 */	
	public class ChapterConfigModel extends Actor
	{
		/**
		 *第一章怪物配置信息 
		 * <p>索引值，线路id
		 */		
		public var chap1s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第二章怪物配置信息 
		 * <p>索引值，线路id
		 */		
		public var chap2s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第三章怪物配置信息 
		 * <p>索引值，线路id
		 */		
		public var chap3s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第四章怪物配置信息 
		 * <p>索引值，线路id
		 */		
		public var chap4s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第五章怪物配置信息
		 * <p>索引值，线路id 
		 */		
		public var chap5s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第六章怪物配置信息
		 * <p>索引值，线路id 
		 */		
		public var chap6s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第七章怪物配置信息
		 * <p>索引值，线路id 
		 */		
		public var chap7s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第八章怪物配置信息
		 * <p>索引值，线路id 
		 */		
		public var chap8s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第九章怪物配置信息
		 * <p>索引值，线路id 
		 */		
		public var chap9s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第十章怪物配置信息
		 * <p>索引值，线路id 
		 */		
		public var chap10s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第十一章怪物配置信息
		 * <p>索引值，线路id 
		 */		
		public var chap11s :Vector.<ChapterMonsterVo>;
		
		/**
		 *第十二章怪物配置信息
		 * <p>索引值，线路id 
		 */		
		public var chap12s :Vector.<ChapterMonsterVo>;
		
		
		/**
		 *每关玩家的原始资源 
		 * <p>索引值，chap
		 */		
		public var chapPlayers :Vector.<ChapterPlayerVo>;
		
		public function ChapterConfigModel()
		{
			LoaderManager.getInstance().getXml("res/chapterConfig/chapterPlayer.xml",onCPC);
			LoaderManager.getInstance().getXml("res/chapterConfig/chapterMonster.xml",onCMC);
		}
		
		private function onCPC(xml:XML):void
		{
			var chapterPlayerVo :ChapterPlayerVo;
			chapPlayers = new Vector.<ChapterPlayerVo>();
			
			for each (var i:XML in xml.item) 
			{
				chapterPlayerVo = new ChapterPlayerVo();
				
				chapterPlayerVo.chap = i.@chap;
				chapterPlayerVo.wave = i.@wave;
				chapterPlayerVo.life = i.@life;
				chapterPlayerVo.money = i.@money;
				
				chapPlayers.push(chapterPlayerVo);
			}
			
		}
		
		private function onCMC(xml:XML):void
		{
			
			chap1s = new Vector.<ChapterMonsterVo>();
			chap2s = new Vector.<ChapterMonsterVo>();
			chap3s = new Vector.<ChapterMonsterVo>();
			chap4s = new Vector.<ChapterMonsterVo>();
			chap5s = new Vector.<ChapterMonsterVo>();
			chap6s = new Vector.<ChapterMonsterVo>();
			chap7s = new Vector.<ChapterMonsterVo>();
			chap8s = new Vector.<ChapterMonsterVo>();
			chap9s = new Vector.<ChapterMonsterVo>();
			chap10s = new Vector.<ChapterMonsterVo>();
			chap11s = new Vector.<ChapterMonsterVo>();
			chap12s = new Vector.<ChapterMonsterVo>();
			
			
			for each (var i:XML in xml.chapter) 
			{
				
				switch(int(i.@id))//记住一定要int转型，除非在if语句中==比较时，会默认转型。swich，case不支持
				{
					case 1:
					{
						commom(chap1s,i);
						
						break;
					}
					case 2:
					{
						commom(chap2s,i);
						break;
					}
					case 3:
					{
						commom(chap3s,i);
						break;
					}
					case 4:
					{
						commom(chap4s,i);
						break;
					}
					case 5:
					{
						commom(chap5s,i);
						break;
					}
					case 6:
					{
						commom(chap6s,i);
						break;
					}
					case 7:
					{
						commom(chap7s,i);
						break;
					}
					case 8:
					{
						commom(chap8s,i);
						break;
					}
					case 9:
					{
						commom(chap9s,i);
						break;
					}
					case 10:
					{
						commom(chap10s,i);
						break;
					}
					case 11:
					{
						commom(chap11s,i);
						break;
					}
					case 12:
					{
						commom(chap12s,i);
						break;
					}
						
				}
				
			}
			
		}
		
		private function commom(chaps:Vector.<ChapterMonsterVo>, i:XML):void
		{
			var id :int;
			
			var chapterMonsterVo :ChapterMonsterVo;
			for each (var j:XML in i.item) 
			{
				chapterMonsterVo = new ChapterMonsterVo();
				
				chapterMonsterVo.wave = j.@wave;
				chapterMonsterVo.lineId = j.@lineId;
				chapterMonsterVo.time = j.@time;
				chapterMonsterVo.monsterType = j.@monsterType;
				chapterMonsterVo.monsterLevel = j.@monsterLevel;
				chapterMonsterVo.id = id;
				id++;
				chaps.push(chapterMonsterVo);
			}
			
		}		
		
		
	}
}
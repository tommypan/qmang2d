package game.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class PlayerModel extends Actor
	{
		/**
		 *已经打过关卡数 
		 */		
		public var finishMapNum :int;
		
		/**
		 *成就 
		 */		
		public var achivements :int;
		
		/**
		 * 每关的星星数量
		 */		
		public var chapterStarNum :Vector.<int>;
		
		public function PlayerModel()
		{
		}
	}
}
package qmang2d.protocol
{
	import flash.events.KeyboardEvent;
	
	import qmang2d.utils.StageProxy;

	/**
	 * 全局键盘事件管理
	 *@author as3Lover_ph
	 *@date 2013-3-12
	 */
	public class KeyBoardManager
	{
		public function KeyBoardManager()
		{
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler);
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler);
		}
		
		protected function keyUpHandler(event:KeyboardEvent):void
		{
			
		}
		
		protected function keyDownHandler(event:KeyboardEvent):void
		{
			
		}
		
		/**
		 *注册键盘相应事件 
		 * 
		 */		
		public static function registerEvent():void
		{
			
		}
		
		
	}
}
package qmang2d.utils
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	
	/**
	 * ...
	 * @author aser_ph
	 */
	public class KeyBoardControl
	{
		private static var code:uint;
		private static var KeyAry:Array = new Array();
		public function KeyBoardControl()
		{
			
		}
		
		public static function register():void
		{
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
		}
		
		public static function unRegister():void
		{
			StageProxy.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			StageProxy.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			KeyAry = [];
		}
		
		
		public static function onKeyDown(evt:KeyboardEvent):void
		{
			code = evt.keyCode;
			//trace("按下了" + code);
			KeyAry[code] = true;
		}
		
		
		public static function onKeyUp(evt:KeyboardEvent) :void
		{
			KeyAry[evt.keyCode] = [];
			TimerManager.getInstance().add(100,clearKeyUp);
			function clearKeyUp():void
			{
				KeyAry[evt.keyCode] = false;
				TimerManager.getInstance().remove(clearKeyUp);
				
			}		
		}
		
		
		public static function isDown(KeyCode:uint):Boolean
		{
			return KeyAry[KeyCode] == true;
		}
		
		public static function isUp(KeyCode:uint):Boolean
		{
			if(KeyAry[KeyCode] == [])
				return false;
			else if(KeyAry[KeyCode] == false)
				return true;
			else
				return false;
		}
	}
	
}
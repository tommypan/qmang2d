package qmang2d.debug.watcher 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	
	/**
	 * 程序运行时帧数、内存信息显示，结合了开源Stats类.自身占6.8m左右。ms：间隔毫秒数
	 *how to use?
	 * Fps.setup(this);   Fps.visible = true;
	 * 
	 * how to hide or show it? 
	 * shift & D
	 @author kaka
	 *ph修改于 2013-1-25
	 */
	public class Fps
	{
		
		static private var _stats:Stats;
		static private var _target:DisplayObjectContainer;
		
		static public function setup(target:DisplayObjectContainer):void
		{
			
			_target = target;
			
			_stats = new Stats();
			
			if (_target.stage != null)
			{
				
				start();
				
			}else{
				
				_target.addEventListener(Event.ADDED_TO_STAGE, start);
				
			}
			
		}
		
		static public function set visible(value:Boolean):void
		{
			
			if (value)
			{
				_target.addChild(_stats);
			}else{
				if (_stats.parent != null)
					_stats.parent.removeChild(_stats);
			}
			
		}
		
		static public function get visible():Boolean
		{
			
			return _target.contains(_stats);
			
		}
		
		static private function start(evt:Event = null):void
		{
			
			_target.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			
		}
		
		static private function onKeyDownHandler(evt:KeyboardEvent):void
		{
			
			if (evt.shiftKey && evt.keyCode == Keyboard.D)
			{
				
				visible = !visible;
				
			}
			
		}
		
	}
	
}
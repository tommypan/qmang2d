package qmang2d.utils
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * 心跳机制。隔一定时间做相应的事，计时精确
	 *@author aser_ph
	 *@date 2013-4-17
	 */
	public class HeartBeat
	{
		private var _timeStep :uint = 0;
		private var _lastTime :int = 0;
		private var _callBack :Function;
		private var _timeEnforcer :Shape;
		private var _delay :int;
		
		/**
		 * 
		 * @param delay_	时间间隔 ms
		 * @param $callBack 回调
		 * 
		 */		
		public function HeartBeat(delay_:int, $callBack:Function)
		{
			_lastTime = getTimer();
			_delay = delay_;
			_callBack = $callBack;
			if(!_timeEnforcer)_timeEnforcer = new Shape();
			_timeEnforcer.addEventListener(Event.ENTER_FRAME, onheartBeat);
		}
		
		protected function onheartBeat(event:Event):void
		{
			_timeStep++;
			if(_timeStep == 3)
			{
				if(getTimer() - _lastTime > _delay)
				{
					_callBack();
					_lastTime = getTimer();
				}
				
				_timeStep = 0;
			}
			
			
		}
		
		
	}
}
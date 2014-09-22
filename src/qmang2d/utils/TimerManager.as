package qmang2d.utils {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	/**
	 * timer管理器，针对游戏中出现多个timer极难操作与管理且造成timer内存难以回收，这里统一起来进行管理
	 * todo 可以考虑时间回收，不一定马上垃圾回收，每次都要实例浪费资源
	 *@author as3Lover_ph
	 *@date 2013-2-12
	 */
	public class TimerManager {
		
		private static var _instance:TimerManager = null;
		
		/**
		 * timer字典，键为时间，值为timer
		 * */
		private var _timerDic:Dictionary;
		
		/**
		 * 函数与timer映射字典，键为函数，值为timer
		 * */
		private var _funcToTimerDic:Dictionary;
		
		/**
		 * 函数字典，键为时间，值为函数顺序表
		 * */
		private var _funcListDic:Dictionary;
		
		public function TimerManager(){
			this._timerDic = new Dictionary();
			this._funcToTimerDic = new Dictionary();
			this._funcListDic = new Dictionary();
		}
		
		/**
		 * 得到单例
		 * */
		public static function getInstance():TimerManager{
			if (_instance == null){
				_instance = new (TimerManager)();
			};
			return (_instance);
		}
		
		/**
		 *增加一个时间触发器 
		 * @param time 间隔时间单位毫秒
		 * @param $fun 回调函数
		 * 
		 */		
		public function add(time:int, $fun:Function):void{
			if (this._funcToTimerDic[$fun] != undefined)
				return;
			
			this._funcToTimerDic[$fun] = this.createTimer(time);
			this._funcListDic[time].push($fun);
		}
		
		
		/**
		 *移除一个时间触发器 
		 * @param $fun 相对应的函数引用
		 * 
		 */		
		public function remove($fun:Function):void{
			if (this._funcToTimerDic[$fun] == undefined)
				return;
			
			var timer:Timer = this._funcToTimerDic[$fun];
			delete this._funcToTimerDic[$fun];
			
			var array:Array = this._funcListDic[timer.delay];
			//哨兵
			var index : int = array.indexOf($fun);
			if (index > -1) 	array.splice(index, 1);
			
			if (array.length == 0)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, this.timerHandler);
				delete this._funcListDic[timer.delay];
				delete this._timerDic[timer.delay];
			};
		}
		
		/**
		 * 
		 * @param time  间隔时间单位毫秒
		 * @return timer
		 * 
		 */		
		private function createTimer(time:int):Timer{
			var timer:Timer;
			if (this._timerDic[time] == undefined)
			{
				timer = new Timer(time);
				timer.addEventListener(TimerEvent.TIMER, this.timerHandler);
				timer.start();
				this._timerDic[time] = timer;
			};
			
			if (this._funcListDic[time] == undefined) this._funcListDic[time] = new Array();
			
			return (this._timerDic[time]);
		}
		
		/**
		 * 时间触发处理函数
		 * @param evt ---------不用解释了
		 * 
		 */		
		private function timerHandler(evt:TimerEvent):void{
			var array:Array = this._funcListDic[Timer(evt.target).delay];
			var len:int = (array.length - 1);
			while (len >= 0) 
			{
				if (array[len] != null)  array[len]();
				len--;
			};
		}
		//----------------------------- function over --------------------------------
		
	}
}

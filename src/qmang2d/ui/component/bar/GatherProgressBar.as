package qmang2d.ui.component.bar
{
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	
	import game.view.core.res.ResManager;
	import game.view.ui.ViewFilter;

	/**
	 * 采集面板 
	 * @author Administrator
	 * 
	 */	
	public class GatherProgressBar extends PercentageBar
	{
		private var _bgShape:Shape = new Shape();
		private var _timer:Timer = new Timer(100);
		private var _timerRepeatCount:uint = 50;
		//回调函数
		private var _completeFunction:Function ;
		
		public function GatherProgressBar()
		{			
//			stage.scaleMode = StageScaleMode.NO_SCALE;
			

			_bgShape.graphics.lineStyle(2,0x72C8CB,1,true);
			_bgShape.graphics.beginFill(0x053D4F);
			_bgShape.graphics.drawRoundRect(0,0,200,14,12,12);
			_bgShape.graphics.endFill();
			_bgShape.y = 25;
			addChild(_bgShape);
			
			_bgShape = new Shape();
			var matr:Matrix = new Matrix();
			matr.createGradientBox(190,20,0,0,0);
			_bgShape.graphics.beginGradientFill(GradientType.LINEAR,[0x74C3CD,0x74C3CD,0x74C3CD],[0,0.7,0],[0,135,255],matr);
			_bgShape.graphics.drawRect(0,0,200,20);
			_bgShape.graphics.endFill();
			_bgShape.x = 5;
			addChild(_bgShape);
			
			super(0,0,11.5,200,[0x17CE03,0x149D02,0x17CE03],0);
			percentbar.x = 1;
			percentbar.y = 26;
			shape.y = 26;
			shape.x = -199;
			
			var rightCloud:Bitmap = new Bitmap();
			ResManager.getInstance().getJPG("resources/ui/baseui/window2.png",rightCloud);
			rightCloud.x = 181;
			rightCloud.y = 23;
			addChild(rightCloud);
			var leftCloud:Bitmap = new Bitmap();
			ResManager.getInstance().getJPG("resources/ui/baseui/window1.png",leftCloud);
			leftCloud.x=-10;			
			leftCloud.y = 23;
			addChild(leftCloud);
			
			
			textformat.size = 15;
			show.defaultTextFormat = textformat;
			showTxt = "采集中...";
			show.textColor = 0xffffff;
//			_show.x = 80;
			show.y = 2;
			show.filters = [ViewFilter.textGlow];
			this.y = 100;
			
			_timer.repeatCount = _timerRepeatCount;
			_timer.addEventListener(TimerEvent.TIMER , onC);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE , onTimerC);
			_timer.start();
		}
		
		private function onTimerC( e:TimerEvent ):void
		{
			if ( _completeFunction != null )
				_completeFunction();
		}
		
		private function onC( e:TimerEvent ):void
		{
			shape.x += 200/_timerRepeatCount;
		}
		/**
		 *传入timer执行完毕时的回调函数 
		 * @param value
		 * 
		 */		
		public function set completeFunction( value:Function ):void
		{
			_completeFunction = value;
		}
		/**
		 *重置进度条 
		 */		
		public function reset():void
		{
			_timer.reset();
			shape.x = -199;
		}
		/**
		 *开始进行。 
		 * 
		 */		
		public function star():void
		{
			_timer.start();
		}
		/**
		 *传入timer的循环次数 
		 * @param value
		 * 
		 */		
		public function set timerRepeatCount(value:uint):void
		{
			_timer.repeatCount  = value;
		}
		/**
		 *传入文本字符串。 
		 * @param value
		 * 
		 */		
		public function set showTxt( value:String ):void
		{
			show.text = value;
			show.x = (200-show.width)/2
		}
		
		override public function clear():void
		{
			super.clear();
			_bgShape.graphics.clear();
			removeChild(_bgShape);
			_bgShape = null;
			
			var shape:Shape = Shape(getChildAt(0));
			shape.graphics.clear();
			removeChild(shape);
			shape = null;
		}
	}
}
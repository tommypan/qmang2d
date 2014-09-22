package  qmang2d.protocol
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/** 
	 * 加载资源等待场景
	 * 
	 * <p> 2013-3-9 下午2:37:38
	 */
	public class LoadingScene  extends Sprite
	{
		private static var _allowInstance :Boolean;
		
		public static var instance :LoadingScene;
		
		//显示条
		protected var _showLayer :Sprite;
		//显示条遮盖层
		protected var _maskLayer :Sprite;
		//显示条渐变色数组
		protected var _colors :Array;
		
		//当前已加载百分比
		private var _textCurrentPercentage :TextField;
		//当前加载资料信息
		private var _textCurrentContent :TextField;
		
		public function LoadingScene()
		{
			addChild(_textCurrentPercentage = new TextField());
			addChild(_textCurrentContent = new TextField());
			addChild(_showLayer = new Sprite());
			addChild(_maskLayer = new Sprite());
			_showLayer.mask = _maskLayer;
			_colors = new Array(0x04A484, 0x036854, 0x0F9F86);

		}
		
		/**
		 *注册单例，使用时直接使用instance属性 
		 * 
		 */		
		public static function registerInstance():void
		{
			if(!_allowInstance)
			{
				instance = new LoadingScene();
				_allowInstance = true;
			}
		}
		
		/**
		 * 绘制矩形进度条
		 */
		public function drawProgressBar(width:int, height:int, colors:Array=null):void
		{
			//当前已加载百分比
			_textCurrentPercentage.text = "已加载：0%";
			_textCurrentPercentage.textColor = 0x00868B;
			_textCurrentPercentage.width = width;
			_textCurrentPercentage.height = 20;
			_textCurrentPercentage.autoSize = TextFieldAutoSize.LEFT;
			_textCurrentPercentage.selectable = false;
			
			//当前加载资料信息
			_textCurrentContent.width = width;
			_textCurrentContent.height = 20;
			_textCurrentContent.textColor = 0x00868B;
			_textCurrentContent.autoSize = TextFieldAutoSize.RIGHT;
			_textCurrentContent.selectable = false;
			
			drawRoundRectBar(0, 20, width, height, true, colors);
			_maskLayer.x =  x + 4 - _maskLayer.width;
		}
		private function drawRoundRectBar(x:int, y:int, width:int, height:int, frame:Boolean, colors:Array=null):void
		{
			colors && (_colors = colors);
			
			if(frame)
			{
				graphics.lineStyle(2,0x8AB8B3,1,true);
				graphics.beginFill(0x053D4F);
				graphics.drawRoundRect(x, y, width+2, height+2.5,12,12);
				graphics.endFill();
			}
			
			
			//显示条
			var matrix :Matrix = new Matrix();
			matrix.createGradientBox(width, height, Math.PI*0.5, 0, 3);
			_showLayer.graphics.lineStyle(0,0x111111,.5,true);
			_showLayer.graphics.beginGradientFill(GradientType.LINEAR,_colors,[1,1,1],[0,135,255],matrix );
			_showLayer.graphics.drawRoundRect(0,0,width,height,10,10);
			_showLayer.graphics.endFill();
			_showLayer.x = x + 1;
			_showLayer.y = y + 1.25;
			
			//显示条遮盖层
			_maskLayer.graphics.beginFill(0x000000);
			_maskLayer.graphics.drawRoundRect(0, 0, width, height, 10, 10);
			_maskLayer.graphics.endFill();
			_maskLayer.x = x + 1 - _maskLayer.width;
			_maskLayer.y = y + 1.25;
		}
		
		/**
		 * 设置当前加载内容
		 */
		public function setContent(content:String):void
		{
			_textCurrentContent.text = content;
		}
		/**
		 * 给一个百分比 
		 * @param percent
		 * 
		 */		
		public function update(percent:Number):void
		{
			percent < 0 ? percent = 0 : (percent > 1 && (percent = 1));
			_maskLayer.x = 1 - _maskLayer.width * (1 - percent);
			
			_textCurrentPercentage.text = "已加载：" + int(percent * 100) + "%";
		}
		/**
		 *清除 
		 */		
		public function clear():void
		{
			graphics.clear();
			removeChild(_showLayer);
			_showLayer.mask = null;
			_showLayer.graphics.clear();
			_showLayer = null;
			removeChild(_maskLayer);
			_maskLayer.graphics.clear();
			_maskLayer = null;
			_colors = null;
			
			removeChild(_textCurrentContent);
			_textCurrentContent = null;
			
			removeChild(_textCurrentPercentage);
			_textCurrentPercentage = null;
		}
	}
}

package qmang2d.ui.component.bar
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	/**
	 * （显示对象）显示条基础类
	 */
	public class BaseBar extends Sprite
	{
		//显示条
		protected var _showLayer :Sprite;
		//显示条遮盖层
		protected var _maskLayer :Sprite;
		//显示条渐变色数组
		protected var _colors :Array;
		
		/**
		 * 创建新的显示条实例
		 */
		public function BaseBar()
		{
			addChild(_showLayer = new Sprite());
			addChild(_maskLayer = new Sprite());
			_showLayer.mask = _maskLayer;
			_colors = new Array(0x04A484, 0x036854, 0x0F9F86);
		}
		
		/**
		 * 绘制显示比例条
		 * @param x :int                 显示条x坐标
		 * @param y :int                 显示条y坐标
		 * @param width :int             显示条宽度
		 * @param height :int            显示条高度
		 * @param frame :Boolean         是否要绘制边框
		 * @param colors :Vector.<uint>  显示条渐变色数组（3个值），默认[0x04A484, 0x036854, 0x0F9F86]
		 */
		protected function drawRoundRectBar(x:int, y:int, width:int, height:int, frame:Boolean, colors:Array=null):void
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
		 * 更新比例显示条
		 * @param percent :Number 当前显示比例小数
		 */
		public function update(percent:Number):void
		{
			percent < 0 ? percent = 0 : (percent > 1 && (percent = 1));
			_maskLayer.x = 1 - _maskLayer.width * (1 - percent);
		}
		
		/**
		 * 清理
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
		}
		
		/**
		 * <只写>设置显示条渐变色，暂只支持绘制先设置，不支持绘制后设置
		 */
		public function set colors(value:Array):void
		{
			_colors = value;
		}
		
		/**
		 * 是否要显示边框
		 */
		public function set frame(value:Boolean):void
		{
			if(value){
				this.graphics.lineStyle(2, 0x000000);
				this.graphics.drawRoundRect(x, y, _showLayer.width+2, _showLayer.height+2, 10, 10);
			}else{
				this.graphics.clear();
			}
		}
	}
}
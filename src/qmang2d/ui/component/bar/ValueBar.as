/*
待解决，红蓝条使用数值分数显示
*/
package qmang2d.ui.component.bar
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * 数值比例条，可用于血条，蓝条，经验条
	 */
	public class ValueBar extends BaseBar
	{
		//当前数值
		private var _currValue :int;
		//最大数值
		private var _maxValue :int;
		//当前已加载百分比
		private var _textCurrentPercentage :TextField;
		
		/**
		 * 创建新的数值比例条实例
		 */
		public function ValueBar()
		{
			super();
			addChild(_textCurrentPercentage = new TextField());
		}
		
		/**
		 * 绘制数值比例条
		 */
		public function drawValueBar(width:int, height:int, colors:Array=null):void
		{
			//当前已加载百分比
			_textCurrentPercentage.text = "0%";
			_textCurrentPercentage.width = width;
			_textCurrentPercentage.height = 20;
			_textCurrentPercentage.autoSize = TextFieldAutoSize.CENTER;
			_textCurrentPercentage.selectable = false;
			
			drawRoundRectBar(0, 0, width, height, false, colors);
		}
		
		override public function update(percent:Number):void
		{
			super.update(percent);
			_textCurrentPercentage.text = int(percent * 100) + "%";
		}
		
		override public function clear():void
		{
			super.clear();
			
			removeChild(_textCurrentPercentage);
			_textCurrentPercentage = null;
		}
		
		/**
		 * <只写>设置数值比当前值
		 */
		public function set currentValue(value:int):void
		{
			_currValue = value;
			_textCurrentPercentage.text = _currValue + "/" + _maxValue;
			super.update(_currValue/_maxValue);
		}
		
		/**
		 * <只写>设置数值比最大值
		 */
		public function set maxValue(value:int):void
		{
			_maxValue = value;
			_textCurrentPercentage.text = _currValue + "/" + _maxValue;
			super.update(_currValue/_maxValue);
		}
	}
}
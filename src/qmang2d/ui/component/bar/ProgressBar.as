package qmang2d.ui.component.bar
{
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import game.view.core.res.ResManager;
	
	/**
	 * 进度条，进度条显示，百分比数，当前加载内容
	 */
	public class ProgressBar extends BaseBar
	{
		//当前已加载百分比
		private var _textCurrentPercentage :TextField;
		//当前加载资料信息
		private var _textCurrentContent :TextField;
		
		private var _bit:Bitmap = new Bitmap();
		/**
		 * 创建新的进度条实例
		 */
		public function ProgressBar()
		{
			super();
			addChild(_textCurrentPercentage = new TextField());
			addChild(_textCurrentContent = new TextField());
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
			
			var leftCloud:Bitmap = new Bitmap();
			ResManager.getInstance().getJPG("resources/ui/baseui/window1.png",leftCloud);
			leftCloud.x=-10;			
			leftCloud.y = 18;
			addChild(leftCloud);
			var rightCloud:Bitmap = new Bitmap();
			ResManager.getInstance().getJPG("resources/ui/baseui/window2.png",rightCloud);
			rightCloud.x = width-18;
			rightCloud.y = 18;
			addChild(rightCloud);
			
			ResManager.getInstance().getJPG("resources/ui/baseui/taiji.png",_bit);
			_bit.visible = false;
			_bit.y = 20-1;
			addChild(_bit);
		}
		
		/**
		 * 设置当前加载内容
		 */
		public function setContent(content:String):void
		{
			_textCurrentContent.text = content;
		}
		
		override public function update(percent:Number):void
		{
			super.update(percent);
			_textCurrentPercentage.text = "已加载：" + int(percent * 100) + "%";
			if ( percent!=0 && percent != 1 )
			{
				_bit.visible = true;
				_bit.x = _maskLayer.x +_maskLayer.width - 15;
			}
			else
				_bit.visible = false;
		}
		
		override public function clear():void
		{
			super.clear();
			
			removeChild(_textCurrentContent);
			_textCurrentContent = null;
			
			removeChild(_textCurrentPercentage);
			_textCurrentPercentage = null;
		}
	}
}
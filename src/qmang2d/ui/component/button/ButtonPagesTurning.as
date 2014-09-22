package  qmang2d.ui.component.button
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import game.view.ui.ViewFilter;
	
	/**
	 * 翻页按钮。 
	 * @author a
	 */
	public class ButtonPagesTurning extends Sprite
	{
		public var leftButton:ButtonDirection;
		public var rightButton:ButtonDirection;
		private var _pageText:TextField = new TextField();
		public var _contentArray:Array;//包含内容数组
		private var _num:uint = 1;//  当前浏览页.
		
		/**
		 * 翻页按钮 
		 */		
		public function ButtonPagesTurning()
		{
			
		}
		
		//左翻页按钮
		public function turnLeft(e:MouseEvent):void{
			if (_num != 1){
				Sprite(_contentArray[_num-1]).visible = false;
				_num -= 1;
				Sprite(_contentArray[_num-1]).visible = true;
				_pageText.text = _num.toString()+"/"+_contentArray.length;
			}
		}
		
		//右翻页按钮
		public function turnRight(e:MouseEvent):void{
			if (_num != _contentArray.length){
				Sprite(_contentArray[_num-1]).visible = false;
				_num += 1;
				Sprite(_contentArray[_num-1]).visible = true;
				_pageText.text = _num.toString()+"/"+_contentArray.length;
			}
		}
		
		/**
		 * 翻页按钮。
		 * @param content 包含每一页内容的数组
		 * @param contentHeight 内容的高
		 * @param moduleWidth 翻页组件的宽
		 * @param moduleHeight 翻页组件的高
		 * 
		 */		
		public function setButtonPages(content:Array = null,contentHeight:uint=100,moduleWidth:uint=50,moduleHeight:uint=25):void
		{
			_contentArray = content;
			var i:uint = 1;
			for(i ; i < _contentArray.length ; i++){
				_contentArray[i].visible = false;
			}	
			_contentArray[0].visible = true;
			
			leftButton= new ButtonDirection(moduleHeight,moduleHeight);
			leftButton.x = 0;
			leftButton.y = contentHeight;
			leftButton.leftButton();
			leftButton.addEventListener( MouseEvent.CLICK , turnLeft );
			
			var background:Shape = new Shape();
			background.graphics.beginFill(0x05607D);
			background.graphics.drawRoundRect(0,contentHeight,moduleWidth - (leftButton.width+3)*2,moduleHeight,5);
			background.x = leftButton.width+3;
			addChild(background);
			
			rightButton = new ButtonDirection(moduleHeight,moduleHeight);
			rightButton.x = background.x+background.width+3;
			rightButton.y = contentHeight;
			rightButton.rightButton();
			rightButton.addEventListener(MouseEvent.CLICK , turnRight );
			addChild(leftButton);
			addChild(rightButton);
			
			_pageText.text = _num.toString()+"/"+_contentArray.length;
			_pageText.textColor = 0xffffff;
			_pageText.filters = [ViewFilter.textGlow];
			_pageText.autoSize = "left";
			_pageText.x = background.x+(background.width-_pageText.width)/2;
			_pageText.y = contentHeight;
			_pageText.mouseEnabled = false;
			addChild(_pageText);
		}
		
		public function clear():void
		{
			_contentArray.splice( 0 , _contentArray.length );
			_contentArray=null;
			
			removeChild( leftButton );
			leftButton.clear();
			leftButton.removeEventListener(MouseEvent.CLICK , turnLeft );
			leftButton = null;
			
			removeChild( rightButton );
			rightButton.removeEventListener(MouseEvent.CLICK , turnRight );
			rightButton.clear();
			rightButton = null ;
			
			removeChild( _pageText );
			_pageText=null;
		}
	}
}
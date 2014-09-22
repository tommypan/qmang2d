package qmang2d.ui.component.button
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	import game.view.ui.ViewFilter;
	
	
	/**
	 * 这个类是向上、下、左、右、加、减及其方向文本按钮，
	 * 分别调用其upButton(),downButton();leftButton(),rightButton();plusButton(),minusButton();来生成其对应的按钮
	 */
	public class ButtonDirection extends ButtonRect
	{
		private var _shape:Shape = new Shape();
		private var _functionNum:uint = 0;
	
		/**
		 *方向按钮 
		 * @param width 宽
		 * @param height 高
		 * @param title 按钮文本
		 */
		public function ButtonDirection(width:Number,height:Number)
		{
			super(width,height)
			
			this.addChild(_shape);

		}
		
		private function gotoFunction ():void
		{
			switch (_functionNum)
			{
				case 1:
					upButton();
					break;
				case 2:
					downButton();
					break;
				case 3:
					rightButton();
					break;
				case 4:
					leftButton();
					break;
				case 5:
					plusButton();
					break;
				case 6:
					minusButton();
					break;
			}
		}
		
		override public function set setText(title:String):void
		{
			if (_buttonText == null )
			{
				_buttonText = new TextField();
				_buttonText.autoSize=TextFieldAutoSize.CENTER;
				_buttonText.filters=[ViewFilter.textGlow];
				_buttonText.textColor = _fontColor;
				_title = title;
				addChild(_buttonText);
			}
			_buttonText.text=title;
			_buttonText.x=(_width-_buttonText.width)/2;
			_buttonText.y=(_height-_buttonText.height)/2;
			gotoFunction();
		}
		
		/**
		 *传入按钮的宽 
		 * @param value
		 */	
		override public function set width(value:Number):void
		{
			_shape.graphics.clear();
			super.width = value;
			gotoFunction();
		}
		/**
		 *传入按钮的高 
		 * @param value
		 */	
		override public function set height(value:Number):void
		{
			_shape.graphics.clear();
			super.height = value;
			gotoFunction();
		}
		
		/**
		 * 向上方向按钮
		 * 
		 */		
		public function upButton():void{
			_shape.graphics.clear();
			_shape.graphics.beginFill(0xffff0f,1);
			_shape.graphics.lineStyle(0.1,0x000000);
			_shape.graphics.moveTo(0,0);
			_shape.graphics.lineTo(30/2,0);
			_shape.graphics.lineTo(30/4,-30/4);
			_shape.graphics.endFill();
			if(_title== "" || _title == null){
				_shape.scaleX = _width/20;
				_shape.x =( _width - _shape.width )/2;
				_shape.y = _height/2;
			}else{
				_shape.scaleX = _height/30;
				_shape.x = _width - _shape.width - _shape.width/8;
				_shape.y = 5*_height/8;
				_buttonText.x = ( _shape.x -_buttonText.width )/2;
			}
			_shape.scaleY = _height/20;
			_functionNum = 1;
		}
		
		/**
		 * 向下方向按钮
		 * 
		 */		
		public function downButton():void{
			_shape.graphics.clear();
			_shape.graphics.beginFill(0xffff0f,1);
			_shape.graphics.lineStyle(0.1,0x000000);
			_shape.graphics.moveTo(0,0);
			_shape.graphics.lineTo(30/2,0);
			_shape.graphics.lineTo(30/4,30/4);
			_shape.graphics.endFill();
			if(_title== "" || _title == null){
				_shape.scaleX = _width/20;
				_shape.x =( _width - _shape.width )/2;
				_shape.y = 6*_height/16;
			}else{
				_shape.scaleX = _height/30;
				_shape.x = _width - _shape.width - _shape.width/6;
				_shape.y = 6*_height/16;
				_buttonText.x = (  _shape.x -_buttonText.width )/2;
			}
			_shape.scaleY = _height/30;
			_functionNum = 2;
		}
		
		/**
		 *右方向按钮 
		 * 
		 */		
		public function rightButton():void{
			_shape.graphics.clear();
			_shape.graphics.beginFill(0xffff0f,1);
			_shape.graphics.lineStyle(0.1,0x000000);
			_shape.graphics.moveTo(0,0);
			_shape.graphics.lineTo(0,30/2);
			_shape.graphics.lineTo(30/4,30/4);
			_shape.graphics.endFill();
			if(_title== "" || _title == null){
				_shape.scaleX = _width/20;
				_shape.x = (_width - _shape.width)/2;
				_shape.y = _height/4;
			}else{
				_shape.scaleX = _height/20;
				_shape.x = _width - _shape.width*1.2;
				_shape.y = _height/4;
				_buttonText.x = ( _shape.x -_buttonText.width )/2;
			}
			_shape.scaleY = _height/25;
			_functionNum = 3;
		}
		
		/**
		 *左方向按钮 
		 * 
		 */		
		public function leftButton():void{
			_shape.graphics.clear();
			_shape.graphics.beginFill(0xffff0f,1);
			_shape.graphics.lineStyle(0.1,0x000000);
			_shape.graphics.moveTo(0,0);
			_shape.graphics.lineTo(0,30/2);
			_shape.graphics.lineTo(-30/4,30/4);
			_shape.graphics.endFill();
			if(_title== "" || _title == null){
				_shape.scaleX = _width/20;
				_shape.x = (_width + _shape.width)/2;
				_shape.y = _height/4;
			}else{
				_shape.scaleX = _height/20;
				_shape.x = _width - _shape.width/3;
				_shape.y = _height/4;
				_buttonText.x = (  _shape.x -_buttonText.width )/2;
			}
			_shape.scaleY = _height/25;
			_functionNum = 4;
		}
		
		/**
		 *加号方向按钮 
		 * 
		 */		
		public function plusButton():void{
			_shape.graphics.clear();
			var a:Number =3.75;
			var X:Number=0
			var Y:Number=0
			_shape.graphics.beginFill(0xffff0f);
			_shape.graphics.lineStyle(0.1,0x000000);
			_shape.graphics.moveTo(0,0);  
			_shape.graphics.lineTo(2*a,0);
			_shape.graphics.lineTo(2*a,a);
			_shape.graphics.lineTo(0,a);
			_shape.graphics.lineTo(0,3*a);
			_shape.graphics.lineTo(-a,3*a);
			_shape.graphics.lineTo(-a,a);
			_shape.graphics.lineTo(-3*a,a);
			_shape.graphics.lineTo(-3*a,0);
			_shape.graphics.lineTo(-a,0);
			_shape.graphics.lineTo(-a,-2*a);
			_shape.graphics.lineTo(0,-2*a);
			_shape.graphics.lineTo(0,0);
			_shape.graphics.endFill();
			if (_height < _width ){
				_shape.scaleX = _shape.scaleY = _height/30;
			}
			else {
				_shape.scaleX = _shape.scaleY = _width/30;
			}
			if(_title== "" || _title == null){
				_shape.x = _width/2 + _shape.width/8;
				_shape.y = 7*_height/16;
			}else{
				_shape.x = _width - _shape.width/2;
				_shape.y = 7*_height/16;
				_buttonText.x = (  _shape.x -_buttonText.width )/2;
			}
			_functionNum = 5;
		}
		
		/**
		 *减号方向按钮 
		 * 
		 */		
		public function minusButton():void{
			var a:Number = 30;
			_shape.graphics.clear();
			_shape.graphics.beginFill(0xffff0f,1);
			_shape.graphics.lineStyle(0.1,0x000000);
			_shape.graphics.moveTo(0,0);
			_shape.graphics.lineTo(a*3/4,0);
			_shape.graphics.lineTo(a*3/4,a*3/16);
			_shape.graphics.lineTo(0,a*3/16);
			_shape.graphics.lineTo(0,0);
			_shape.graphics.endFill();
			if (_height < _width ){
				_shape.scaleX = _shape.scaleY = _height/30;
			}
			else {
				_shape.scaleX = _shape.scaleY = _width/30;
			}
			if(_title== "" || _title == null){
				_shape.x = (_width - _shape.width ) /2;
				_shape.y = 3*_height/8;
			}else{
				_shape.x = _width - _shape.width*1.1;
				_shape.y = 3*_height/8;
				_buttonText.x = (  _shape.x -_buttonText.width )/2;
			}
			_functionNum = 6;
		}
		
		override public function clear():void
		{
			super.clear();
			removeChild( _shape );
			_shape = null ;
		}
	}
}
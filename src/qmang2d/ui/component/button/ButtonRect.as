package qmang2d.ui.component.button
{
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import game.view.ui.ViewFilter;
	
	
	
	
	/**
	 *绘画一个方形按钮，有凸起和凹下两种状态，当传入按钮文本时，可选择文本是否随按钮状态而改变颜色（fontIsChange）。另外，可在外部传入参数以控制按钮的状态（changeButtonMode） 
	 * @author L
	 * 
	 */	
	public class ButtonRect extends Sprite
	{
		protected var _buttonText:TextField;//按钮文本
		protected var _title:String;
		private var _matr:Matrix=new Matrix();
		protected var _width:Number;//文本高宽
		protected var _height:Number;
		protected var _btnColor:Array=[0x11DAF0,0x117A83];//按钮的颜色(注意，只能传两种颜色，亮色在前，暗色在后)。
		protected var _fontColor:uint = 0xffffff;//文本字体颜色
		protected var _changeFontColor:uint = 0xffff00;//选中后字体颜色
		protected var _textF:TextFormat=new TextFormat();//文本格式
		protected var _isChange:Boolean = false;//按钮是否被选中
		private var _mode:Boolean = true;
		/**
		 * 
		 * @param width
		 * @param height
		 * @param title
		 */		
		public function ButtonRect( width:Number=40 , height:Number=20 , title:String = "" )
		{
			drawButton( width , height , title);
			_title=title;
			this.addEventListener(MouseEvent.MOUSE_DOWN,down);
			this.addEventListener(MouseEvent.MOUSE_UP,up);
			this.addEventListener(MouseEvent.MOUSE_OVER,over);
			this.addEventListener(MouseEvent.MOUSE_OUT,out);
			this.buttonMode=true;
			this.mouseChildren=false;
		}

		public function get title():String
		{
			return _title;
		}

		private function drawButton ( wid:Number , hei:Number , title:String = ""):void
		{
			_width=wid;
			_height=hei;
			
			this.graphics.clear();
			this.graphics.lineStyle(2,0,.6,true);
			this.graphics.drawRoundRect(0,0,wid-1,hei-1,6);
			
			this.graphics.lineStyle(1,0x1EC3DD,1,true);

			if ( _mode == true )
				shape(_btnColor,-_height*0.2);
			else
				shape([_btnColor[1],_btnColor[0]],hei*0.7);
			
			if ( title != "" && title != null)
			{
				setText = title ;
				txtFontColor(0xffffff);
			}
		}
		
		//文本颜色设置
		private function txtFontColor(wordcolor:uint):void{
			
			_textF.color=wordcolor;
			if ( _buttonText != null )
				_buttonText.setTextFormat(_textF);	
		}
		
		//鼠标移开状态
		private function out(event:MouseEvent):void
		{			
			if ( _mode == true )
				shape(_btnColor,-_height*0.2);
			else
				shape([_btnColor[1],_btnColor[0]],_height*0.7);
			if(_isChange){
				txtFontColor(_fontColor);
			}
		}
		
		//鼠标移过状态
		private function over(event:MouseEvent):void
		{

			shape(_btnColor);
		}
		
		//鼠标放开状态
		private function up(event:MouseEvent):void
		{
			if(_isChange){
				txtFontColor(_fontColor);
			}			
			shape(_btnColor);
		}
		
		//按钮按下状态
		private function down(event:Event):void
		{
			shape([_btnColor[1],_btnColor[0]],_height*0.7);
			if(_isChange == true){
				if(_textF.color ==_changeFontColor){
					txtFontColor(_fontColor);
				}else{
					txtFontColor(_changeFontColor);
				}
			}
		}
		
		//按钮背景
		private function shape(color:Array,ty:Number=0):void{
			_matr.createGradientBox(_width,_height,Math.PI/2,0,ty);
			this.graphics.beginGradientFill(GradientType.LINEAR,color,[1,1],[0,200],_matr);
			this.graphics.drawRoundRect(0.5,0.5,_width-2,_height-2,6);
		}
		/**
		 * 
		 * @param fontIsChange   字体是否显改变颜色当按钮被点击。
		 * @param btnColor  按钮的颜色[注意，只能传两种颜色，亮色在前，暗色在后。
		 * 
		 */		
		public function setButtonColor(fontIsChange:Boolean=false,btnColor:Array=null):void
		{
			_isChange=fontIsChange;
			if(btnColor!=null){
				_btnColor=btnColor;
				drawButton( _width , _height , _title );
			}
		}
//		public function set setFontSize(size:uint):void{
//			_textF.size = size;
//			_buttonText.setTextFormat(_textF);
//		}
		/**
		 * 
		 * @param title 文本
		 * 
		 */		
		public function set setText(title:String):void
		{
			if (_buttonText == null )
			{
				_buttonText = new TextField();
				_buttonText.autoSize=TextFieldAutoSize.CENTER;
				_buttonText.filters=[ViewFilter.textGlow];
				textFormat( );
				_buttonText.textColor = _fontColor;
			}
			_title = title;
			_buttonText.text=title;
			_buttonText.x=(_width-_buttonText.width)/2;
			_buttonText.y=(_height-_buttonText.height)/2;
			addChild(_buttonText);
		}
		
		/**
		 *传入文本的格式。 
		 * @param fontColor 颜色
		 * @param fontSize 字体大小
		 * @param changeFontColor 点击改变后的颜色。
		 * 
		 */		
		public function textFormat( fontColor:Number=0xFFFFFF,fontSize:uint=12,changeFontColor:uint=0xffff00 ):void
		{
			_changeFontColor=changeFontColor;
			_fontColor = fontColor;
			_textF.font="Arial";
			_textF.size=fontSize;
//			_textF.bold=true;
			txtFontColor(fontColor);
		}
		
		/**
		 *传入按钮的高 
		 * 
		 */		
		override	public function set height(value:Number ):void
		{
			drawButton( _width , value , _title);
		}
		/**
		 *传入按钮的宽 
		 * @param value
		 * 
		 */		
		override public function set width( value:Number ):void
		{
			drawButton( value , _height , _title);
		}
		
		/**
		 * 通过传入数字来改变按钮的状态。
		 *1、凸起，2、凹下。 
		 * <p>若已选择isChange=true，可传入数字改变字体颜色，3、选中颜色，4、未选中颜色。</p>
		 * @param modeNum
		 * @return 
		 * 
		 */		
		public function set changeButtonMode(modeNum:uint):void{
//			drawButton( _width , _height , _title);
			switch (modeNum){
				case 1:
					shape(_btnColor);
					break;
				case 2:
					shape([_btnColor[1],_btnColor[0]],_height*0.5);
					break;
				case 3:
					if(_isChange){
						txtFontColor(_changeFontColor);
					}
					break;
				case 4:
					if(_isChange){
						txtFontColor(_fontColor);
					}
					break;
			}
		}
	
		
		/**
		 *传入图标。 
		 * @param icon 图标 
		 * @param xpos x坐标
		 * @param ypos y坐标
		 * 
		 */		
		public function setIcon(icon:Bitmap,xpos:Number,ypos:Number):void{
			icon.x = xpos;
			icon.y = ypos;
			this.addChild(icon);
		}
		
		/**
		 *清除按钮。 
		 * 
		 */		
		public function clear():void{
			if ( _buttonText != null )
			{
				removeChild( _buttonText );
				_buttonText=null;
			}
			_btnColor=null;
			_matr=null;
			_textF=null;
			closeEventListen = 0;
		}
		/**
		 *关闭按钮内部鼠标监听！  
		 * @param value 0,关闭所有；1、关闭down监听；2、关闭up监听；3、关闭over；4、关闭out。
		 * 
		 */
		public function  set closeEventListen(value:uint):void{
			switch (value){
				case 0:
					this.removeEventListener(MouseEvent.MOUSE_DOWN,down);
					this.removeEventListener(MouseEvent.MOUSE_UP,up);
					this.removeEventListener(MouseEvent.MOUSE_OVER,over);
					this.removeEventListener(MouseEvent.MOUSE_OUT,out);
					break;
				case 1:
					this.removeEventListener(MouseEvent.MOUSE_DOWN,down);
					break;
				case 2:
					this.removeEventListener(MouseEvent.MOUSE_UP,up);
					break;
				case 3:
					this.removeEventListener(MouseEvent.MOUSE_OVER,over);
					break;
				case 4:
					this.removeEventListener(MouseEvent.MOUSE_OUT,out);
					break;
			}
		}
		/**
		 *传入按钮类型。
		 * ture，初始状态为凸起。默认状态。
		 * false，初始状态为正常。
		 */
		public function  set buttonStyle(value:Boolean):void{
			_mode = value;
			if ( _mode == true )
				shape(_btnColor,-_height*0.2);
			else
				shape([_btnColor[1],_btnColor[0]],_height*0.7);
		}
	}
}
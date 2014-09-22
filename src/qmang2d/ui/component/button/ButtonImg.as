package qmang2d.ui.component.button
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import game.view.ui.ViewFilter;
	
	/**
	 * 这是个用于传入图片生成按钮的类。
	 * @author a
	 */	
	public class ButtonImg extends Sprite
	{
		//按钮图片
		private var _img:Bitmap = new Bitmap();
		//按钮文本
		private var _buttonText:TextField;
		//图片是否发光		
		private var _glowEnable:Boolean=true;
		//文本格式
		private var _textFormat:TextFormat=new TextFormat();
		//文本内容
//		private var _text:String=new String();		//保留，当以后需要提取时
		
		
		/**
		 * @param img 传入图片
		 */		
		public function ButtonImg(image:Bitmap)
		{
			_img=image
			addChild(_img);
			this.buttonMode=true;
			this.mouseChildren=false;
			this.addEventListener(MouseEvent.MOUSE_OVER,onOver);			
		}
		
		private function onOver(e:MouseEvent):void{
			this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
			if(_glowEnable==true){
				_img.filters=[ViewFilter.glowCharacter];
			}
		}
		
		private function onOut(e:MouseEvent):void{
			this.removeEventListener(MouseEvent.MOUSE_OUT,onOut);
			_img.filters=[];
		}
		
		/**
		 *当鼠标移上去，是否发光。 
		 * @param value
		 */		
		public function set glowEnable( value:Boolean ):void
		{
			_glowEnable = value;
		}
		
		/**
		 *传入文本颜色 
		 * @param color
		 */		
		public function set textColor( color:uint ):void
		{
			_buttonText.textColor = color;
		}
		
		/**
		 *按钮文本字体大小 
		 * @param size
		 */		
		public function set texdSize( size:uint ):void
		{
			_textFormat.size = size;
			_buttonText.setTextFormat( _textFormat );
		}
		
		/**
		 *传入按钮文本 
		 * @param str
		 */		
		public function set text( str:String ):void
		{
			if (_buttonText == null){
				_buttonText = new TextField();
				this.addChild(_buttonText);
			}
			_buttonText.text = str;
//			_text = str;
			_buttonText.setTextFormat( _textFormat );
		}
		
		/**
		 *传入文本的x和y 
		 * @param xpos
		 * @param ypos
		 */		
		public function setTextXY(xpos:Number,ypos:Number):void{
			_buttonText.x = xpos;
			_buttonText.y = ypos;
		}
		
		/**
		 *图片按钮中的图片 
		 */		
		public function get getImg():Bitmap
		{
			return _img;
		}
		
		public function set getImg( bitmap:Bitmap ):void
		{
			_img = bitmap;
		}
		
		/** 
		 * 清除函数
		 */		
		public function clear():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER,onOver);	
			_img.bitmapData.dispose();
			this.removeChild(_img);
			_img = null;
			
			if (_buttonText != null){
				_buttonText = null;
				this.removeChild(_buttonText);
			}
		}
	}
}
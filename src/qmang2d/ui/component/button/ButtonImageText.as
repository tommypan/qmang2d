package qmang2d.ui.component.button
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import game.view.ui.ViewFilter;
	
	/**
	 * 这是个用于传入图片生成按钮的类。
	 * 
	 * @author a
	 */	
	public class ButtonImageText extends Sprite
	{
		private var _img:Bitmap=new Bitmap();
		private var _buttonText:TextField=new TextField();
		private var _imgGlow:GlowFilter=new GlowFilter();
		private var _function:Function=new Function();
		private var _glowEnable:Boolean=true;
		private var _text:String=new String();
		/**
		 * 
		 * @param img 传入图片
		 * @param text 传入文本
		 * @param glowEnable 图片是否发光
		 * @param textSize 字体大小
		 * @param textColor 文本颜色
		 * @param func 绑定函数
		 * 
		 */		
		public function ButtonImageText(img:Bitmap=null,text:String=null,glowEnable:Boolean=true,
										textSize:int=12,textColor:uint=0xFFFAAC,func:Function=null)
		{
			_function=func;
			_img=img;
			_text=text;
			_glowEnable=glowEnable;
			if(glowEnable==true){
				_imgGlow.color=0xFFFf00;
				_imgGlow.blurX=8;
				_imgGlow.blurY=8;
				_imgGlow.alpha=1;
				_imgGlow.quality=BitmapFilterQuality.MEDIUM;
			}
			
			this.addChild(_img);
			
			if (text != null){
				var textF:TextFormat=new TextFormat("宋体",textSize,textColor,true);
				_buttonText.text=_text;
				_buttonText.setTextFormat(textF);
				_buttonText.x=_img.x+10;
				_buttonText.y=_img.y+25;
				_buttonText.width=29;
				_buttonText.height=18;
				this.addChild(_buttonText);
				_buttonText.filters = [ViewFilter.textGlow];
			}
			this.buttonMode=true;
			this.mouseChildren=false;
			this.addEventListener(MouseEvent.CLICK,onClick);
			this.addEventListener(MouseEvent.MOUSE_OVER,onOver);			
		}
		
		private function onClick(e:MouseEvent):void
		{
			if(_function!=null) 	
				_function();
		}
		private function onOut(e:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT,onOut);
			_img.filters=[];
		}
		
		private function onOver(e:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
			if(_glowEnable==true){
				_img.filters=[_imgGlow];
			}
		}
		
		/**
		 *传入按钮绑定函数 
		 * @param value
		 * 
		 */		
		public function set setFunction(value:Function):void
		{
			_function=value;
		}
		
		/**
		 *传入文本的x和y 
		 * @param xpos
		 * @param ypos
		 */		
		public function setTextXY(xpos:Number,ypos:Number):void
		{
			_buttonText.x = xpos;
			_buttonText.y = ypos;
		}
		
		/**
		 *传入图片。 
		 * @param img
		 * 
		 */		
		public function set setImg(img:Bitmap):void
		{
			_img = img;
		}
		
		public function close():void
		{
			this.removeEventListener(MouseEvent.CLICK,onClick);
			this.removeEventListener(MouseEvent.MOUSE_OVER,onOver);	
			_img.bitmapData.dispose();
			this.removeChild(_img);
		}
	}
}
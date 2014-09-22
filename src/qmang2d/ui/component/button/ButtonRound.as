package qmang2d.ui.component.button
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import game.view.ui.ViewFilter;
	
	
	
	/** 
	 *绘制一个圆角按钮
	 */	
	public class ButtonRound extends Sprite
	{
		//文本格式
		private var _textF:TextFormat =new TextFormat();
		//按钮文本
		private var _buttonText:TextField;
		
		//是否发光
		private var _isLight:Boolean;
		//按钮发光
		private var _glowShape:Shape=new Shape();
		//发光控制器
		private var _timer:Timer=new Timer(1000,0);
		//光晕半径控制
		private var _i:int=0;
		
		//按钮半径
		private var _radius:int;
		//按钮颜色
		private var _btnColor:Array=[0x24C8B2,0x246F6C];
		//渐变数组
		private var _matr:Matrix=new Matrix();
		/**
		 *		 圆角按钮
		 * @param radius 半径
		 * @param buttonTitle  按钮文本 
		 * @param buttonColor 按钮颜色
		 */		
		public function ButtonRound( radius:Number = NaN , buttonTitle:String = "" , buttonColor:Array = null )
		{
			drawButtonRound( radius , buttonColor , _isLight );
			if( buttonTitle != "" )
				title = buttonTitle;
			
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,down);
			this.addEventListener(MouseEvent.MOUSE_UP,up);
			this.addEventListener(MouseEvent.MOUSE_OVER,over);
			this.addEventListener(MouseEvent.MOUSE_OUT,out);
			
		}
		
		//绘制按钮边框
		private function drawRound():void
		{
			graphics.clear();
			graphics.lineStyle(1,0,0.5);
			graphics.drawCircle(0,0,_radius+1.5);
			graphics.lineStyle(2,0,1,true);
			var ma:Matrix = new Matrix();
			ma.createGradientBox(_radius*2,_radius*2,Math.PI/2,0,-10);
			graphics.lineGradientStyle(GradientType.LINEAR,[0x57E1F4,0x039A8B],[1,1],[0,255],ma);
			graphics.drawCircle(0,0,_radius);
			shape(_btnColor,-_radius*2);
			graphics.endFill();
			
			if(_isLight){
				_timer.reset();
				_timer.start();
				_timer.addEventListener(TimerEvent.TIMER,islight);
				addChild(_glowShape);
			}
		}
		
		//绘制按钮渐变
		private function shape(color:Array, ty:Number):void{
			_matr.createGradientBox(_radius*1.9,_radius*1.9,0,-_radius*1.8*0.5,ty);
			graphics.beginGradientFill(GradientType.RADIAL,color,[1,1],[50,255],_matr);
			graphics.drawCircle(0,0,_radius);
		}
		
		//发光设置
		private function islight(e:TimerEvent):void{
			_i++;
			rad(_radius);
		}
		
		//绘制光晕
		private function rad(radius:Number):void{	
			_glowShape.graphics.clear();
			_glowShape.graphics.lineStyle(2,0xFFF92F);
			_glowShape.graphics.drawCircle(0,0,radius+_i*1.5);
			if(_i>3){
				_i = 0;
			}
		}
		
		//鼠标移开
		private function out(event:Event):void
		{
			shape(_btnColor,-_radius*2);
		}
		
		//鼠标经过
		private function over(event:Event):void
		{
			shape( _btnColor ,-_radius*1.7);
		}
		
		//鼠标松开
		private function up(event:Event):void
		{
			shape(_btnColor,-_radius*1.7);
		}
		
		//鼠标按下
		private function down(event:Event):void
		{
			shape([_btnColor[0],_btnColor[1]],_radius*0.3);
			if(_isLight){
				_timer.stop();
				_glowShape.visible = false;
				_isLight=false;
			}
		}
		
		/**
		 *当未点击过按钮时，是否发光 
		 */		
		public function set isLight( value:Boolean ):void
		{
			_isLight  = value;
		}
		
		/**
		 *传入按钮颜色数组，亮的在前，暗的在后。
		 * @param value
		 */		
		public function set buttonColor( value:Array ):void
		{
			_btnColor = value;
			drawRound();
		}
		
		/**
		 *设置圆角按钮属性
		 * @param radius 圆形按钮的半径
		 * @param btnColor 按钮颜色
		 * @param light 是否发光
		 */	
		public function drawButtonRound(radius:Number=10,btnColor:Array=null,light:Boolean=false):void
		{
			if(btnColor!=null){
				_btnColor=btnColor;
			}
			_radius=radius;
			isLight = light;
			drawRound();
		}
		/**
		 *传入按钮文本 
		 * @param value
		 * 
		 */		
		public function set title( value:String ):void
		{
			if ( _buttonText == null )
			{
				_buttonText=new TextField();
				_buttonText.autoSize = TextFieldAutoSize.CENTER;
			}
			_buttonText.text  = value ;
//			_buttonText.width=_radius*2;
//			_buttonText.height=_radius*2;
			_buttonText.x=-( _buttonText.width)/2;
			_buttonText.y=-( _buttonText.height)/2;
			_buttonText.mouseEnabled=false;
			_buttonText.filters =[ViewFilter.textGlow];
			_buttonText.textColor = 0xffffff;
			addChild(_buttonText);
		}
		/**
		 *传入按钮文本格式。 
		 * @param color 颜色
		 * @param size 大小
		 * 
		 */		
		public function titleFormat( color:uint , size:uint ):void
		{
			_textF.size = size;
			_textF.color = color ;
			_buttonText.defaultTextFormat = _textF;
			_buttonText.setTextFormat( _textF );
			_buttonText.x=-( _buttonText.width)/2;
			_buttonText.y=-( _buttonText.height)/2;
		}
		
		/**
		 *输入按钮文本 
		 * @param str 标题
		 * @param fontColor 字体颜色
		 * @param fontSize 字体大小
		 * 
		 */		
		public function setTitleAndFormat( str:String="", fontColor:Number=0x0f5765,fontSize:uint=12 ):void
		{
			titleFormat( fontColor , fontSize );
			title=str;
		}
		/**
		 *清除函数 
		 * 
		 */		
		public function clear():void{
			removeChild( _buttonText );
			_buttonText=null;
			_btnColor=null;
			_matr=null;
			_textF=null;
			this.removeEventListener(MouseEvent.MOUSE_DOWN,down);
			this.removeEventListener(MouseEvent.MOUSE_UP,up);
			this.removeEventListener(MouseEvent.MOUSE_OVER,over);
			this.removeEventListener(MouseEvent.MOUSE_OUT,out);
			
			if ( _isLight )
			{
				_glowShape.graphics.clear();
				removeChild( _glowShape );
				_glowShape = null ;
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,islight);
			}
		}
	}
}
package qmang2d.ui.component.window
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.sensors.Accelerometer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import game.view.core.res.ResManager;
	import qmang2d.ui.component.button.ButtonClose;
	
	
	public class Window extends Sprite
	{
		private var _dragable:Boolean=true;
		private var _sprite:Sprite=new Sprite();
		private var _txt:TextField;//窗口文本
		private var _height:Number = 0;//窗口高
		private var _width:Number  = 0;//窗口宽
		private var _isCloseButton:Boolean=true;//是否有关闭按钮,默认为true
		public var closeButton:ButtonClose;//关闭按钮
		private var bim1:Bitmap=new Bitmap();
		private var bim2:Bitmap=new Bitmap();//窗口左右下角图案
		
		/**
		 *窗口 
		 * 
		 */		
		public function Window()
		{
			if(_dragable){				
				_sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_sprite.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				_sprite.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			}
			addChild(_sprite);
		}
		
		/**
		 *绘制窗口 
		 * @param width 宽
		 * @param height 高
		 */
		public function drawWindow( width:Number , height:Number , isCloseButton:Boolean = true):void
		{
			_sprite.graphics.clear();
			
			var matr:Matrix=new Matrix();
			matr.createGradientBox(60,60,Math.PI/2,0,0);
			_sprite.graphics.lineStyle(0.1,0x000000,0.6,true);
			_sprite.graphics.beginGradientFill(GradientType.LINEAR, [0x78DDDC,0x2B80A0,0x2B80A0,0x2B80A0], [0.9,1,1,1], [0,80,0,250], matr);
			_sprite.graphics.drawRoundRect(0,0,width,height,16,16);
			_sprite.graphics.endFill();
			
			_isCloseButton = isCloseButton;
			
			var bim3:Bitmap= new Bitmap();
			ResManager.getInstance().getPNG("resources/ui/baseui/window3.png" , bim3) ;
			addChild(bim3);
			bim3.x=width/2 - 52;
			bim3.y=6;
			
			var bim4:Bitmap=new Bitmap();
			ResManager.getInstance().getPNG("resources/ui/baseui/window4.png" , bim4) ;
			addChild(bim4);
			bim4.x=width/2;
			bim4.y=6;
			if(width>300)
			{
				var bim5:Bitmap=new Bitmap();
				ResManager.getInstance().getPNG("resources/ui/baseui/window5.png" , bim5) ;
				addChild(bim5);
				bim5.x=1;
				bim5.y=6;
				
				var bim6:Bitmap=new Bitmap();
				ResManager.getInstance().getPNG("resources/ui/baseui/window6.png" , bim6) ;
				addChild(bim6);
				bim6.x=width/1.3;
				bim6.y=6;
			}
			
			if(_isCloseButton)
			{
				closeButton=new ButtonClose();
				closeButton.x=width-25;
				closeButton.y=5;
				addChild(closeButton);
			}
			
			
			bim1==new Bitmap();
			ResManager.getInstance().getPNG("resources/ui/baseui/window1.png" , bim1) ;
			bim1.x=-5;
			bim1.y=height-15;
			
			bim2==new Bitmap();
			ResManager.getInstance().getPNG("resources/ui/baseui/window2.png" , bim2) ;
			bim2.x=width-21.5;
			bim2.y=height-15;
			
			
		}
		//鼠标弹起事件
		protected function onMouseUp(event:MouseEvent):void{
			if( _dragable )this.stopDrag();
		}
		//鼠标按下事件
		protected function onMouseDown(event:MouseEvent):void{
			if( _dragable )this.startDrag();
		}
		//鼠标移过事件
		protected function onMove(event:MouseEvent):void
		{
			if(event.buttonDown==false){
				if(_dragable)this.stopDrag();
			}
		}
		
		/**
		 * @param dragable 设置窗口是否可拖动
		 */
		public function set dragAble( value:Boolean):void
		{
			_dragable=value;
		}
		
		/**
		 * @param IsCloseButton  设置是否有关闭按钮
		 * 
		 */		
		public function set haveClose( value:Boolean):void	
		{
			_isCloseButton=value;	
		}
		
		/**
		 *传入顶部文本 
		 * @param title  按钮文本
		 * 
		 */		
		public function setTitle(title:String=""):void
		{
			
			var textF:TextFormat=new TextFormat();
			textF.font='楷体';
			textF.size=15;
			textF.color=0xFFFFFF;
			textF.bold=true;
			_txt=new TextField();
			_txt.text=title;
			_txt.setTextFormat(textF);
			_txt.mouseEnabled=false;
			_txt.autoSize = "left";
			_txt.x=(width-_txt.textWidth)/2;
			_txt.y=(30-_txt.textHeight)/2;
			addChild(_txt);
		}
		
		/**
		 * 向面板中添加显示对象,instance作为显示对象,后面两个参数为该显示对象的坐标
		 * */
		public function addElement(instance:DisplayObject=null, x:Number=0, y:Number=0):void{
			instance.x = x;
			instance.y = y;
			addChild(instance);
			
			addChild(bim1);
			addChild(bim2);
			
		}
		
		/**
		 *传入window的宽。 
		 * @param value
		 * 
		 */		
		public function set setWidth( value:Number ):void
		{
			drawWindow( value , _height );
			_width = value;
		}
		
		/**
		 *传入window的高。 
		 * @param value
		 * 
		 */		
		public function set setHeight ( value:Number ):void
		{
			drawWindow( _width , value );
			_height = value;
		}
		
		/**
		 *清除函数 
		 * 
		 */		
		public function clear():void{
			_sprite.graphics.clear();
			if(_dragable){
				_sprite.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_sprite.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				_sprite.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			}
			_sprite = null;
			
			if(_isCloseButton)
			{
				removeChild(addChild(closeButton));
				closeButton = null;
			}
			
			if ( _txt != null )
			{
				removeChild( _txt );
				_txt = null ;
			}
			removeChildren();
		}
	}
}
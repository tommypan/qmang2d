package qmang2d.ui.component.list
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import game.view.ui.ViewFilter;
	

	/**
	 *绘画一个列表子元素。也可单独使用 
	 * 
	 */	
	public class ListItem extends Sprite
	{
		//绘制背景 
		private var _BGShape:Shape;
		//点击触发函数
		private var _func:Function;
		//经过时显示的背景颜色的透明度
		private var _ChangeAlpha:Number ;
		//背景颜色透明度
		private var _alpha:Number = 0;
		 
		/**
		 * 背景颜色
		 */		
		protected var _BGColor:uint = 0 ;
		
		/**
		 * 当鼠标经过时显示的背景颜色
		 */		
		protected var _changeColors:uint;
				
		/**
		 *高 
		 */		
		protected var _height:Number;
		/**
		 *宽 
		 */		
		protected var _width:Number;
		/**
		 * 内容数组
		 */		
		protected var _content:Array = null;
		/**
		 * 文本颜色
		 */		
		protected var _textColor:String = "0xffffff";
		/**
		 * 文本大小
		 */		
		protected var _textSize:uint = 12;
		/**
		 *内容数组的各个内容的x坐标 
		 */		
		protected var _xArray:Array = null;
		
		
		/**
		 * 将一个数组的元素排列成一行并显示，是list列表的子元素。
		 * @param width 宽
		 * @param height 高
		 * 
		 */		
		public function ListItem(width:Number, height:Number)
		{
			_width = width;
			_height = height;
			
			
			_BGShape = new Shape();
			addChildAt(_BGShape , 0);
			
		 }
		
		//绘画背景
		private function drawBG ( shape:Shape , color:uint , width:Number , height:Number ,alpha:Number ):void
		{
			shape.graphics.clear();
			shape.graphics.beginFill( color , alpha);
			shape.graphics.drawRect( 0 , 0 , width , height );
			shape.graphics.endFill();
		}
		
		//鼠标经过触发
		private function onOver(e:MouseEvent):void
		{
			drawBG(_BGShape , _changeColors , _width , _height , _ChangeAlpha );
			this.addEventListener(MouseEvent.MOUSE_OUT , onOut);
		}
		//移开触发
		private function onOut(e:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT , onOut);
			drawBG(_BGShape , _BGColor , _width , _height , _alpha );
		}
		
		/**
		 * 绘制contentArray中的内容
		 * @param contentArray 内容数组
		 * @param xArray 内容的x数组
		 * 
		 */		
		protected function makeContent( contentArray:Array , xArray:Array ):void
		{
			var i:uint = 0;

			for ( ; i < contentArray.length ; i++ ){
				
				if ( contentArray[i] is String || contentArray[i] is Number){
					var text:TextField = new TextField();
					if ( text.height >  _height ) text.height =  _height ;
					text.htmlText = "<font face='宋体' color='"+_textColor+"' size='"+_textSize+"'>"+contentArray[i]+"</font>";
					text.width =  text.textWidth + 5; 
					text.y = ( this.height - text.height )/2;
					if ( this.height == 0 || text.y < 0) text.y = 0;
					text.x = xArray[i];
					text.mouseEnabled = false ;
					text.filters = [ViewFilter.textGlow];
					this.addChild(text);
					_content[i] = text;
				}else{
					contentArray[i].x = xArray[i];
					this.addChild(contentArray[i]);
				}
			}	
		}
		
		
		private function onClick( e:MouseEvent ):void
		{
			if (_func != null) _func(e);
		}
		
		/**
		 *传入内容数组和x数组。 
		 * @param content 内容数组
		 * @param xArray x数组，用以确定各个内容的x坐标。
		 * 
		 */		
		public function setContent( content:Array , xArray:Array ):void
		{
			_content = content ;
			_xArray = xArray;
			makeContent( content , xArray );
		}
		
		/**
		 *改变此对象的内容。 
		 * @param contentArray 内容数组
		 * @param xArray x数组。
		 * 
		 */		
		public function changeContent( contentArray:Array , xArray:Array ):void
		{
			var i :uint;
			for ( i = 0 ; i < _content.length ; i++ )
				this.removeChild( _content[i] );
			_content = contentArray;
			makeContent( contentArray , xArray );
			_xArray = xArray;
			
		}
		
		/**
		 *传入文本颜色。 
		 * @param color
		 * 
		 */		
		public function set textColor ( color:String ):void
		{
			var i:uint ;
			_textColor = color;
			for ( i = 0 ; i < _content.length ; i++ )
			{
				if ( _content[i] is TextField )
				{
					_content[i].htmlText = "<font face='宋体' color='"+_textColor+"' size='"+_textSize+"'>"+_content[i].text+"</font>";
					_content[i].width =  _content[i].textWidth + 5; 
				}
			}
		}
		
		/**
		 *传入文本的字体大小 
		 * @param size
		 * 
		 */		
		public function set textSize( size:uint ):void
		{
			var i:uint ;
			_textSize = size;
			for ( i = 0 ; i < _content.length ; i++ )
			{
				if ( _content[i] is TextField )
				{
					_content[i].htmlText = "<font face='宋体' color='"+_textColor+"' size='"+_textSize+"'>"+_content[i].text+"</font>";
					_content[i].width =  _content[i].textWidth + 5; 
				}
			}
		}
		
		/**
		 *传入单击触发方法，设定点击是否改变背景颜色。
		 * @param func 传入的方法，必须带MouseEvent参数
		 * @param isChageColor 当鼠标移上去是否改变背景颜色
		 * @param changeColor 改变后的背景颜色
		 * 
		 */		
		public function setClickFunction(func:Function , isChageColor:Boolean = false , changeColor:uint = 0xfffff0 , BGAlpha:Number = 1 ):void{
			_func = func;
			if (isChageColor == true ){
				this.addEventListener(MouseEvent.MOUSE_OVER , onOver);
			}

			_changeColors = changeColor;
			_ChangeAlpha = BGAlpha;
			this.addEventListener(MouseEvent.CLICK,onClick);
		}

		/**
		 *传入背景颜色 
		 * @param color
		 * 
		 */		
		public function set bgColor( color:uint ):void
		{
			_BGColor = color;
			drawBG( _BGShape , color , _width , _height , _alpha );
		}
		
		/**
		 *传入背景透明度 
		 * @param alpha
		 * 
		 */		
		public function set bgAlpha ( alpha:Number ):void
		{
			_alpha = alpha;
			drawBG( _BGShape , _BGColor , _width , _height , _alpha );
		}
		
		/**
		 *获取内容数组 
		 * @return 
		 * 
		 */		
		public function get getContent():Array{
			return _content;
		}
		
		/**
		 *获取内容的x坐标数组 
		 * @return 
		 * 
		 */		
		public function get getXArray():Array
		{
			return _xArray;
		}
		
		/**
		 *改变背景颜色 
		 * @param changeColor 改变的颜色
		 * @param BGAlpha 改变的透明度
		 * 
		 */		
		public function backGround( changeColor:uint = 0xfffff0 , BGAlpha:Number = 1 ):void
		{
			drawBG(_BGShape , changeColor , _width , _height , BGAlpha );
		}
			
		/**
		 *清楚本实例。 
		 * 
		 */		
		public function clear():void{
			_content.splice( 0 , _content.length );
			_content = null ;
			
			_xArray.splice( 0 , _xArray.length );
			_xArray = null;
			
			var i:uint ;
			var child:*;
			for ( i = 0 ; i < this.numChildren ; i++ )
			{
				child = this.getChildAt( i );
				
				if ( child is Shape )
					child.graphics.clear();
				else if (child is Sprite )
				{
					child.graphics.clear();
					if( child.clear() != null )
						child.clear();
				}
				else if ( child is Bitmap )
					child.bitmapData.dispose();

				child = null ;
			}
			this.removeChildren( );
			
			if (_func != null ){
				this.removeEventListener(MouseEvent.CLICK,onClick);
				_func = null;
				_changeColors=NaN;
			}
			this.removeEventListener(MouseEvent.MOUSE_OVER , onOver);
			_width = NaN;
			_height = NaN;
		}
	}
}

package qmang2d.ui.component.window
{
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import game.view.ui.ViewFilter;
	
	
	/**
	 *绘画一个解释框，用于对某个对象（parent）的解释当鼠标移上去。 
	 * @author L
	 * 
	 */	
	public class ExplainPanel extends Sprite
	{
		private var _explainText:TextField ;
		private var _parent:DisplayObjectContainer;//需要解释的对象
		private var _textArray:Array = new Array();
		private var _width:Number = 0;
		private var _imgWidth:Number = 0;
		private var _allHeight:Number = 0;
		private var _backgroundcolor:uint;
		/**
		 * 
		 * @param width 解释框宽
		 * @param height　　解释框高
		 * 
		 */		
		public function ExplainPanel(width:Number=50,height:Number=30)
		{
			_width = width;
			graphics.lineStyle(0.5,0x31889C);
			graphics.beginFill(0xffffff);
			graphics.drawRoundRect(0,0,width,height,8,8);
			graphics.endFill();
			
			var ban2:Shape=new Shape();
			ban2.graphics.lineStyle(0.5,0x31889C);
			ban2.graphics.beginFill(_backgroundcolor,0.8);
			ban2.graphics.drawRoundRect(2,2,width-4,height-4,8,8);
			ban2.graphics.endFill();
			addChild(ban2);
			
			makeTxt( 2 , 2 , _width);
		}
		
		//创造文本函数
		private function makeTxt( x:Number , y:Number , wid:Number ):void
		{
			_explainText = new TextField();
			_explainText.mouseEnabled=false;
			_explainText.x = x;
			_explainText.y = y;
			_explainText.autoSize="left";
			_explainText.width=wid;
			_explainText.wordWrap=true;
			_explainText.multiline=true;
			_explainText.filters = [ViewFilter.textGlow];
			this.addChild(_explainText);
			_textArray.splice(0);
		}
		
		//鼠标移过事件
		private function  over(event:MouseEvent):void{
			if(_parent!=null)_parent.addChild(this);
		}
		
		//鼠标移开事件
		private function out(event:MouseEvent):void{
			if(_parent!=null)_parent.removeChild(this);
		}
		
		//设置文字
		private function setWorld(str:String , color:String = "#ffffff" , size:uint = 13 ):String{
			str = "<font face='宋体' color='"+color+"' size='"+size+"'>"+str+"</font>";
			return str;
		}
		
		/**
		 * 解释框设置
		 * @param parent  设置待解释对象
		 * @param backgroundcolor  //设置背景颜色
		 * 
		 */		
		public function setParent(parent:DisplayObjectContainer=null,backgroundcolor:Number=0x0A444F):void
		{
			_parent=parent;
			_backgroundcolor=backgroundcolor;
			_parent.addEventListener(MouseEvent.MOUSE_OVER,over);
			_parent.addEventListener(MouseEvent.MOUSE_OUT,out);
		}
		
		/**
		 *多种颜色的解释文本。 文本数组中将不同颜色的文本分开，颜色数组中对应这些文本分别赋予颜色。
		 * @param strArray 文本数组，字符串。
		 * @param colorArray 颜色数组，颜色字符串，如：["#ff00ff","#ff0000","#000000"]【若只有一个元素，则默认使用到全部文本
		 * @param size 文字大小数组【若只有一个元素，则默认使用到全部文本
		 * @param isNewline 是否换行
		 * 
		 */		
		public function setWorldArray( strArray:Array , colorArray:Array , size:Array , isNewline:Boolean = false ):void
		{
			var str:String = new String();
			var i:uint = 0;
			for ( i ; i < strArray.length ; i++){
				if ( colorArray.length == 1 && size.length == 1 )
				{
					str = str + setWorld(strArray[i] , colorArray[0] , size[0]  );
				}
				else if ( colorArray.length == 1 )
				{
					str = str + setWorld(strArray[i] , colorArray[0] , size[i]  );
				}
				else if ( size.length == 1 )
				{
					str = str + setWorld(strArray[i] , colorArray[i] , size[0]  );
				}
				else {
					str = str + setWorld(strArray[i] , colorArray[i] , size[i]  );
				}
			}
			if( isNewline == true ){
				str = "<p>"+str+"</p>";
			}
			_textArray.push(str);
			_explainText.htmlText = _textArray.join("");
		}
		
		/**
		 *当有图片的时候，确定文本是和图片并排还是在图片下。 
		 * @param boo true:并排；false:在下。
		 * 
		 */		
		public function set textAfterImg( boo:Boolean ):void
		{
			if ( boo == true )
			{
				makeTxt( 10 + _imgWidth , _explainText.height - 5 , _width - _imgWidth - 4 );
			}
			else
			{
				makeTxt( 2 , _allHeight , _width - 2 );
			}
		}
		
		/**
		 *传入图片。传入图片后，可调用textAfterImg方法确定后续文本的位置。
		 *【注意，文本不会在超出图片范围后自动调整到图片下，需调用textAfterImg确定后续文本的位置。
		 * @param img 图片
		 * @param scale 图片缩放比。如，0.5：缩放50%。
		 * @param textAfter 后续文本是在图片下还是在图片旁。true: 在图片旁。 
		 */		
		public function setImg ( img:Bitmap , textAfter:Boolean = false ):void
		{
			img.x = 4 ;
			img.y = _explainText.height ; 
			addChild( img );
			_imgWidth = img.width;
			_allHeight = img.y + img.height ;			
			
			this.textAfterImg = textAfter ;
		}
		
		/**
		 *清除解释面板里面的文字，重新按照新setworldarray方法设置里面的文字
		 * @param strArray 文本数组，字符串。
		 * @param colorArray 颜色数组，颜色字符串，如：["#ff00ff","#ff0000","#000000"]【若只有一个元素，则默认使用到全部文本
		 * @param size 文字大小数组【若只有一个元素，则默认使用到全部文本
		 * @param isNewline 是否换行
		 * 
		 */	
		public function updateWord(strArray:Array , colorArray:Array , size:Array , isNewline:Boolean = false):void{
			_textArray.splice(0,_textArray.length);
			setWorldArray( strArray , colorArray , size , isNewline );
		}
		
		/**
		 *清除本实例。 
		 * 
		 */		
		public function clear():void{
			if(_parent!=null){
				_parent.removeEventListener(MouseEvent.MOUSE_OVER,over);
				_parent.removeEventListener(MouseEvent.MOUSE_OUT,out);
			}
			_textArray.splice( 0 , _textArray.length );
			
			var i:uint ;
			var child:*;
			for ( i = 0 ; i < this.numChildren ; i++ )
			{
				child = this.getChildAt( i ) ;
				if ( child is Bitmap )
					child.bitmapData.dispose();
				
				child = null ;
			}
			this.removeChildren();
		}
	}
}
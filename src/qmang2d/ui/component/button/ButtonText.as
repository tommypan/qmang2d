package qmang2d.ui.component.button
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import game.view.ui.ViewFilter;
	
	
	/**
	 *创建一个文本按钮。 
	 * @author L
	 * 
	 */	
	public class ButtonText extends Sprite
	{
		//按钮文本
		private var _text:TextField=new TextField();
		//是否有下划线
		private var _underline:Boolean=true;
		//字体颜色 ("#ffffff")
		private var _color:String;
		//经过时颜色
		private var _overColor:String ="#E3E0D6";
		private var _isChangeColor:Boolean = false;
		//字体大小
		private var _size:int;
		//文本
		private var _title:String;
		
		/** 
		 * 文本按钮		
		 * @param title 文本文字
		 * @param size 字体大小
		 * @param color 字体颜色 
		 * @param underline 是否有下划线
		 * 
		 */	
		public function ButtonText(title:String="东方不败",size:uint=15,color:String="#7FFF00",underline:Boolean=true)
		{
			_text.autoSize = "left";
			_text.selectable=false;
			setButtonText( title , size , color , underline );
			addChild(_text);
			_text.filters = [ViewFilter.textGlow];
		}
		
		//更新文本
		private function updataText():void
		{
			if ( _isChangeColor )
			{
				var style:StyleSheet = new StyleSheet(); 
				style.setStyle("a:hover",{color:_overColor});
				style.setStyle("a:active",{color:_overColor});
				_text.styleSheet = style; 
			}
			if(_underline==true){
				_text.htmlText="<font face='Arial' color='"+_color+"' size='"+_size+"'><a href='event:'><u>"+_title+"</u> </a></font>";
			}
			else{
				_text.htmlText="<font face='Arial' color='"+_color+"' size='"+_size+"'><a href='event:'>"+_title+" </a></font>";
			}
		}
		
	
		public function setButtonText(title:String="东方不败",size:uint=15,color:String="#7FFF00",underline:Boolean=true):void
		{
			_title=title;
			_size = size;
			_color=color;
			_underline=underline;
			updataText();
		}
		
		/**
		 *当鼠标经过时的颜色。 
		 * @param colorStr
		 */		
		public function set overColor( colorStr:String ):void
		{
			_isChangeColor = true;
			_overColor = colorStr;
			updataText();
		}
		
		/**
		 *清楚函数。 
		 * 
		 */		
		public function clear ():void
		{
			_title = null;
			removeChild( _text );
			_text = null;
		}

		public function get textfield():TextField
		{
			return _text;
		}

	}
}
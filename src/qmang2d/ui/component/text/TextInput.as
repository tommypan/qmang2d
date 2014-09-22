/*
PBK：没细看
*/
package qmang2d.ui.component.text
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TLFTypographicCase;
	
	import game.view.ui.ViewFilter;
	
	
	public class TextInput extends Sprite
	{
		
		private var _txt:TextField=new TextField();
		//背景透明度
		private var _bgAlpha:Number = 1;
		//背景颜色
		private var _txtBGcolor:uint=0x004A60;
		//文本边框颜色
		private var  _txtBorderColor:uint=0x05324F;
		//文本颜色
		private var _txtColor:uint=0x96FFFB;
		//是否具有边框
		private var _isboard:Boolean=false;
		//格式类
		private var _format:TextFormat = new TextFormat();
		//绘制背景
		private var _BGShape:Shape = new Shape();
		
		public function TextInput(width:uint=50,height:uint=20 , BG:Boolean = true)
		{
			if ( BG = true )
				addChild(_BGShape);
			
			_txt.type=TextFieldType.INPUT;
			_txt.border=_isboard;
			_txt.textColor=_txtColor;
			_txt.height=height;
			_txt.width=width;
//			focus=_txt
//			_txt.setSelection(0,_txt.length);
//			_txt.alwaysShowSelection=true;
//			_txt.
//			var tlf:TLFTypographicCase = new TLFTypographicCase;
//			tlf.
			addChild(_txt);
			
			makeBG( _txtBGcolor , _bgAlpha);
			var filter:GlowFilter = new GlowFilter ();
			filter.color = 0x000000;
			filter.blurX = filter.blurY = 10;
			filter.alpha = 0.3;
			filter.inner = true;
			_BGShape.filters = [filter];
			
			this.filters = [ViewFilter.textGlow];
		}
		
		//绘制背景
		private function makeBG( bgColor:uint , alpha:Number ):void{		
			_BGShape.graphics.clear();
			_BGShape.graphics.lineStyle(1,0x139EC0 , 1, true);
			_BGShape.graphics.beginFill( bgColor , alpha );
			_BGShape.graphics.drawRoundRect(0,0,width,height,6);
			_BGShape.graphics.endFill();
		}
		
		/**
		 *文本内容 
		 * 
		 */		
		public function get textword():String {
			return _txt.text;
		}
		public function set textword(ns:String):void {
			_txt.text=ns;
			_txt.setTextFormat(_format);
		}
		
		/**
		 *是否具有边框 
		 * @param ns
		 * 
		 */		
		public function set isborder(ns:Boolean):void {
			_isboard=ns;
			_txt.border=_isboard;
		}
		
		/**
		 *文本背景颜色 
		 * @return 
		 * 
		 */		
		public function get BGcolor():uint {
			return _txtBGcolor;
		}
		public function set BGcolor(ns:uint):void {
			_txtBGcolor=ns;
			makeBG(ns , _bgAlpha);
		}
		
		/**
		 *传入背景透明度。 
		 * @param alpha
		 * 
		 */		
		public function set BGAlpha( alpha:Number ):void
		{
			_bgAlpha = alpha;
			makeBG(_txtBGcolor , alpha);
			
		}
		/**
		 *文本颜色 
		 * @return 
		 * 
		 */		
		public function get textcolor():uint {
			return _txtColor;
		}
		public function set textcolor(ns:uint):void {
			_txtColor=ns;
			_format.color = ns;
			_txt.setTextFormat(_format);		
		}
		
		/**
		 *传入文本大小 
		 * @param size
		 * 
		 */		
		public function set textSize(size:uint):void{
			_format.size = size;
			_txt.setTextFormat(_format);
		}
		
		/**
		 *获取组件关联的textFile。 
		 * @return 
		 * 
		 */		
		public function get textFiled():TextField
		{
			return _txt;
		}
		
		public function clear():void
		{
			removeChild(_txt);
			_txt = null;
			
			_BGShape.graphics.clear();
			removeChild( _BGShape );
			_BGShape = null;
			
			_format = null;
		}
	}
}
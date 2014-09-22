package qmang2d.ui.component.button
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import game.view.ui.ViewFilter;
	
	
	/** 
	 *复选框组件
	 */	
	public class CheckBox extends Sprite
	{
		//方框
		private var _rect:Shape = new Shape();
		//对勾
		private var _right:Shape=new Shape();
		//选矿后的文本
		private var _title:TextField;
		//复选框滤镜
		private var _filter:GlowFilter=new GlowFilter();
		
		/**
		 * 复选框
		 */		
		public function CheckBox()
		{
			_rect.graphics.lineStyle(1,0x139EC0 , 1, true);
			_rect.graphics.beginFill( 0x004A60 , 1 );
			_rect.graphics.drawRoundRect(0,0,15,15,6);
			_rect.graphics.endFill();
			_filter.color = 0x000000;
			_filter.blurX = _filter.blurY = 10;
			_filter.alpha = 0.3;
			_filter.inner = true;
			_rect.filters = [_filter];
			addChild(_rect);
			
			_right.graphics.lineStyle(1.5,0x7FFF00);
			_right.graphics.moveTo(0,5);
			_right.graphics.lineTo(5,10);
			_right.graphics.moveTo(5,10);
			_right.graphics.lineTo(12,0);
			_right.visible = false;
			addChild(_right);
			this.filters = [ViewFilter.textGlow];
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
		}
		
		private function mouseOver(e:MouseEvent):void
		{			
			_filter
			_filter.color = 0x00BFFF;
			_filter.blurX = _filter.blurY = 5;
			_filter.alpha = 1;
			_filter.inner = true; 
			_rect.filters=[_filter];
		}
		
		private function mouseOut(e:MouseEvent):void
		{
			_filter.color = 0x000000;
			_filter.blurX = _filter.blurY = 10;
			_filter.alpha = 0.3;
			_filter.inner = true;
			_rect.filters = [_filter];
		}
		
		/**
		 *接收鼠标事件反映 
		 * 
		 */		
		public function clickCheckBoxEvent( e:MouseEvent = null):void
		{
			if(_right.visible==false)
			{
				_right.visible=true;
				
			}else{
				_right.visible=false;
			}
		}
		
		/**
		 * 设置checkbox属性
		 * @param title   文字标题
		 * @param textColor 文字颜色
		 * @param textSize 文字大小
		 */		
		public function setCheckBox( title:String="",textColor:uint = 0xffffff,textSize:uint = 13):void
		{
			
			_title=new TextField();
			var format:TextFormat = new TextFormat("Arial",textSize,textColor);
			_title.text=title;
			_title.x=18;
			_title.setTextFormat(format);
			_title.autoSize = "left";
			_title.y=(_rect.height-_title.height)/2;
			_title.selectable = false;
			
			addChild(_title);
		}
		
		/**
		 *传入和获得是否已选。 
		 * 
		 */		
		public function get isSelected():Boolean
		{
			return _right.visible==false?false:true;
		}
		
		public function set isSelected(value:Boolean):void{
			_right.visible = value;
		}
		
		/**
		 * 清除本实例。 
		 */		
		public function clear():void{
			this.removeEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			this.removeEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			
			removeChild( _right );
			_rect.graphics.clear();
			
			removeChild( _rect );
			_right.graphics.clear();
			_rect.filters=null;
			_right=null;
			
			_rect = null;
			_filter=null;
		}
	}
}
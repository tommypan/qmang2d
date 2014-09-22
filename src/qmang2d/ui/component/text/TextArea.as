/*
PBK：没细看
*/
package qmang2d.ui.component.text
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.engine.TextBaseline;
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.container.ScrollPolicy;
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.CompositionCompleteEvent;
	import flashx.textLayout.events.TextLayoutEvent;
	import flashx.textLayout.formats.BaselineOffset;
	import flashx.textLayout.formats.BaselineShift;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.undo.UndoManager;

	public class TextArea extends Sprite
	{
		//绘制背景
		private var _flowBG:Shape=new Shape();
		//背景颜色
		private var _BGColor:uint=new uint();
		//背景透明度
		private var _BGAlpha:Number=new Number();
		//滚动条
		private var _sroll:Scroll=new Scroll();
		//滚动条的宽
		private var _scrollWidth:uint=10;
		//组件的宽
		private var _compomentWidth:uint=new uint();
		//组件的高
		private var _compomentHeight:Number=new Number();
		//文本的宽
		private var _flowWidth:uint=new uint();
		//行数
		private var _numLine:uint=new uint();
		
		//文本的可滚动高度
		private var _flowMaxDrag:Number=new Number();
		//文本可见高度（组件高度）与可滚动高度的比
		private var _flowPercent:Number=new Number();
		//文本颜色
		private var _flowColor:uint=new uint();
		//文本字体大小
		private var _flowSize:Number=new Number();
		//文本容器
		private var _flowTextContainer:Sprite=new Sprite();
		//flow关联管理器
		private var _flowController:ContainerController;
		//格式		
		private var _flowTextContainerFormat:TextLayoutFormat=new TextLayoutFormat();
		//滚动条在左还是在右
		private var _leftOrRight:Boolean=true;
		//行高
		private var _lineHeight:uint=5;
		//是否可编辑
		private var _isedit:Boolean=true;
		//总行高和滚动范围的误差
		private var vNum:Number = 0;

		/**
		 *组件关联的textflow。 
		 */		
		public var textflow:TextFlow=new TextFlow();
		
		
		/**
		 * TLF
		 * @param width  组件的宽，也是文本可见宽
		 * @param height 组件的高，文本可见高
		 * @param fontColor 字体颜色
		 * @param fontsize 字体大小
		 * @param BGColor 背景颜色
		 * @param BGAlpha 背景透明度
		 * 
		 */		
		public function TextArea(isEdit:Boolean=true,width:uint=200,height:uint=100,fontColor:uint=0xffffff,fontsize:Number=13,BGColor:uint=0x00000,BGAlpha:Number=0.3)
		{
			_isedit=isEdit;
			_lineHeight=fontsize;
			_compomentWidth=width;
			_compomentHeight=height;
			_flowColor=fontColor;
			_flowSize=fontsize;
			_BGColor=BGColor;
			_BGAlpha=BGAlpha;
			_flowWidth=_compomentWidth;
			
			initFlow();
			updataComposition();
			drawBack();
			drawSroll();
			_sroll.visible = false;
			addChild(_sroll);
			addToStage();
			_sroll.addEventListener(Event.CHANGE,onSrollChange);
		}
		
		//更新文本可见的高与宽
		private function updataComposition():void{
			textflow.lineHeight=_lineHeight;
			_flowController.setCompositionSize(_flowWidth,_compomentHeight);
			textflow.flowComposer.updateAllControllers();
		}
		
		//初始化flow
		private function initFlow():void{
			_flowController=new ContainerController(_flowTextContainer);
			_flowController.verticalScrollPolicy=ScrollPolicy.AUTO;
			_flowController.firstBaselineOffset = BaselineOffset.LINE_HEIGHT;
			textflow.flowComposer.addController(_flowController);
			
			_flowTextContainerFormat.alignmentBaseline = TextBaseline.IDEOGRAPHIC_TOP;
			_flowTextContainerFormat.dominantBaseline = TextBaseline.IDEOGRAPHIC_CENTER;
			_flowTextContainerFormat.fontSize=_flowSize;
			_flowTextContainerFormat.color=_flowColor;
			textflow.format=_flowTextContainerFormat;
			
			this.edit = _isedit;
			textflow.addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE,onC);
			textflow.addEventListener(TextLayoutEvent.SCROLL,onFlowScroll);
		}
		
		//绘制滚动条
		private function drawSroll():void{
			_sroll.setSliderWidth=_scrollWidth;
			_sroll.setSliderHeight=_compomentHeight;
			_sroll.setHandleValue=_flowController.verticalScrollPosition/_flowMaxDrag;
		}
		
		//绘制背景
		private function drawBack():void{
			_flowBG.graphics.clear();
			_flowBG.graphics.beginFill(_BGColor);
			_flowBG.graphics.drawRect(0,0,_flowWidth,_compomentHeight);
			_flowBG.graphics.endFill();
			_flowBG.alpha=_BGAlpha;
		}
		
		//加载在舞台上
		private function addToStage():void{
			addChild(_flowBG);
			addChild(_flowTextContainer);
		}
		
		//监听滚动条滚动
		private function onSrollChange(e:Event):void{
			_flowPercent=_sroll.getHandleValue;
			_flowController.verticalScrollPosition=_flowMaxDrag*_flowPercent;
		}
		
		//更新文本以及文本实际高与可滚动高
		private function onC(e:CompositionCompleteEvent=null):void
		{
			var i:uint;
			_flowMaxDrag = 0;
			for ( i = 0 ; i < textflow.flowComposer.numLines ; i ++ )
			{
				_flowMaxDrag += textflow.flowComposer.getLineAt( i ).height;
			}
			if(_flowController.verticalScrollPosition == 0 && _flowMaxDrag < _compomentHeight)
			{
				vNum = 0 ;
			}
			_flowMaxDrag += vNum;
			_flowMaxDrag -= _compomentHeight ;

			if( _flowMaxDrag > 0 && _numLine!=textflow.flowComposer.numLines){

				_sroll.setHandlePencent= _compomentHeight / (_flowMaxDrag + _compomentHeight);
				_sroll.setHandleValue=_flowController.verticalScrollPosition / _flowMaxDrag;
				if(_flowController.compositionWidth ==_compomentWidth){
					_sroll.visible=true;
					updataTextFlow();
				}
			}else if( _flowMaxDrag <= 0 ){
				if(_flowController.compositionWidth !=_compomentWidth){
					_sroll.visible=false;
					_flowTextContainer.x=0;
					_flowBG.x=0;
					_flowWidth=_compomentWidth;
					updataComposition();
					drawBack();
				}
			}
			_numLine = textflow.flowComposer.numLines;
		}
		
		//滚动文本，更新滚动条位置
		private function onFlowScroll(e:TextLayoutEvent):void{
			if ( _flowController.verticalScrollPosition > _flowMaxDrag )
			{
				vNum = _flowController.verticalScrollPosition - _flowMaxDrag ;
				_flowMaxDrag = _flowController.verticalScrollPosition;
			}
			_sroll.setHandleValue=_flowController.verticalScrollPosition/_flowMaxDrag;
		}
		
		//调整滚动条与文本直接的大小，控制在组件的宽高之中。
		private function updataTextFlow():void{
			if(_leftOrRight==true){
				_flowWidth=_compomentWidth-_sroll.width + 2;
				_sroll.x=_flowWidth;
				_flowTextContainer.x = 2;
				updataComposition();
				drawBack();
			}else{
				_flowWidth=_compomentWidth-_sroll.width + 2;
				_sroll.x=0;
				_flowTextContainer.x=_sroll.width + 2;
				_flowBG.x=_sroll.width;
				updataComposition();
				drawBack();
			}
		}
		/**
		 *是否可编辑。 
		 * @param value
		 * 
		 */		
		public function set edit( value:Boolean ):void
		{
			
			if(value == true )
				textflow.interactionManager = new EditManager(new UndoManager());
			else
				textflow.interactionManager = null;
		}
		
		/**
		 * 
		 * 直接走到文本框最底下
		 */		
		public function goToBottom():void{
			_flowController.verticalScrollPosition=_flowMaxDrag;
			_sroll.setHandleValue=1;
		}
		/**
		 *传入文本。 
		 * @param value 字符串。
		 * 
		 */		
		public function set setText(value:String):void{
			var span:SpanElement=new SpanElement();
			span.text=value;
			var p:ParagraphElement=new ParagraphElement();
			p.addChild(span);
			textflow.addChild(p);
			textflow.flowComposer.updateAllControllers();
			textflow.flowComposer.composeToPosition();
		}
		/**
		 *控制行间距。 
		 * @param value
		 * 
		 */		
		public function set setFontHeight(value:uint):void{
			_lineHeight=value;
			updataComposition();
		}
		/**
		 *传入一个布尔值，判断滚动条的位置。 
		 * @param value 默认值为true，滚动条在右边。false滚动条在左边。
		 * 
		 */		
		public function set setSrollX(value:Boolean):void{
			_leftOrRight=value;
		}
		/**
		 *传入组件的高。 
		 * @param value
		 * 
		 */		
		public function set setHeight(value:Number):void{
			_compomentHeight=value;
			updataComposition();
			drawBack();
			drawSroll();
		}
		/**
		 *传入 组件的宽。 
		 * @param value
		 * 
		 */		
		public function set setWidth(value:uint):void{
			_compomentWidth=value;
			_flowWidth=_compomentWidth-_scrollWidth;
			drawSroll();
			updataComposition();
			drawBack();
		}
		/**
		 *传入滚动条的宽。 
		 * @param value
		 * 
		 */		
		public function set setSrollWidth(value:uint):void{
			_scrollWidth=value;
			drawSroll();
			updataComposition(); 
			drawBack();
		}
		/**
		 *传入滚动条的背景颜色 
		 * @param value
		 * 
		 */		
		public function set setScrollBGColor(value:uint):void{
			_sroll.setBackColor=value;
		}
		/**
		 *传入滚动条滑块的颜色。 
		 * @param value
		 * 
		 */		
		public function set setScrollHandleColor(value:uint):void{
			_sroll.setHandleColor=value;
		}
		
		/**
		 *清理函数。 
		 * 
		 */		
		public function clear():void
		{
			_flowBG.graphics.clear();
			removeChild( _flowBG );
			_flowBG = null ;
			
			_sroll.clear();
			removeChild( _sroll );
			_sroll.removeEventListener(Event.CHANGE , onSrollChange);
			_sroll = null ;
			
			_flowTextContainer.removeChildren();
			removeChild(_flowTextContainer);
			_flowTextContainer = null ;
			
			_flowController = null;
			_flowTextContainerFormat = null;
			
			textflow.removeEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE,onC);
			textflow.removeEventListener(TextLayoutEvent.SCROLL,onFlowScroll);
			textflow = null;
		}
	}
}



import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import qmang2d.ui.component.button.ButtonDirection;
import qmang2d.ui.component.button.ButtonRect;

	/**
	 *textarea关联的滚动条类。 
	 * @author a
	 * 
	 */
	class Scroll extends Sprite{
		//_handleBakc.height-_handle.height
		private var _dragMax:Number=new Number();
		//滑块的当前位置的y值
		private var _handleValue:Number=new Number();
		//滚动条的宽
		private var _sliderWidth:uint=20;
		//滚动条的高
		private var _sliderHeight:Number=100;
		//滑块大小占总高的比值【控制滑块的高
		private var _handlePercent:Number=new Number();
		//滚动条的背景颜色
		private var _backColor:uint=0x00ff00;
		//滑块的颜色
		private var _handleColor:uint=0x0000ff;
		//滑块
		private var _handle:ButtonRect ;
		//滚动条的背部
		private var _handleBack:Sprite=new Sprite();
		//上移按钮
		private var _upButton:ButtonDirection ;
		//下移按钮
		private var _downButton:ButtonDirection ;
		/**
		 * 滑动条，不能控制其他容器或对象，只能传入最大值和最小值。可获得滑动块代表的当前值，用途如同声音大小控制条。
		 * <p>当滑动条滑动变化时，需监听Event.CHANGE 事件，然后通过getHandleValue方法获得滑动块代表的当前值。</p>
		 * @param width 滑动条宽
		 * @param height	滑动条高
		 * @param max 滑动条最大值
		 * @param min 滑动条最小值
		 */		
		public function Scroll()
		{
			drawComponent();
			addEventListen();
		}
		//初始化滚动条
		private function drawComponent():void{
			_upButton = new ButtonDirection( _sliderWidth,_sliderWidth ) ;
			_upButton.addEventListener( MouseEvent.CLICK , onUp );
			_upButton.upButton();
			addChild( _upButton );
			
			drawBack();
			addChild(_handleBack);

			_downButton = new ButtonDirection( _sliderWidth,_sliderWidth );
			_downButton.y = _handleBack.y + _handleBack.height +3 ;
			_downButton.addEventListener( MouseEvent.CLICK , onDown );
			_downButton.downButton();
			addChild( _downButton );
			
			_handle = new ButtonRect(_sliderWidth,40);
			_handle.y = _sliderWidth + 3;
			addChild(_handle );
			drawHandle(_handlePercent);
			
			_dragMax=_handleBack.height-_handle.height;

		}
		
		//绘制上下按钮
		private function drawUpButton():void
		{
			_upButton.width = _sliderWidth;
			_upButton.height = _sliderWidth;
			_upButton.upButton();
		}
		private function drawDownButton():void
		{
			_downButton.width = _sliderWidth;
			_downButton.height = _sliderWidth;
			_downButton.y = _handleBack.y + _handleBack.height +3 ;
			_downButton.downButton();
		}
		
		//绘制背部条
		private function drawBack():void{
			_handleBack.graphics.clear();
			_handleBack.graphics.beginFill(_backColor);
			_handleBack.graphics.drawRoundRect(0,0,_sliderWidth,_sliderHeight-(_sliderWidth+3)*2,10);
			_handleBack.graphics.endFill();
			_handleBack.y = _upButton.height + 3;
		}
		
		//绘制滑块
		private function drawHandle(pencent:Number):void{
			if ( _handleBack.height*pencent < 20)
			{
				pencent = 15 /_handleBack.height ;
			}
			_handle.width = _sliderWidth;
			_handle.height = _handleBack.height*pencent;
			_handle.y = _upButton.height + 3;
			_handle.addEventListener(MouseEvent.MOUSE_DOWN,onHandleDown);
		}
		
		//添加监听
		private function addEventListen():void{
			_handle.addEventListener(MouseEvent.MOUSE_DOWN,onHandleDown);
			_handleBack.addEventListener(MouseEvent.MOUSE_DOWN,onBackDown);
			addEventListener(MouseEvent.MOUSE_WHEEL,onWhell);
		}
		
		//上移滑块
		private function onUp(e:MouseEvent):void{
			_handle.y-=5;
			if(_handle.y<_handleBack.y){
				_handle.y=_handleBack.y;
			}
			upDataHadleValue();
		}
		//下移滑块
		private function onDown(e:MouseEvent):void{
			_handle.y += 5;
			if(_handle.y+_handle.height>_handleBack.height+_handleBack.y){
				_handle.y=_handleBack.height-_handle.height+_handleBack.y;
			}
			upDataHadleValue();
		}
		
		//背部条滚动
		private function onWhell(e:MouseEvent):void{
			e.delta=5*e.delta;
			_handle.y-=e.delta;
			if(_handle.y+_handle.height>_handleBack.height+_handleBack.y){
				_handle.y=_handleBack.height+_handleBack.y-_handle.height;
			}else if(_handle.y<_handleBack.y){
				_handle.y=_handleBack.y;
			}
			upDataHadleValue();
		}
		
		//按下滑块
		private function onHandleDown(e:MouseEvent):void{
			_handle.changeButtonMode = 2;
			_handle.startDrag(false,new Rectangle(0,_handleBack.y,0,_handleBack.height-_handle.height));
			_handle.addEventListener(MouseEvent.MOUSE_UP,onHandleUp);
			_handle.addEventListener(MouseEvent.MOUSE_MOVE,onHandleMove);
		}
		
		private function onHandleMove(e:MouseEvent):void{
			upDataHadleValue();
		}
		
		private function onHandleUp(e:MouseEvent):void{
			_handle.stopDrag();
			_handle.removeEventListener(MouseEvent.MOUSE_UP,onHandleUp);
			_handle.removeEventListener(MouseEvent.MOUSE_MOVE,onHandleMove);
		}
		
		private function onBackDown(e:MouseEvent):void{
				if(_handleBack.mouseY>_handle.y||_handleBack.mouseY<_handle.y){
					_handle.y=_handleBack.mouseY-_handle.height/2;
					if(_handle.y+_handle.height>_handleBack.height){
						_handle.y=_handleBack.height-_handle.height;
					}else if(_handle.y<_handleBack.y){
						_handle.y=0;
					}
				}
			upDataHadleValue();
		}
		
		//更新滑块y值与可滑动大小的比值，派发监听
		private function upDataHadleValue():void{
			_handleValue=(_handle.y-_handleBack.y)/(_handleBack.height-_handle.height);	
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		//更新滑块位置
		private function updataHandleY():void{
			_handle.y=_handleValue*(_handleBack.height-_handle.height)+_handleBack.y;	
		}
		
		
		/**
		 *传入按钮的当前值。 
		 * @param value
		 * 
		 */		
		public function set setHandleValue(value:Number):void{
			_handleValue=value;
			updataHandleY();
		}
		/**
		 *获取滑动条的当前值 
		 */		
		public function get getHandleValue():Number{
			return _handleValue;
		}
		/**
		 *传入滑动条的高度 。
		 * @param value 
		 * 
		 */		
		public function set setSliderHeight(value:Number):void{
			_sliderHeight=value;
			drawUpButton();
			drawBack();
			drawDownButton();
			drawHandle(_handlePercent);
		}
		/**
		 *传入滑动条的宽度。 
		 * @param value
		 */		
		public function set setSliderWidth(value:uint):void{
			_sliderWidth=value;
			drawUpButton();
			drawBack();
			drawDownButton();
			drawHandle(_handlePercent);
		}
		/**
		 *传入背景颜色。 
		 * @param value
		 * 
		 */		
		public function set setBackColor(value:uint):void{
			_backColor=value;
			drawBack();
		}
		/**
		 *传入滑动块颜色。 
		 * @param value
		 * 
		 */		
		public function set setHandleColor(value:uint):void{
			_handleColor=value;
			drawHandle(_handlePercent);
		}
		public function set setHandlePencent(value:Number):void{
			drawHandle(value);
			_handlePercent=value;
		}
		
		/**
		 *清理函数。 
		 * 
		 */		
		public function clear ():void
		{
			_upButton.clear();
			removeChild( _upButton );
			_upButton.removeEventListener(MouseEvent.CLICK , onUp);
			_upButton = null;
			
			_downButton.clear();
			_upButton.removeEventListener(MouseEvent.CLICK , onDown);
			removeChild( _downButton );
			_downButton = null ;
			
			_handle.clear();
			_handle.removeEventListener(MouseEvent.MOUSE_UP,onHandleUp);
			_handle.removeEventListener(MouseEvent.MOUSE_MOVE,onHandleMove);
			_handle.removeEventListener(MouseEvent.MOUSE_DOWN,onHandleDown);
			removeChild( _handle );
			_handle = null;
			
			_handleBack.graphics.clear();
			_handleBack.removeEventListener(MouseEvent.MOUSE_DOWN,onBackDown);
			removeChild( _handle );
			_handleBack = null;
			
			removeEventListener( MouseEvent.MOUSE_WHEEL,onWhell );
		}
	}


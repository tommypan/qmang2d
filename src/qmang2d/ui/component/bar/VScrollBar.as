package qmang2d.ui.component.bar
{
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display3D.IndexBuffer3D;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import qmang2d.ui.component.button.ButtonDirection;
	import qmang2d.ui.component.button.ButtonRect;

	
	
	/**
	 *绘制一个滚动条。 
	 * @author D
	 */	
	public class VScrollBar extends Sprite
	{
		//背景条
		private var _scroBg:Sprite;
		//滑动块
		private var _scroSli:ButtonRect;
		//上按钮
		private var _shapeUp:ButtonDirection;
		//下按钮
		private var _shapeDown:ButtonDirection;
		//滚动条的x坐标
		private var _scroBgX:uint;
		//滚动条的y
		private var _scroBgY:uint;
		//滚动条绑定内容的y
		public var _targetY:uint;
		public var _targetX:uint;
		//滚动条控制对象
		public var _target:DisplayObjectContainer;
		//舞台
		private var _Stagetarget:Stage;
		//鼠标滚动的速度
		private var _speed:uint=4;
		//所控制容器的最大滚动范围
		private var _tagetMaxDrag:uint;
		//滑块的最多滑动范围
		private var _sliMax:uint;
		//滑块的高
		private var _sliHeight:uint;
		//滑标的宽
		private var _sliWidth:uint;
		//控制容器的实际高
		private var _targetHeight:uint;
		//控制容器的可见高
		public var _visibleHeight:uint;
		//控制容器的可见宽
		private var _visibleWidth:uint;
		//滑标的方向
		private var _direction:String;
		//滑标的背景
		private var matr:Matrix;
		
		/**
		 * 滚动条。传入控制对象，然后将滚动条和对象整合成为一个整体显示在舞台上。
		 * 
		 * @param target 控制的对象
		 * @param targetX x坐标
		 * @param targetY y坐标
		 * @param targetVisibleHeight 控制对象要显示范围的高
		 * @param targetVisibleWidth 控制对象要显示范围的宽
		 * @param sliWidth 滚动条的宽
		 * @param direction 滚动条在左（L），还是在右（R）。
		 * @param tagheight 内容的高
		 */
		public function VScrollBar(target:DisplayObjectContainer=null,targetX:uint=0,targetY:uint=0,targetVisibleHeight:uint=0,targetVisibleWidth:uint=200,sliWidth:uint=15,direction:String="R",tagheight:Number=0 )
		{
			_visibleHeight=targetVisibleHeight;
			_visibleWidth=targetVisibleWidth;
			_targetY=targetY;
			_targetX=targetX;
			_direction=direction;
			_sliWidth=sliWidth;
			_target=target;
			if(_target!=null){
				_target.x=targetX;
				_target.y=_targetY;
				addChild(_target);
				if(tagheight!=0){
					_targetHeight=tagheight;
				}
				else{
					_targetHeight = _target.height;
				}
				this.addEventListener(MouseEvent.MOUSE_WHEEL,onTagetWhell);
			}
			if(direction=="L"){
				_scroBgX=targetX-sliWidth;
			}else if(direction=="R"){
				_scroBgX=targetX+targetVisibleWidth;
			}
			
			_shapeUp=new ButtonDirection( sliWidth,sliWidth );
			_shapeUp.x = _scroBgX;
			_shapeUp.y = targetY;
			_shapeUp.addEventListener(MouseEvent.CLICK , onUpClick );
			_shapeUp.upButton();
			addChild(_shapeUp);
			
			
			_shapeDown=new ButtonDirection( sliWidth,sliWidth );
			_shapeDown.downButton();
			_shapeDown.addEventListener(MouseEvent.CLICK , onDownClick );
			upDate();
		}
		/**
		 *更新滚动条显示。 
		 * 
		 */		
		public function upDate():void{
			if(_target!=null){
				_target.scrollRect = new Rectangle(0, 0,_visibleWidth,_visibleHeight);
			}
			_tagetMaxDrag=_visibleHeight - (_sliWidth+3)*2; 
			_sliHeight=(_visibleHeight/_targetHeight)*_tagetMaxDrag;
			if(_sliHeight < 20) _sliHeight = 20; 
			_sliMax=_tagetMaxDrag-_sliHeight;
			
			_visibleHeight=_visibleHeight;
			
			if(_scroBg){
				_scroBg.graphics.clear();
				removeChild(_scroBg);
			}
			_scroBg=new Sprite();
			matr=new Matrix();
			matr.createGradientBox(180,180,Math.PI/2,0,100);
			_scroBg.graphics.beginGradientFill(GradientType.LINEAR, [0x45DCB,0x34659], [0.5,1], [0,210], matr, SpreadMethod.PAD);
			_scroBg.graphics.drawRoundRect(0,0,_sliWidth,_tagetMaxDrag,5,5);
			_scroBg.graphics.endFill();
			_scroBg.y=_targetY+_shapeUp.height+3;
			_scroBg.x=_scroBgX;
			_scroBg.addEventListener(MouseEvent.CLICK,onBGClick); 
			addChild(_scroBg);
			
			if(_scroSli){
				_scroSli.removeEventListener(MouseEvent.MOUSE_DOWN,onHandleDown);
				removeChild(_scroSli);
			}
			_scroSli=new ButtonRect( _sliWidth,_sliHeight);
			_scroSli.x = _scroBgX;
			_scroSli.y = _scroBg.y;
			_scroSli.closeEventListen = 5;
			addChild(_scroSli);
			_scroSli.addEventListener(MouseEvent.MOUSE_DOWN,onHandleDown);
			
			_shapeDown.x=_scroBgX;
			_shapeDown.y=_scroBg.y+_scroBg.height+3;
			addChild(_shapeDown);
		}
		//按下滑块触发
		private function onHandleDown(e:MouseEvent):void{
			_scroSli.startDrag(false,new Rectangle(_scroBgX,_scroBg.y,0,_sliMax));
			stage.addEventListener(MouseEvent.MOUSE_UP,onHandleUp);
			addEventListener(MouseEvent.MOUSE_MOVE,onHandleMove);
		}
		
		//放开滑块触发
		private  function onHandleUp(e:MouseEvent):void{		
			_scroSli.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP,onHandleUp);
			removeEventListener(MouseEvent.MOUSE_MOVE,onHandleMove);
		}
		
		//移动滑块触发
		private function onHandleMove(e:MouseEvent):void{
			updateTargetY();
		}
		
		//点击滚动条背景触发
		private function onBGClick(event:MouseEvent):void{
			if(mouseY>_scroSli.y||mouseY<_scroSli.y){
				_scroSli.y=mouseY-_scroSli.height/2;
				if(_scroSli.y+_scroSli.height>_scroBg.y+_scroBg.height){
					_scroSli.y=_scroBg.y+_scroBg.height-_scroSli.height;
				}else if(_scroSli.y<_scroBg.y){
					_scroSli.y=_scroBg.y;
				}
			}
			updateTargetY();
		}
		
		//点击上移按钮
		private function onUpClick(event:MouseEvent):void{
			_scroSli.y-=4;
			if(_scroSli.y<=_scroBg.y){
				_scroSli.y=_scroBg.y;
			}
			updateTargetY();
		}
		
		//点击下移按钮
		private function onDownClick(event:MouseEvent):void{
			_scroSli.y+=4;
			if(_scroSli.y+_scroSli.height>=_scroBg.height+_scroBg.y){
				_scroSli.y=_scroBg.height-_scroSli.height+_scroBg.y;
			}
			updateTargetY();
		}
		
		//更新控制容器的可见区域
		private function  updateTargetY():void{
			var rect:Rectangle = _target.scrollRect;
			rect.y =((_scroSli.y-_scroBg.y)/_sliMax )*(_targetHeight-_visibleHeight);
			rect.height=_visibleHeight;
			_target.scrollRect = rect;
		}
		
		//当在容器上滑动鼠标滚轮
		private function onTagetWhell(e:MouseEvent):void{
			var rect:Rectangle = _target.scrollRect;
			e.delta=5*e.delta;
			rect.y-=e.delta;
			if((rect.y<=0)&&(e.delta>0)){
				rect.y=0;
				_target.y=_targetY;
				rect.height=_visibleHeight;
			}else if((rect.y>=_targetHeight-_visibleHeight)&&(e.delta<0)){
				rect.y=_targetHeight-_visibleHeight;
				_target.y=_targetY;
				_target.height=_visibleHeight;
			}
			_scroSli.y=(rect.y/(_targetHeight-_visibleHeight))*_sliMax+_scroBg.y;
			_target.scrollRect = rect;
			if(_scroSli.y+_scroSli.height>_scroBg.height+_scroBg.y){
				_scroSli.y=_scroBg.height-_scroSli.height+_scroBg.y;
			}else if(_scroSli.y<_scroBg.y){
				_scroSli.y=_scroBg.y;
			}
		}
		
		/**
		 *清除此实例 
		 * 
		 */		
		public function clear():void{
			this.removeChildren();
			
			_shapeUp.clear();
			_shapeUp.removeEventListener(MouseEvent.CLICK,onUpClick);
			_shapeUp = null;
			_shapeDown.clear();
			_shapeDown.removeEventListener(MouseEvent.CLICK,onDownClick);
			_shapeDown = null;
			
			_Stagetarget.removeEventListener(MouseEvent.MOUSE_UP,onHandleUp);
			_Stagetarget.removeEventListener(MouseEvent.MOUSE_MOVE,onHandleMove);
			
			_scroBg.removeEventListener(MouseEvent.CLICK,onBGClick); 
			_scroBg.graphics.clear();
			_scroBg = null;
			
			_scroSli.removeEventListener(MouseEvent.MOUSE_MOVE,onHandleMove);
			_scroSli.clear();
			_scroSli = null;
			
			if(_target!=null){
				_target.removeEventListener(MouseEvent.MOUSE_WHEEL,onTagetWhell);
			}
		}
	}
}
/**
 * Version 1.0.0 Alpha https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.filters.DisplacementMapFilter;
	
	import morn.core.handlers.Handler;
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	
	/**按钮类*/
	public class SimpleButton extends Component {
		protected var _clips:Object = new Object();
		protected var _clickHandler:Handler;
		protected var _stateMap:Object = {"rollOver": 1, "rollOut": 0, "mouseDown": 2, "mouseUp": 1, "selected": 2};
		protected var _state:int;
		protected var _toggle:Boolean;
		protected var _selected:Boolean;
		protected var _sizeGrid:Array = [4, 4, 4, 4];
		
		public function SimpleButton() {
			super();
		}
		
		override protected function initialize():void {
			addEventListener(MouseEvent.ROLL_OVER, onMouse);
			addEventListener(MouseEvent.ROLL_OUT, onMouse);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouse);
			addEventListener(MouseEvent.MOUSE_UP, onMouse);
			addEventListener(MouseEvent.CLICK, onMouse);
		}
		
		protected function onMouse(e:MouseEvent):void {
			if ((_toggle == false && _selected) || _disabled) {
				return;
			}
			if (e.type == MouseEvent.CLICK) {
				if (_toggle) {
					selected = !_selected;
				}
				if (_clickHandler) {
					_clickHandler.execute();
				}
				return;
			}
			if (_selected == false) {
				state = _stateMap[e.type];
			}
		}
		
		public function set upState(upState:DisplayObject):void {
			if(_state == 0 && _clips[0]!=null && this.contains(_clips[0])) {
				this.removeChild(_clips[0]);
			}
			_clips[0] = upState;
			initializeDraw();
		}
		
		public function set overState(overState:DisplayObject):void{
			if(_state == 1 && _clips[1]!=null && this.contains(_clips[1])) {
				this.removeChild(_clips[1]);
			}
			_clips[1] = overState;
			initializeDraw();
		}
		
		public function set downState(downState:DisplayObject):void{
			if(_state == 2&& _clips[2]!=null && this.contains(_clips[2])) {
				this.removeChild(_clips[2]);
			}
			_clips[2] = downState;
			initializeDraw();		
		}
		
		override protected function render():void {
			super.render();
		}
		
		/**是否选择*/
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				state = _selected ? _stateMap["selected"] : _stateMap["rollOut"];
			}
		}
		
		protected function get state():int {
			return _state;
		}
		
		protected function set state(value:int):void {
			if(_state == value){return ;}
			if(_clips[_state] != null && _clips[value] != null) {
				this.removeChild(_clips[_state]);
			}
			_state = value;
			if(_clips[_state] != null) {
				this.addChild(_clips[_state]);
			}
		}
		
		protected function initializeDraw():void{
			this.addChild(_clips[_state]);
		}
		
		/**控制是否处于切换状态*/
		public function get toggle():Boolean {
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void {
			if (_toggle != value) {
				_toggle = value;
			}
		}
		
		override public function set disabled(value:Boolean):void {
			if (_disabled != value) {
				super.disabled = value;
				state = _stateMap["rollOut"];
				ObjectUtils.gray(this, _disabled);
			}
		}
		
		/**点击处理器(无默认参数)*/
		public function get clickHandler():Handler {
			return _clickHandler;
		}
		
		public function set clickHandler(value:Handler):void {
			if (_clickHandler != value) {
				_clickHandler = value;
			}
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		public function get sizeGrid():String {
			return _sizeGrid.toString();
		}
		
		public function set sizeGrid(value:String):void {
			_sizeGrid = StringUtils.fillArray([4, 4, 4, 4], value);
		}
	}
}
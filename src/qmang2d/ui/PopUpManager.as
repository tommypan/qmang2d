package qmang2d.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import qmang2d.utils.StageProxy;
	
	/**
	 * 弹出框管理工具
	 *@author as3Lover_ph
	 *@date 2013-3-19
	 */
	public class PopUpManager 
	{
		
		public static const CLOSE:String = "close";
		
		public static var layer:DisplayObjectContainer;
		
		
		private static var _dic:Dictionary = new Dictionary(true);
		
		/**模态资源存储器*/
		private static var _modalDic:Dictionary = new Dictionary(true);
		
		/**
		 * 创造弹出框
		 * @param $popUpClass $popUpClass一般继承于Sprite的一个类（注意传入类，不是对象）
		 * @param isModal_是否为为模态
		 * @param alphaNum在为模态的情况下，设置模态的背景alpha值
		 * @return 返回是传入类的对象
		 * 
		 */	
		public static function createPopUp($popUpClass:Class, isModal_:Boolean=true, alphaNum:Number=0):DisplayObject
		{
			
			var displayObject:DisplayObject;//先找，找不到就创造一个
			if (_dic[$popUpClass] != undefined){
				displayObject = _dic[$popUpClass];
				setmodal(displayObject, false);
			} else {
				displayObject = new ($popUpClass)();
				
				_dic[$popUpClass] = displayObject;
			}
			
			
			layer.addChild(displayObject);
			if (isModal_ == true){
				setmodal(displayObject, true, 0, alphaNum);
			} else {
				setmodal(displayObject, false);
			};
			
			//默认在中间弹出
			centerPopUp(displayObject);
			displayObject.addEventListener(Event.CLOSE, closeHandle);
			return (displayObject);
		}
		
		/**
		 *移除弹出框的对象 。如果是模态的，那么其附属的背景也将被一起移除
		 * @param $displayObject 就是创造一个弹出框返回的实例
		 * 
		 */		
		public static function removePopUp($displayObject:DisplayObject):void
		{
			
			if ( $displayObject == null || $displayObject.parent == null)
				return;
			
			if ($displayObject is DisplayObjectContainer)
			{
				DisplayObjectContainer($displayObject).mouseChildren = false;
				InteractiveObject($displayObject).mouseEnabled = false;
			}
			
			delete _dic[$displayObject["constructor"]];
			var maskLayer:Sprite = _modalDic[$displayObject];
			
			if (maskLayer != null && maskLayer.parent != null)
				maskLayer.parent.removeChild(maskLayer);
			
			delete _modalDic[$displayObject];
			$displayObject.parent.removeChild($displayObject);
		}
		
		/**
		 * 设置弹出框的位置
		 * @param $displayObject 创造弹出框的实例
		 * @param xpo_x坐标
		 * @param ypo_y坐标
		 * 
		 */		
		public static function setPopUpPosition($displayObject:DisplayObject, xpo_:Number=0, ypo_:Number=0):void
		{
			$displayObject.x = xpo_;
			$displayObject.y = ypo_;
		}
		
		/**
		 *将弹出框位置默认为居中 （使用createPopUp默认为居中）
		 * @param $displayObject创造弹出框的实例
		 * 
		 */		
		public static function centerPopUp($displayObject:DisplayObject):void
		{
			//  >>1跟/2差不多
			$displayObject.x = (((StageProxy.width  - $displayObject.width) >> 1) - StageProxy.leftOffset());
			$displayObject.y = (((StageProxy.height - $displayObject.height) >> 1) - StageProxy.upOffset());
			//trace("StageProxy.width,StageProxy.height",StageProxy.width,StageProxy.height);//1000 580
			//trace("$displayObject.width,$displayObject.height",$displayObject.width,$displayObject.height);//728 109   928 109
			//trace("$displayObject.x,$displayObject.y",$displayObject.x,$displayObject.y);//136 235   36 235
		}
		
		/**
		 * 是否有某弹出框
		 * @param $popUpClass
		 * @return 
		 * 
		 */		
		public static function hasWindow($popUpClass:Class):Boolean
		{
			return (!((_dic[$popUpClass] == undefined)));
		}
		
		/**
		 * 得到某弹出框
		 * @param $popUpClass
		 * @return 
		 * 
		 */		
		public static function getWindow($popUpClass:Class):DisplayObject
		{
			if (hasWindow($popUpClass) == true){
				return (_dic[$popUpClass]);
			};
			return (null);
		}
		
		
		private static function closeHandle(_arg1:Event):void
		{
			_arg1.target.removeEventListener(CLOSE, closeHandle);
			removePopUp(DisplayObject(_arg1.target));
		}
		
		
		private static function setmodal($displayObject:DisplayObject, isShowMask_:Boolean=true, colorNum:Number=0, alphaNum:Number=0):void
		{
			var rect:Sprite;
			var maskLayer:Sprite = _modalDic[$displayObject];
			if (isShowMask_ == false){
				if (((!((maskLayer == null))) && (layer.contains(maskLayer)))){
					layer.removeChild(maskLayer);
				};
				delete _modalDic[$displayObject];
				return;//为false直接返回
			};
			if (maskLayer == null){
				rect = new Sprite();
				rect.graphics.beginFill(colorNum, alphaNum);
				rect.graphics.drawRect(-(StageProxy.leftOffset()), -(StageProxy.upOffset()), StageProxy.width, StageProxy.height);
				maskLayer = rect;
				_modalDic[$displayObject] = maskLayer;
			};
			layer.addChildAt(maskLayer, layer.getChildIndex($displayObject));
		}
		
		
	}
}

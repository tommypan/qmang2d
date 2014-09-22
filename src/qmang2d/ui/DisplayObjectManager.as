package  qmang2d.ui {
	import flash.display.*;
	import flash.filters.*;
	
	/**
	 * 可显示对象的方法工具
	 * @author as3Lover_ph
	 * 
	 */	
	public class DisplayObjectManager {
		
		/**
		 *移除一个容器里面所有的显示对象。比如：DisplayObjectManager.clearChildren(effectContainer) 
		 * @param $container 要移除的显示容器
		 * 
		 */		
		public static function clearChildren($container:DisplayObjectContainer):void{
			while ($container.numChildren > 0) {
				$container.removeChildAt(0);
			}
		}
		
		
		/**
		 *设置显示对象鼠标监听可用（防止用户他妈的狂点鼠标）
		 * @param $displayObject要设置的显示对象
		 * @param isEnable_设置监听Enable，当设置为false时，会出现滤镜效果，这样显示对象会显示为灰色
		 * 
		 */		
		public static function setEnbled($displayObject:DisplayObject, isEnable_:Boolean):void{
			var array:Array;
			var colorMatrixF:ColorMatrixFilter;
			if ($displayObject is InteractiveObject)
				InteractiveObject($displayObject).mouseEnabled = isEnable_;
			
			if (isEnable_ == false){
				array = new Array();
				array = array.concat([0.33, 0.33, 0.33, 0, 0]);
				array = array.concat([0.33, 0.33, 0.33, 0, 0]);
				array = array.concat([0.33, 0.33, 0.33, 0, 0]);
				array = array.concat([0, 0, 0, 1, 0]);
				colorMatrixF = new ColorMatrixFilter(array);
				$displayObject.filters = [colorMatrixF];
			} else {
				$displayObject.filters = [];
			}
			
			//$displayObject.filters = $displayObject.filters || [];
		}
		
	}
}

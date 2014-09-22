package qmang2d.ui.component.button
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import game.view.core.res.ResList;
	import game.view.core.res.ResManager;
	
	/**
	 * 
	 * 关闭按钮类
	 * 
	 */	
	public class ButtonClose extends Sprite
	{
		/**
		 * 关闭按钮
		 */	
		public function ButtonClose()
		{
			var bmp :Bitmap = new Bitmap();
			ResManager.getInstance().getPNG("resources/ui/baseui/close.png", bmp, ResList.PRIORITY_MIDDLE, true);
			addChild(bmp);
			
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}
	
		private function onOut(e:MouseEvent):void {
			alpha=1;
		}	
		
		private function onOver(e:MouseEvent):void {
			alpha=0.6;
		}
		
		/**
		 * 清除函数
		 */		
		public function clear():void{
			this.removeEventListener(MouseEvent.MOUSE_OUT,onOut);
			this.removeEventListener(MouseEvent.MOUSE_OVER,onOver);
			(removeChildAt(0) as Bitmap).bitmapData.dispose();
		}
	}
}
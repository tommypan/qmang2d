/*
具体的一些图标按钮，比如关闭按钮，要等资源传输储存具体情况再决定
*/
package qmang2d.ui.component.button
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	
	/**
	 * 图片按钮
	 */
	public class ButtonImage extends Sprite
	{
		/**
		 * 图片的 BitmapData 资源
		 * 
		 * @param bitmapData：图片资源
		 */
		public function ButtonImage(bitmap:Bitmap)
		{
			addChild(bitmap);
		}
		
		public function clear():void
		{
			(removeChildAt(0) as Bitmap).bitmapData = null;
		}
		
		/**
		 * 深度清理，释放图片资源占用的内存
		 */
		public function deepClear():void
		{
			var bitmap :Bitmap = removeChildAt(0) as Bitmap;
			bitmap.bitmapData.dispose();
			bitmap.bitmapData = null;
		}
	}
}
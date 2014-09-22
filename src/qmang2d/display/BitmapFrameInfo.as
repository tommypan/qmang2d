package  qmang2d.display 
{
	import qmang2d.qmang2d;
	import qmang2d.cacher.SmartSourceCacher;
	
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	use namespace qmang2d;
	
	/**
	 * 位图帧基本信息
	 * @author as3Lover_ph
	 *@date 2013-1-25
	 */
	public class BitmapFrameInfo
	{
		/**
		 * x轴偏移
		 */
		qmang2d var x:Number;
		
		/**
		 * y轴偏移
		 */
		qmang2d var y:Number;
		
		/**
		 * 位图数据
		 */
		qmang2d var bitmapData:BitmapData;
		
		
	}
}
package qmang2d.display 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import qmang2d.qmang2d;
	
	use namespace qmang2d;
	
	/**
	 * 位图缓存类
	 * @author as3Lover_ph
	 *@date 2013-1-25
	 * */
	public class BitmapCacher
	{
		
		/**
		 * 缓存单张位图，这个主要为缓存整个movieClip服务，虽然可以支持旋转，缩放，但是由于旋转缩放位图均会对渲染效率产生影响，而大型游戏中
		 * 大小，缩放等都是设计之初已经定好，所以开始几个设计参数显得没有必要。所以暂时注释掉，如有需要在进行改写，也是很简单的事情
		 * 注：在player10之前的版本中，重绘机制比较笨拙，所以必须好要做一些像素剔除，边缘判断等。但是之后已经有很大改进，故在此省了一些步骤
		 * @param	source			要被绘制的目标对象
		 * @param	transparent	是否透明
		 * @param	fillColor			填充色
		 * @param	scale				绘制的缩放值
		 * @return
		 */
		static qmang2d function cacheFrame(mc:MovieClip/*, transparent:Boolean = true, fillColor:uint = 0x00000000*/, scale:Number = 1):BitmapFrameInfo
		{
			var bitInfo:BitmapFrameInfo;
			var bitData:BitmapData;
			
			//mc是否为空已经判断，在此不需要再次判断
			var rect:Rectangle = mc.getBounds(mc);
			if(rect.isEmpty())//防止无效的bitmapData异常。经常遇到类似问题
			{
				rect.width  = 1;
				rect.height = 1;
			}
			
			bitData = new BitmapData(Math.ceil(rect.width), Math.ceil(rect.height), true, 0);
			bitData.draw(mc, new Matrix(scale, 0, 0, scale, -rect.x, -rect.y), null, null, null, false);
			bitInfo = new BitmapFrameInfo();
			bitInfo.x = rect.x;
			bitInfo.y = rect.y;
			bitInfo.bitmapData = bitData;
			
			return bitInfo;
			
			//			rect = mc.getBounds(mc);
			//			x = Math.round(rect.x);
			//			y = Math.round(rect.y);
			//			
			//			//防止空白帧报错
			//			if (rect.isEmpty())
			//			{
			//				rect.width = 1;
			//				rect.height = 1;
			//			}
			//			//截图
			//			var bitmapData:BitmapData = new BitmapData(Math.ceil(rect.width), Math.ceil(rect.height), true, 0x000000);
			//			bitmapData.draw(mc, new Matrix(1, 0, 0, 1, -x, -y), null, null, null, true);
			//			
			//			//剔除透明边界
			//			realRect = bitmapData.getColorBoundsRect(0xFF000000, 0x00000000, false);
			//			
			//			if (!realRect.isEmpty() && (bitmapData.width != realRect.width || bitmapData.height != realRect.height))
			//			{
			//				
			//				var realBitData:BitmapData = new BitmapData(realRect.width, realRect.height, true, 0x000000);
			//				realBitData.copyPixels(bitmapData, realRect, pot);
			//				
			//				bitmapData.dispose();
			//				bitmapData = realBitData;
			//				x += realRect.x;
			//				y += realRect.y;
			//				
			//			}
			//			
			//			var bitmapMCFrameInfo:BitmapFrameInfo=new BitmapFrameInfo();
			//			bitmapMCFrameInfo.bitmapData=bitmapData;
			//			bitmapMCFrameInfo.x=x;
			//			bitmapMCFrameInfo.y=y;
			//			return bitmapMCFrameInfo;
		}
		
		/**
		 * 缓存位图动画
		 * @param	mc				要被绘制的影片剪辑
		 * @param	transparent	是否透明
		 * @param	fillColor			填充色
		 * @param	scale				绘制的缩放值
		 * @return
		 */
		static qmang2d function cacheBitmapMovie(source:MovieClip/*, transparent:Boolean = true, fillColor:uint = 0x00000000*/, scale:Number = 1):Vector.<BitmapFrameInfo>
		{
			
			var bitmapMCFrameInfoArr:Vector.<BitmapFrameInfo>=new Vector.<BitmapFrameInfo>();
			var i:int;
			var length:int=source.totalFrames;
			for(i=0;i<length;i++)
			{
				source.gotoAndStop(i+1);
				bitmapMCFrameInfoArr[i] = cacheFrame(source/*,smoothing*/);
			}
			return bitmapMCFrameInfoArr;
		}
		
		
		
	}
	
}
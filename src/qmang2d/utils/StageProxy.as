package qmang2d.utils
{
	import flash.display.Stage;
	
	/**
	 * 舞台代理
	 * <p>使用静态的stage代理，避免大规模蛋疼的stage传参</p>
	 *@author as3Lover_ph
	 *@date 2013-3-14
	 */
	public class StageProxy
	{
		public static var stage:Stage;
		public static var _isRegisted:Boolean;
		public static var _height:Number;
		public static var _width:Number;
		
		/**
		 *注册舞台 
		 * @param $stage
		 * 
		 */		
		public static function registed($stage:Stage, width_:Number=1000, height_:Number=580):void{
			_isRegisted = true;
			stage = $stage;
			_width = width_;
			_height = height_;
		}
		
		/**
		 * 获取舞台高度
		 * @return 舞台高度
		 * 
		 */		
		public static function stageHeight():Number{
			return (stage.stageHeight);
		}
		
		/**
		 * 获取舞台宽度
		 * @return 舞台宽度
		 * 
		 */		
		public static function stageWidth():Number{
			return (stage.stageWidth);
		}
		
		
		public static function get startHeight():Number{
			return (580);
		}
		public static function get startWidth():Number{
			return (1000);
		}
		
		/**
		 *获取当前舞台高度 
		 * @return 
		 * 
		 */		
		public static function get height():Number{
			//trace("stage.stageHeight",stage.stageHeight);//375
			return (Math.max(stage.stageHeight, 637));
		}
		
		/**
		 *获取当前舞台宽度 
		 * @return 
		 * 
		 */	
		public static function get width():Number{
			//trace("stage.stageWidth",stage.stageWidth);//500
			return (Math.max(stage.stageWidth, 1366));
		}
		
		/**
		 * 舞台与初始舞台大小的左偏移量
		 * @return 
		 * 
		 */		
		public static function leftOffset():Number{
			return (0);
		}
		
		/**
		 * 舞台与初始舞台大小的右偏移量
		 * @return 
		 * 
		 */		
		public static function rightOffset():Number{
			return ((stage.stageWidth - 1366));
		}
		
		/**
		 * 舞台与初始舞台大小的上偏移量
		 * @return 
		 * 
		 */		
		public static function upOffset():Number{
			return (0);
		}
		
		/**
		 * 舞台与初始舞台大小的下偏移量
		 * @return 
		 * 
		 */		
		public static function downOffset():Number{
			return ((stage.stageHeight - 637));
		}
		
	}
}
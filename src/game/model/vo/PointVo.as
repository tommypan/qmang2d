package game.model.vo
{
	import qmang2d.pool.interfaces.IPool;
	
	/**
	 *自定义point，实现类似 Point类功能。
	 * <p>轻量级
	 * <p>可以采用对象池优化
	 * @author panhao
	 * 
	 */	
	public class PointVo
	{
		/**
		 *x pixel 
		 */		
		public var x:int;
		
		/**
		 *y pixel 
		 */		
		public var y :int;
		
		
		public function PointVo(x_:int,y_:int)
		{
			x = x_;
			y = y_;
		}
	}
}
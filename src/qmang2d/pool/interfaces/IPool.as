package qmang2d.pool.interfaces
{
	public interface IPool
	{
		public function IPool();
		
		
		/**
		 * start the animation and add all listeners
		 * 
		 */			
		function wakeUp():void;
		
		
		/**
		 *stop the animation and remove all listeners
		 * <p>it did not kill the memory cause  we would use  pool to solve the problem
		 * 
		 */
		function sleep():void;
	}
}
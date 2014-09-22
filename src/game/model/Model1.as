package game.model
{
	import qmang2d.framework.ModelFactory;

	public class Model1 
	{
		private var counter :int;
		
		public function Model1()
		{
		}
		
		public function say():void
		{
			counter++;
			trace("call"+counter);
		}
	}
}
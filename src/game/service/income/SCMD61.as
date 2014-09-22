package game.service.income
{
	import qmang2d.framework.command.IncommingBase;
	
	public class SCMD61 extends IncommingBase
	{
		public var fallOrWin :String;
		
		public var sum:int;
		
		public function SCMD61(id1:uint)
		{
			super(id1);
		}
		
		override public function fill(obj:Object):void
		{
			fallOrWin = obj.fallOrWin;
			sum = obj.sum;
		}
		
		
	}
}
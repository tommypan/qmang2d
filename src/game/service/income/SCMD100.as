package game.service.income
{
	import flash.utils.ByteArray;
	
	import qmang2d.framework.command.IncommingBase;

	/**
	 *登陆结果包，收到 
	 * @author panhao
	 * 
	 */	
	public class SCMD100 extends IncommingBase
	{
		public var result :int;
		
		public function SCMD100(id1:uint)
		{
			super(id1);
		}
		
		override public function fill(obj:Object):void
		{
			result = int(obj);
		}
		
		
	}
}
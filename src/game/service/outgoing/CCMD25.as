package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD25 extends OutgoingBase
	{
		public var guess20 :int;
		
		public function CCMD25(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj :Object= new Object();
			obj.guess20 = guess20;
			_socket.sendJSON(obj,25);
		}
		
	}
}
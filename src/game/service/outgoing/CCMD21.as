package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD21 extends OutgoingBase
	{
		public var guess0 :int;
		
		public function CCMD21(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj :Object= new Object();
			obj.guess0 = guess0;
			_socket.sendJSON(obj,21);
		}
		
	}
}
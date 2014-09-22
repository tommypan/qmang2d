package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD22 extends OutgoingBase
	{
		public var guess5 :int;
		
		public function CCMD22(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj :Object= new Object();
			obj.guess5 = guess5;
			_socket.sendJSON(obj,22);
		}
		
	}
}
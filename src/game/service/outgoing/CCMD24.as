package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD24 extends OutgoingBase
	{
		public var guess15 :int;
		
		public function CCMD24(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj :Object= new Object();
			obj.guess15 = guess15;
			_socket.sendJSON(obj,24);
		}
		
	}
}
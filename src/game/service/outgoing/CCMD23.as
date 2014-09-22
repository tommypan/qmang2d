package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD23 extends OutgoingBase
	{
		public var guess10 :int;
		
		public function CCMD23(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj :Object= new Object();
			obj.guess10 = guess10;
			_socket.sendJSON(obj,23);
		}
		
	}
}
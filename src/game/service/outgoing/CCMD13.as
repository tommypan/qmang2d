package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD13 extends OutgoingBase
	{
		public var input10 :int;
		
		public function CCMD13(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj :Object= new Object();
			obj.input10 = input10;
			_socket.sendJSON(obj,13);
		}
		
	}
}
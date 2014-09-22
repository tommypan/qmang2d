package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD12 extends OutgoingBase
	{
		public var input5 :int;
		
		public function CCMD12(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj :Object= new Object();
			obj.input5 = input5;
			_socket.sendJSON(obj,12);
		}
		
		
	}
}
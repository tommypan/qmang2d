package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD11 extends OutgoingBase
	{
		public var input0 :int;
		
		public function CCMD11(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj :Object= new Object();
			obj.input0 = input0;
			_socket.sendJSON(obj,11);
		}
		
		
	}
}
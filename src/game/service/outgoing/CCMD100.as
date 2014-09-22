package game.service.outgoing
{
	import qmang2d.framework.command.OutgoingBase;
	
	public class CCMD100 extends OutgoingBase
	{
		public var id :String;
		public var pwd :String;
		
		public function CCMD100(id1:uint)
		{
			super(id1);
		}
		
		override public function send():void
		{
			var obj:Object = {};
			obj.id = id;
			obj.pwd = pwd;
			_socket.sendJSON(obj,commandId);
		}
		
		
	}
}
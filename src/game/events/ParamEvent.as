package game.events
{
	import flash.events.Event;

	public class ParamEvent extends Event
	{
		public var data :Object;
		
		public function ParamEvent(type:String,data_:Object)
		{
			super(type);
			data = data_;
		}
	}
}
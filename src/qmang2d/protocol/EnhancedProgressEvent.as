package qmang2d.protocol
{
	import flash.events.ProgressEvent;

	/**
	 *@author aser_ph
	 *@date 2013-4-14
	 */
	public class EnhancedProgressEvent extends ProgressEvent
	{
		public  var resType :String;
		
		public function EnhancedProgressEvent(type:String, resType_:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:Number=0, bytesTotal:Number=0)
		{
			super(type,bubbles,cancelable,bytesLoaded,bytesTotal);
			resType = resType_;
		}
		
	}
}
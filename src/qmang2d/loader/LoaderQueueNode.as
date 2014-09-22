package qmang2d.loader
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	import qmang2d.qmang2d;
	
	use namespace qmang2d;
	
	/**
	 * 链队列的节点信息
	 *@author as3Lover_ph
	 *@date 2013-1-22
	 */
	public class LoaderQueueNode
	{
		//-----------------------逻辑存储--------------------------------------------------
		/**链表下一个节点域*/
		qmang2d var next :LoaderQueueNode;
		
		//----------------------节点信息-------------------------------------------------
		/**链表节点自身存储信息*/
		qmang2d var data :Object = {};
		
		public function LoaderQueueNode()
		{
		}
		
		
	}
}
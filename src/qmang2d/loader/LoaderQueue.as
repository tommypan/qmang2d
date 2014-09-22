package qmang2d.loader
{
	import qmang2d.qmang2d;
	
	use namespace qmang2d;
	
	/**
	 * 链队列，降低了时间复杂度。提升效率
	 * 让加载工具按照队列进行加载
	 *@author as3Lover_ph
	 *@date 2013-1-22
	 */
	public class LoaderQueue
	{
		/**
		 *链表现有节点数（不计入头结点） 
		 */		
		private var _length :int = 0;
		
		/**
		 *链表头结点
		 */		
		private var _front :LoaderQueueNode;
		
		/**
		 *链表尾节点 
		 */		
		private var _rear :LoaderQueueNode;
		
		//链表高级尾节点
		private var _highRear :LoaderQueueNode;
		
		//链表中级尾节点
		private var _middleRear :LoaderQueueNode;
		
		/**
		 * 优先级<高级>：
		 * 必须优先于所有资源加载的资源，用于加载用户当前操作所需的资源
		 * 可用于：当前用户操作的UI
		 */
		public static const PRIORITY_FIRST :int = 2;
		
		/**优先级<中级>：默认正常加载优先级*/
		public static const PRIORITY_COMMON :int = 1;
		
		/**优先级<低级>：预加载，在资源都加载完成后*/
		public static const PRIORITY_PRELOADING :int = 0;
		
		
		public function LoaderQueue()
		{
			//建立链队列，头结点占位，不含数据域
			var node :LoaderQueueNode = new LoaderQueueNode();
			node.data = null;
			
			_front = _rear = node;
		}
		
		
		/**
		 *进入队列，放置于队列尾
		 * @param $node 被放置的节点 
		 * 
		 */			
		public function enQueue($node:LoaderQueueNode):void
		{
			_rear.next = $node;
			_rear = $node;
			_length++;
		}
		
		
		/**
		 *退出队列，从队列头弹出
		 * @return 返回此被弹出的节点
		 * 
		 */				
		public function deQueue():LoaderQueueNode
		{
			if(_front == _rear) throw new Error("链表已为空");
			
			var node :LoaderQueueNode = _front.next;
			_front.next = node.next;
			
			if(_rear == node) _rear = _front;
			
			_length--
			 //trace("弹出后链表的长度为："+_length);
			
			return node;
		}
		
		/**
		 *得到链表第一个节点 
		 * @return 第一个节点
		 * 
		 */		
		public function getFirstNode():LoaderQueueNode
		{
			//外面有判断，这里就不脱了裤子放屁了
			return _front.next;
		}
		
		
		//----------------读写器----------------------
		
		public function get length():int
		{
			return _length;
		}
		
		
		
	}
}

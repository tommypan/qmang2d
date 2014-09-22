package qmang2d.framework
{
	/**
	 *被继承的controller，被继承后拥有游戏全局的一个事件派发器 
	 * @author panhao
	 * 
	 */	
	public class Controller
	{
		public var dispatcher:GameDispatcher;
		
		public function Controller()
		{
			dispatcher = GameDispatcher.getInstance();
		}
		
	}
}
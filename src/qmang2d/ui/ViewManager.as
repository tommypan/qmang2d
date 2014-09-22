package qmang2d.ui
{
	import flash.errors.IllegalOperationError;

	/**
	 * <p>基于加载管理器上面搭建ui框架</p>
	 * <p>用掌握的资源管理技术来方便我们的项目开发</p>
	 * <p>关闭其它同级窗口与视图，显示模块视图</p>
	 *@author as3Lover_ph
	 *@date 2013-3-2
	 */
	public class ViewManager
	{
		private static var _instance :ViewManager;
		
		public function ViewManager($singltonEnforcer :SingltonEnforcer)
		{
			if(!$singltonEnforcer)
			{
				throw new IllegalOperationError("搞毛啊，这是单例，用getInstance方法吧");
			}else{
				//what???
			}
		}
		
		public static function getInstance():ViewManager
		{
			_instance ||= new ViewManager( new SingltonEnforcer());
			return _instance;
		}
		
		public function changeView($changeVo :ChangeViewVo):void
		{
			
		}
		
		
	}
}
internal class SingltonEnforcer{}
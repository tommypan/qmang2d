package qmang2d.ui
{
	/**
	 *@author as3Lover_ph
	 *@date 2013-3-2
	 */
	public class ChangeViewVo
	{
		public var modualName :String;
		public var swfNames :String;
		public var canCancel :Boolean;
		public var guiName :String;
		public var isClearBox :Boolean; //是否关闭其它模块视图
		public var boxLevel :int; //模块视图层次级别
		public var isModal :Boolean; //是否为模态
		
		public function ChangeViewVo()
		{
		}
	}
}
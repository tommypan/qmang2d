package qmang2d.findPath
{
	import flash.utils.*;
	
	/**
	 * 以节点为基本单位讨论，将地图中可能的矩形，菱形等进行抽象
	 * a*寻路至少需要开放列表，g，h，f计算
	 * @author aser_ph
	 * 
	 */	
	public class FindNode
	{
		
		public static var _dic:Dictionary = new Dictionary();
		
		/**f值*/
		public var value_f:int;
		
		/**g值，父节点到开放列表里面的移动代价。跟移动代价设置有关系，移动代价设置与地图复杂程度有关*/
		public var value_g:int;
		
		/**h值,目标到开放列表里面节点的横向数跟纵向数和再乘以10*/
		public var value_h:int;
		
		public var open:Boolean;
		
		/**父节点*/
		public var nodeparent:FindNode;
		public var block:Boolean;
		public var value:int;
		public var x:int;
		public var y:int;
		public var dir:int = 0;
		
		public static function clearDic():void
		{
			_dic = new Dictionary();
		}
		
		public static function changeValue(_arg1:FindNode):void
		{
			if (_dic[_arg1] == undefined)
				_dic[_arg1] = null;
			
		}
		
		/**
		 *重置字典里面数据，一般在切换地图时 
		 * 
		 */		
		public static function resetDic():void
		{
			var _local1:*;
			for (_local1 in _dic) 
			{
				_local1.block = false;
				_local1.open = false;
				_local1.value_g = 0;
				_local1.value_h = 0;
				_local1.value_f = 0;
				_local1.nodeparent = null;
			}
		}
		
		public function init(_arg1:int, _arg2:int, _arg3:int):void
		{
			this.x = _arg1;
			this.y = _arg2;
			this.value = _arg3;
			this.block = false;
			this.open = false;
			this.value_g = 0;
			this.value_h = 0;
			this.value_f = 0;
			this.nodeparent = null;
		}
		
		
		private function reset():void
		{
			this.block = false;
			this.open = false;
			this.value_g = 0;
			this.value_h = 0;
			this.value_f = 0;
			this.nodeparent = null;
		}
		
	}
}

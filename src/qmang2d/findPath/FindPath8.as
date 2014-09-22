package qmang2d.findPath 
{
	
	import flash.geom.*;
	
	/**
	 *只是场景里面有调用 
	 * @author zxy
	 * 
	 */	
	public class FindPath8 implements IFindPath 
	{
		
		//地图数据，是从外部传入的拷贝了一份。先初始化竖行
		private static var _map:Array = [];
		
		/**地图纵节点个数*/
		private var _h:int;
		/**地图横节点个数*/
		private var _w:int;
		
		/**算好的*/
		protected var _path:Array;
		/**开放列表*/
		private var _open:Array;
		
		/**寻路出发点*/
		private var _startNode:FindNode;
		/**寻路终点*/
		private var _endNode:FindNode;
		
		/**
		 *传入mapData 
		 * @param _arg1
		 * 
		 */		
		public function FindPath8($mapData:Array)
		{
			var walkableNum:int;
			var judgeWalkeIndex:int;
			var hIndex:int;
			var wIndex:int;
			this._path = [];
			super();
			FindNode.resetDic();
			this._w = $mapData[0].length;
			this._h = $mapData.length;
			hIndex = 0;
			while (hIndex < this._h) 
			{
				if (_map[hIndex] == undefined)
					_map[hIndex] = new Array();
				
				wIndex = 0;
				while (wIndex < this._w) 
				{
					judgeWalkeIndex = $mapData[hIndex][wIndex];
					//可以走的存储数字
					if ((((((((((((((((judgeWalkeIndex == 0)) || ((judgeWalkeIndex == 2)))) || ((judgeWalkeIndex == 3)))) || ((judgeWalkeIndex == 5)))) || ((judgeWalkeIndex == 6)))) || ((judgeWalkeIndex == 7)))) || ((judgeWalkeIndex == 8)))) || ((judgeWalkeIndex == 61)))){
						walkableNum = 0;
					} else {
						walkableNum = 1;
					}
					if (_map[hIndex][wIndex] == undefined)
					{
						_map[hIndex][wIndex] = new FindNode();
						_map[hIndex][wIndex].x = wIndex;        //横索引          
						_map[hIndex][wIndex].y = hIndex;		//竖索引
					};
					FindNode(_map[hIndex][wIndex]).value = walkableNum;  //可走与否
					wIndex++;
				}
				hIndex++;
			}
			FindNode.clearDic();
		}
		
		/**
		 * 寻路
		 * @param startPoint
		 * @param endPoint
		 * @return 
		 * 
		 */		
		public function find(startPoint:Point, endPoint:Point):Array
		{
			var suspectOpenArr:Array;
			var arrLength:int;
			var index:int;
			var node:FindNode;
			this._path = [];
			if (_map[startPoint.y] == null)	//鲁棒检查
			{
				return (null);
			};
			this._startNode = _map[startPoint.y][startPoint.x];	//转换为Node
			
			
			if (_map[endPoint.y] == null) //鲁棒检查
			{
				return (null);
			};
			trace(endPoint.y,endPoint.x, _map[endPoint.y][endPoint.x]);
			this._endNode = _map[endPoint.y][endPoint.x];
			
			
			if ((((this._endNode == null)) || ((this._endNode.value == 1))))	//还是检查
			{
				return (null);
			};
			if ((((this._startNode == null)) || ((this._startNode.value == 1))))
			{
				return (null);
			};
			if ((((this._endNode.x == this._startNode.x)) && ((this._endNode.y == this._startNode.y))))
			{
				return (null);
			};
			
			
			var getEnd:Boolean;
			this.initBlock();
			var neighborNode:FindNode = this._startNode;
			while (!getEnd) //找点寻路
			{
				neighborNode.block = true;
				FindNode.changeValue(neighborNode);
				suspectOpenArr = [];
				if (neighborNode.y > 0) //八方向，加入开放列表，节点旁边八个，类似于九宫格
				{
					suspectOpenArr.push(_map[(neighborNode.y - 1)][neighborNode.x]);
				};
				if (neighborNode.x > 0)
				{
					suspectOpenArr.push(_map[neighborNode.y][(neighborNode.x - 1)]);
				};
				if (neighborNode.x < (this._w - 1))
				{
					suspectOpenArr.push(_map[neighborNode.y][(neighborNode.x + 1)]);
				};
				if (neighborNode.y < (this._h - 1))
				{
					suspectOpenArr.push(_map[(neighborNode.y + 1)][neighborNode.x]);
				};
				if ((((((neighborNode.y > 0)) && ((neighborNode.x > 0)))) && (!((((_map[neighborNode.y][(neighborNode.x - 1)].value == 1)) && ((_map[(neighborNode.y - 1)][neighborNode.x].value == 1)))))))
				{
					suspectOpenArr.push(_map[(neighborNode.y - 1)][(neighborNode.x - 1)]);
				};
				if ((((((neighborNode.y < (this._h - 1))) && ((neighborNode.x > 0)))) && (!((((_map[neighborNode.y][(neighborNode.x - 1)].value == 1)) && ((_map[(neighborNode.y + 1)][neighborNode.x].value == 1)))))))
				{
					suspectOpenArr.push(_map[(neighborNode.y + 1)][(neighborNode.x - 1)]);
				};
				if ((((((neighborNode.y > 0)) && ((neighborNode.x < (this._w - 1))))) && (!((((_map[(neighborNode.y - 1)][neighborNode.x].value == 1)) && ((_map[neighborNode.y][(neighborNode.x + 1)].value == 1)))))))
				{
					suspectOpenArr.push(_map[(neighborNode.y - 1)][(neighborNode.x + 1)]);
				};
				if ((((((neighborNode.y < (this._h - 1))) && ((neighborNode.x < (this._w - 1))))) && (!((((_map[(neighborNode.y + 1)][neighborNode.x].value == 1)) && ((_map[neighborNode.y][(neighborNode.x + 1)].value == 1)))))))
				{
					suspectOpenArr.push(_map[(neighborNode.y + 1)][(neighborNode.x + 1)]);
				};
				
				
				
				arrLength = suspectOpenArr.length;
				index = 0;
				while (index < arrLength) 
				{
					node = suspectOpenArr[index];//将可疑的节点取出
					if (node == this._endNode)
					{
						node.nodeparent = neighborNode;
						getEnd = true;
						break;
					};
					if (node.value == 0)//如果可以走
					{
						this.count(node, neighborNode);//计算ghf，看是否加载到开放列表中去
						FindNode.changeValue(node);
					};
					index++;
				};
				
				if (!getEnd)
				{
					if (this._open.length > 0)
					{
						neighborNode = this._open.splice(this.getMin(), 1)[0];//通过getMin()找到下个路点时，在开放列表里面删除
					} else {
//						return ([]);
						break;
					};
				}
				
				
			};
			
			
			this.drawPath();
			trace(_path);
			return (this._path);
		}
		
		
		public function aheadNode(_arg1:FindNode):void
		{
			var _local4:int;
			var _local5:FindNode;
			var _local2:int;
			var _local3:int = (this._open.length - 1);
			if (this._open.length == 0)
			{
				this._open.push(_arg1);
			} else {
				if (FindNode(this._open[_local2]).value_f < _arg1.value_f)
				{
					this._open.unshift(_arg1);
				} else {
					if (FindNode(this._open[_local3]).value_f > _arg1.value_f)
					{
						this._open.push(_arg1);
					} else {
						_local4 = 0;
						while ((_local3 - _local2) > 1)
						{
							_local4 = (((_local3 - _local2) >> 1) + _local2);
							_local5 = this._open[_local4];
							if (_arg1.value_f < _local5.value_f)
							{
								_local2 = _local4;
							} else {
								_local3 = _local4;
							};
						};
						this._open.splice((_local4 + 1), 0, _arg1);
					};
				};
			};
		}
		
		
		public function get path():Array
		{
			return (this._path);
		}
		
		
		private function addToOpen(_arg1:FindNode):void
		{
			this._open.push(_arg1);
			_arg1.open = true;
		}
		
		
		private function ghf(n$ode:FindNode):void
		{
			var w_gap:Number = this.abs((n$ode.x - this._endNode.x));
			var h_gap:Number = this.abs((n$ode.y - this._endNode.y));
			n$ode.value_h = (10 * (w_gap + h_gap));//*10 估算
			n$ode.value_f = (n$ode.value_g + n$ode.value_h); //f就是h+g，取最小的f值
		}
		
		/**省效率，舍不得调原有的*/
		private function abs(value:int):int
		{
			return (((value < 0)) ? (value * -1) : value);
		}
		
		
		private function drawPath():void
		{
			var _local1:FindNode = this._endNode;
			while (_local1 != this._startNode)
			{
				trace(_path);
				this._path.unshift(new Point(_local1.x, _local1.y));
				_local1 = _local1.nodeparent;
			};
			this._path.unshift(new Point(_local1.x, _local1.y));
		}
		
		/**
		 *测算真正的开放列表节点 
		 * @param node
		 * @param neighborNode
		 * 
		 */		
		private function count(node:FindNode, neighborNode:FindNode):void
		{
			var value_g:Number=0;
			if (!node.block)
			{
				value_g = (neighborNode.value_g + 10);
				if ((((this.abs((node.x - neighborNode.x)) == 1)) && ((this.abs((node.y - neighborNode.y)) == 1))))
				{
					value_g = (neighborNode.value_g + 14);
				} else {
					value_g = (neighborNode.value_g + 10);
				};
				if (node.open)
				{
					if (node.value_g >= value_g)
					{
						node.value_g = value_g;
						this.ghf(node);//计算改变节点ghf值
						node.nodeparent = neighborNode;
					};
				} else {
					this.addToOpen(node);
					node.value_g = value_g;
					this.ghf(node);
					node.nodeparent = neighborNode;
				};
			};
		}
		
		
		private function getMin():int
		{
			var openLength:int = this._open.length;
			var maxDistance:Number = 100000;
			var minNum:int;
			var index:int;
			while (index < openLength) 
			{
				if (maxDistance > this._open[index].value_f)
				{
					maxDistance = this._open[index].value_f;
					minNum = index;
				}
				index++;
			}
			
			return minNum;
		}
		
		
		private function initBlock():void
		{
			FindNode.resetDic();
			this._open = [];
			FindNode.clearDic();
		}
		
	}
}

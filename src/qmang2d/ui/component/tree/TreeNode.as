/*
PBK：没细看
*/
package qmang2d.ui.component.tree
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import game.view.ui.ViewFilter;
	import qmang2d.ui.component.list.ListItem;
	

	/**
	 * 树的节点
	 * @author w
	 * 
	 */	
	public class TreeNode extends ListItem
	{
//		private var _parentNode:TreeNode;//储存此节点的父节点
		
		//此节点的子节点数组
		private var _childArray:Array = new Array();
		//此节点的索引
		private var _index:String = "1";
		//此节点是否为父节点
		private var _isParent:Boolean = false;
		//此节点是否处于打开状态
		private var _isOpen:Boolean = false;
		
		/**
		 *此节点显示的高。是此节点的高和此节点下子节点的显示的高的和。 
		 */		
		public var showHeight:Number = 0
			
			
		/**
		 * tree的节点。
		* @param parent 父容器
		 * @param xpos x坐标
		 * @param ypos y坐标
		 * @param contentArray 内容数组
		 * @param xArray 内容的坐标数组【与内容数组依次对应
		 * @param width 宽
		 * @param height 高
		 * @param BGColor 背景颜色
		 * @param BGAlpha 背景透明度
		 * @param textColor 文本颜色
		 * @param textSize 文本大小
		 * 
		 */		
		public function TreeNode(  width:Number , height:Number )
		{
			showHeight  = height;
			super(  width , height );
		}
		
		//覆盖listItem下的makeContent方法，显示contentArray数组的内容。
		override protected function makeContent( contentArray:Array , xArray:Array ):void
		{
			var i:uint = 0;
			
			for ( ; i < contentArray.length ; i++ ){
				
				if ( contentArray[i] is String || contentArray[i] is Number){
					var text:TextField = new TextField();
					if ( text.height >  _height ) text.height =  _height ;
					text.htmlText = "<font face='宋体' color='"+_textColor+"' size='"+_textSize+"'>"+contentArray[i]+"</font>";
					text.width =  text.textWidth + 5; 
					text.y = ( this._height - text.height )/2;
					if ( this._height == 0 || text.y < 0) text.y = 0;
					text.x = xArray[i];
					text.mouseEnabled = false ;
					text.filters = [ViewFilter.textGlow];
					this.addChild(text);
					_content[i] = text;
				}else{
					contentArray[i].x = xArray[i];
					this.addChild(contentArray[i]);
				}
			}	
		}
		
		/**
		 *是否是父节点。 
		 * @return 
		 * 
		 */		
		public function get isParent():Boolean
		{
			return _isParent;
		}

		/**
		 *是否是父节点 
		 * @param value
		 * 
		 */		
		public function set isParent(value:Boolean):void
		{
			_isParent = value;
		}

		/**
		 *更新此节点下子节点的布局。 
		 * @param node
		 * 
		 */		
		public function updataLayout( node:TreeNode ):void
		{
			var i:uint = 1;
			var childArray:Array = node.getChildArray;
			childArray[0].y = node.nodeHeight;
			while (  i < childArray.length )
			{
				childArray[i].y = childArray[i-1].y + childArray[i-1].showHeight;
				i++;
			}
			if ( node.parent is TreeNode )
				updataLayout( TreeNode( node.parent ) );
		}
		
		/**
		 *此节点是否是展开状态。 
		 * @return 
		 * 
		 */		
		public function get isOpen():Boolean
		{
			return _isOpen;
		}

		public function set isOpen(value:Boolean):void
		{
			_isOpen = value;
		}

		/**
		 *此节点的父节点索引。 
		 * @return 
		 * 
		 */	
		public function get parentIndex():String
		{
			return TreeNode(this.parent).parentIndex;
		}
		
		/**
		 *此节点的索引。 
		 * @param index
		 * 
		 */	
		public function set index( index:String ):void
		{
			_index = index;
		}
		public function get index():String
		{
			return _index;
		}
		
		/**
		 *此节点的高。 
		 */	
		public function get nodeHeight():Number
		{
			return _height;
		}
		
		/**
		 *通过索引获取子节点 
		 * @param index 子节点的索引【0开始。 
		 */		
		public function getChildByIndex( index:uint ):TreeNode
		{
			return TreeNode(_childArray [index]);
		}
		
		/**
		 *获取此节点的子节点数组. 
		 * @return 
		 * 
		 */		
		public function get getChildArray():Array
		{
			return _childArray;
		}
		/**
		 *添加子节点到相应位置。 
		 * @param index
		 * 
		 */		
		public function addChildByIndex( childNode:TreeNode , index:uint ):void
		{
			_childArray.splice(index , 0 , childNode );
			addChild( childNode );
			updataLayout( this );
		}
		
		override public function clear():void
		{
			super.clear();
			
			if ( _isParent == true )
			{
				this.removeChildren();
				var i:uint;
				for ( i = 0 ; i < _childArray.length ; i++ )
				{
					_childArray[i].clear();
					_childArray[i] = null;
				} 
				_childArray.splice( 0 , _childArray.length );
			}
		}
	}
}
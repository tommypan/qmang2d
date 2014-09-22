/*
PBK：没细看
*/
package  qmang2d.ui.component.tree
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import qmang2d.ui.component.button.ButtonDirection;
	
	
	/**
	 *tree 
	 * @author w
	 * 
	 */	
	public class Tree extends Sprite
	{
		//父节点前的按钮，若buttonStyle选择ICON_BUTTON，就会显示这个按钮
		private var _iconButton:ButtonDirection;
		//父节点打开时显示的打开图片，如buttonStyle选择ICON_IMG，则显示这个按钮图片
		private var _openIcon:Bitmap ;
		//节点打开时显示的关闭图片
		private var _closeIcon:Bitmap ;
		//tree下第一组子节点
		private var _firstNode:Array = new Array();
		//按钮模式，是方形按钮还是图片按钮。		
		private var _buttonStyle:String;
		
		/**
		 *确定按钮模式，此选项须传入两张图片作为按钮 
		 */		
		public static const ICON_IMG:String = "iconImg";
		
		/**
		 * 确定按钮模式，此选项设定使用方形按钮，图标是三角形
		 */		
		public static const ICON_BUTTON_TRIANGLE:String = "iconButtonTraingle";
		
		/**
		 *确定按钮模式，此选项设定使用方形按钮，图标为加减符号。 
		 */		
		public static const ICON_BUTTON_PLUS:String = "iconButtonPlus";
		
		
		/**
		 * 绘制tree。
		 * @param buttonStyle 确定父节点的按钮模式。
		 * 
		 */		
		public function Tree( buttonStyle:String = "iconButtonTraingle")
		{
			_buttonStyle = buttonStyle;
		}
		
		//解析索引，返回相应的节点 
		private function analysisIndex( index:String):*
		{
			var i:uint = 1;
			var node:TreeNode;
			if ( index != "-1" ){
				node = _firstNode[ uint(index.substr( 0 , 1 )) ]
				while (  i < index.length )
				{
					node = node.getChildArray[ uint(index.substr( i , 1 )) ];
					i++;
				}
				return node;
			}
			else
				return this;
		}
		
		//传入节点内容数组时，获得其中最大的高 
		private function nodeContentHeight( content:Array):Number
		{
			var i:uint;
			var height:Number = 0;
			
			var textFiled:TextField = new TextField();
			
			
			for (	i = 0 ; i <content.length ; i++)
			{
				if ( content[i] is String ){
					textFiled.htmlText = "<font face='宋体' color='#ffffff' size='13'>"+ content[i] +"</font>";
					textFiled.autoSize = "left";
					height = textFiled.height;
				}
				else
					height = content[i].height>height ?content[i].height:height;
			}
			return height;
		}
		
		//调整tree下第一组节点之间的位置
		private function updataLayout():void
		{
			var i:uint;
			_firstNode[0].y = 0;
			_firstNode[0].index = 0;
			for ( i = 1; i < this.numChildren ; i++)
			{
				_firstNode[i].index = i;
				_firstNode[i].y = _firstNode[i-1].y + _firstNode[i-1].showHeight;
			}
		}
		
		//更改节点将要显示的高。
		private function changeNodeShowheight( node:TreeNode , num:Number , isAdd:Boolean = true ):void
		{
			var i:uint ;
			var parentNode:TreeNode;
			if ( node.parent is Tree )
				parentNode = node;
			else
				parentNode = TreeNode(node.parent);
			
			if ( isAdd == true )
			{
				node.showHeight +=num ;
			}
			else
			{
				node.showHeight -=num;
			}
			if ( node.parent is TreeNode )
			{
				changeNodeShowheight( parentNode , num  , isAdd );
			}
		}
		
		//父节点按钮点击函数
		private function nodeClick( e:MouseEvent ):void
		{
			var node:TreeNode = e.currentTarget.parent ;
			var i:uint;
			var childArray:Array = node.getChildArray;
			var firstNode:TreeNode = _firstNode[ uint(node.index.substr(0,1)) ];
			var num:uint = 0;
			
			if ( node.isOpen != true )
			{
				node.isOpen = true;
				for ( i = 0 ; i < childArray.length ; i++)
				{
					childArray[i].visible = true;
					num += childArray[i].showHeight;
				}
				
				changeNodeShowheight( node , num );
				
				if ( _buttonStyle == ICON_BUTTON_TRIANGLE )
					ButtonDirection( e.currentTarget ).downButton();
				else if ( _buttonStyle == ICON_BUTTON_PLUS )
					ButtonDirection( e.currentTarget ).minusButton();
				else if ( _buttonStyle == ICON_IMG )
				{
					Sprite( e.currentTarget ).getChildAt( 0 ).visible = true;
					Sprite( e.currentTarget ).getChildAt( 1 ).visible = false;
				}
			}
			else
			{
				node.isOpen = false;
				for ( i = 0 ; i <childArray.length ; i++)
				{
					childArray[i].visible = false;
					num += childArray[i].showHeight;
				}
				changeNodeShowheight( node , num, false );
				
				if ( _buttonStyle == ICON_BUTTON_TRIANGLE )
					ButtonDirection( e.currentTarget ).rightButton();
				else if ( _buttonStyle == ICON_BUTTON_PLUS )
					ButtonDirection( e.currentTarget ).plusButton();
				else if ( _buttonStyle == ICON_IMG )
				{
					Sprite( e.currentTarget ).getChildAt( 0 ).visible = false;
					Sprite( e.currentTarget ).getChildAt( 1 ).visible = true;
				}
			}
			
			updataLayout();
			if ( node.parent is TreeNode)
				TreeNode( node.parent ).updataLayout( TreeNode( node.parent ) );
		}
		
		//为父节点添加按钮
		private function makeParentButton( node:TreeNode ):void
		{
			var parentContent:Array = node.getContent;
			if ( _buttonStyle != ICON_IMG )
			{
				_iconButton = new ButtonDirection( node.nodeHeight *4/5, node.nodeHeight *4/5 );
				_iconButton.y = (node.nodeHeight - _iconButton.height) / 2;
				_iconButton.addEventListener( MouseEvent.CLICK , nodeClick );
				node.addChild( _iconButton );
				
				if ( _buttonStyle == ICON_BUTTON_TRIANGLE )
					_iconButton.rightButton();
				else if ( _buttonStyle == ICON_BUTTON_PLUS )
					_iconButton.plusButton();
				
				parentContent.unshift(_iconButton);
			}
			else
			{
				var imgButton:Sprite = new Sprite();
				imgButton.addEventListener( MouseEvent.CLICK , nodeClick );
				imgButton.buttonMode = true;
				imgButton.addChild( new Bitmap(_openIcon.bitmapData.clone() ));
				imgButton.addChild( new Bitmap(_closeIcon.bitmapData.clone() ));
				imgButton.getChildAt(0).visible = false;
				node.addChild( imgButton);
				parentContent.unshift(imgButton);
			}
			
			
			var xArray:Array = new Array();
			var i:uint;
			xArray.push(0);
			for ( i = 0 ; i <  node.getXArray.length ; i++ )
			{
				xArray.push(node.getXArray[i] + parentContent[0].width+3);
			}
			node.changeContent( parentContent , xArray);
			node.isParent = true;
		}
		
		//		/**
		//		 *传入节点和方法，将对节点下所有节点遍历此方法。 
		//		 * @param node
		//		 * @param func
		//		 * 
		//		 */		
		//		public function ( node:TreeNode , func:Function ):void
		//		{
		//			
		//		}
		
		/**
		 *添加子节点到特定的父节点。 
		 * @param parentIndex 父节点在树的位置（索引）。[若父节点为根节点，则索引为-1
		 * @param content 子节点的内容。
		 * @param childIndex 子节点在父节点下的位置（索引）。
		 */		
		public function addChildNode ( parentIndex:String , content:Array ,  xArray:Array , childIndex:int ):void
		{
			var contentWidth:Number = 0;
			
			if ( content[content.length-1] is String )
			{
				var textFiled:TextField = new TextField();
				textFiled.htmlText = "<font face='宋体' color='#ffffff' size='13'>"+ content[content.length-1] +"</font>";
				textFiled.autoSize = "left";
				contentWidth = textFiled.width+xArray[xArray.length-1];
			}
			else
			{
				contentWidth = content[content.length-1].width+xArray[xArray.length-1];
			}
			
			var parentNode:*= analysisIndex( parentIndex );
			
			if ( childIndex > parentNode.getChildArray.length ) 
				childIndex = parentNode.getChildArray.length;
			
			var node:TreeNode = new TreeNode( 
				contentWidth , nodeContentHeight(content) );
			node.setContent( content , xArray );
			node.textColor = "#fffffff";
			node.textSize = 13;
			
			if (  parentNode is Tree )
			{
				_firstNode.splice(childIndex , 0 , node );
				addChildAt( node , childIndex );
				updataLayout();
			}
				
			else if (parentNode is TreeNode )
			{
				if ( parentNode.isParent != true)// && parentNode != _rootNode)
					makeParentButton(parentNode);
				
				parentNode.addChildByIndex( node , childIndex);
				node.index = parentNode.index + childIndex.toString();
				node.x = parentNode.getContent[0].width+ 8;
				if ( parentNode.isOpen != true ) 
				{
					node.visible = false;
				}
				else 
				{
					//					_firstNode[ uint(node.index.substr(0,1)) ].showHeight +=  node.nodeHeight;
					this.updataLayout();
				}
			}
		}
		
		/**
		 *获取tree下所有的树的数组。 
		 * @return 
		 * 
		 */		
		public function get getChildArray():Array
		{
			return _firstNode;
		}
		
		/**
		 *删除Index位置的子节点
		 * @param index 子节点在父节点下的索引
		 * @return 返回被删除的子节点
		 */		
		public function delectChildNode( index:String ):TreeNode
		{
			var node:TreeNode = analysisIndex( index );
			
			if ( node.parent is TreeNode )
			{
				var parentNode:TreeNode = TreeNode( node.parent );
				parentNode.removeChild( node );
				if ( parentNode.isOpen == true )
					changeNodeShowheight( parentNode , node.showHeight , false );				
				parentNode.updataLayout( parentNode );
				parentNode.getChildArray.splice( index.slice( index.length - 2 ) , 1);
			}
			else if ( node.parent is Tree )
			{
				this.removeChild( node );
				_firstNode.splice( uint(index) , 1 );
			}
			updataLayout();
			return node;
		}
		
		/**
		 *改变相应节点的内容  
		 * @param nodeIndex 节点的索引
		 * @param nodeContent 节点的新内容
		 * @param xArray x数组
		 */		
		public function changeNodeContent( index:String , nodeContent:Array , xArray:Array ):void
		{
			var node:TreeNode = analysisIndex( index );
			if (node.isParent == true )
			{
				nodeContent.unshift( node.getContent.shift() );
				xArray.unshift(0)
				var i:uint;
				for ( i = 1 ; i <  xArray.length ; i++ )
				{
					xArray[i] += nodeContent[0].width+3;
				}
			}
			node.changeContent( nodeContent , xArray );
		}
		
		/**
		 *传入展开图标 
		 * @param icon
		 * 
		 */		
		public function set openIcon( icon:Bitmap ):void
		{
			_openIcon = icon;
		}
		
		/**
		 *传入关闭图标 
		 * @param icon
		 * 
		 */		
		public function set closeIcon( icon:Bitmap ):void
		{
			_closeIcon = icon;
		}
		
		/**
		 *通过索引获取节点的内容 
		 * @param index
		 * 
		 */		
		public function getContentByIndex( index:String ):Array
		{
			var node:TreeNode = analysisIndex( index );
			return node.getContent;
		}
		
		/**
		 *通过父节点获取子节点 
		 * @param parentNode
		 * @param index
		 * @return 
		 * 
		 */		
		public function getChildNodeByParent( parentIndex:String , index:uint):TreeNode
		{
			return TreeNode(analysisIndex( parentIndex ).getChildAt( index ));
		}
		
		/**
		 *通过索引获取节点 
		 */		
		public function getNodeByIndex( index:String ):TreeNode
		{
			return TreeNode(analysisIndex( index ));
		}
		
		/**
		 *清理函数。 
		 * 
		 */		
		public function clear():void
		{
			this.removeChildren();
			
			_closeIcon.bitmapData.dispose();
			_closeIcon = null;
			
			_openIcon.bitmapData.dispose();
			_openIcon = null;
			
			_iconButton.clear();
			
			var i:uint;
			for ( i = 0 ; i <_firstNode.length ; i++ )
			{
				clearEventListener( _firstNode[i] );
				_firstNode[i].clear();
			}
		}
		//清理父节点的监听。
		private function clearEventListener( node:TreeNode ):void
		{
			if ( node.isParent == true )
			{
				node.removeEventListener(MouseEvent.CLICK , nodeClick);
				var i:uint;
				for ( i = 0 ; i < node.getChildArray.length ; i++ )
				{
					clearEventListener( node.getChildArray[i] );
				}
			}
		}
	}
}

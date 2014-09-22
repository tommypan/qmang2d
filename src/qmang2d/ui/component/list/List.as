/*
PBK：没细看
*/
package qmang2d.ui.component.list
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.sensors.Accelerometer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 *创建一个列表。 
	 * 
	 */	
	public class List extends Sprite
	{
		//列表的装载容器和背景绘制，当有多个列表时会新建多个此容器
		private var _listBox:Sprite = new Sprite();
		
		//储存列表当前选中的子对象的键值
		private var _itemIndex:int=1;
		
		//列表的宽
		private var _listWidth:int=new int;
		//列表的高
		private var _listheight:int=new int;
		//列表背景颜色
		private var _listColor:uint=new uint;
		//列表背景颜色的透明度
		private var _alpha:Number=new Number;
		
		//列表点击触发函数
		private var _clickFunc:Function = null;
		
		//当加载子对象时，记录子对象总共的高
		private var _itemAllHeight:Number = 0;

		//当有多个列表时，储存所有列表
		private var _listArray:Array = new Array();
		
		//储存所有子对象
		protected var _itemArray:Array=new Array();
		
//		private var scroll :VScrollBar;			预留滚动条
		
		/**
		 *创建一个列表 。有公共方法：addItem()。
		 * @param parent 父容器
		 * @param xpos x坐标
		 * @param ypos y坐标
		 * @param width 宽
		 * @param height 高
		 * @param BGColor 背景颜色
		 * @param BGAlpha 背景透明度【不需要背景的时候设置为0
		 * 
		 */		
		public function List( width:int , height:int , BGColor:uint ,BGAlpha:Number = 1 )
		{
			_listWidth = width;
			_listheight = height;
			_listColor=BGColor;
			_alpha = BGAlpha;
			
			makeListBox();
		}
		
		//绘制列表的背景颜色
		private function makeListBox():void
		{
			_listBox = new Sprite();
			_listBox.graphics.beginFill(_listColor,_alpha);
			_listBox.graphics.drawRect(0,0,_listWidth,_listheight);
			_listBox.graphics.endFill();
			_listBox.addEventListener(MouseEvent.CLICK,onClick);
			this.addChildAt( _listBox , 0);
		}
		
		//列表的点击触发方法，同时更新当前选中的子对象键值
		private function onClick (e:MouseEvent):void
		{
			if (_itemArray.length != 0)
			{
				if ( e.target is ListItem )
				{
					_itemIndex = _itemArray.indexOf( e.target );
				}
			}
			
			if ( _clickFunc != null ) _clickFunc( e );
			
		}
		
		/**
		 *逐个加入列表子元素(listItem)。 
		 * @param itemContent 子元素内容数组
		 * @param itemX 子元素内容的x坐标数组【当子元素内有多个内容时，每个内容依次对应数组内的x坐标
		 * @param itemheight 子元素的高【注意，会影响到内容的y坐标
		 * @param isSeparate 前子元素与后一个子元素之间是否有分割线
		 * @param splitLineColor 分割线的颜色 
		 * @param textColor 子元素内文本颜色
		 * @param textSize 子元素内文本大小
		 * @param itemIsChange 子元素是否鼠标经过变换颜色
		 * @param changeColor 若鼠标经过变换颜色，点击后的颜色。
		 * @param itemClickFunc 子元素相应的点击方法【不推荐直接通过list传递方法给listItem！
		 * 
		 */		
		public function addItem( itemContent:Array , itemX:Array , itemheight:uint , isSeparate:Boolean , splitLineColor:uint = 0x39A2B2,  textColor:String = null ,
								 textSize:uint = 13 , itemIsChange:Boolean = false , changeColor:uint = 0xff0000 , itemClickFunc:Function = null):void
		{
			
			_itemAllHeight += itemheight ;				
			_listBox.name = _listBox.numChildren.toString();
			
			//当子对象的总高已经大于列表的高的时候，新建一个列表并储存。
			if (_itemAllHeight > _listheight ){
				if (_listArray.length == 0) _listArray.push( _listBox );
				makeListBox();
				_listArray.push( _listBox );
				_listBox.x = 200;
				_itemAllHeight = 0;
			}
			
			var item:ListItem ;
			if ( isSeparate == true )
			{
				_itemAllHeight += 1;
				item = new ListItem( _listWidth , itemheight -1.5 );
				item.setContent( itemContent , itemX );
				item.graphics.lineStyle(1,splitLineColor);
				item.graphics.moveTo( 5 , item.height + 1);
				item.graphics.lineTo( _listWidth-5 ,  item.height + 1);
			}
			else
			{
				item = new ListItem(  _listWidth , itemheight );
				item.setContent( itemContent , itemX );
			}
			
			item.bgAlpha = 0;
			item.textColor = textColor;
			item.textSize = textSize;
			_listBox.addChild( item );
			item.y = _itemAllHeight - itemheight;
			item.setClickFunction(itemClickFunc,itemIsChange,changeColor);
			_itemArray.push(item);
		}
		
		/**
		 *自动排列元素。 将所有内容按照左至右，上至下的顺序放在数组内，再确定多少数组元素为一排，传入列的x坐标数组。
		 * @param content 内容数组
		 * @param sliceNum 分割的范围【多少元素为一排
		 * @param xArray 每一列的x坐标数组
		 * @param itemheight item的高
		 * @param isSeparate item之间是否有分割线
		 * @param splitLineColor 分割线的颜色
		 * @param textColor item中的文本颜色
		 * @param textSize item中文本的大小
		 * @param itemIsChange item是否在鼠标经过的时候变换背景颜色
		 * @param changeColor 变换的背景颜色
		 * @param itemClickFunc item触发的方法数组。
		 * 
		 */		
		public function autoAddItem( content:Array , sliceNum:uint , xArray:Array , itemheight:uint , isSeparate:Boolean , splitLineColor:uint = 0x39A2B2,  textColor:String = null ,
									 textSize:uint = 13 , itemIsChange:Boolean = false , changeColor:uint = 0xff0000 , itemClickFunc:Array = null):void
		{
			var itemContent:Array;
			var sliceN:uint = 0 ;
			if (itemClickFunc == null ) itemClickFunc = [];
			
			for ( var i :uint = 1 ; i <= content.length / sliceNum ; i++ )
			{
				itemContent = content.slice(sliceN , sliceN + sliceNum );
				sliceN += sliceNum ;
				
				addItem( itemContent ,  xArray , itemheight, isSeparate , changeColor , textColor , textSize , itemIsChange , changeColor , itemClickFunc[ i-1 ]);
			}
		}
		
		/**
		 *对列表中某一列的元素比较大小进行排列 。汉字不会按拼音首字母排列。
		 * @param num 第几列，最小值0，最大值（列数-1）
		 * @param compareBig 是由大到小排序，还是由小到大排序，true是由大到小。【注意，字母的大小，a小于b小于c小于.....
		 * 
		 */		
		public function  automaticTypeset( num:uint , compareBig:Boolean = true):void
		{
			
			var item:ListItem;
			var xNum:uint;
			//对选中的列进行大小排列
			for  ( var i:uint = 0 ; i < _itemArray.length  ; i++ )
			{
				for ( var j:uint = _itemArray.length - 1 ; j > i ; j-- )
				{
					if( compareBig ? ( ListItem(_itemArray[j-1]).getContent[ num ] < ListItem(_itemArray[j]).getContent[ num ] ) : ( ListItem(_itemArray[j-1]).getContent[ num ] > ListItem(_itemArray[j]).getContent[ num ] ))
					{
						item = _itemArray[j-1];
						_itemArray[j-1] = _itemArray[j];
						_itemArray[j] = item;
					}
				}
			}
			//对数组中排列后的元素加载进显示列表
			if ( _listArray.length != 0 )
			{					
				j = 0 ;
				var itemNum:uint ;
				for ( i = 0 ; i< _listArray.length ; i++ )
				{
					itemNum += uint ( _listArray [i].name );
					Sprite ( _listArray [i] ).removeChildren( );
					_itemAllHeight = 0;
					for ( ; j < itemNum ; j++ )
					{
						Sprite ( _listArray [i] ) .addChild( _itemArray[j] );
						_itemArray[j].y = _itemAllHeight;
						_itemAllHeight += _itemArray[j].height + 1;
					}
				}
			}
			else {
				itemNum = _listBox.numChildren ;
				_listBox.removeChildren( );
				_itemAllHeight = 0;
				for ( j = 0 ; j < itemNum ; j++ )
				{
					_listBox .addChild( _itemArray[j] );
					_itemArray[j].y = _itemAllHeight;
					_itemAllHeight += _itemArray[j].height +1;
				}
			}
		}
		
		/**
		 *传入文本字体大小和颜色 
		 * @param size 字体大小
		 * @param color 字体颜色【格式"#ffffff"】
		 * 
		 */		
		public function textFormat( size:uint , color:String ):void
		{
			var i:uint;
			for ( i = 0 ; i < _itemArray.length ; i++ )
			{
				_itemArray[i].textSize = size;
				_itemArray[i].textColor = color;
			}
		}
		
		/**
		 *获取列表数组。只有分页后才有效。
		 * <p>返回包含分页后列表的数组</p>
		 */		
		public function get getContent():Array
		{
			
			return _listArray;
		}
		
		/**
		 *传入列表点击方法。 
		 * @param func
		 * 
		 */		
		public function set setClickFunc(func:Function ):void
		{
			_clickFunc = func ;
		}
		
		/**
		 *获得当前子对象的键值 
		 * @return 列表中的子对象
		 * 
		 */		
		public function get index():uint 
		{
			return _itemIndex;
		}
		
		/**
		 *通过index来获取列表的子对象Item 
		 * @param index 最小0，最大list的长度-1
		 * @return 
		 * 
		 */		
		public function getChildByIndex( index:uint ):ListItem
		{
			return _itemArray[index];
		}
		
		/**
		 *通过index来改变子对象的背景颜色和透明度。
		 * @param index 最小0，最大list的长度-1
		 * @param BGColor 背景颜色
		 * @param BGAlpha 透明度
		 * 
		 */		
		public function changeItemBG( index:uint , BGColor:uint , BGAlpha:uint ):void
		{
			ListItem( _itemArray[index] ).backGround( BGColor , BGAlpha );
		}
		
		/**
		 *获取列表的长度。 
		 * @return 
		 * 
		 */		
		public function get length():uint
		{
			return _itemArray.length;
		}
		
		/**
		 *	 删除子对象 
		 * @param index 要删除item的键值
		 * @return 被删除的子对象
		 */		
		public function deleteItem ( index:uint ):ListItem
		{
			return _itemArray.splice( index , 1 );
		}
		
		/**
		 *清理函数。 
		 * 
		 */		
		public function clear():void
		{
			var i:uint ;
			for ( i = 0 ; i < _itemArray.length ; i++ )
			{
				_itemArray[i].clear();
			}
			_itemArray.splice( 0 , _itemArray.length );
			_itemArray = null;
			
			if ( _listArray.length >1 )
			{
				for ( i = 0 ; i < _listArray.length ; i++ )
				{
					this.removeChild( _listArray[i] );
					_listArray[i].graphics.clear();
					_listArray[i].removeEventListener(MouseEvent.CLICK,onClick);
					_listArray[i].removeChildren( );
					_listArray[i] = null ;
				}
				_listArray.splice( 0 , _listArray.length );
			}
			else
			{
				_listBox.graphics.clear();
				_listBox.removeChildren( );
				removeChild( _listBox );
				_listBox = null ;
			}
			_listArray = null;
			if ( _clickFunc != null ) _clickFunc = null ;
		}
	}
}
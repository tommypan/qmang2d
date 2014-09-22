package qmang2d.ui.component
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import qmang2d.ui.component.button.ButtonRect;
	
	/**
	 *分页按钮。 
	 * @author a
	 * 
	 */	
	public class Tabbar extends Sprite
	{
		private var _tabDirection:uint=1;//按钮的位置
		private var _contentHeight:Number;
		private var _contentWidth:Number;
		private var _tabheight:Number;
		private var _tabwidth:Number;
		private var _index:uint = 0;  //当前按钮的索引值
		private var _contentArray:Array = null;
		private var _buttonArray:Array = new Array();
		private var _clickFunc:Function = null;
		
		/**
		 *分页按钮。 
		 * 
		 */			
		public function Tabbar()
		{
		}
		
		/**
		 *分页按钮。传递文本数组做分页按钮，传递内容数组做分页内容。 两个数组长度必须相同，先后顺序一一对应。
		 * <p>还可传递最后一个参数来确定按钮和分页的相对位置。</p>
		 * @param tabArray 文本数组
		 * @param contentArray 内容数组
		 * @param contentWidth 分页的宽
		 * @param contentHeight 分页的高
		 * @param tabwidth 按钮的宽
		 * @param tabheight 按钮的高
		 * @param tabDirection 1、按钮在上。2、按钮在下。3、按钮在左。4、按钮在右。
		 */	
		public function setContent(tabArray:Array,contentArray:Array,contentWidth:uint,contentHeight:uint,tabwidth:Number,tabheight:Number,tabDirection:uint = 1):void
		{	
			if(tabArray.length != contentArray.length) throw new Error("容器和按钮的个数不相等！");
			
			_tabwidth=tabwidth;
			_tabheight=tabheight;
			
			var i:uint=0;
			_tabDirection = tabDirection;
			_contentArray = contentArray;
			
			for( i = 0; i < contentArray.length; i++){
				this.addChildAt(contentArray[i],0);
				contentArray[i].visible=false;
			}
			contentArray[0].visible=true;
			
			var button:ButtonRect;
			for(i=0;i<tabArray.length;i++){
				switch (_tabDirection){
					case 1:
						button=new ButtonRect( _tabwidth,_tabheight );
						button.x = i*_tabwidth+i*5;
						contentArray[i].x = 0;
						contentArray[i].y = _tabheight+3;
						break;
					case 2:
						button=	new ButtonRect(_tabwidth,_tabheight);
						button.x = i*_tabwidth+i*5;
						button.y = contentHeight+3;
						break;
					case 3:
						button = new ButtonRect( _tabwidth,_tabheight );
						button.x =0;
						button.y = i*(_tabheight+5);
						contentArray[i].x = _tabwidth+3;
						contentArray[i].y = 0;
						break;
					case 4:
						button = new ButtonRect( _tabwidth,_tabheight );
						button.x =contentWidth+3;
						button.y = i*(_tabheight+5);
						break;
				}
				button.name=i.toString();
				button.closeEventListen = 0;
				button.addEventListener(MouseEvent.CLICK,onClickBar);
				button.setText = tabArray[i];
				button.setButtonColor( true , [0x11DAF0,0x117A83] );
				button.buttonStyle = false;
				addChildAt(button,0);
				_buttonArray.push(button);
			}
			ButtonRect(this.getChildByName(_index.toString())).mouseEnabled = false;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=1;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=3;
		}
		
		/**
		 * @param 判断是否显示
		 */		
		private function onClickBar(e:MouseEvent=null):void{
			ButtonRect(this.getChildByName(_index.toString())).mouseEnabled = true;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=2;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=4;
			_contentArray[_index].visible=false;
			
			_index=uint(e.currentTarget.name);
			ButtonRect(this.getChildByName(_index.toString())).mouseEnabled = false;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=1;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=3;
			_contentArray[_index].visible=true;
			
			if ( _clickFunc != null ) _clickFunc( e );
		}
		
		public function onOverBar(name1:String):void{
			ButtonRect(this.getChildByName(_index.toString())).mouseEnabled = true;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=2;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=4;
			_contentArray[_index].visible=false;
			
			_index=uint(name1);
			ButtonRect(this.getChildByName(_index.toString())).mouseEnabled = false;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=1;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=3;
			_contentArray[_index].visible=true;
		}
		
		/**
		 *获取当前按钮的值。 
		 * @return index
		 */		
		public function get index():uint{
			return _index;
		}
		
		public function set gotoIndex(index:uint):void
		{
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=2;
			ButtonRect(this.getChildByName(_index.toString())).mouseEnabled = true;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=4;
			_contentArray[_index].visible=false;
			
			_index=index;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=1;
			ButtonRect(this.getChildByName(_index.toString())).mouseEnabled = false;
			ButtonRect(this.getChildByName(_index.toString())).changeButtonMode=3;
			_contentArray[_index].visible=true;
		}
		
		/**
		 *调整按钮间的间距，不论按钮是横排列还是竖排列。 
		 * @param value 距离
		 * 
		 */		
		public function set buttonInterval( value:Number ):void
		{
			var button:ButtonRect ;
			var i:uint ;
			for(i=1;i<_contentArray.length;i++){
				button= ButtonRect(getChildByName( i.toString() ));
				switch (_tabDirection){
					case 1:
					case 2:
						button.x = i*(_tabwidth+value);
						break;
					case 3:
					case 4:
						button.y = i*(_tabheight+value);
						break;
				}
			}
		}
		/**
		 *传入按钮和内容的间距
		 * @param value
		 * 
		 */		
		public function set buttonAndContentSpacing( value:Number ):void
		{
			var button:ButtonRect ;
			var i:uint ;
			for(i=0;i<_contentArray.length;i++){
				button= ButtonRect(getChildByName( i.toString() ));
				switch (_tabDirection){
					case 1:
						_contentArray[i].y = _tabheight + value;
						break;
					case 2:
						button.y = _contentHeight+value;
						break;
					case 3:
						_contentArray[i].x = _tabwidth + value;
						break;
					case 4:
						button.x = _contentWidth + value ;
						break;
				}
			}
		}
		/**
		 *传入tab按钮的点击方法 
		 * @param func
		 */		
		public function set setClickFunc(func:Function ):void
		{
			_clickFunc = func ;
		}
		
		/**
		 *获取tab按钮的数量。 
		 * @return 
		 */		
		public function get length():uint
		{
			return _contentArray.length;
		}
		
		/**
		 *获取tab的内容数组。 
		 * @return 
		 */		
		public function get getContent():Array
		{
			return _contentArray;
		}
		
		public function clear():void
		{
			var child:ButtonRect;
			var i:uint;
			for ( i = 0; i < _buttonArray.length ; i++ )
			{
				child = _buttonArray[i];
				child.removeEventListener(MouseEvent.CLICK,onClickBar);
				child.clear();
				removeChild( child );
				child = null;
			}
			removeChildren();
		}
	}
}
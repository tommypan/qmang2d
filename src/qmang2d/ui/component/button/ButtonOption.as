package qmang2d.ui.component.button
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * 这是一个圆形单选按钮
	 * @author 
	 * 
	 */
	public class ButtonOption extends Sprite
	{
		//绘制一个圆
		private var _round:Sprite;
		//绘制一个点，当选中时显示
		private var _point:Shape=new Shape();
		//按钮后的文本
		private var _title:TextField;
		//按钮数组
		private var _array:Array=new Array();
		//按钮键值
		private var _index:uint=0;
		
		/**
		 * 圆形单选按钮
		 */		
		public function ButtonOption()
		{
			
		}
		/**
		 * 画当选框。当w = 0，为竖排列；若h = 0，为横排列。
		 * @param number 按钮个数
		 * @param w  横向间隔
		 * @param h  纵向间隔
		 * @param title 文本内容为数组
		 * @param textColor  文本颜色
		 * @param textSize   文本大小
		 * 
		 */		
		public function draw( number:uint = 1 , w:Number = 0 , h:Number = 0 ):void
		{
			for(var i:Number=0;i<number;i++)
			{
				_round=new Sprite();
				_round.graphics.beginFill(0x055F7C);
				_round.graphics.lineStyle(2,0x1874CD);
				_round.graphics.drawCircle(0,0,8);
				_round.graphics.endFill();
				if(h==0){
				    _round.x=i*(8+w);
				}else if(w==0){
					_round.y=i*(8+h);
				}
				addChild(_round);
				_array.push(_round);
				
				_point=new Shape();
				_point.graphics.beginFill(0xFFFF00);
				_point.graphics.lineStyle(2,0xFFFF00);
				_point.graphics.drawCircle(0,0,3);
				_point.graphics.endFill();
				_point.visible=false;
				_round.addChild(_point);
				_round.buttonMode = true;
				
			}
			    _array[0].getChildAt(0).visible=true;
				_index = 0;
		}
		
		/**
		 *传入按钮后的文本 
		 * @param strArray 字符串数组
		 * @param textColor 文本颜色
		 * @param textSize 字体大小
		 * @param startIndex 从第几个按钮开始排列文本【从0开始计数。
		 * 
		 */		
		public function setTitle( strArray:Array = null , textColor:uint = 0xffffff , textSize:uint = 13 , startIndex:uint = 0 ):void
		{
			var i:uint ;
			var j:uint = startIndex;
			for ( i = 0 ; i < strArray.length ; i++ )
			{
				_title=new TextField();
				var format:TextFormat = new TextFormat("宋体",textSize,textColor);
				_title.text=strArray[i];
				_title.x=_array[j].x+10;
				_title.y=_array[j].y-8;
				_title.setTextFormat(format);
				_title.autoSize = "left";
				_title.mouseEnabled = false;
				addChild(_title);
				
				j++;
			}
		}
		
		/**
		 *改变当选按钮 
		 */		
		public function changeSelectedWhenClick( e:MouseEvent ):void
		{
			Sprite( e.target ).getChildAt(0).visible = true;
			_array[_index].getChildAt(0).visible=false;
			_index = _array.indexOf( e.target );
		}
		
		/**
		 *传入想要查找的按钮的键值，从0开始 。返回布尔值，反应按钮是否被选中。
		 * @param index
		 * @return 
		 * 
		 */		
		public function getSelect(index:uint):Boolean{
			return _array[index].getChildAt(0).visible?true:false;
		}
		
		/**
		 *返回当前选中按钮的键值。 
		 * @return 选中按钮的键值
		 * 
		 */		
		public function get selectedIndex():uint
		{
			return _index;
		}
		
		/**
		 *清除实例。 
		 * 
		 */		
		public function clear():void
		{
			_array.splice( 0 , _array.length );
			_array = null;
			var i:uint;
			var child:*;
			for ( i = 0 ; i < this.numChildren ; i++ )
			{
				child = this.getChildAt( i );
				if ( child is Sprite || child is Shape )
					child.graphics.clear();
				
				removeChild( child );
				child = null;
			}
		}
	}
}
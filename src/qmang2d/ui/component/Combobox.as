package  qmang2d.ui.component
{
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.net.FileFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import qmang2d.ui.component.button.ButtonDirection;
	import qmang2d.ui.component.list.List;
	import qmang2d.ui.component.text.TextInput;
	
	/**
	 * 
	 *combobox 包括按钮：button ，菜单：list ，滚动条：， 可以设置这3者的属性
	 * 
	 */
	public class Combobox extends Sprite
	{	
		private var _width:uint;   //组件宽/
		private var _buttonHeight:uint;   //按钮高度
		private var _content:Array=new Array;   // 菜单里面装的内容，表格
		private var _isPullDown:Boolean;  //一个boolean值，判定是否为下拉菜单或者上啦才到那
		private var _buttonColor:uint;          // 按钮颜色
		private var _list:List;
		private var _button:ButtonDirection ;
		private var _buttonIsSeparate:Boolean;//是否有方向按钮
		private var _textInput:TextInput ;
		/**
		 * 
		 * author  as
		 * @param xpos   相对于父对象的x坐标
		 * @param ypos   相对于父对象的y坐标
		 * @param isPullDown    是否为下拉菜单，true 为下拉菜单，falsh 为上啦菜单
		 * @param width         宽度
		 * @param buttonHeight  高度
		 * @param buttonColor   颜色
		 * @param buttonIsSeparate   是否有方向按钮  
		 * @param textBgColor 文字背景颜色
		 * @param fontColor 字体颜色
		 * @param fontSize  字体大小
		 * 
		 * 这只是建立一个下拉框，关于点击下拉框，弹出来的菜单，后面只需调用drawList方法即可，
		 */
		public function Combobox(isPullDown:Boolean , width:uint)
		{
			
			_isPullDown=isPullDown;
			_width = width;
			
		}
		//绘制滚动条，可以选择滚动条的属性；
//		public function creat_rollbar():void
//		{
//			//现在这里还没设置滚动条
//		}

		private  function func(e:MouseEvent):void
		{
			if(_list.visible==false)
			{
				_list.visible=true;
				this.addEventListener(MouseEvent.CLICK,hideList);//common.stage
			}
			else{
				_list.visible=false;
				this.removeEventListener(MouseEvent.CLICK,hideList);
			}
		}
		//列表隐藏
		private function hideList(e:MouseEvent):void
		{
			if(e.target != _button){
				this.removeEventListener(MouseEvent.CLICK,hideList);
				_list.visible=false;
			}
		}
		//改变文本
		private function changeText(e:MouseEvent):void{
			if(_buttonIsSeparate == true )
			{
				_textInput.textword = _content[_list.index];
			}
			else
			{
				_button.setText = _content[_list.index];
			}
		}
		
		/**
		 *绘制下拉按钮
		 * @param buttonHeight 按钮的高
		 * @param buttonColor 按钮的颜色
		 * @param buttonIsSeparate 按钮是否和文本分开
		 * @param textBgColor 若分开，按钮的背景颜色
		 * 
		 */		
		public function drawButton( buttonHeight:uint , buttonColor:Array = null, buttonIsSeparate:Boolean=false  , textBgColor:uint = 0x004865 ):void
		{
			var textShape:Shape = new Shape();
			textShape.graphics.lineStyle(1,0x2B88A5);
			textShape.graphics.beginFill(textBgColor,1);
			textShape.graphics.drawRoundRect(0,0,_width-buttonHeight+5,buttonHeight,8);
			textShape.graphics.endFill();
			
			var filter:GlowFilter = new GlowFilter ();
			filter.color = 0x000000;
			filter.blurX = filter.blurY = 9;
			filter.alpha = 0.3;
			filter.inner = true;
			textShape.filters = [filter];
			
			_buttonHeight = buttonHeight;
			_buttonIsSeparate = buttonIsSeparate;
			
			if(_isPullDown)
			{
				if(buttonIsSeparate == false)
				{
					_button = new ButtonDirection(_width,buttonHeight);
				}else{
					
					addChild(textShape);
					_button = new ButtonDirection(buttonHeight,buttonHeight);
					_button.x = width-buttonHeight;
					_textInput = new TextInput(_width-buttonHeight,buttonHeight);
					addChild(_textInput );
				}
				_button.downButton();
			}
			else
			{
				if(buttonIsSeparate == false)
				{
					_button = new ButtonDirection(_width,buttonHeight);
				}
				else
				{
					textShape.y =-buttonHeight;
					addChild(textShape);
					
					_button = new ButtonDirection(buttonHeight,buttonHeight);
					_button.x = _width-buttonHeight;
					_textInput = new TextInput(_width-buttonHeight,buttonHeight);
					addChild(_textInput );
				}
				_button.upButton();
			}
			
			if(_textInput != null)
			{
				_textInput.textFiled.mouseEnabled = false;
			}
			_button.addEventListener( MouseEvent.CLICK , func );
			this.addChild(_button);
		}
		
		/**
		 * 按钮的文本格式。
		 * @param size
		 * @param color
		 * 
		 */		
		public function buttonTextFormat( size:uint , color:uint ):void
		{
			if ( _buttonIsSeparate == true ){
				_textInput.textcolor = color;
				_textInput.textSize = size;
			}
			else
			{
				_button.textFormat( color , size );
			}
		}

		/**
		 * 绘制下拉列表
		 * @param listHeight 列表的高
		 * @param listColor 列表的颜色
		 * @param alpha 列表的背景透明度
		 * @param content 列表的内容数组
		 * @param Function 列表子元素关联的方法数组
		 * @param textColor 列表的文本颜色
		 * @param textSize 列表的字体大小
		 * @param itemColors 鼠标经过时子元素的背景颜色
		 */		
		public function drawList(listHeight:uint,listColor:uint,alpha:Number,content:Array,Function:Array,textColor:String = "#000000" , textSize:uint=12,itemColors:uint=0xff0000):void
		{
			if(_isPullDown == true ){			
				_list = new List(_width ,listHeight ,listColor ,alpha );
				_list.y = _buttonHeight + 1;
				
			}else{				
				_list = new List(_width ,listHeight ,listColor ,alpha );
				_list.y = -listHeight;
			}
			addChild(_list);
			
			_content=content;
//			_size=textSize;
			_list.visible=false;
			
			if (_buttonIsSeparate == false)
			{
				_button.setText = content[0];
			}
			else
			{
			 	_textInput.textword = content[0];
			}
			
			for(var i:int=0;i<_content.length;i++)
			{
				_list.addItem([content[i]] , [0] , listHeight/content.length , false , 0 , textColor , textSize  ,true , itemColors, Function[i]);
			}
			
			_list.addEventListener(MouseEvent.CLICK,changeText);
		}
		
		/**
		 * 
		 * @获取索引值
		 * 
		 */		
		public function get getIndex():uint
		{
			return _list.index;
		}
		
		/**
		 *列表字体格式设置 
		 * @param size 字体大小
		 * @param color 字体颜色【格式"#ffffff"】
		 * 
		 */		
		public function listTextFormat( size:uint , color:String ):void
		{
			_list.textFormat( size , color );
		}
		
		/**
		 *走到键值对应的列表子元素 
		 * @param index
		 * 
		 */		
		public function set gotoIndex( index:uint ):void
		{
			if(_buttonIsSeparate == true )
			{
				_textInput.textword = _content[index];
			}
			else
			{
				_button.setText = _content[index];
			}
		}
		
		/**
		 * 
		 * @获取列表长度
		 * 
		 */		
		public function get length():uint
		{
			return _list.length;
		}
	}
}

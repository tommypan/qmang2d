package qmang2d.ui.component.bar
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * 百分比条
	 */
	public class PercentageBar extends Sprite
	{

		private var _height:Number;
		private var _width:Number;
		protected var percentbar:Shape = new Shape(); //percentbar
		protected var show:TextField = new TextField(); //percentbar number
		protected var shape:Shape = new Shape();//对percentbar的遮罩
		protected var textformat:TextFormat = new TextFormat;
		/**
		 * 创建百分比条
		 *  
		 * @param xpos
		 * @param ypos
		 * @param height 高
		 * @param width 宽
		 * @param colors 渐变颜色数组，颜色由上而下,里面包含三种颜色
		 * @param per
		 * 
		 */
		public function PercentageBar(xpos:Number =10,ypos:Number =10,height:Number =20,
									  width:Number =100,colors:Array=null,per:Number=0)
		{
			x=xpos;
			y=ypos;

			_height=height;
			_width=width;
			// 绘制百分比条
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_height,_height,Math.PI/2,0,0);
			percentbar.graphics.lineStyle(0,0x111111,.5,true);
			percentbar.graphics.beginGradientFill(GradientType.LINEAR,colors,[1,1,1],[0,135,255],matr,SpreadMethod.PAD);
			percentbar.graphics.drawRoundRect(0,0,_width,_height,10,10);
			percentbar.graphics.endFill();
			percentbar.mask=shape;
			//绘制percentbar的遮罩
			shape.graphics.beginFill(0xffffff);
			shape.graphics.drawRoundRect(0,0,_width,_height,10,10);
			shape.graphics.endFill();
			shape.x=percentbar.x-_width*(1-per);
			shape.y=percentbar.y;
			
			//显示百分比条上的数字
			
			textformat.size=12;
			show.defaultTextFormat = textformat;
			show.autoSize= TextFieldAutoSize.CENTER;
			show.textColor=0x000000;
			show.text = "0";
			show.x=_width/2;
			show.y=(_height-show.height)/2;
			
			this.mouseChildren=false;
			this.addChild(shape);
			this.addChild(percentbar);
			this.addChild(show);
			
			setNum(48,48);
//			setValue(30);
		}
		
		/**
		 * 设置百分比  
		 * 
		 * @param per  0 - 100
		 * 
		 */		
		public function setValue(per:Number):void
		{
//			if(_showPercent)
			show.text = per + "%";
			shape.x=percentbar.x-_width*((100-per)/100);
		}
		
		/**
		 *传入分子分母，以两者比值显示文本 
		 * @param member 分子
		 * @param denominator 分母
		 * 
		 */		
		public function setNum( member:uint , denominator:uint ):void
		{
			show.text = member + "/" +denominator ;
			if( denominator == 0 || denominator < 0 )
			{
				denominator = 1;
				member = 0;
			}
			shape.x=percentbar.x-_width*(denominator-member)/denominator;
		}
		
		public function clear():void
		{
			percentbar.graphics.clear();
			removeChild(percentbar);
			percentbar = null;
			
			shape.graphics.clear();
			removeChild(shape);
			shape = null;
			
			show.defaultTextFormat = null;
			removeChild(show);
			show = null;
			
			textformat = null;
			
			
		}
	}
}
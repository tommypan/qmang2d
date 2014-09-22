package qmang2d.ui.component.window
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	

	/**
	 * 面板 (内嵌面板和主面板)
	 * @author H
	 * 
	 */	
	public class Panel extends Sprite
	{
		private var _shape:Shape=null;
		private var _glow:GlowFilter ; 
		/**
		 * MakePanel(),调用此方法绘画底板。
		 *<p> MakePanelEmbed(), 绘画内嵌面板</p>
		 * <p>AddInstance(),添加内容。</p>
		 * 
		 */		
		public function Panel()
		{
		}
		
		/**
		 * @param xpos 内嵌面板的x
		 * @param ypos 内嵌面板的y。
		 * @param width 内嵌面板的宽度
		 * @param heigh 内嵌面板的高度
		 * @param colors 内嵌面板的颜色
		 */		
		public function makePanelEmbed(xpos:Number=110,ypos:Number=110,width:Number=400,heigh:Number=200,colors:uint=0x055F7C):void
		{
			_shape=new Shape();
			_glow=new GlowFilter();
			_glow.inner=true;
			_glow.color = 0x000000; 
			_glow.alpha = 0.5; 
			_glow.blurX = 8; 
			_glow.blurY = 8; 
			
			_shape.graphics.beginFill(colors);
			_shape.graphics.drawRoundRect(xpos,ypos,width,heigh,6,6);
			_shape.graphics.endFill();
			_shape.filters=[_glow];
			addChild(_shape);
		}
		
		/**
		 * @param width 底板的宽度
		 * @param heigh 底板的高度
		 * @param colors 底板的颜色
		 * @param IsNewSprite 是否实例化一个sprite
		 */		
		public function makePanel(_width:Number=400,_height:Number=200,_color:uint=0x1E93B3):void//0x1E93B3
		{
			_glow=new GlowFilter();
			_glow.color = 0x000000;
			_glow.alpha = 0.4; 
			_glow.blurX = 2; 
			_glow.blurY = 2;
//			graphics.lineStyle(0.2,,0.8);0x4DB0D5
			graphics.beginFill(_color);
			graphics.drawRoundRect(0,0,_width,_height,6,6);
			graphics.endFill();
			filters=[_glow];
		}
		
		/**
		 *绘画带有顶部条的内嵌面板。  
		 * @param xpos x
		 * @param ypos y
		 * @param width 宽
		 * @param heigh 高
		 * @param textColors 文本颜色
		 * @param textSize 文本大小 
		 * @param textArray 文本数组 【当文本数组长度大于分区数，当溢出
		 * @param subfield 顶部栏的分区数 
		 * @param lineXArray 顶部栏分区线的x坐标数组。【数组长度比subfield少1，以顶部栏左上角为原点。
		 * 
		 */		
		public function makeTopBarPanel(xpos:Number=110,ypos:Number=110,width:Number=400,heigh:Number=300,textColors:String="#055F7C",
										textSize:uint = 15,textArray:Array = null,subfield:uint = 1,lineXArray:Array = null):void
		{
			makePanelEmbed(xpos,ypos , width,heigh);
			var topBar:Shape = new Shape();
			var Mtr:Matrix=new Matrix;
			Mtr.createGradientBox(width,27,Math.PI/2,0,0);
			topBar.graphics.lineStyle(1,0x004766,0);
			topBar.graphics.beginGradientFill(GradientType.LINEAR,[0x3B9AB0,0x055F7C],
				[1,1],[10,200],Mtr);
			topBar.graphics.drawRoundRect(0,0,width,27,8);
			topBar.graphics.endFill();
			topBar.x = xpos;
			topBar.y = ypos;
			addChild(topBar);
			
			var i:uint = 1;
			while ( i < subfield ){
				topBar.graphics.lineStyle(1,0x39A2B2);
				topBar.graphics.moveTo(lineXArray[i-1] , 3 );
				topBar.graphics.lineTo(lineXArray[i-1] , 24 );
				i++ ;
			}
			
			for ( i = 0 ; i < textArray.length ; i++ )
			{
				var text:TextField = new TextField();
				text.htmlText = "<font face='宋体' color='"+textColors+"' size='"+textSize+"'>"+textArray[i]+"</font>";
				text.autoSize = "left" ;
				if ( i == 0 ) 	{
					text.x = ( lineXArray[i] - text.width )/2 + xpos ;
				}
				else if ( i == lineXArray.length ){
					text.x = ( width - lineXArray[lineXArray.length-1] - text.width )/2 + lineXArray[lineXArray.length-1] + xpos;
				}
				else {
					text.x = ( lineXArray[i] - lineXArray[i-1] - text.width )/2 + lineXArray[i-1] + xpos;  
				}
				
				text.y = ypos + ( 27 - text.height )/2;
				text.mouseEnabled = false ;
				addChild( text );
			}
		}
		
		/**
		 * @param target 加入的对象
		 * @param X  对象的x
		 * @param Y 对象的Y
		 */		
		public function addInstance(target:*,X:Number,Y:Number):void
		{
			target.x=X;
			target.y=Y;
			addChild(target);
		}
		
		/**
		 *清除函数。 
		 */		
		public function clear ():void
		{
			var i:uint ;
			var child:*;
			for ( i = 0 ; i < this.numChildren ; i++ )
			{
				child = this.getChildAt( i );
				if ( child is Shape )
				{
					child.graphics.clear();
				}
				
				this.removeChild( child );
				child = null ;
				
			}
		}
	}
}
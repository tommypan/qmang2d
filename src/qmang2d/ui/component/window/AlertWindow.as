package qmang2d.ui.component.window
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import game.view.ui.ViewFilter;
	import qmang2d.ui.component.button.ButtonRect;
	
	/**
	 * 提示框
	 */
	public class AlertWindow extends Sprite
	{
		//显示ok文本的方形按钮
		public var okButton:ButtonRect ;
		//显示yes文本的方形按钮
		public var yesButton:ButtonRect;
		//显示no文本的方形按钮
		public var noButton:ButtonRect;
		//窗口
		private var window:Window = new Window();
		//顶部文本
		private var _title:TextField = new TextField();

		/**
		 * 
		 * @param isOk  是否只有Ok按钮
		 * @param title  提示框标题
		 * @param height 提示框宽和高
		 * @param width
		 * 
		 */		
		public function AlertWindow(isOk:Boolean = true , height:Number = 100 , width:Number = 100)
		{
			window.drawWindow( width , height );
			if ( isOk == true )
			{
				okButton = new ButtonRect( 40 , 20 );
				okButton.setText = "确定";
				okButton.x =  (width - 40 )/2 ;
				okButton.y = height - 35 ;
				window.addChild(okButton);
			}
			else 
			{
				yesButton = new ButtonRect( 40 , 20 );
				yesButton.setText = "是";
				yesButton.x =  40 ;
				yesButton.y = height - 35 ;
				window.addChild(yesButton);
				noButton = new ButtonRect( 40 ,20 );
				noButton.setText = "否";
				noButton.x =  width - 80;
				noButton.y = height - 35 ;
				window.addChild(noButton);
			}
			addChild(window);
		}
		
		/**
		 *传入窗口顶部文本 
		 * @param str
		 * 
		 */		
		public function set setTitle( str:String ):void
		{
			window.setTitle( str );
		}
		
		/**
		 * 
		 * @param str  提示框文字
		 * @param size  文字大小
		 * @param color  文字颜色
		 * 
		 */		
		public function setText ( str:String , size:uint = 13 ,color:uint = 0xffffff):void
		{
			_title.text = str;
			var format:TextFormat  = new TextFormat( "宋体" , size ,color );
			_title.setTextFormat( format );
			_title.height = window.height * 2 /3 ; 
			_title.width = window.width * 5 / 7;
			_title.multiline = true ;
			_title.wordWrap=true;
			_title.filters = [ViewFilter.textGlow];
			_title.mouseEnabled = false;
			window.addElement(_title , window.width/7 , 40);
		}
		
		/**
		 *清除函数。 
		 */		
		public function clear():void
		{
			window.removeChildren( );
			yesButton = null;
			okButton = null ; 
			noButton = null ;
			_title = null;
			
			removeChild( window );
			window = null;
		}
	}
}
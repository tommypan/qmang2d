package qmang2d.ui.component.text
{
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Text extends TextField
	{
		//文本格式
		private var _format:TextFormat = new TextFormat( );
		
		/**
		 *文本类，继承textfield，并添加textformat。 
		 * 
		 */		
		public function Text()
		{
			super();
		}
		
		/**
		 *文本大小 
		 */		
		public function set textSize( size:uint ):void
		{
			_format.size = size;
			setTextFormat( _format );
		}
		
		/**
		 *是否是粗体 
		 */		
		public function set isBold ( bold:Boolean ):void
		{
			_format.bold = bold;
			setTextFormat( _format );
		}

		/**
		 *是否为斜体。 
		 * @param italic
		 * 
		 */		
		public function set textItalic( italic:Boolean ):void
		{
			_format.italic = italic;
			setTextFormat( _format );
		}
		
		/**
		 * 文本字体
		 */		
		public function set textFont( font:String ):void
		{
			_format.font = font;
			setTextFormat( _format );
		}
		
		/**
		 *文本是否有下划线
		 */		
		public function set textUnderline( underline:Boolean ):void
		{
			_format.underline = underline;
			setTextFormat( _format );
		}
		
		/**
		 *文本对齐方式
		 */		
		public function set textAlign( align:String ):void
		{
			_format.align = align;
			setTextFormat( _format );
		}
		
		public function defaultFormat():void
		{
			defaultTextFormat = _format;
		}
	}
}
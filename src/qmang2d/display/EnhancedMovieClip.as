package qmang2d.display
{
	/**
	 * 支持鼠标交互，EnhancedMovieClip一般用于角色，怪物渲染等
	 *@author as3Lover_ph
	 *@date 2013-3-12
	 */
	public class EnhancedMovieClip extends BitmapMovie
	{
		
		/**
		 * 
		 * @param isUseDefRe_ 是否使用默认资源
		 * @param delay_ 设置动画时延
		 * 
		 */	
		public function EnhancedMovieClip(isUseDefRe_ :Boolean = false,delay_ :int = -1)
		{
			super(isUseDefRe_,delay_);
			this.mouseChildren = true;
			this.mouseEnabled  = true;
		}
		
	}
}
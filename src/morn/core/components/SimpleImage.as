package morn.core.components
{
	import flash.display.DisplayObject;
	
	import mx.core.UIComponent;

	/**
	 *@author tanshiyu
	 *@date 2013-9-5
	 */
	public class SimpleImage extends Component
	{
		private var _image:DisplayObject;
		public function SimpleImage()
		{
			
		}
		
		public function set image(image:DisplayObject):void {
			if(_image == image){return};
			if(_image != null && this.contains(_image)) {
				this.removeChild(_image);
			}
			_image = image;
			this.addChild(_image);
		}
	}
}
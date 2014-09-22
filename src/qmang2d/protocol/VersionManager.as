package qmang2d.protocol
{
	
	/**
	 * 版本管理，可以采取从外部读取配置文件
	 * <p>这里只是一个示例，游戏发布后具体版本当视情况而定</p>
	 *@author as3Lover_ph
	 *@date 2013-3-3
	 */
	public class VersionManager
	{
		private static const CLIENT_VERSION :String = "V1.2.2.858";
		private static const JPG_VERSION :String = "J001";
		private static const PNG_VERSION :String = "P002";
		private static const SWF_VERSION :String = "S003";
		private static const XML_VERSION :String = "X004";
		
		private static const _root :String = "res/";
		
		public function VersionManager()
		{
		}
		
		/**
		 *进行版本编码 
		 * @param name 初始url地址
		 * @return 返回编码后的url地址
		 * 
		 */		
		public static function encode(name :String):String
		{
			if((name.indexOf(_root) > -1) && (name.indexOf("jpg") > -1))
				return name+"?v="+JPG_VERSION;
			if((name.indexOf(_root) > -1) && (name.indexOf("png") > -1))
				return name+"?v="+PNG_VERSION;
			if((name.indexOf(_root) > -1) && (name.indexOf("swf") > -1))
				return name+"?v="+SWF_VERSION;
			if((name.indexOf(_root) > -1) && (name.indexOf("dnf") > -1))
				return name+"?v="+XML_VERSION;
			if((name.indexOf(_root) > -1) && (name.indexOf("xml") > -1))
				return name+"?v="+XML_VERSION;
			return CLIENT_VERSION;
			
		}
		
		
	}
}
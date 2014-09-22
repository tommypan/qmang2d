package qmang2d.security.xml
{
	import flash.utils.ByteArray;

	/**
	 * 通过此类做一个加密工具
	 * @author ph
	 * 
	 */	
	public class SecurityTool
	{
		public function SecurityTool()
		{
		}
		
		//密钥
		private static const swfKey:String="daj7r4$3{:38crazyTribe";
		private static const zipKey:String="543u8y&^&^$/crazyTribe";
		
		//源文件读出的short值.xml读不出来，所以只好进行zip打包
		private static const swfHead:uint=0x4357;
		private static const zipHead:uint=0x504B;
		
		
		public static function encode(data:ByteArray,type:String):ByteArray
		{
			var head:uint=data.readShort();
			var key:String;
			if(type==SecurityFileType.SWF)
			{
				if(head!=swfHead)
				{
					trace("该文件不是swf文件");
					return data;
				}
				else
				{
					key=swfKey;
				}
			}
			else if(type==SecurityFileType.ZIP)
			{
				if(head!=zipHead)
				{
					trace("该文件不是zip文件");
					return data;
				}
				else
				{
					key=zipKey;
				}
			}
			var byteArray:ByteArray=new ByteArray();
			data.position=0;
			var flag:int=0;
			for(var i:int = 0; i<data.length ; i++ ,flag++){
				if(flag >= key.length){
					flag = 0;
				}
				byteArray.writeByte(data[i] + key.charCodeAt(flag));
			}
			return byteArray;
		}
		
		/**
		 *通过urlLoader将其load，然后解密其二进制流，返回一个二进制流。在重新load一次即可。
		 * @param data
		 * @param type
		 * @return 
		 * 
		 */		
		public static function decode(data:ByteArray,type:String="zip"):ByteArray
		{
			var head:uint=data.readShort();
			var key:String;
			if(type==SecurityFileType.SWF)
			{
				if(head==swfHead)
				{
					trace("swf未加密");
					return data;
				}
				else
				{
					trace("swf已加密");
					key=swfKey;
				}
			}
			else if(type==SecurityFileType.ZIP)
			{
				if(head==zipHead)
				{
					trace("zip未加密");
					return data;
				}
				else
				{
					trace("zip已加密");
					key=zipKey;
				}
			}
			var byteArray:ByteArray=new ByteArray();
			data.position=0;
			var flag:int=0;
			for(var i:int = 0; i<data.length ; i++ ,flag++){
				if(flag >= key.length){
					flag = 0;
				}
				byteArray.writeByte(data[i] - key.charCodeAt(flag));
			}
			trace("解密完成");
			return byteArray;	
		}
	}
}
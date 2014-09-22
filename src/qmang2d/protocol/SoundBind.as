package qmang2d.protocol
{
	import flash.utils.Dictionary;
	
	/**
	 * 声音素材swf资源路径与类的绑定
	 *@author as3Lover_ph
	 *@date 2013-2-16
	 */
	public class SoundBind
	{
		private static var _soundBindDic :Dictionary = new Dictionary();
		
	
		/**
		 *音效素材绑定 
		 * id为键，值为资源地址
		 */		
		public static function bind():void
		{
			//背景音乐
			_soundBindDic["bg1"] = "assets/sound.swf";
			_soundBindDic["bg2"] = "assets/sound.swf";
			_soundBindDic["bg3"] = "assets/sound.swf";
			_soundBindDic["bg4"] = "assets/sound.swf";
			_soundBindDic["bg5"] = "assets/sound.swf";
			_soundBindDic["bg6"] = "assets/sound.swf";
			_soundBindDic["bg7"] = "assets/sound.swf";
			_soundBindDic["bg8"] = "assets/sound.swf";
			_soundBindDic["finalSound"] = "assets/finalSound.swf";
			
			
			//攻击音效
			_soundBindDic["lFight"] = "assets/sound.swf";
		
			_soundBindDic["fight1"] = "assets/sound.swf";
			_soundBindDic["fight2"] = "assets/sound.swf";
			_soundBindDic["fight3"] = "assets/sound.swf";
//			_soundBindDic["fight4"] = "assets/sound.swf";
//			_soundBindDic["fight5"] = "assets/sound.swf";
//			_soundBindDic["fight6"] = "assets/sound.swf";
			
			//其它音效
			_soundBindDic["sheep"] = "assets/sound.swf";
			_soundBindDic["mouseClick"] = "assets/sound.swf";
			_soundBindDic["start"] = "assets/sound.swf";
			//建塔音效
			_soundBindDic["sBuild"] = "assets/sound.swf";
			_soundBindDic["sArrow1"] = "assets/sound.swf";
			_soundBindDic["sArrow2"] = "assets/sound.swf";
			_soundBindDic["sArrow3"] = "assets/sound.swf";
			_soundBindDic["sArrow4"] = "assets/sound.swf";
			
			_soundBindDic["sSoldier1"] = "assets/sound.swf";
			_soundBindDic["sSoldier2"] = "assets/sound.swf";
			_soundBindDic["sSoldier3"] = "assets/sound.swf";
			_soundBindDic["sSoldier4"] = "assets/sound.swf";
			
			_soundBindDic["sMagic1"] = "assets/sound.swf";
			_soundBindDic["sMagic2"] = "assets/sound.swf";
			_soundBindDic["sMagic3"] = "assets/sound.swf";
			_soundBindDic["sMagic4"] = "assets/sound.swf";
			
			_soundBindDic["sCannon1"] = "assets/sound.swf";
			_soundBindDic["sCannon2"] = "assets/sound.swf";
			_soundBindDic["sCannon3"] = "assets/sound.swf";
			_soundBindDic["sCannon4"] = "assets/sound.swf";
			
			//塔的攻击音效
			_soundBindDic["sFightCannon1"] = "assets/sound.swf";
			_soundBindDic["sFightCannon2"] = "assets/sound.swf";
			_soundBindDic["sFightArrow3"] = "assets/sound.swf";
			_soundBindDic["sFightMagic1"] = "assets/sound.swf";
			
			//支援音效
			_soundBindDic["sSupport1"] = "assets/sound.swf";
			_soundBindDic["sSupport2"] = "assets/sound.swf";
			_soundBindDic["sSupport3"] = "assets/sound.swf";
			_soundBindDic["sSupport4"] = "assets/sound.swf";
			//怪物咆哮
			_soundBindDic["dog"] = "assets/sound.swf";
			_soundBindDic["wolf"] = "assets/sound.swf";
			_soundBindDic["sFire"] = "assets/sound.swf";
			//怪物受伤
			_soundBindDic["hurt1"] = "assets/sound.swf";
			_soundBindDic["hurt2"] = "assets/sound.swf";
			_soundBindDic["hurt3"] = "assets/sound.swf";
//			_soundBindDic["hurt4"] = "assets/sound.swf";
			//怪物死亡
			_soundBindDic["dead1"] = "assets/sound.swf";
			_soundBindDic["dead2"] = "assets/sound.swf";
			_soundBindDic["dead3"] = "assets/sound.swf";
			_soundBindDic["dead4"] = "assets/sound.swf";
			_soundBindDic["dead5"] = "assets/sound.swf";
			_soundBindDic["dead6"] = "assets/sound.swf";
//			_soundBindDic["dead7"] = "assets/sound.swf";
//			_soundBindDic["dead8"] = "assets/sound.swf";
//			_soundBindDic["dead9"] = "assets/sound.swf";
//			_soundBindDic["dead10"] = "assets/sound.swf";
//			_soundBindDic["dead11"] = "assets/sound.swf";
//			_soundBindDic["dead12"] = "assets/sound.swf";
//			_soundBindDic["dead13"] = "assets/sound.swf";
//			_soundBindDic["dead14"] = "assets/sound.swf";
			//怪物通过音效
			_soundBindDic["sClock"] = "assets/sound.swf";
			//第一关的鸟叫
			_soundBindDic["sBird"] = "assets/sound.swf";
			//胜利音效
			_soundBindDic["sVictory"] = "assets/sound.swf";
			
			// and others...........
		}
		
		/**
		 *储存声音字典 只读 
		 * @return 
		 * 
		 */		
		public static function get soundBindDic():Dictionary
		{
			return _soundBindDic;
		}
		
	}
}
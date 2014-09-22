package qmang2d.protocol
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import qmang2d.loader.LoaderManager;
	import qmang2d.utils.ClassManager;
	
	/**
	 * 为音乐播放提供简单接口
	 * <p>请不要在游戏中直接调用LoaderManager中提供的getMp3方法，实际上这些音乐素材都是通过swf打包后模块加载获取的
	 * 所以请使用这里的方法获取mp3素材</p>
	 *@author as3Lover_ph
	 *@author Star_lql
	 *@date 2013-2-12
	 */
	public class SoundManager
	{
		private static var _instance :SoundManager;
		
		/**背景音乐(城中和战斗背景)*/
		private var _bgSoundChannel :SoundChannel;
		
		/**特效音乐*/
		private var _effectSoundChannel :SoundChannel;
		
		/***背景音乐大小*/
		private var _bgSoundVolume :Number;
		
		/**特效音乐音量大小*/
		private var _effectSoundVolume :Number;
		
		/**是否关闭所有音效*/
		public static var isCloseEffectSound:Boolean=false;
		
		/**是否关闭所有背景音乐*/
		public static var isCloseBgSound:Boolean=false;
		
		private var _playBgClassName :String;
		
		private var _curEffectCalssName :String;
		
		/**是否正在加载*/
		private var _isLoading :Boolean;
		
		//加载完成进行匹配时的鲁棒性检查
		private var _bgFlagA :int;
		private var _bgFlagB :int;
		
		private var _root:String = "assets/";
		
		public function SoundManager($singlton :SingltonEnforcer)
		{
			if($singlton==null) throw new Error("此例为单例");
			else
			{
				SoundBind.bind();
				
				//LoaderManager.getInstance().getModualSwf(_root+"common.swf"); //------------加载音效swf文件
				
			}
		}
		
		public static function getInstance():SoundManager
		{
			_instance ||= new SoundManager( new SingltonEnforcer());
			return _instance;
		}
		
		/**
		 *播放背景音乐 。加载完成后，会自动播放
		 * @param id_ 背景音乐id号。 在SoundBind里面有绑定的信息
		 * @param soundVolume_音量大小，从0到1
		 * 
		 */		
		public function playBgSound(id_:String,soundVolume_:Number):void
		{
			if(!isCloseBgSound){
				_bgFlagA++;
				_playBgClassName = id_;
				_bgSoundVolume = soundVolume_;
				LoaderManager.getInstance().getModualSwf(SoundBind.soundBindDic[id_],handleBgMusic);
			}
		}
		
		private function handleBgMusic():void
		{
			_bgFlagB++;
			if(_bgFlagA==_bgFlagB)	
			{
				var sound :Sound = ClassManager.createInstance(_playBgClassName) as Sound;
				
				if(_bgSoundChannel) _bgSoundChannel.stop();
				_bgSoundChannel = sound.play(0,int.MAX_VALUE);
				
				if(_bgSoundVolume != 1)
				{
					var soundTrans:SoundTransform;
					soundTrans = _bgSoundChannel.soundTransform;
					soundTrans.volume = _bgSoundVolume;
					_bgSoundChannel.soundTransform = soundTrans;
				}
			}
		}
		
		/**
		 * 注：特效音乐最好放在进入游戏之前加载完成(直接调用SoundManager.getInstance()就行)，一般游戏都是这样做的，这样里面就不用再加判断
		 *<p>播放特效音乐，加载完成后，会自动播放。比如打开面板，战斗特效音乐 </p>
		 * @param id_特效音乐编号。 在SoundBind里面有绑定的信息
		 * @param soundVolume_ 音量大小，从0到1。默认值为1
		 * 
		 */		
		public function playEffectSound(id_:String,soundVolume_:Number=1):void
		{
			if(!isCloseEffectSound){
				_curEffectCalssName = id_;
				_effectSoundVolume = soundVolume_;
				LoaderManager.getInstance().getModualSwf(SoundBind.soundBindDic[id_], handleEffectMusic); 
			}
		}
		
		private function handleEffectMusic():void
		{
			var sound :Sound = ClassManager.createInstance(_curEffectCalssName) as Sound;
			_effectSoundChannel = sound.play();
			if(_effectSoundVolume != 1)
			{
				var soundTrans:SoundTransform;
				soundTrans = _bgSoundChannel.soundTransform;
				soundTrans.volume = _bgSoundVolume;
				_effectSoundChannel.soundTransform = soundTrans;
			}
			
		}
		
		/**
		 *停止播放当前背景音乐。因为考虑到地图场景切换问题，所以要重新播放音乐，请使用  playBgSound(id_:String,soundVolume_:Number)方法
		 * 
		 */		
		public function MusicPuase():void
		{
			if(_bgSoundChannel)	_bgSoundChannel.stop();
		}
		/**
		 *开关音效播放
		 * lql   2013.8.14添加
		 */		
		public function closeEffectMusic(boolean:Boolean):void
		{
			isCloseEffectSound = boolean;
		}
		/**
		 *开关音乐播放
		 * lql   2013.8.14添加
		 */		
		public function closeBgMusic(boolean:Boolean):void
		{
			isCloseBgSound = boolean;
			if(!boolean){
				playBgSound(_playBgClassName,_bgSoundVolume);
			}else{
				_bgSoundChannel.stop();
			}
		}
		
		//------------------------------------------读写器-----------------------------------------
		public function get bgSoundVolume():Number
		{
			return _bgSoundVolume;
		}
		
		public function get effectSoundVolume():Number
		{
			return _effectSoundVolume;
		}
		
		/**
		 *设置背景音乐音量值 
		 * @param value 音量大小
		 * 
		 */		
		public function set bgSoundVolume(value:Number):void
		{
			var soundTrans:SoundTransform;
			if (_bgSoundChannel)
			{
				soundTrans = _bgSoundChannel.soundTransform;
				soundTrans.volume = value;
				_bgSoundChannel.soundTransform = soundTrans;
			};
			
		}
		
		/**
		 *设置特效声音音量 
		 * @param value 音量值
		 * 
		 */		
		public function set effectSoundVolume(value:Number):void
		{
			var soundTrans:SoundTransform;
			if (_effectSoundChannel)
			{
				soundTrans = _effectSoundChannel.soundTransform;
				soundTrans.volume = value;
				_effectSoundChannel.soundTransform = soundTrans;
			};
		}
		
		
	}
}
internal class SingltonEnforcer{}
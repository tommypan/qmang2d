package qmang2d.display 
{
	import qmang2d.qmang2d;
	import qmang2d.cacher.SmartSourceCacher;
	import qmang2d.utils.TimerManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.FrameLabel;
	import flash.display.Sprite;
	import flash.events.Event;
	
	use namespace qmang2d;
	
	/**
	 * 位图缓存显示对象基类
	 * <p>不支持鼠标交互，用于技能渲染等</p>
	 * <p>注：在外部使用接口时，如果先要判断资源是否加载进来时，请frameInfo()方法判断</p>
	 * <p>例：if(bitmapMovie.frameInfo)	bitmapMovie.gotoAndStop(2);</p>
	 * @author as3Lover_ph
	 * @date 2013-2-10
	 * 
	 */
	public class BitmapMovie extends Sprite
	{
		
		/**主角*/
		protected var _bitmap:Bitmap;
		
		/**派发事件携带的信息*/
		public static var END:String = "end";
		
		/**存储影片剪辑容器*/
		protected var _movieClipDataContainer:Vector.<BitmapFrameInfo>;
		
		/**动画的总帧数*/
		protected var _totalFrames:int;
		
		/**每帧动画之间的时延*/
		protected var _delay:int = -1;
		
		/**动画播放区间的开始帧*/
		protected var _startFrame:int;
		
		/**动画播放区间的结束帧*/
		protected var _endFrame:int;
		
		protected var _currentFrame:int=1;
		
		/**是否循环播放*/
		protected var _isLoop:Boolean = true;;
		
		/**在播放动画缩放时是否进行平滑处理，默认不用，外部可以设置*/
		protected var _isSmooth:Boolean = false;
		
		/**动画播放区间完成后的回调函数*/
		protected var _endFunction:Function;
		
		protected var _url :String;
		
		protected var _counter :int;
		
		protected var _loopCounter :int = 1;
		
		/**
		 *标签数组 
		 */		
		public var lables :Array;
		
		/**
		 * 
		 * @param isUseDefRe_ 是否使用默认资源
		 * @param delay_ 设置动画时延
		 * 
		 */		
		public function BitmapMovie(isUseDefRe_ :Boolean = false,delay_ :int = -1):void
		{
			
			_bitmap = new Bitmap(null,"auto",true);
			this.mouseChildren = false;
			this.mouseEnabled  = false;
			addChild(_bitmap);
			
			useDefRe(isUseDefRe_);
			_delay = delay_;
		}
		
		private function useDefRe(isUseDefRe_:Boolean):void
		{
			if(isUseDefRe_ && SmartSourceCacher.getInstance().contain("default.png") )	
				_bitmap.bitmapData = SmartSourceCacher.getInstance().getValue("default.png") as BitmapData;
		}		
		
		/**
		 *开始播放动画 
		 * 
		 */		
		public function play():void{
			if (delay)//调整好每帧之间时间间隔后就开始渲染
			{
				TimerManager.getInstance().remove(step);
				TimerManager.getInstance().add(delay,step);
			}
		}
		
		/**
		 *停止播放动画 
		 * <p>注：此种方法只能停止此bitmapMovie渲染，若要彻底清理，则还要调用recycle方法</p>
		 * 
		 */		
		public function stop():void
		{
			TimerManager.getInstance().remove(step);
		}
		
		
		/**
		 *跳到指定的帧开始播放 
		 * <p>注：这里的接口与官方的movieClip接口有点不一样，增加了几个可选参数，主要是考虑到游戏实际
		 * 中的影片剪辑文件与游戏中的需求问题故而才设置了这几个可选参数。功能类似于播放管理类</p>
		 * @param frameIndex 所指定播放帧
		 * @param isLoop_ 是否循环播放
		 * @param _startFrame_ 循环播放后开始帧
		 * @param _endFrame_ 播放结束帧
		 * @param $endFunction 播放结束后回调函数  在isLoop_为false的情况下才执行
		 * */
		public function gotoAndPlay(frameIndex:int,isLoop_:Boolean=true, _startFrame_:int=0, _endFrame_:int=0, $endFunction:Function=null):void
		{
			
			_isLoop = isLoop_;
			_currentFrame = frameIndex;
			
			//程序的各种鲁棒检查
			if (_movieClipDataContainer == null)
			{
				return;
			};
			
			if (_startFrame_ == 0)
			{
				_startFrame = 1;
			} else {
				_startFrame = _startFrame_;
				
			};
			
			if (_endFrame_ == 0)
			{
				_endFrame = _totalFrames;
			} else {
				
				_endFrame = _endFrame_;
				
			};
			
			_endFunction = $endFunction;
			setCurrentFrame(_currentFrame);
			play();
			
		}
		
		/**
		 * 跳转到指定帧并停止
		 * @param	frameIndex
		 */
		public function gotoAndStop(frame_:Object):void
		{
			
			if (_movieClipDataContainer == null){
				return;
			};
			if ((frame_ is Number)){
				_currentFrame = int(frame_);
			};
			setCurrentFrame(_currentFrame);
			stop();
			
		}
		
		
		private function step(/*evt:Event*/):void
		{
			_counter++;
			if(_counter/_loopCounter is int)
			{
				if (_currentFrame == _endFrame)//如果当前播放帧数等于于结束帧
				{
					
					if (_isLoop == false)
					{
						stop();
						if (_endFunction != null)
						{
							_endFunction();
						};
						dispatchEvent(new Event(END));
						return;
					}
					
					if (_endFunction != null)
//						_endFunction();
					dispatchEvent(new Event(END));
					_currentFrame = this._startFrame;
				}else {
					_currentFrame++;
				};
				
				if (_movieClipDataContainer == null){
					return;
				};
				setCurrentFrame(_currentFrame);//设定下帧播放
			}
		}
		
		
		/**
		 * 跳转到指定索引的帧
		 * @param	frameIndex
		 */
		protected function setCurrentFrame(frameIndex:int):void
		{
			
			
			if (frameIndex > _movieClipDataContainer.length)
			{
				frameIndex = 1//_movieClipDataContainer.length;
			}else if (frameIndex <= 0){
				frameIndex = 1;
			}
			
			_currentFrame = frameIndex;
			var f_info:BitmapFrameInfo = _movieClipDataContainer[_currentFrame - 1];
			_bitmap.bitmapData = f_info.bitmapData;
			_bitmap.x = f_info.x;
			_bitmap.y = f_info.y;
			
		}
		
		
		/**
		 * 获取当前位图帧信息
		 */
		public function getCurrentBitmapFrameInfo():BitmapFrameInfo
		{
			return _movieClipDataContainer[_currentFrame];
		}
		
		/**
		 * 获取指定索引的位图帧信息
		 * @param	index
		 * @return
		 */
		public function getBitmapFrameInfoByIndex(index:int):BitmapFrameInfo
		{
			///用户指定的帧数从1开始，程序内部的数组索引从0开始  因此减1
			return _movieClipDataContainer[index - 1];
		}
		
		/**
		 * 回收。
		 * <p>注：此资源内存释放问题已经过反复测试，可起到及时缓存及释放内存之功效，请放心使用</p>
		 */
		public function recycle():void
		{
			if(SmartSourceCacher.getInstance().contain(_url))
				SmartSourceCacher.getInstance().remove(_url);
			dispose();
			
		}
		
		/**
		 * 销毁对象，释放资源
		 */
		public function dispose():void
		{
			
			
			_endFunction = null;
			
			if(_bitmap.bitmapData)
			{
				_bitmap.bitmapData.dispose();
				_bitmap.bitmapData = null;
			}
			
			TimerManager.getInstance().remove(step);
			
			if (_movieClipDataContainer != null)
			{
				_movieClipDataContainer = null;
			};
			
		}
		
		//---------------------------------------- 华丽的转身，各种读写器 ------------------------------
		/**
		 * 位图帧序列
		 */
		public function get frameInfo():Vector.<BitmapFrameInfo> 
		{
			
			return _movieClipDataContainer; 
			
		}
		
		/**
		 * 位图帧序列
		 */
		public function set frameInfo(value:Vector.<BitmapFrameInfo>):void
		{
			
			_movieClipDataContainer = value;
			
			_bitmap.bitmapData = null;
			
			if (_movieClipDataContainer != null)
			{
				_totalFrames = _movieClipDataContainer.length - 1;
				this._startFrame = 1;
				this._endFrame = this._totalFrames;
				//gotoAndPlay(_currentFrame);
				//gotoAndStop(5);
				//setCurrentFrame(_currentFrame);
				play();
			}
			
		}
		
		/**
		 * 获取或设置位图是否启用平滑处理
		 */
		public function get smoothing():Boolean 
		{ 
			return _bitmap.smoothing; 
		}
		
		public function set smoothing(value:Boolean):void 
		{
			_bitmap.smoothing = value;
		}
		
		
		public function get bitmap():Bitmap
		{
			return _bitmap;
		}
		
		public function set bitmapData(value :BitmapData):void
		{
			_bitmap.bitmapData = value;
		}
		
		/**每帧动画之间的时间间隔*/
		public function set delay(value:int):void{
			this._delay = value;
		}
		
		public function get delay():int{
			if (this._delay <= 0){//为timerManeger
				return ((1000 / 30));
			};
			return (this._delay);
		}
		
		/**此bitmapMovie的url地址*/
		public function set url(value:String):void
		{
			_url = value;
		}
		
		/**
		 *如果要还要进一步减小每帧之间 的渲染时间，可以通过设置此参数
		 * <p>若此参数增大，则每帧之间渲染时间会提高
		 * @param value
		 * 
		 */
		public function set loopCounter(value:int):void
		{
			_loopCounter = value;
		}
		
		/**当前播放帧，默认从第一帧开始，与线性表索引从0开始不同*/
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		
	}
	
}
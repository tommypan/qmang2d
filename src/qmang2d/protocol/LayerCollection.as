package qmang2d.protocol
{
	import flash.display.Sprite;
	
	/**
	 * 进入游戏时会涉及到各种分层。所以在此处可以管理游戏分层，提前将层次分好，到了游戏各个阶段只需将对应displayObject加在已经分好的层次上
	 *@author as3Lover_ph
	 *@date 2013-3-12
	 */
	public class LayerCollection extends Sprite
	{
		/**
		 * 战斗场景的背景 最里层的
		 */		
		public static var mapLayer:Sprite = new Sprite();
		
		
		/**
		 *人物层 ，还应该细化一个尸体层
		 */		
		public static var playerLayer :Sprite = new Sprite();
		
		/**
		 *特效层，人物层上面，ui层下面 
		 */		
		public static var effectLayer :Sprite = new Sprite();
		
		/**
		 *建筑层，人物层上面，ui层下面 
		 */		
		public static var buildingLayer :Sprite = new Sprite();
		
		/**
		 *UI层  最外层 
		 */		
		public static var uiLayer:Sprite = new Sprite();
		
		/**
		 *debug层  最外层 
		 */		
		public static var deBugLayer:Sprite = new Sprite();
		
		public function LayerCollection()
		{
		}
	}
}

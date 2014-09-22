package qmang2d.ui
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import qmang2d.loader.LoaderManager;
	import qmang2d.utils.ClassManager;
	import qmang2d.protocol.VersionManager;
	
	/**
	 * 测试PopUpManager用的
	 *@author as3Lover_ph
	 *@date 2013-3-19
	 */
	public class TestUiSprite extends Sprite
	{
		public function TestUiSprite()
		{
			initUi();
			
		}
		
		private function initUi():void
		{
			var bitmap1 :Bitmap = new Bitmap(ClassManager.createBitmapDataInstance("Battle_BattleVictoryTitle"));
			bitmap1.x = 600;
			addChild(bitmap1);
			
			var bitmap2 :Bitmap = new Bitmap(ClassManager.createBitmapDataInstance("Battle_BattleFailTitle"));
			bitmap2.x = 300;
			addChild(bitmap2);
			
			var bitmap3 :Bitmap = new Bitmap(ClassManager.createBitmapDataInstance("Battle_ExperienceLabel"));
			bitmap3.x = 100;
			addChild(bitmap3);
			
		}		
		
	}
}
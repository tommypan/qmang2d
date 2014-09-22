package  qmang2d.findPath 
{
    import flash.utils.*;

	/**
	 * 场景寻路，将场景寻路与小范围寻路区分开。小范围使用优化后的a*完全没问题的，场景寻路时如果在使用前一种寻路方式必然造成效率极大问题
	 * 所以可以考虑使用一种更合适的方法寻路。甚至可以对一些固定的跳转点，npc点先前算好路点
	 * @author aser_ph
	 * 
	 */	
    public class FindScenePath 
	{


        public function FindScenePath(obj:Object):void
		{
			
        }

    }
}

package qmang2d.framework
{
    import flash.events.*;
    import flash.utils.*;

    public class GameDispatcher extends EventDispatcher
	{

        private static var _instance:GameDispatcher;


        public function GameDispatcher($singltonEnforcer:singltonEnforcer)
		{
			if(!$singltonEnforcer)
				throw new Error("此为单例");
        }
		
        public static function getInstance():GameDispatcher
		{
			_instance ||= new GameDispatcher(new singltonEnforcer());
			return _instance;
        }


    }
}
class singltonEnforcer{}
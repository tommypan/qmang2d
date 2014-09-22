package qmang2d.framework.command
{

    public class CommandBase implements IProtocol
	{

        private var _commandId:uint = 0;
		
        public function CommandBase(cmdId:uint)
		{
			_commandId = cmdId;
        }
		
        public function get commandId():uint
		{
            return _commandId;
        }

		
    }
}

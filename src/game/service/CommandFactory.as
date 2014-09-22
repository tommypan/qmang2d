package  game.service
{
	import flash.utils.Dictionary;
	
	import game.service.income.SCMD100;
	import game.service.income.SCMD61;
	import game.service.outgoing.CCMD100;
	
	import qmang2d.framework.command.IIncomming;
	import qmang2d.framework.command.IncommingBase;
	
	
	public class CommandFactory
	{
		private static var _instance:CommandFactory;
		
		private  var _commands:Dictionary;
		
		public function CommandFactory($singltonEnforcer:singltonEnforcer)
		{
			if($singltonEnforcer)
			{
				_commands = new Dictionary();
			}
		
		}
		
		public static function getIntance():CommandFactory
		{
			_instance ||= new CommandFactory(new singltonEnforcer());
			return _instance;
		}
		
		/**
		 * 绑定所有的SCMD命令
		 * 
		 */		
		public  function bindAll():void
		{
			_commands[100] = SCMD100;
			_commands[61] = SCMD61;
		}
		
		/**
		 * 增加一个绑定
		 * @param cmdId SCMD代号id
		 * @param clazz SCMD类的引用
		 * <p>警告： 请传入SCMD类型的类引用
		 */		
		public  function bind(cmdId:int,clazz:Class):void
		{
			if(_commands[cmdId]) return;
			else _commands[cmdId] = clazz;
		}
		
		/**
		 * 解除一个绑定
		 * @param cmdId SCMD代号id
		 * 
		 */		
		public  function unbind(cmdId:int):void
		{
			if(_commands[cmdId])
			{
				_commands[cmdId] = null;
				delete _commands[cmdId];
			}
		}
		
		public  function getCommandMode(id:uint):IIncomming
		{
			return new (_commands[id])(id);
		}

		
	}
}
class singltonEnforcer{}
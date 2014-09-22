package game.controller
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.controller.Controller1520;
	import game.events.bus.GameBus;
	import game.model.Model1;
	import game.service.income.SCMD100;
	import game.service.income.SCMD61;
	import game.service.outgoing.CCMD100;
	import game.service.outgoing.CCMD11;
	import game.service.outgoing.CCMD12;
	import game.service.outgoing.CCMD13;
	import game.service.outgoing.CCMD21;
	import game.service.outgoing.CCMD22;
	import game.service.outgoing.CCMD23;
	import game.service.outgoing.CCMD24;
	import game.service.outgoing.CCMD25;
	
	import qmang2d.framework.Controller;
	import qmang2d.framework.GameDispatcher;
	import qmang2d.framework.ModelFactory;
	import qmang2d.framework.SocketService;
	
	public class Controller1520 extends Controller
	{
		public function Controller1520()
		{
			SocketService.getInstance().connect("172.23.15.40",8080);
			dispatcher.addEventListener(GameBus.CONNECT_COMPLETE,onConnect);
		}
		
		
		protected function onConnect(event:Event):void
		{
			var loginCommand :CCMD100 = new CCMD100(100);
			loginCommand.id = "潘豪";
			loginCommand.pwd = "123456";
			loginCommand.send();
			
			
			SocketService.getInstance().addCmdListener(100,this.handleLogin);
			SocketService.getInstance().removeCmdListener(100,this.handleLogin);
			
			SocketService.getInstance().addCmdListener(61,handle61);
			
			var cmd11 :CCMD11 = new CCMD11(11);
			cmd11.input0 = 0;
			cmd11.send();
			
			var cmd12 :CCMD12 = new CCMD12(12);
			cmd12.input5 = 5;
			cmd12.send();
			
			var cmd13 :CCMD13 = new CCMD13(13);
			cmd13.input10 = 10;
			cmd13.send();
			
			var cmd21 :CCMD21 = new CCMD21(21);
			cmd21.guess0 = 0;
			cmd21.send();
			
			var cmd22 :CCMD22 = new CCMD22(22);
			cmd22.guess5 = 5;
			cmd22.send();
			
			var cmd23 :CCMD23 = new CCMD23(23);
			cmd23.guess10 = 10;
			cmd23.send();
			
			var cmd24 :CCMD24 = new CCMD24(24);
			cmd24.guess15 = 15;
			cmd24.send();
			
			var cmd25 :CCMD25 = new CCMD25(25);
			cmd25.guess20 = 20;
			cmd25.send();
			
		}
		
		private function handle61(scmd61:SCMD61):void
		{
			trace("scmd61.fallOrWin:"+scmd61.fallOrWin);
			trace("scmd61.sum:"+scmd61.sum);
		}
		
		private function handleLogin(login:SCMD100):void
		{
			trace(login.result);
		}
	}
}
package
{
	import app.ctrl.InitCommand;
	import app.model.TextModel;
	import app.service.MockTextService;
	import app.service.TextService;
	import app.view.Console;
	import app.view.ConsoleMediator;
	import flash.display.DisplayObjectContainer;
	import gaia.lib.robotlegs.flow.CommandFlow;
	import org.robotlegs.mvcs.Context;




	public class AppContext extends Context
	{
		
		public function AppContext(container:DisplayObjectContainer)
		{
			super(container, true);
		}

		override public function startup():void
		{
			injector.mapSingleton(CommandFlow);
			injector.mapSingleton(TextModel);
			injector.mapSingletonOf(TextService, MockTextService);
			
			mediatorMap.mapView(Console, ConsoleMediator);
			
			commandMap.execute(InitCommand);
		}
		
	}
}

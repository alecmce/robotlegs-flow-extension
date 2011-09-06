package app.ctrl
{

	import gaia.lib.robotlegs.flow.CommandFlow;
	
	public class InitCommand
	{
		[Inject]
		public var stack:CommandFlow;
		
		public function execute():void
		{
			stack.push(InitModelCommand);
			stack.push(InitViewCommand);
			stack.next();
		}

	}
}

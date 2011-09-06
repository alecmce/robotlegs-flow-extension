package gaia.lib.robotlegs.flow.eg
{
	import gaia.lib.robotlegs.flow.CommandFlow;
	
	public class TrivialCommand
	{

		private var _stack:CommandFlow;

		public function TrivialCommand(stack:CommandFlow)
		{
			_stack = stack;
		}

		public function execute():void
		{
			_stack.next();
		}
		
	}
}

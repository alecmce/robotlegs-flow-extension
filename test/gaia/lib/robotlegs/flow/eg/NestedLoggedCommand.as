package gaia.lib.robotlegs.flow.eg
{
	import gaia.lib.robotlegs.flow.CommandFlow;
	
	public class NestedLoggedCommand
	{
		private var _stack:CommandFlow;
		private var _log:TestLog;
		private var _ids:Array;

		public function NestedLoggedCommand(stack:CommandFlow, log:TestLog, ids:Array)
		{
			_stack = stack;
			_log = log;
			_ids = ids;
		}

		public function execute():void
		{
			_stack.push(LoggedCommand, _log, "b");
			_stack.push(LoggedCommand, _log, "c");
			_stack.next();
		}
		
	}
}

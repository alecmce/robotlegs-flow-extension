package gaia.lib.robotlegs.flow.eg
{
	import gaia.lib.robotlegs.flow.CommandFlow;
	
	public class LoggedCommand
	{

		private var _stack:CommandFlow;
		private var _log:TestLog;
		private var _id:String;

		public function LoggedCommand(stack:CommandFlow, log:TestLog, id:String)
		{
			_stack = stack;
			_log = log;
			_id = id;
		}

		public function execute():void
		{
			_log.append(_id);
			_stack.next();
		}
		
	}
}

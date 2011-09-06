package gaia.lib.robotlegs.flow.eg
{
	import gaia.lib.robotlegs.flow.CommandFlow;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class AsyncCommand
	{
		
		private var _flow:CommandFlow;
		private var _log:TestLog;
		private var _id:String;

		private var _timer:Timer;

		public function AsyncCommand(flow:CommandFlow, log:TestLog, id:String)
		{
			_flow = flow;
			_log = log;
			_id = id;
		}

		public function execute():void
		{
			_log.append(_id.toLowerCase());
			_timer = new Timer(50, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.start();
		}

		private function onTimerComplete(event:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.reset();
			_timer = null;
			
			_log.append(_id.toUpperCase());
			_flow.next();
		}
		
	}
}

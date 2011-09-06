package app.service
{

	import gaia.lib.async.Future;
	import gaia.lib.async.FutureDispatcher;

	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class MockTextService implements TextService
	{
		private var _map:Dictionary;
		
		public function MockTextService()
		{
			_map = new Dictionary();
		}
		
		public function getText():Future
		{
			var future:FutureDispatcher = new FutureDispatcher();
			
			var timer:Timer = new Timer(1000, 1);
			_map[timer] = future;
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTextResponse);
			timer.start();
			
			return future;
		}

		private function onTextResponse(event:TimerEvent):void
		{
			var timer:Timer = event.currentTarget as Timer;
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTextResponse);
			
			var future:FutureDispatcher = _map[timer];
			delete _map[timer];
			
			var lines:Vector.<String> = new Vector.<String>(2, true);
			lines[0] = "Hello Robotlegs!";
			lines[1] = "This is a demo";
			
			future.dispatch(lines);
		}

	}
}

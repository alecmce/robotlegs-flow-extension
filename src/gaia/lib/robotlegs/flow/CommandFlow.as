package gaia.lib.robotlegs.flow
{
	import gaia.lib.async.Future;
	import gaia.lib.async.FutureDispatcher;

	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;

	import flash.system.ApplicationDomain;

	final public class CommandFlow
	{
		private var _domain:ApplicationDomain;
		private var _injector:IInjector;
		private var _reflector:IReflector;
		
		private var _stack:Vector.<CommandWrapper>;
		private var _completed:FutureDispatcher;
		
		private var _isExecuted:Boolean;

		private var _runInParallel:Boolean;
		private var _parallelCount:uint;
		
		public function CommandFlow(injector:IInjector, reflector:IReflector)
		{
			_injector = injector.createChild(_domain = injector.applicationDomain);
			_reflector = reflector;
			
			_stack = new Vector.<CommandWrapper>();
			_completed = new FutureDispatcher();
		}
		
		public function get runInParallel():Boolean
		{
			return _runInParallel;
		}

		public function set runInParallel(value:Boolean):void
		{
			if (_runInParallel == value)
				return;
			
			if (_isExecuted)
				throw new Error("runInParallel must be set before the CommandFlow is initiated with next()");
			
			_runInParallel = value;
		}
		
		public function push(command:Class, ...args):Boolean
		{
			if (_isExecuted)
				return false;
			
			var wrapper:CommandWrapper = new CommandWrapper(_injector, _reflector);
			wrapper.command = command;
			
			wrapper.args = args;
			
			_stack.push(wrapper);
			return true;
		}
		
		public function next():void
		{
			_isExecuted = true;
			if (_stack.length)
				_runInParallel ? executeInParallel() : executeSequentially();
			else
				_completed.dispatch();
		}

		public function get completed():Future
		{
			return _completed;
		}

		private function executeInParallel():void
		{
			_parallelCount = _stack.length;
			
			var count:uint = _parallelCount;						// this is required in case of synchronous commands
			for (var i:int = 0; i < count; i++)
				_stack[i].execute().addOnce(parallelCommandCompleted);
		}

		private function parallelCommandCompleted():void
		{
			if (--_parallelCount == 0)
				_completed.dispatch();
		}
		
		private function executeSequentially():void
		{
			_stack.shift().execute().addOnce(next);
		}
		
	}
}

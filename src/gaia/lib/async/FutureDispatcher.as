package gaia.lib.async
{
	import gaia.lib.async.helper.SingularListeners;
	
	public class FutureDispatcher implements Future, Dispatcher
	{
		
		private var _listeners:SingularListeners;
		private var _hasDispatched:Boolean;
		private var _arguments:Array;
		
		public function FutureDispatcher()
		{
			_listeners = new SingularListeners();
			_hasDispatched = false;
		}
		
		final public function get hasDispatched():Boolean
		{
			return _hasDispatched;
		}

		final public function addOnce(listener:Function):void
		{
			if (_hasDispatched)
				listener.apply(this, _arguments);
			else
				_listeners.add(listener);
		}

		final public function dispatch(...arguments):void
		{
			if (_hasDispatched)
				return;
			
			_hasDispatched = true;
			_arguments = arguments;
			_listeners.dispatch(arguments);
		}
		
	}
}

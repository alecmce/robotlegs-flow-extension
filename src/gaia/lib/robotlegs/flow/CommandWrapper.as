package gaia.lib.robotlegs.flow
{
	import gaia.lib.async.Future;

	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;

	import flash.system.ApplicationDomain;
	
	final internal class CommandWrapper
	{
		private var _injector:IInjector;
		private var _reflector:IReflector;
		private var _domain:ApplicationDomain;
		private var _stack:CommandFlow;
		
		public var command:Class;
		public var args:Array;
		
		private var _classes:Vector.<Class>;
		
		public function CommandWrapper(injector:IInjector, reflector:IReflector)
		{
			_injector = injector;
			_reflector = reflector;
			_domain = _injector.applicationDomain;
			_stack = new CommandFlow(_injector, _reflector);
		}
		
		public function execute():Future
		{
			if (args)
				mapValues(args);

			_injector.mapValue(CommandFlow, _stack);
			
			var instance:* = _injector.instantiate(command);
			if (instance.execute)
				instance.execute();
			else
				throw new Error(_reflector.getClass(instance) + " has no execute() method (is not a duck-typed to Command)");
			
			unmapValues();
			
			return _stack.completed;
		}
		
		private function mapValues(args:Array):void
		{
			var i:int = args.length;
			
			_classes = new Vector.<Class>(i, true);
			
			while (i--)
			{
				var arg:* = args[i];
				if (arg == null)
					continue;
				
				var clazz:Class = _reflector.getClass(arg, _domain);
				
				_injector.mapValue(clazz, arg);
				_classes[i] = clazz;
			}
		}
		
		private function unmapValues():void
		{
			var i:int = _classes.length;
			while (i--)
				_injector.unmap(_classes[i]);
			
			_injector.unmap(CommandFlow);
		}

	}
}

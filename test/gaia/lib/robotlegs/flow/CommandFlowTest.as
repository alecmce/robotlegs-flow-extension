package gaia.lib.robotlegs.flow
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.framework.Async;

	import gaia.lib.robotlegs.flow.eg.AsyncCommand;
	import gaia.lib.robotlegs.flow.eg.LoggedCommand;
	import gaia.lib.robotlegs.flow.eg.NestedLoggedCommand;
	import gaia.lib.robotlegs.flow.eg.TestLog;
	import gaia.lib.robotlegs.flow.eg.TrivialCommand;

	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.base.CommandMap;
	import org.robotlegs.core.IInjector;

	import flash.events.EventDispatcher;



	
	public class CommandFlowTest
	{
		[Inject]
		public var async:Async;
		
		private var eventDispatcher:EventDispatcher;
		private var injector:SwiftSuspendersInjector;
		private var reflector:SwiftSuspendersReflector;
		private var commandMap:CommandMap;
		
		private var flow:CommandFlow;
		private var log:TestLog;
		
		[Before]
		public function before():void
		{
			eventDispatcher = new EventDispatcher();
			injector = new SwiftSuspendersInjector();
			injector.mapValue(IInjector, injector);
			reflector = new SwiftSuspendersReflector();
			commandMap = new CommandMap(eventDispatcher, injector, reflector);
			
			flow = new CommandFlow(injector, reflector);
			injector.mapValue(CommandFlow, flow);
			
			log = new TestLog();
		}
		
		[After]
		public function after():void
		{
			eventDispatcher = null;
			injector = null;
			reflector = null;
			commandMap = null;
		}
		
		[Test]
		public function a_flowed_command_is_executed():void
		{
			flow.completed.addOnce(async.add(after_a_flowed_command_is_executed, 100));
			flow.push(TrivialCommand);
			flow.next();
		}
		private function after_a_flowed_command_is_executed():void {}
		
		[Test]
		public function a_flowed_command_gets_its_parameters():void
		{
			flow.completed.addOnce(async.add(after_a_flowed_command_gets_its_parameters, 1000));
			flow.push(LoggedCommand, log, "a");
			flow.next();
		}
		private function after_a_flowed_command_gets_its_parameters():void
		{
			assertEquals("a", log.toString());
		}
		
		[Test]
		public function flowed_commands_are_executed_in_order():void
		{
			flow.completed.addOnce(async.add(after_flowed_commands_are_executed_in_order, 100));
			flow.push(LoggedCommand, log, "a");
			flow.push(LoggedCommand, log, "b");
			flow.push(LoggedCommand, log, "c");
			flow.next();
		}
		private function after_flowed_commands_are_executed_in_order():void
		{
			assertEquals("abc", log.toString());
		}
		
		[Test]
		public function the_flow_passed_into_commands_is_a_nested_flow():void
		{
			flow.completed.addOnce(async.add(after_the_flow_passed_into_commands_is_a_nested_flow, 100));
			flow.push(LoggedCommand, log, "a");
			flow.push(NestedLoggedCommand, log, ["b","c"]);
			flow.push(LoggedCommand, log, "d");
			flow.next();
		}
		private function after_the_flow_passed_into_commands_is_a_nested_flow():void
		{
			assertEquals("abcd", log.toString());
		}
		
		[Test]
		public function async_commands_delay_execution_in_sequential_flow():void
		{
			flow.completed.addOnce(async.add(after_async_commands_delay_execution_in_sequential_flow, 250));
			flow.push(AsyncCommand, log, "a");
			flow.push(AsyncCommand, log, "b");
			flow.next();
		}
		private function after_async_commands_delay_execution_in_sequential_flow():void
		{
			assertEquals("aAbB", log.toString());
		}
		
		[Test]
		public function commands_can_be_run_in_parallel_too():void
		{
			flow.runInParallel = true;
			flow.completed.addOnce(async.add(after_commands_can_be_run_in_parallel_too, 250));
			flow.push(AsyncCommand, log, "a");
			flow.push(LoggedCommand, log, "b");
			flow.push(LoggedCommand, log, "c");
			flow.push(LoggedCommand, log, "d");
			flow.next();
		}
		private function after_commands_can_be_run_in_parallel_too():void
		{
			assertEquals("abcdA", log.toString());
		}
		
		[Test]
		public function adding_a_command_after_next_has_been_called_fails():void
		{
			flow.runInParallel = true;
			flow.push(AsyncCommand, log, "a");
			flow.next();
			
			assertFalse(flow.push(LoggedCommand, log, "b"));
		}
		
	}
}

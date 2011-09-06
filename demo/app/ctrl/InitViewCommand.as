package app.ctrl
{
	import app.view.Console;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import gaia.lib.robotlegs.flow.CommandFlow;



	public class InitViewCommand
	{
		private var _stack:CommandFlow;
		private var _container:DisplayObjectContainer;

		public function InitViewCommand(stack:CommandFlow, container:DisplayObjectContainer)
		{
			_stack = stack;
			_container = container;
		}
		
		public function execute():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.load(new URLRequest("console.swf"));
		}

		private function onLoaderComplete(event:Event):void
		{
			var info:LoaderInfo = event.currentTarget as LoaderInfo;
			var loader:Loader = info.loader;
			
			var console:Console = new Console(loader.content as MovieClip);
			_container.addChild(console);
			
			_stack.next();
		}
		
	}
}

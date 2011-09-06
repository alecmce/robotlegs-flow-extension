package app.ctrl
{
	import app.model.TextModel;
	import app.service.TextService;
	import gaia.lib.robotlegs.flow.CommandFlow;


	public class InitModelCommand
	{
		private var _stack:CommandFlow;
		
		private var _model:TextModel;
		private var _service:TextService;

		public function InitModelCommand(stack:CommandFlow, model:TextModel, service:TextService)
		{
			_stack = stack;
			_service = service;
			_model = model;
		}
				
		public function execute():void
		{
			_service.getText().addOnce(onResponse);
		}

		private function onResponse(lines:Vector.<String>):void
		{
			_model.text = lines;
			_stack.next();
		}
		
	}
}

package app.view
{
	import app.model.TextModel;

	import org.robotlegs.mvcs.Mediator;


	public class ConsoleMediator extends Mediator
	{
		[Inject]
		public var model:TextModel;
		
		[Inject]
		public var view:Console;
		
		override public function onRegister():void
		{
			view.text = model.text;
			model.changed.add(onModelChanged);
		}
		
		override public function onRemove():void
		{
			model.changed.remove(onModelChanged);
		}

		private function onModelChanged():void
		{
			view.text = model.text;
		}
		
	}
}

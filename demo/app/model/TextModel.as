package app.model
{
	import org.osflash.signals.Signal;
	
	public class TextModel
	{
		private var _text:Vector.<String>;
		private var _changed:Signal;
		
		public function get text():Vector.<String>
		{
			return _text;
		}
		
		public function set text(value:Vector.<String>):void
		{
			if (_text == value)
				return;
			
			_text = value;
			
			if (_changed)
				_changed.dispatch();
		}
		
		public function get changed():Signal
		{
			return _changed ||= new Signal();
		}
		
	}
}

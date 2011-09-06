package app.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	public class Console extends Sprite
	{
		private var _ui:MovieClip;
		private var _text:TextField;
		
		public function Console(ui:MovieClip)
		{
			addChild(_ui = ui);
			_text = _ui.console;
		}
		
		public function get text():Vector.<String>
		{
			return Vector.<String>(_text.text.split("\n"));
		}
		
		public function set text(lines:Vector.<String>):void
		{
			_text.text = lines.join("\n");
		}
		
	}
}

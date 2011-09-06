package gaia.lib.robotlegs.flow.eg
{
	public class TestLog
	{
		private var _ids:Array;
		
		public function TestLog()
		{
			_ids = [];
		}

		public function append(id:String):void
		{
			_ids.push(id);
		}
		
		public function toString():String
		{
			return _ids.join("");
		}
		
	}
}

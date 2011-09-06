package
{
	import flash.display.Sprite;

	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="510", height="270")]
	public class HelloRobotlegs extends Sprite
	{
		private var context:AppContext;
		
		public function HelloRobotlegs()
		{
			context = new AppContext(this);
		}
		
	}
}

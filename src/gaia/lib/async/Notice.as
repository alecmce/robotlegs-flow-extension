package gaia.lib.async
{
	public interface Notice
	{
		
		function add(listener:Function):Boolean;
		
		function addOnce(listener:Function):Boolean;
		
		function remove(listener:Function):Boolean;
		
	}
}

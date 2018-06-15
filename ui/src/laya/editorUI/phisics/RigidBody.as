package laya.editorUI.phisics 
{
	import laya.editorUI.Script;
	
	/**
	 * ...
	 * @author ww
	 */
	public class RigidBody extends Script 
	{
		
		public function RigidBody() 
		{
			super();
			this.pic.visible = false;
		}
		
		override public function get mask():Sprite 
		{
			return null;
		}
		
		override public function set mask(value:Sprite):void 
		{
			
		}
	}

}
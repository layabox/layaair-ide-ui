package laya.editorUI 
{
	import laya.display.EffectAnimation;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ww
	 */
	public class EffectAnimationPlayer extends EffectAnimation
	{
		private var img:Image;
		public function EffectAnimationPlayer() 
		{
			visible = true;
			img = new Image();
			
			addChild(img);
			autoSize = true;
		}
		public function set skin(path:String):void {
			img.skin = path;
		}
	}

}
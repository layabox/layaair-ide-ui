package laya.editorUI {
	import laya.media.SoundNode;
	import laya.media.SoundNode;
	import laya.ui.Image;
	/**
	 * 声音播放器
	 */
	public class SoundPlayer extends SoundNode {
		
		private var img:Image;
		
		public function SoundPlayer() {
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
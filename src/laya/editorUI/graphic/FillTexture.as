package laya.editorUI.graphic {
	import laya.editorUI.Loader;
	import laya.editorUI.Loader;
	import laya.maths.Rectangle;
	import laya.resource.Texture;
	/**
	 * 填充位图
	 */
	public class FillTexture extends DrawTexture {
		
		private var _repeat:String;
		
		public function FillTexture() {
			super();
			autoSize = false;
		}
		
		override public function drawSelf():void {
			this.graphics.clear();
			var tex:Texture;
			tex = Loader.getRes(skin);
			if (tex) {
				this.graphics.fillTexture(tex, 0, 0, width, height, repeat);
				var rec:Rectangle;
				rec = this.graphics.getBounds();
				size(rec.width, rec.height);
			}		
		}
		
		public function set repeat(v:String):void {
			_repeat = v;
			drawSelf();
		}
		
		public function get repeat():String {
			return _repeat;
		}
	}

}
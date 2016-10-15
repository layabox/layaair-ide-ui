package laya.editorUI.graphic {
	import laya.editorUI.Loader;
	import laya.editorUI.Loader;
	import laya.maths.Rectangle;
	import laya.resource.Texture;
	/**
	 * 绘制位图
	 */
	public class DrawTexture extends GraphicBase {
		private var _skin:String;
		
		override public function drawSelf():void {
			this.graphics.clear();
			var tex:Texture;
			tex = Loader.getRes(skin);
			if (tex) {
				this.graphics.drawTexture(tex, 0, 0, _width, _height);
				var rec:Rectangle;
				rec = this.graphics.getBounds();
				
			}		
		}
		
		override public function get width():Number {
			if (_width > 0) return _width;
			var rec:Rectangle;
			rec = graphics.getBounds();
			if (rec.width > 0) return rec.width;
			return 100;
		}
		
		override public function set width(value:Number):void {
			if (_width != value) {
				Laya.timer.once(10, this, drawSelf);
			}
			super.width = value;
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				Laya.timer.once(10, this, drawSelf);
			}
			super.height = value;
		}
		
		override public function get height():Number {
			if (_height > 0) return _height;
			var rec:Rectangle;
			rec = graphics.getBounds();
			if (rec.height > 0) return rec.height;
			return 100;
		}
		
		public function set skin(v:String):void {
			_skin = v;
			drawSelf();
		}
		
		public function get skin():String {
			return _skin;
		}
	
	}

}
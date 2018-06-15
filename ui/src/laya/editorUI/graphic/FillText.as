package laya.editorUI.graphic {
	import laya.maths.Rectangle;
	
	/**
	 * 绘制文本
	 */
	public class FillText extends GraphicBase {
		public var text:String;
		public var font:String;
		public var color:String;
		public var textAlign:String;
		private var _mMBounds:Rectangle;
		
		public function FillText() {
			super();
			this.size(100, 100);
		}
		
		override public function drawSelf():void {
			this.graphics.clear();
			this.graphics.fillText(text, 0, 0, font, color, textAlign);
		}
		
		override public function _getBoundPointsM(ifRotate:Boolean = false):Array {
			if (this._width > 0 && this._height > 0 && !autoSize) {
				if (!_mMBounds) {
					_mMBounds = new Rectangle();
				}
				_mMBounds.setTo(0, 0, width, height);
				return _mMBounds._getBoundPoints();
			}
			return super._getBoundPointsM(ifRotate);
		}
	}

}
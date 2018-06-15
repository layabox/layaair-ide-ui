package laya.editorUI.graphic {
	import laya.display.Sprite;
	
	/**
	 * 绘制矩形
	 */
	public class DrawRect extends GraphicBase implements IGraphic {		
		
		override public function drawSelf():void {
			this.graphics.clear();
			this.graphics.drawRect(0, 0, width, height, fillColor, lineColor, lineWidth);
			this.size(width, height);
		}
		
		override public function set width(value:Number):void {
			if (width != value) {
				Laya.timer.once(10, this, drawSelf);
			}
			super.width = value;
		}
		
		override public function set height(value:Number):void {
			if (height != value) {
				Laya.timer.once(10, this, drawSelf);
			}
			super.height = value;
		}
	}

}
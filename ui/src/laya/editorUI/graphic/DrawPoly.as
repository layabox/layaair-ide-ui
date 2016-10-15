package laya.editorUI.graphic {
	
	/**
	 * 绘制多边形
	 */
	public class DrawPoly extends DrawLines {
		
		public function DrawPoly() {
			super();		
		}
		
		override protected function drawWork():void {
			this.graphics.drawPoly(0, 0, pointList, fillColor, lineColor, lineWidth);
		}
	}

}
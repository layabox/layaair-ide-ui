package laya.editorUI.graphic {
	
	/**
	 * 画曲线
	 */
	public class DrawCurves extends DrawLines {
		
		public function DrawCurves() {
			super();
		
		}
		
		override protected function drawWork():void {
			this.graphics.drawCurves(0, 0, pointList, lineColor, lineWidth);
		}
	}

}
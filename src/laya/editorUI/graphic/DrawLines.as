package laya.editorUI.graphic {
	import laya.display.Sprite;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ide.managers.IDEAPIS;
	import laya.maths.Rectangle;
	import laya.utils.Handler;
	/**
	 * 绘制线段
	 */
	public class DrawLines extends GraphicBase {
		public var points:String;
		public var pointList:Array;
		public var isSelectState:Boolean = false;
		
		private var pointSpList:Array = [];
		private var _start:Handler;
		private var _end:Handler;
		private var _draging:Handler;
		
		public function DrawLines() {
			super();
			this.on(Event.DISPLAY, this, _displayChange);
			this.on(Event.UNDISPLAY, this, _displayChange);
			off(Event.ADDED, this, drawSelf);
			_start = new Handler(this, _endPointStartDrag);
			_end = new Handler(this, _endPointDragEnd);
			_draging = new Handler(this, _endPointDraging);
		}
		
		private function _displayChange():void {
			this.on(Event.MOUSE_DOWN, this, _mMouseDown);
			this.off(Event.MOUSE_DOWN, this, _mMouseDown);
			drawSelf();
		}
		
		private function _mMouseDown():void {
		
		}
		
		public function getPointsByStr(str:String):Array {
			var pointArr:Array;
			pointArr = str.split(",");
			var i:int, len:int;
			len = pointArr.length;
			for (i = 0; i < len; i++) {
				pointArr[i] = parseFloat(pointArr[i]);
				if (pointArr[i].toString() == "NaN") {
					pointArr[i] = 0;
				}
			}
			if (pointArr.length % 2 == 1) {
				pointArr.push(0);
			}
			return pointArr;
		}
		
		public function getPointsArrBySpList(spList:Array):Array {
			var i:int, len:int;
			len = spList.length;
			var rst:Array;
			rst = [];
			for (i = 0; i < len; i++) {
				rst.push(spList[i].x, spList[i].y);
			}
			return rst;
		}
		
		override public function drawSelf():void {
			removePoints();
			this.graphics.clear();
			if (!points) return;
			pointList = getPointsByStr(points);
			drawWork();
			var rec:Rectangle;
			rec = this.graphics.getBounds();
			this.size(rec.right, rec.bottom);
			if (isSelectState && this.displayedInStage) {
				var i:int, len:int;
				var tsp:ControlPoint;
				len = pointList.length;
				for (i = 0; i < len; i += 2) {
					tsp = ControlPoint.getControlPoint(_start, _end, _draging);
					tsp.pos(pointList[i], pointList[i + 1]);
					myAddChild(tsp);
					pointSpList.push(tsp);
				}
			}
		}
		
		protected function drawWork():void {
			this.graphics.drawLines(0, 0, pointList, lineColor, lineWidth);
		}
		
		private function _endPointStartDrag(sp:Sprite):void {
			sp.startDrag();
		}
		
		private function _endPointDraging(sp:Sprite):void {
			var i:int, len:int;
			len = pointSpList.length;
			var tSp:Sprite;
			for (i = 0; i < len; i++) {
				tSp = pointSpList[i];
				pointList[i * 2] = tSp.x;
				pointList[i * 2 + 1] = tSp.y;
			}
			this.graphics.clear();
			drawWork();
		}
		
		private function _endPointDragEnd():void {
			updateTos();
			var data:Object;
			data = this["comXml"];
			if (data && data.props) {
				data.props.points = points;
				IDEAPIS.nodeChange(data, ["points"], false);
			}
		
		}
		
		private function updateTos():void {
			points = getPointsArrBySpList(pointSpList).join(",");
			drawSelf();
		}
		
		private function removePoints():void {
			var i:int, len:int;
			len = pointSpList.length;
			var tsp:ControlPoint;
			for (i = 0; i < len; i++) {
				tsp = pointSpList[i];
				tsp.removeSelf();
				tsp.recover();
			}
			pointSpList.length = 0;
		}
		
		public function freshIDESelect():void {
		}
		
		public function setIDESelectState(isSelect:Boolean):void {
			isSelectState = isSelect;
			if (isSelect) {
				
			} else {
				
			}
			drawSelf();
		}
	}

}
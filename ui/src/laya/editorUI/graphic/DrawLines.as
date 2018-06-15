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
		public var SplitSign:String = ",";
		private var pointSpList:Array = [];
		private var _start:Handler;
		private var _end:Handler;
		private var _draging:Handler;
		private var _doubleClick:Handler;
		
		public function DrawLines() {
			super();
			this.on(Event.DISPLAY, this, _displayChange);
			this.on(Event.UNDISPLAY, this, _displayChange);
			off(Event.ADDED, this, drawSelf);
			_start = new Handler(this, _endPointStartDrag);
			_end = new Handler(this, _endPointDragEnd);
			_draging = new Handler(this, _endPointDraging);
			_doubleClick = new Handler(this, onDoubleClick);
			this.mouseThrough = true;
		}
		
		private function onDoubleClick(sp:Sprite):void
		{
			if (!isSelectState) return;
			var i:int, len:int;
			len = pointSpList.length;
			for (i = 0; i < len; i++)
			{
				if (pointSpList[i] == sp)
				{
					
					(sp as ControlPoint).recover();
					pointSpList.splice(i, 1);
					_updateAndChangeValue();
					return;
				}
			}
		}
		private function _displayChange():void {
			
			this.off(Event.DOUBLE_CLICK, this, _mMouseDown);
			this.on(Event.DOUBLE_CLICK, this, _mMouseDown);
			drawSelf();
		}
		public function getDistance(sp0:Sprite,sp1:Sprite):Number
		{
			var dx:Number = sp1.x - sp0.x;
			var dy:Number = sp1.y - sp0.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		private function _mMouseDown(e:Event):void {
		
			if (!isSelectState) return;
			
			//if(!e.
			//trace("lines mouseDown");
			if (e.target is ControlPoint) return ;
			var nCt:ControlPoint;
			nCt = _getAControlPoint();
			nCt.pos(this.mouseX, this.mouseY);
			if (getDistance(pointSpList[0], nCt) < getDistance(pointSpList[pointSpList.length - 1], nCt))
			{
				pointSpList.unshift(nCt);
			}else
			{
				pointSpList.push(nCt);
			}
			
			
			_updateAndChangeValue();
		}
		
		public function getPointsByStr(str:String):Array {
			var pointArr:Array;
			pointArr = str.split(SplitSign);
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
					tsp = _getAControlPoint();
					tsp.pos(pointList[i], pointList[i + 1]);
					myAddChild(tsp);
					pointSpList.push(tsp);
				}
			}
		}
		
		private function _getAControlPoint():ControlPoint
		{
			return ControlPoint.getControlPoint(_start, _end, _draging,_doubleClick);
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
			
		
			_updateAndChangeValue();
		}
		protected function _updateAndChangeValue():void
		{
			updateTos();
			var data:Object;
			data = this["comXml"];
			if (data && data.props) {
				data.props.points = points;
				IDEAPIS.nodeChange(data, ["points"], false);
			}
		}
		private function updateTos():void {
			points = getPointsArrBySpList(pointSpList).join(SplitSign);
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
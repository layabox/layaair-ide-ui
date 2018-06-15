package laya.editorUI {
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ide.managers.IDEAPIS;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	
	/**
	 * 地图格子编辑组件
	 */
	public class GridEditor extends Sprite {
		public var disablePivot:Boolean = true;
		public var enableDragSet:Boolean = true;
		public var isCleanMode:Boolean = false;
		public static const DataSign:String = "data";
		
		private static var tipText:Text;
		
		public function GridEditor() {
			_selectLineLayer = new Sprite();
			this.addChild(_selectLineLayer);
			this.mouseEnabled = true;
			on(Event.ADDED, this, drawSelf);
			//this.on(Event.CLICK, this, click);
			this.on(Event.MOUSE_DOWN, this, mouseDownH);
			if (!tipText) {
				tipText = new Text();
				tipText.color = "#ffffff";
				tipText.align = "center";
				
			}		
		}
		
		private var _showPos:Boolean = false;
		
		public function set showPos(v:Boolean):void {
			_showPos = v;
			updateTipState();
		}
		
		private function updateTipState():void {
			this.off(Event.MOUSE_MOVE, this, myMouseMove);
			this.off(Event.MOUSE_OUT, this, myMouseOut);
			this.off(Event.MOUSE_OVER, this, myMouseOver);
			if (_showPos && isSelectState) {
				this.on(Event.MOUSE_MOVE, this, myMouseMove);
				this.on(Event.MOUSE_OUT, this, myMouseOut);
				this.on(Event.MOUSE_OVER, this, myMouseOver);
			} else {
				
			}
		}
		
		private function myMouseOver():void {
			addChild(tipText);
		}
		
		private function myMouseOut():void {
			tipText.removeSelf();
		}
		
		private function myMouseMove():void {
			if (tipText && tipText.parent) {
				var pos:Point;
				pos = this.getMousePoint();
				tipText.pos(pos.x, pos.y + 20);
				tipText.text = "(" + getGridIJ(pos.x, pos.y).toString() + ")";
			} else {
				if (isSelectState && tipText) {
					addChild(tipText);
				}
			}
		}
		
		public function get disableDragMove():Boolean {
			return enableDragSet;
		}
		
		public function drawSelf():void {
			renderMe();
		}
		public var gridWidth:int = 20;
		public var gridHeight:int = 20;
		public var countX:int = 20;
		public var countY:int = 20;
		public var value:int = 1;
		public var lineColor:String = "#ff0000";
		public var textColor:String = "#00ff00";
		public var lineWidth:int = 1;
		public var data:Array = [];
		private static var _wordSpace = new Point(0, 0);
		
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
			if (pointArr.length % 3 != 0) {
				len = pointArr.length % 3;
				for (i = 0; i < len; i++)
					pointArr.push(0);
			}
			return pointArr;
		}
		
		public function renderMe():void {
			var dataO:Object;
			dataO = this["comXml"];
			if (dataO && dataO.props) {
				if (dataO.props[DataSign]) {
					data = getPointsByStr(dataO.props[DataSign]);
				}
			}
			this.graphics.clear();
			size(gridWidth * countX, gridHeight * countY);
			var i:int, j:int;
			var tX:Number;
			var tY:Number;
			for (i = 0; i <= countY; i++) {
				tY = i * gridHeight;
				this.graphics.drawLine(0, tY, width, tY, lineColor, lineWidth);
			}
			for (i = 0; i <= countX; i++) {
				tX = i * gridWidth;
				this.graphics.drawLine(tX, 0, tX, height, lineColor, lineWidth);
			}
			if (!data) data = [];
			
			var p:Point;
			var len:int;
			len = data.length;
			var hasChange:Boolean = false;
			//for (i = 0; i < len; i += 3)
			//{
			//p = getIJPos(dataList[i], dataList[i + 1]);
			//this.graphics.fillText(dataList[i + 2] + "", p.x, p.y - 5, null, textColor, "center");
			//}
			//return;
			for (i = len - 3; i >= 0; i -= 3) {
				//p = getIJPos(dataList[i], dataList[i + 1]);
				//this.graphics.fillText(dataList[i + 2] + "", p.x, p.y - 5, null, textColor, "center");
				//continue;
				if (data[i] < countX && data[i + 1] < countY) {
					p = getIJPos(data[i], data[i + 1]);
					this.graphics.fillText(data[i + 2] + "", p.x, p.y - 5, null, textColor, "center");
				} else {
					data.splice(i, 3);
					hasChange = true;
				}
				
			}
			if (hasChange)
				noticeChange();
		}
		
		private static var _ijPosPoint:Point = new Point();
		
		public function getIJPos(i:int, j:int):Point {
			var p:Point;
			p = _ijPosPoint;
			p.x = i * gridWidth + 0.5 * gridWidth;
			p.y = j * gridHeight + 0.5 * gridHeight;
			return p;
		}
		
		private static var _preMousePos:Point = new Point();
		private static var _preMyPos:Point = new Point();
		
		private function mouseDownH():void {
			if (!isSelectState) return;
			_preMousePos.setTo(Laya.stage.mouseX, Laya.stage.mouseY);
			_preMyPos.setTo(this.mouseX, this.mouseY);
			_isDragSelect = false;
			_selectLineLayer.graphics.clear();
			Laya.stage.on(Event.MOUSE_MOVE, this, onStageMouseMove);
			Laya.stage.on(Event.MOUSE_UP, this, onStageMouseUp);
		}
		private var _isDragSelect = false;
		private var _selectLineLayer:Sprite;
		
		/**移动组件*/
		protected function onStageMouseMove(e:Event):void {
			if (!isSelectState) return;
			if (!enableDragSet) return;
			if (_isDragSelect) {
				_selectLineLayer.graphics.clear();
				_selectLineLayer.graphics.drawRect(_preMyPos.x, _preMyPos.y, this.mouseX - _preMyPos.x, this.mouseY - _preMyPos.y, null, "#ff0000");
				
			} else {
				if (Math.abs(_preMousePos.x - Laya.stage.mouseX) + Math.abs(_preMousePos.y - Laya.stage.mouseY) > 5) {
					_isDragSelect = true;
				}
			}
		}
		
		protected function onStageMouseUp(e:Event):void {
			//trace("onStageMouseUp");
			Laya.stage.off(Event.MOUSE_MOVE, this, onStageMouseMove);
			Laya.stage.off(Event.MOUSE_UP, this, onStageMouseUp);
			if (_isDragSelect) {
				
				_isDragSelect = false;
				multiSelect();
				_selectLineLayer.graphics.clear();
			} else {
				click();
			}
		}
		
		private function multiSelect():void {
			var i:int, iLen:int;
			var j:int, jLen:int;
			var tGrid:Sprite;
			var range:Array;
			var rec:Rectangle;
			rec = _selectLineLayer.getBounds();
			//trace("rec:",rec.toString());
			range = getWrapGrid(rec.x, rec.y, rec.width, rec.height);
			iLen = range[3] + 1;
			jLen = range[2] + 1;
			range[0] = range[0] > 0 ? range[0] : 0;
			range[1] = range[1] > 0 ? range[1] : 0;
			iLen = iLen < countY ? iLen : countY;
			jLen = jLen < countX ? jLen : countX;
			var index:int;
			//removeChildren();
			var hasChange:Boolean = false;
			//trace("range:",range.toString());
			for (i = range[1]; i < iLen; i++) {
				for (j = range[0]; j < jLen; j++) {
					changeGridValue(j, i, value, true, isCleanMode);
					hasChange = true;
				}
			}
			if (hasChange)
				noticeChange();
		}
		
		public function click():void {
			if (!isSelectState) return;
			if (Math.abs(_preMousePos.x - Laya.stage.mouseX) + Math.abs(_preMousePos.y - Laya.stage.mouseY) > 5) return;
			var p:Point;
			p = getGridIJ(this.mouseX, this.mouseY);
			trace(p.toString());
			changeGridValue(p.x, p.y, value);
			noticeChange();
		}
		
		private function noticeChange():void {
			var dataO:Object;
			dataO = this["comXml"];
			if (dataO && dataO.props) {
				dataO.props[DataSign] = data.join(",");
				IDEAPIS.nodeChange(dataO, [DataSign], false);
			}
			renderMe();
		}
		
		private function changeGridValue(i:int, j:int, value:int, force:Boolean = false, isClean:Boolean = false):void {
			var ii:int;
			var len:int;
			len = data.length;
			
			for (ii = 0; ii < len; ii += 3) {
				if (data[ii] == i && data[ii + 1] == j) {
					if (!force) {
						if (data[ii + 2] == value) {
							data.splice(ii, 3);
							return;
						}
					} else {
						if (isClean) {
							data.splice(ii, 3);
							return;
						}
					}
					data[ii + 2] = value;
					return;
				}
			}
			if (isClean) {
				return;
			}
			data.push(i, j, value);
		}
		
		public function getWrapGrid(x:Number, y:Number, width:Number, height:Number):Array {
			var rst:Array;
			rst = [];
			rst.length = 4;
			var tP:Point;
			tP = getGridIJ(x, y);
			rst[0] = tP.x;
			rst[1] = tP.y;
			tP = getGridIJ(x + width, y + height);
			rst[2] = tP.x;
			rst[3] = tP.y;
			
			return rst;
		}
		private static const _gridIJ:Point = new Point();
		
		public function getGridIJ(x:Number, y:Number):Point {
			x -= _wordSpace.x;
			y -= _wordSpace.y;
			var i:int;
			i = Math.floor(x / gridWidth);
			var j:int;
			j = Math.floor(y / gridHeight);
			if (i < 0) i = 0;
			if (j < 0) j = 0;
			
			_gridIJ.setTo(i, j);
			return _gridIJ;
		}
		
		public function freshIDESelect():void {
			//drawSelf();
		}
		public var isSelectState:Boolean = false;
		
		public function setIDESelectState(isSelect:Boolean):void {
			isSelectState = isSelect;
			if (isSelect) {
				
			} else {
				
			}
			drawSelf();
			updateTipState();
		}
	}

}
package laya.editorUI.graphic {
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ide.managers.IDEAPIS;
	import laya.maths.Rectangle;
	
	/**
	 * 画线
	 */
	public class DrawLine extends GraphicBase {
		public var toX:Number = 0;
		public var toY:Number = 0;
		private var _endPoint:Sprite;
		
		public function DrawLine() {
			super();
			_endPoint = new Sprite();
			_endPoint.graphics.drawCircle(5, 5, 5, "#ffffff", "#ff0000", 1);
			_endPoint.size(10, 10);
			_endPoint.pivot(5, 5);
			_endPoint.on(Event.MOUSE_DOWN, this, _endPointStargDrag);
			_endPoint.on(Event.DRAG_END, this, _endPointDragEnd);
			_endPoint.on(Event.DRAG_MOVE, this, _endPointDraging);
		}
		
		private function _endPointStargDrag(e:Event):void {
			e.stopPropagation();
			_endPoint.startDrag();
		}
		
		private function _endPointDraging():void {
			updateTos();
		}
		
		private function _endPointDragEnd():void {
			updateTos();
			var data:Object;
			data = this["comXml"];
			if (data && data.props) {
				data.props.toX = toX;
				data.props.toY = toY;
				IDEAPIS.nodeChange(data, ["toX", "toY"], false);
			}
		}
		
		private function updateTos():void {
			toX = _endPoint.x;
			toY = _endPoint.y;
			drawSelf();
		}
		
		override public function drawSelf():void {
			this.graphics.clear();
			this.graphics.drawLine(0, 0, toX, toY, lineColor, lineWidth);
			var rec:Rectangle;
			var w:Number;
			var h:Number;
			w = Math.abs(toX) > 0 ? Math.abs(toX) : 2;
			h = Math.abs(toY) > 0 ? Math.abs(toY) : 2;
			
			this.size(w, h);
			_endPoint.pos(toX, toY);
		}
		
		public function freshIDESelect():void {
			drawSelf();
		}
		
		public function setIDESelectState(isSelect:Boolean):void {
			if (isSelect) {
				this.myAddChild(_endPoint);
			} else {
				_endPoint.removeSelf();
			}
		}
	}
}
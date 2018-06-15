package laya.editorUI.graphic {
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ide.managers.IDEAPIS;
	
	/**
	 * 画圆
	 */
	public class DrawCircle extends GraphicBase {
		public var radius:Number;
		private var _endPoint:Sprite;
		
		public function DrawCircle() {
			super();
			_initDragPoints();
		}
		
		private function _initDragPoints():void {
			_endPoint = new Sprite();
			_endPoint.graphics.drawCircle(5, 5, 5, "#ffffff", "#ff0000", 1);
			_endPoint.size(10, 10);
			_endPoint.pivot(5, 5);
			_endPoint.on(Event.MOUSE_DOWN, this, _endPointStargDrag);
			_endPoint.on(Event.DRAG_END, this, _endPointDragEnd);
			_endPoint.on(Event.DRAG_MOVE, this, _endPointDraging);
		}
		
		override public function drawSelf():void {
			this.graphics.clear();
			this.graphics.drawCircle(0, 0, radius, fillColor, lineColor, lineWidth);
			this.size(radius, radius);
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
				data.props.radius = Math.round(radius);
				IDEAPIS.nodeChange(data, ["radius"], false);
			}
		
		}
		
		private function updateTos():void {
			radius = Math.sqrt(_endPoint.x * _endPoint.x + _endPoint.y * _endPoint.y);
			drawSelf();
		}
		
		public function freshIDESelect():void {
			drawSelf();
		}
		
		public function setIDESelectState(isSelect:Boolean):void {
			if (isSelect) {
				this.myAddChild(_endPoint);
				_endPoint.pos(radius, 0);
			} else {
				_endPoint.removeSelf();
			}
		}
	}

}
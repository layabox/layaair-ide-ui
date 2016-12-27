package laya.editorUI.graphic {
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Handler;
	import laya.utils.Pool;
	
	/**
	 * 控制点
	 */
	public class ControlPoint extends Sprite {
		
		public var startHandler:Handler;
		public var endHandler:Handler;
		public var dragingHandler:Handler;
		public var doubleHandler:Handler;
		
		public function ControlPoint() {
			this.graphics.drawCircle(5, 5, 5, "#ffffff", "#ff0000", 1);
			this.size(10, 10);
			this.pivot(5, 5);
			this.on(Event.MOUSE_DOWN, this, _endPointStartDrag, [this]);
			this.on(Event.DRAG_END, this, _endPointDragEnd, [this]);
			this.on(Event.DRAG_MOVE, this, _endPointDraging, [this]);
			this.on(Event.DOUBLE_CLICK, this, _doubleClick, [this]);
		}
		
		private function _doubleClick(sp:Sprite):void {
			if (doubleHandler)
			{
				doubleHandler.runWith(sp);
			}
		}
		private function _endPointStartDrag(sp:Sprite, e:Event):void {
			e.stopPropagation();
			if (startHandler) {
				startHandler.runWith(sp);
			}
		}
		
		private function _endPointDraging(sp:Sprite):void {
			if (dragingHandler) {
				dragingHandler.runWith(sp);
			}
		}
		
		private function _endPointDragEnd(sp:Sprite):void {
			if (endHandler) {
				endHandler.runWith(sp);
			}
		}
		
		public function recover():void {
			removeSelf();
			startHandler = null;
			dragingHandler = null;
			endHandler = null;
			doubleHandler=null
			Pool.recover("ControlPoint", this);
		}
		
		public static function getControlPoint(start:Handler, end:Handler, draging:Handler,doubleHandler:Handler=null):ControlPoint {
			var rst:ControlPoint;
			rst = Pool.getItemByClass("ControlPoint", ControlPoint);
			rst.startHandler = start;
			rst.endHandler = end;
			rst.dragingHandler = draging;
			rst.doubleHandler = doubleHandler;
			return rst;
		}
	}
}
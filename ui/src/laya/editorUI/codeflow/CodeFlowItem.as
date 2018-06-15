package laya.editorUI.codeflow 
{
	import ide.managers.Notice;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ide.event.IDEEvent;
	import laya.ide.managers.IDEAPIS;
	import laya.ui.Component;
	import laya.ui.View;
	/**
	 * ...
	 * @author ww
	 */
	public class CodeFlowItem extends View
	{
		
		public function CodeFlowItem() 
		{
			drawSelf();
			this.on(Event.MOUSE_DOWN, this, onMouseDown);
			this.on(Event.DRAG_END, this, onDragEnd);
		}
		
		protected function onMouseDown(e:Event):void
		{
			this.startDrag();
		}
		
		protected function onDragEnd(e:Event):void
		{
			if (!this.comXml.props) this.comXml.props = { };
			this.comXml.props.x = this.x;
			this.comXml.props.y = this.y;
			Notice.notify(IDEEvent.PROP_CHANGED);
		}
		public function drawSelf():void
		{
			this.graphics.clear();
			this.graphics.drawCircle(0, 0, 100, "#ff0000");
			this.size(100, 100);
		}
		
		private static var _dragPoint:Sprite;
		public function setDragPointEvent(dragPoint:Sprite,params:*):void
		{
			dragPoint.on(Event.MOUSE_DOWN, this, onDragPointMouseDown, [dragPoint]);
			dragPoint.on(Event.DRAG_END, this, onDragPointDragEnd, [dragPoint,params]);
		}
		
		private function onDragPointMouseDown(dragPoint:Sprite):void
		{
			
		}
		
		private function onDragPointDragEnd(dragPoint:Sprite,params:*):void
		{
			
		}
		public function addDragPoints():void
		{
			
		}
		
		public function initByConfig(configO:Object):void
		{
			
		}
	}

}
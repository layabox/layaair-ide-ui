package laya.editorUI.graphic {
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.events.Event;
	
	/**
	 * 矢量图基类
	 */
	public class GraphicBase extends Sprite implements IGraphic {
		public var fillColor:*;
		public var lineColor:*;
		public var lineWidth:Number = 1;
		public var disablePivot:Boolean = true;
		
		public function GraphicBase() {
			this.mouseEnabled = true;
			on(Event.ADDED, this, drawSelf);
		}
		
		public function drawSelf():void {
		
		}
		
		override public function addChild(node:Node):Node {
			return null;
		}
		
		public function myAddChild(node:Node):Node {
			return super.addChild(node);
		}
	}

}
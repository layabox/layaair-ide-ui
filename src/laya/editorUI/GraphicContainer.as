package laya.editorUI {
	import laya.display.Node;
	import laya.display.Node;
	import laya.editorUI.graphic.GraphicBase;
	import laya.events.Event;
	
	/**
	 * Graphics容器
	 */
	public class GraphicContainer extends Box {
		private var pic:Image;
		
		public function GraphicContainer() {
			on(Event.ADDED, this, onAddToParent);
		}
		
		private function onAddToParent():void {
			if (this.parent) {
				if (this.numChildren < 1) {
					if (!pic) {
						pic = new Image();
						pic.skin = "spriteSkin.png";
						pic.size(100, 100);
						//size(100, 100);
						super.addChild(pic);
					}
				}
			}
		}
		
		override public function removeChild(node:Node):Node {
			if (node != pic && numChildren == 1) {
				pic = new Image();
				pic.skin = "spriteSkin.png";
				pic.size(100, 100);
				//size(100, 100);
				super.addChild(pic);
			}
			return super.removeChild(node);
		}
		
		override public function addChild(node:Node):Node {
			
			if (node is Image || node is GraphicBase) {
				if (pic) {
					pic.removeSelf();
				}
				return super.addChild(node);
			}
			return node;
		}
	}

}
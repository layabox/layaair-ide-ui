package laya.editorUI.graphic {
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ide.managers.IDEAPIS;
	
	/**
	 * 矢量图基类
	 */
	public class GraphicBase extends Sprite implements IGraphic {
		public var fillColor:*;
		public var lineColor:*;
		public var lineWidth:Number = 1;
		public var disablePivot:Boolean = true;
		
		public var isSelectState:Boolean;
		
		public function GraphicBase() {
			this.mouseEnabled = true;
			on(Event.ADDED, this, drawSelf);
		}
		
		protected function updateCompKeyValue(key:String, value:*):void {
			var data:Object;
			data = this["comXml"];
			this[key] = value;
			if (data && data.props) {
				
				data.props[key] = value;
				IDEAPIS.nodeChange(data, [key], false);
			}
		}
		
		protected function updateCompKeysValue(keys:Array):void {
			var data:Object;
			data = this["comXml"];
			
			var i:int, len:int;
			var key:String;
			len = keys.length;
			for (i = 0; i < len; i++) {
				key = keys[i];
				if (data && data.props) {
					
					data.props[key] = this[key];
					
				}
			}
			IDEAPIS.nodeChange(data, keys, false);
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
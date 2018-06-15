package laya.editorUI{
	
	/**VBox容器*/
	public class VBox extends LayoutBox {
		public static const NONE:String = "none";
		public static const LEFT:String = "left";
		public static const CENTER:String = "center";
		public static const RIGHT:String = "right";
		
		public function VBox() {
		}
		
		override public function set width(value:Number):void 
		{
			if (_width != value) {
				_width = value;
				conchModel && conchModel.size(_width, _height);
				//callLater(changeSize);
				if (_layout.enable && (!isNaN(_layout.centerX) || !isNaN(_layout.right) || !isNaN(_layout.anchorX))) resetLayoutX();
				changeSize();
				callLater(changeItems);
			}
		}
		override public function set width(value:Number):void 
		{
			if (_width != value) {
				super.width = value;
				callLater(changeItems);
			}
		}
		/** @inheritDoc	*/
		override protected function changeItems():void {
			//_itemChanged = false;
			var items:Array = [];
			var maxWidth:Number = 0;
			
			for (var i:int = 0, n:int = numChildren; i < n; i++) {
				var item:Component = getChildAt(i) as Component;
				if (item&&item.layoutEnabled) {
					items.push(item);
					maxWidth = _width?_width:Math.max(maxWidth, item.width * item.scaleX);
				}
			}
			
			sortItem(items);
			var top:Number = 0;
			for (i = 0, n = items.length; i < n; i++) {
				item = items[i];
				item.y = top;
				top += item.height * item.scaleY + _space;
				if (_align == LEFT) {
					item.x = 0;
				} else if (_align == CENTER) {
					item.x = (maxWidth - item.width * item.scaleX) * 0.5;
				} else if (_align == RIGHT) {
					item.x = maxWidth - item.width * item.scaleX;
				}
			}
			changeSize();
		}
	}
}
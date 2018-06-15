package laya.editorUI{
	
	/**HBox容器*/
	public class HBox extends LayoutBox {
		public static const NONE:String = "none";
		public static const TOP:String = "top";
		public static const MIDDLE:String = "middle";
		public static const BOTTOM:String = "bottom";
		
		public function HBox() {
		}
		override protected function sortItem(items:Array):void 
		{
			if(items) items.sort(function(a:*, b:*):Number { return a.x > b.x ? 1 : -1});
		}
		override public function set height(value:Number):void 
		{
			if (_height != value) {
				super.height = value;
				callLater(changeItems);
			}
		}
		
		/** @inheritDoc	*/
		override protected function changeItems():void {
			//_itemChanged = false;
			var items:Array = [];
			var maxHeight:Number = 0;
			for (var i:int = 0, n:int = numChildren; i < n; i++) {
				var item:Component = getChildAt(i) as Component;
				if (item&&item.layoutEnabled) {
					items.push(item);
					maxHeight = _height?_height:Math.max(maxHeight, item.height * item.scaleY);
				}
			}
			sortItem(items);
			var left:Number = 0;
			for (i = 0, n = items.length; i < n; i++) {
				item = items[i];
				item.x = left;
				left += item.width * item.scaleX + _space;
				if (_align == TOP) {
					item.y = 0;
				} else if (_align == MIDDLE) {
					item.y = (maxHeight - item.height * item.scaleY) * 0.5;
				} else if (_align == BOTTOM) {
					item.y = maxHeight - item.height * item.scaleY;
				}
			}
			changeSize();
		}
	}
}
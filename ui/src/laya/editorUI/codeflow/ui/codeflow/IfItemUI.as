/**Created by the LayaAirIDE,do not modify.*/
package laya.editorUI.codeflow.ui.codeflow {
	import laya.display.Sprite;
	import laya.ui.*;
	import laya.editorUI.codeflow.CodeFlowItem;
	

	public class IfItemUI extends CodeFlowItem {
		public var elseDragPoint:Sprite;
		public var thenDragPoint:Sprite;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"CodeFlowItem","props":{"width":91,"height":71},"child":[{"type":"Poly","props":{"y":32,"x":18,"points":"-12,6,27,-29,71,3,29,33","lineWidth":1,"lineColor":"#ff0000","fillColor":"#00ffff"}},{"type":"Sprite","props":{"y":60,"x":44,"var":"elseDragPoint","pivotY":4,"pivotX":4},"child":[{"type":"Circle","props":{"y":8,"x":8,"radius":8,"lineWidth":1,"lineColor":"#000000","fillColor":"#8eff00"}}]},{"type":"Sprite","props":{"y":30,"x":85,"var":"thenDragPoint","pivotY":4,"pivotX":4},"child":[{"type":"Circle","props":{"y":8,"x":8,"radius":8,"lineWidth":1,"lineColor":"#000000","fillColor":"#8eff00"}}]},{"type":"Label","props":{"y":28,"x":31,"width":36,"text":"label","height":16}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
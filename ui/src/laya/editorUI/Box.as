package laya.editorUI {
	import laya.display.Node;
	import laya.ide.managers.IDEAPIS;
	import laya.ui.IBox;
	
	
	/**
	 * <code>Box</code> 类是一个控件容器类。
	 * @author yung
	 */
	public class Box extends Component implements IBox {
		
		public function Box()
		{
			callLater(checkIfShowRec);
		}
		/**@inheritDoc */
		override public function set dataSource(value:*):void {
			_dataSource = value;
			for (var name:String in value) {
				var comp:Component = getChildByName(name) as Component;
				if (comp) comp.dataSource = value[name];
				else if (hasOwnProperty(name)) this[name] = value[name];
			}
		}
		
		override protected function changeSize():void 
		{
			super.changeSize();
			callLater(checkIfShowRec);
		}
		override protected function _childChanged(child:Node = null):void 
		{
			super._childChanged(child);
			callLater(checkIfShowRec);
		}
		
		protected function checkIfShowRec():void
		{
			if (IDEAPIS.isPreview) return;
			this.graphics.clear();
			if (numChildren<1)
			{
				this.graphics.drawRect(0, 0, width?width:100, height?height:100, null, "#666666");
			}
		}
	}
}
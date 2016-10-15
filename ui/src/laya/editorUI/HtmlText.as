package laya.editorUI {
	import laya.ide.managers.ResFileManager;
	import laya.html.dom.HTMLDivElement;
	import laya.ide.managers.ResFileManager;
	import laya.maths.Rectangle;
	import laya.net.URL;
	import laya.ui.IComponent;
	/**
	 * HTMLText组件
	 */
	public class HtmlText extends HTMLDivElement implements IComponent {
		
		public function HtmlText() {
			URI = new URL(ResFileManager.adptToCommonUrl(ResFileManager.basePath) + "/");
		}
		
		/**
		 * @private
		 * @inheritDoc
		 */
		override public function _getBoundPointsM(ifRotate:Boolean = false):Array {
			var rec:Rectangle = Rectangle.TEMP;
			rec.setTo(0, 0, width, height);
			return rec._getBoundPoints();
		}
		
		public function get comXml():Object {
			return _comXml;
		}
		private var _comXml:Object;
		
		public function set comXml(value:Object):void {
			_comXml = value;
		}
	}

}
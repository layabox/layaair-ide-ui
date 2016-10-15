package laya.editorUI {
	import laya.display.Sprite;
	import laya.ide.managers.ResFileManager;
	import laya.maths.Rectangle;
	import laya.ui.Image;
	
	/**
	 * 精灵
	 */
	public class SpritePlayer extends Sprite implements IBox {
		
		public function SpritePlayer() {
			if (!pic) {
				pic = new Image();
				pic.skin = ResFileManager.getIDECompIconPath("SpriteHolder");
				super.addChild(pic);
			}
		}
		
		protected var pic:Image;
		
		public function get comXml():Object {
			return _comXml;
		}
		private var _comXml:Object;
		
		public function set comXml(value:Object):void {
			_comXml = value;
		}
		
		override public function get width():Number {
			if (_width > 0)
				return _width;
			return getSelfBounds().right;
			
			return super.width;
		}
		
		override public function get height():Number {
			if (_height > 0)
				return _height;
			return getSelfBounds().bottom;
			return super.height;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
		}
		private var _mMBounds:Rectangle;
		
		override public function _getBoundPointsM(ifRotate:Boolean = false):Array {
			if (this._width > 0 && this._height > 0 && !autoSize) {
				if (!_mMBounds) {
					_mMBounds = new Rectangle();
				}
				_mMBounds.setTo(0, 0, _width, _height);
				return _mMBounds._getBoundPoints();
			}
			return super._getBoundPointsM(ifRotate);
		}
	
	}

}
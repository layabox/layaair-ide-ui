package laya.editorUI {
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.ide.managers.IDEAPIS;
	import laya.ide.managers.ResFileManager;
	import laya.maths.Rectangle;
	import laya.resource.Texture;
	import laya.ui.IBox;
	import laya.ui.Image;
	
	/**
	 * 精灵
	 */
	public class SpritePlayer extends Sprite implements IBox {
		protected var iconSign:String="SpriteHolder";
		public function SpritePlayer() {
			__createIcon();
		}
		protected function __createIcon():void
		{
			if (!pic) {
				pic = new Image();
				pic.scaleX = pic.scaleY = 0.5;
				pic.skin = ResFileManager.getIDECompIconPath(iconSign);
				if(!IDEAPIS.isPreview)
				super.addChild(pic);
			}
		}
		protected var pic:Image;
		
		override protected function _childChanged(child:Node = null):void 
		{
			super._childChanged(child);
			if (numChildren > 1&&pic) pic.visible = false;
		}
		
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
	
		
		override public function get texture():Texture 
		{
			return super.texture;
		}
		
		override public function set texture(value:Texture):void 
		{
			if (!value)
			{
				super.texture = null;
				return;
			}
			if (value is String)
			{
				var textureRes:String = value as String;
				super.texture = Loader.getRes(textureRes);
				if(pic)pic.visible = false;
			}else
			{
				super.texture = value;
			}
		}
	}

}
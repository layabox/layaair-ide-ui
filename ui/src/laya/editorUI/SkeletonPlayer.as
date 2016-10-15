package laya.editorUI {
	import laya.ani.bone.Skeleton;
	import laya.ani.bone.Skeleton;
	import laya.ide.managers.FileManager;
	import laya.ide.managers.ResFileManager;
	import laya.maths.Rectangle;
	import laya.net.Loader;
	import laya.ui.IComponent;
	/**
	 * 骨骼动画播放器
	 */
	public class SkeletonPlayer extends Skeleton implements IComponent {
		
		public function SkeletonPlayer(tmplete:* = null) {
			super(tmplete);
			size(100, 100);			
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
		
		public function get comXml():Object {
			return _comXml;
		}
		private var _comXml:Object;
		
		public function set comXml(value:Object):void {
			_comXml = value;
		}
		
		override public function set url(path:String):void {
			path = ResFileManager.getIDEResPath(path);
			if (!FileManager.exists(path)) {
				var image:Image;
				image = new Image();
				image.skin = "loseskin.png";
				addChild(image);
				return;
			}
			Loader.clearRes(path);
			load(path);
		}
	}

}
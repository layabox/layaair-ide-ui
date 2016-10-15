package laya.editorUI {
	import laya.ani.swf.MovieClip;
	import laya.ide.managers.FileManager;
	import laya.ide.managers.ResFileManager;
	import laya.maths.Rectangle;
	import laya.net.Loader;
	import laya.ui.IComponent;
	
	
	/**
	 * Flash时间轴动画播放器
	 */
	public class MovieClipPlayer extends MovieClip implements IComponent {
		
		public function get comXml():Object {
			return _comXml;
		}
		private var _comXml:Object;
		
		public function set comXml(value:Object):void {
			_comXml = value;
		}
		
		public function MovieClipPlayer() {
			
			size(100, 100);
			
			setBounds(new Rectangle(0, 0, 100, 100));
		
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
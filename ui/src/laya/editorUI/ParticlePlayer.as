package laya.editorUI {
	import laya.ide.managers.ResFileManager;
	import laya.maths.Rectangle;
	import laya.particle.Particle2D;
	import laya.particle.ParticleSetting;
	import laya.ui.IComponent;
	
	/**
	 * 例子播放器
	 */
	public class ParticlePlayer extends Particle2D implements IComponent {
		
		public function ParticlePlayer() {
			size(100, 100);
			graphics.clear();
		}
		
		public function get comXml():Object {
			return _comXml;
		}
		private var _comXml:Object;
		
		public function set comXml(value:Object):void {
			_comXml = value;
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
			path = ResFileManager.getIDEPagePath(path);
			Loader.clearRes(path);
			load(path);
		}
		
		override public function setParticleSetting(settings:ParticleSetting):void {
			if (!settings) {
				var image:Image;
				image = new Image();
				image.skin = "loseskin.png";
				addChild(image);
				return;
			}
			if (settings.textureName.indexOf(":") < 0) {
				settings.textureName = ResFileManager.getIDEResPath(settings.textureName);
			}
			super.setParticleSetting(settings);
		}
		private var _focus:Boolean = false;
		
		public function setIDEFocusState(focus:Boolean):void {
			_focus = focus;
		}
		
		override public function advanceTime(passedTime:Number = 1):void {
			if (!_focus) return;
			repaint();
			super.advanceTime(passedTime);		
		}
	}
}
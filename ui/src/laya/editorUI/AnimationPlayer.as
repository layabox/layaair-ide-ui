package laya.editorUI {
	import laya.display.Animation;
	import laya.ide.managers.ResFileManager;
	import laya.maths.Rectangle;
	import laya.utils.Handler;
	
	/**
	 * 动画播放器
	 */
	public class AnimationPlayer extends Animation {
		
		private var pic:Image;
		private var _mMBounds:Rectangle;
		
		public function AnimationPlayer() {
			checkEmpty();
		}
		
		private function checkEmpty():void {
			if (this.numChildren < 1) {
				if (!pic) {
					pic = new Image();
					pic.skin = "spriteSkin.png";
					pic.size(100, 100);
					super.addChild(pic);
				}
			}
		}
		
		override public function set source(value:String):void {
			if (value && value != "") {
				if (pic) {
					pic.removeSelf();
				}
			}
			super.source = value;
		}
		
		override public function set autoPlay(value:Boolean):void {
			return;
		}
		
		override public function set autoAnimation(value:String):void 
		{
			this._actionName = value;
		}
		override public function loadAtlas(url:String, loaded:Handler = null, cacheName:String = ""):Animation {
			url = ResFileManager.getIDEResPath(url);
			return super.loadAtlas(url, loaded, cacheName);
		}
		
		override public function loadImages(urls:Array, cacheName:String = ""):Animation {
			if (!urls) return;
			var i:int, len:int;
			len = urls.length;
			for (i = 0; i < len; i++) {
				urls[i] = ResFileManager.getIDEResPath(urls[i]);
			}
			return super.loadImages(urls, cacheName);
		}
		
		/**@private */
		override protected function _parseGraphicAnimationByData(animationObject:Object):Object {
			return GraphicParser.parseAnimationByData(animationObject);
		}
		
		override public function loadAnimation(url:String, loaded:Handler = null,atlas:String=null):Animation {
			url = ResFileManager.getIDEPagePath(url);
			Loader.clearRes(url);
			delete framesMap[url];
			Animation.clearCache(url);
			return super.loadAnimation(url, loaded, atlas);
		}
		
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
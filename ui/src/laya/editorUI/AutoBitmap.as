package laya.editorUI {
	import laya.display.Graphics;
	import laya.resource.Texture;
	import laya.ui.AutoBitmap;
	import laya.utils.Utils;
	
	/**
	 * <code>AutoBitmap</code> 类是用于表示位图图像或绘制图形的显示对象。
	 * <p>封装了位置，宽高及九宫格的处理，供UI组件使用。</p>
	 */
	public final class AutoBitmap extends laya.ui.AutoBitmap {
		public function AutoBitmap()
		{
			super();
			autoCacheCmd = false;
			//trace("autoBitMap:",autoCacheCmd);
		}
		/** @private */
		override protected function _setChanged():void {
			if (!_isChanged) {
				_isChanged = true;
				//Laya.timer.callLater(this, changeSource);
				changeSource();
			}
		}
		
		/**
		 * @private
		 * texture缓存
		 */
		private static var textureCache:Object = { };
		
		/**@private 缓存资源*/
		public static function setCache(key:String, value:*):void {
			cacheCount++;
			textureCache[key] = value;
		}
		
		/**@private 获取资源*/
		public static function getCache(key:String):* {
			return textureCache[key];
		}
		
		/**@private */
		private static var cacheCount:int = 0;
		
		///**@private 缓存资源*/
		//public static function setCache(key:String, value:*):void {
			//laya.ui.AutoBitmap.setCache(key, value);
		//}
		//
		///**@private 获取资源*/
		//public static function getCache(key:String):* {
			//return laya.ui.AutoBitmap.getCache(key);
		//}
	}
}
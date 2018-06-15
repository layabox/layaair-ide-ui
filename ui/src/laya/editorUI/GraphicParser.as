package laya.editorUI {
	import laya.utils.GraphicAnimation;
	/**
	 * Graphics解析器
	 */
	public class GraphicParser extends GraphicAnimation {
		private static var _I:GraphicAnimation;
		
		override protected function _getTextureByUrl(url:String):String {
			//url = ResFileManager.getIDEResPath(url);
			return Loader.getRes(url);
			//return super._getTextureByUrl(url);
		}
				
		public static function parseAnimationByData(animationObject:Object):Object
		{
			if (!_I)
				_I = new GraphicParser();
			var rst:Object;
			rst = _I.parseByData(animationObject);
			_I._clear();
			return rst;
		}
	}
}
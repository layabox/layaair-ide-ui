package laya.editorUI {
	import laya.display.GraphicAnimation;
	import laya.display.GraphicAnimation;
	import laya.ide.managers.ResFileManager;
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
		
		public static function parseAnimationData(aniData:Object):Object {
			if (!_I) _I = new GraphicParser();
			_I.setAniData(aniData);
			var rst:Object;
			rst = {};
			rst.animationList = _I.animationList;
			rst.animationDic = _I.animationDic;
			return rst;
		}
	}
}
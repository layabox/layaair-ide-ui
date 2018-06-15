package laya.ide {
	import laya.display.css.Font;
	import laya.editorUI.Label;
	import laya.editorUI.View;
	/**
	 * 组件被加载后，会调用此类的init方法进行初始化
	 */
	public class Initiator {
		/*[COMPILER OPTIONS:normal]*/
		public static function init(parms:*):* {
			if (parms.font) {
				Font.defaultFont = parms.font;
				Label.initDefaultFontInfo(parms.font);
			}else
			{
				
                Label.initDefaultFontInfo(parms.font);
			}
			if (parms.createComp) {
				View.createComp = parms.createComp;
			}
			return {}
		}		
	}
}
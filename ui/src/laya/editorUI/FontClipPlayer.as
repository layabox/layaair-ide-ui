package laya.editorUI 
{
	import laya.ui.FontClip;
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author ww
	 */
	public class FontClipPlayer extends FontClip 
	{
		
		public function FontClipPlayer(skin:String=null, sheet:String=null) 
		{
			super(skin, sheet);
			
		}
		override protected function changeClip():void 
		{
			_clipChanged = false;
			if (!_skin) return;
			var img:* = Loader.getRes(_skin);
			if (img) {
				loadComplete(_skin, img);
			} else {
				Laya.loader.load(_skin, Handler.create(this, loadComplete, [_skin]));
			}
		}
		
		override protected function changeValue():void 
		{
			if (!_indexMap) return;
			super.changeValue();
		}
	}

}
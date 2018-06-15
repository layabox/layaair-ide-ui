package laya.editorUI 
{

	import laya.display.Text;
	/**
	 * ...
	 * @author ww
	 */
	public class Text extends laya.display.Text 
	{
		
		public function Text() 
		{
			super();
			if (Label.labelDefaultFont)
			{
				font = Label.labelDefaultFont;
			}
			if (Label.labelDefaultSize)
			{
				fontSize = Label.labelDefaultSize;
			}
		}
		//override public function lang(text:String, arg1:* = null, arg2:* = null, arg3:* = null, arg4:* = null, arg5:* = null, arg6:* = null, arg7:* = null, arg8:* = null, arg9:* = null, arg10:* = null):void 
		//{
			//if (arguments.length < 2) {
				//this._text = text;
			//} else {
				//for (var i:int = 0, n:int = arguments.length; i < n; i++) {
					//text = text.replace("{" + i + "}", arguments[i + 1]);
				//}
				//this._text = text;
			//}
		//}
	}

}
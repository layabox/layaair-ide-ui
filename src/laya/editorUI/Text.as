package laya.editorUI 
{

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
		}
		
	}

}
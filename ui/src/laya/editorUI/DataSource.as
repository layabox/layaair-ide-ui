package laya.editorUI 
{
	import laya.ide.managers.ResFileManager;
	/**
	 * ...
	 * @author ww
	 */
	public class DataSource  extends SpritePlayer
	{
		
		public function DataSource() 
		{
			pic.skin = ResFileManager.getIDECompIconPath("DataBase");
		}
		
	}

}
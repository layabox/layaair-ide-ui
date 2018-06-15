package laya.editorUI {
	import laya.ide.managers.ResFileManager;
	
	/**
	 * 脚本
	 */
	public class Script extends SpritePlayer {
		
		public function Script() {
		
			
		}
	
		override protected function __createIcon():void 
		{
			iconSign = "Script";
			super.__createIcon();
		}
	}

}
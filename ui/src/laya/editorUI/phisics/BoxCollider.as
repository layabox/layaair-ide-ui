package laya.editorUI.phisics {
	import laya.editorUI.graphic.DrawRect;
	
	/**
	 * @Script {name:laya.physics.BoxCollider}
	 */
	public class BoxCollider extends DrawRect {
		/**
		 * @prop {name:x,type:number,title:x,tips:相对节点的X偏移,default:0}
		 */
		//public var x:Number = 0;
		/**
		 * @prop {name:y,type:number,title:y,tips:相对节点的Y偏移,default:0}
		 */
		//public var y:Number = 0;
		/**
		 * @prop {name:width,type:number,title:width,tips:巨型碰撞宽度,default:100}
		 */
		//public var width:Number = 100;
		/**
		 * @prop {name:height,type:number,title:height,tips:巨型碰撞宽度,default:100}
		 */
		//public var height:Number = 100;
		 public var _ideBorderColor:String = "#ffff00";
		public function BoxCollider() {
			width = 100;
			height = 100;
			fillColor = null;
		}
		
		public function fitsize():void
		{
			this.x = 0;
			this.y = 0;
			this.width = parent.width;
			this.height = parent.height;
			drawSelf();
			//updateCompKeyValue("width", this.width);
			//updateCompKeyValue("height", this.height);
			updateCompKeysValue(["x","y","width","height"]);
		}
	}
}
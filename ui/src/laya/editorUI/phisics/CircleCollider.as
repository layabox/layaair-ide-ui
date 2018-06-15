package laya.editorUI.phisics {
	import laya.editorUI.graphic.GraphicBase;
	
	/**
	 * @Script {name:laya.physics.CircleCollider}
	 * @author yung
	 */
	public class CircleCollider extends GraphicBase {
		
		/**
		 * @prop {name:x,type:number,title:x,tips:相对节点的X偏移,default:0}
		 */
		//public var x:Number = 0;
		/**
		 * @prop {name:y,type:number,title:y,tips:相对节点的Y偏移,default:0}
		 */
		//public var y:Number = 0;
		/**
		 * @prop {name:radius,type:number,title:radius,tips:半径,default:50}
		 */
		public var radius:Number = 50;
		
		public function CircleCollider()
		{
			 radius = 50;
			 fillColor = null;
		}
		
		public function fitsize():void
		{
			
			this.radius = parent.width * 0.5;
			this.x = 0;
			this.y = parent.height*0.5-this.radius;
			drawSelf();
			//updateCompKeyValue("width", this.width);
			//updateCompKeyValue("height", this.height);
			updateCompKeysValue(["x","y","radius"]);
		}
		override public function drawSelf():void 
		{
			this.graphics.clear();
			if (isSelectState)
			{
				this.graphics.drawCircle(radius, radius, radius, fillColor, lineColor, 4);
			}else
			{
				this.graphics.drawCircle(radius, radius, radius, fillColor, lineColor, lineWidth);
			}
			
		}
		public function freshIDESelect():void {
			drawSelf();
		}
		
		public function setIDESelectState(isSelect:Boolean):void {
			if (isSelect) {

			} else {

			}
			isSelectState = isSelect;
			drawSelf();
		}
	}
}
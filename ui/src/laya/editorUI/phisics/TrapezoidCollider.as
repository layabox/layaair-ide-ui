package laya.editorUI.phisics {
	import laya.editorUI.graphic.GraphicBase;
	
	/**
	 * @Script {name:laya.physics.TrapezoidCollider}
	 * @author yung
	 */
	public class TrapezoidCollider extends GraphicBase {
		
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
		/**
		 * @prop {name:slope,type:number,title:slope,tips:坡度，取值范围0-1,default:0.5}
		 */
		public var slope:Number = 0.5;
		
		public function TrapezoidCollider()
		{
			
		}
		override public function drawSelf():void {
			this.graphics.clear();
			var tSlope:Number;
			tSlope = slope * 0.5;
			var roof:Number = (1 - (tSlope * 2)) * width;
			
			var x1:Number = width * tSlope;
			var x2:Number = x1 + roof;
			var x3:Number = x2 + x1;
			var verticesPath:Array;
			
			if (tSlope < 0.5) {
				verticesPath = [0, 0, x1, -height, x2, -height, x3, 0];
			}
			else {
				verticesPath = [0, 0, x2, -height, x3, 0];
			}
			this.graphics.drawPoly(0, height, verticesPath, fillColor, lineColor, lineWidth);
		}
		
		public function freshIDESelect():void {
			drawSelf();
		}
		
		//public function setIDESelectState(isSelect:Boolean):void {
			//if (isSelect) {
//
			//} else {
//
			//}
			//drawSelf();
		//}
	}
}
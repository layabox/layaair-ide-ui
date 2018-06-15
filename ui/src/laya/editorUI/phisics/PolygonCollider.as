package laya.editorUI.phisics {
	import laya.editorUI.graphic.DrawCircle;
	import laya.editorUI.graphic.GraphicBase;
	import laya.maths.Rectangle;
	
	/**
	 * @Script {name:laya.physics.PolygonCollider}
	 * @author yung
	 */
	public class PolygonCollider extends DrawCircle {
		
		/**
		 * @prop {name:x,type:number,title:x,tips:相对节点的X偏移,default:0}
		 */
		//public var x:Number = 0;
		/**
		 * @prop {name:y,type:number,title:y,tips:相对节点的Y偏移,default:0}
		 */
		//public var y:Number = 0;
		/**
		 * @prop {name:sides,type:number,title:sides,tips:边的数量,default:5}
		 */
		public var sides:Number = 5;
		/**
		 * @prop {name:radius,type:number,title:radius,tips:半径,default:50}
		 */
		//public var radius:Number = 50;
		
		override public function drawSelf():void 
		{
			this.graphics.clear();
			var theata:Number = 2 * Math.PI / sides;
			var offset:Number;
			offset = 0.5 * theata;
			var i:int, len:int;
			len = sides;
			var angle:Number;
			var points:Array;
			points = [];
			
			for (i = 0; i < len; i++)
			{
				angle = offset + i * theata;
				points.push(Math.cos(angle)*radius,Math.sin(angle)*radius);
			}
			var rec:Rectangle;
			rec = Rectangle.TEMP;
			Rectangle._getWrapRec(points,rec);
			this.graphics.drawPoly(radius, -rec.y, points, fillColor, lineColor, lineWidth);
		}
	}
}
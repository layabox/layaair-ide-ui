package laya.editorUI.phisics {
	import laya.editorUI.graphic.DrawPoly;
	/**
	 * 多边形
	 */
	public class VerticesCollider extends DrawPoly  {
		/**
		 * @prop {name:x,type:number,tips:相对节点的X偏移,default:0}
		 */
		//public var x:Number = 0;
		/**
		 * @prop {name:y,type:number,tips:相对节点的Y偏移,default:0}
		 */
		//public var y:Number = 0;
		/**
		 * @prop {name:pointNum,type:number,tips:点的数量,default:5}
		 */
		//public var pointNum:Number = 5;
		/**
		 * @prop {name:points,type:string,tips:用空格隔开的点的集合,default:5}
		 */
		//public var points:String;
		
		public function VerticesCollider()
		{
			SplitSign = " ";
		}
		override protected function drawWork():void 
		{
			super.drawWork();
		}
	}
}
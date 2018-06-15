package laya.editorUI.phisics {
	import laya.display.Sprite;
	import laya.editorUI.Script;
	import laya.events.Event;
	import laya.ide.managers.IDEAPIS;
	import laya.maths.Point;
	import laya.renders.RenderContext;
	
	/**
	 * ...
	 * @author ww
	 */
	public class Constraint extends Script {
		public var other:int;
		public var otherPoint:String;
		public var selfPoint:String;
		public var isSelectState:Boolean = false;
		public var disablePivot:Boolean = true;
		private var _myPoint:Sprite;
		private var _otherPoint:Sprite;
		private var _isDraging:Boolean;
		
		public function Constraint() {
			this.pic.visible = false;
			_myPoint = createPointSprite("#00ff00");
			_otherPoint = createPointSprite("#ff0000");
			setIDESelectState(false);
		}
		
		override public function get mask():Sprite 
		{
			return null;
		}
		
		override public function set mask(value:Sprite):void 
		{
			
		}
		private function createPointSprite(color:String):Sprite {
			var sp:Sprite;
			sp = new Sprite();
			sp.graphics.drawCircle(5, 5, 5, color);
			sp.pivot(5, 5);
			sp.size(5 * 2, 5 * 2);
			addChild(sp);
			sp.visible = false;
			sp.on(Event.MOUSE_DOWN, this, onMouseDown, [sp]);
			sp.on(Event.DRAG_END, this, onDragEnd, [sp]);
			return sp;
		}
		
		private function onMouseDown(sp:Sprite, e:Event):void {
			e.stopPropagation();
			_isDraging = true;
			sp.startDrag();
		}
		
		private function onDragEnd(sp:Sprite):void {
			_isDraging = false;
			updatePoint(sp);
		}
		
		private function updatePoint(sp:Sprite):void {
			if (sp == _otherPoint) {
				var tarDisplay:Sprite;
				var point:Point;
				tarDisplay = IDEAPIS.GetNodeByNodeRefer(other);
				_point.setTo(_otherPoint.x, _otherPoint.y);
				_point = this.localToGlobal(_point);
				if (tarDisplay) {
					
					_point=tarDisplay.globalToLocal(_point);
				}
				else {
					_point=IDEAPIS.globalToDesignGlobal(_point);
				}
				updateKeyValue("otherPoint", [Math.round(_point.x), Math.round(_point.y)].join(","));
			}
			if (sp == _myPoint) {
				_point.setTo(_myPoint.x, _myPoint.y);
				_point=this.toParentPoint(_point);
				updateKeyValue("selfPoint", [Math.round(_point.x), Math.round(_point.y)].join(","));
			}
		}
		
		private function updateKeyValue(key:String, value:String):void {
			var data:Object;
			data = this["comXml"];
			this[key] = value;
			if (data && data.props) {
				
				data.props[key] = value;
				IDEAPIS.nodeChange(data, [key], false);
			}
		}
		public function freshIDESelect():void {
		}
		public function setIDESelectState(isSelect:Boolean):void {
			isSelectState = isSelect;
			if (isSelect) {
				this.pic.visible = false;
				_myPoint.visible = true;
				_otherPoint.visible = true;
			}
			else {
				this.graphics.clear();
				this.pic.visible = false;
				_myPoint.visible = false;
				_otherPoint.visible = false;
			}
			repaint();
		}
		private static var _point:Point = new Point();
		
		private function getPointFromPointStr(point:String, tarPoint:Point = null):Point {
			if (!tarPoint)
				tarPoint = _point;
			if (!point)
				return tarPoint.setTo(0, 0);
			var arr:Array = point.split(",");
			if (arr.length != 2) {
				tarPoint.setTo(0, 0);
				return tarPoint;
			}
			tarPoint.setTo(parseFloat(arr[0]) || 0, parseFloat(arr[1]) || 0);
			return tarPoint;
		}
		
		private static var _pointA:Point = new Point();
		private static var _pointB:Point = new Point();
		
		private function drawPointAndLine():void {
			//debugger;
			this.graphics.clear();
			var tarDisplay:Sprite;
			var point:Point;
			if (!_isDraging) {
				tarDisplay = IDEAPIS.GetNodeByNodeRefer(other);
				
				point = getPointFromPointStr(otherPoint, _pointA);
				if (tarDisplay) {
					point = tarDisplay.localToGlobal(point);
					point = this.globalToLocal(point);
				}
				else {
					point = IDEAPIS.DesignGlobalToGlobal(point);
					point = this.globalToLocal(point);
				}
				_otherPoint.pos(point.x, point.y);
				//this.graphics.drawCircle(point.x, point.y, 5, "#ff0000");
				
				point = getPointFromPointStr(selfPoint, _pointB);
				this.fromParentPoint(point);
				//this.graphics.drawCircle(point.x, point.y, 5, "#00ff00");
				_myPoint.pos(point.x, point.y);
				
			}
			
			this.graphics.drawLine(_myPoint.x, _myPoint.y, _otherPoint.x, _otherPoint.y, "#ffff00");
		
		}
		
		override public function render(context:RenderContext, x:Number, y:Number):void {
			if (isSelectState)
				drawPointAndLine();
			super.render(context, x, y);
		}
	}

}
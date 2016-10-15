package laya.editorUI.graphic {
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ide.managers.IDEAPIS;
	import laya.maths.MathUtil;
	
	/**
	 * 绘制扇形
	 */
	public class DrawPie extends GraphicBase {
		public var radius:Number;
		public var startAngle:Number;
		public var endAngle:Number;
		private var _tDragPoint:Sprite;
		private var _startPoint:Sprite;
		private var _endPoint:Sprite;
		
		public function DrawPie() {
			super();
			_initDragPoints();
		}
		
		override public function drawSelf():void {
			this.graphics.clear();
			this.graphics.drawPie(0, 0, radius, startAngle, endAngle, fillColor, lineColor, lineWidth);
			this.size(radius, radius);
			if (_tDragPoint != _startPoint) {
				_posSprite(startAngle, _startPoint);
			}
			if (_tDragPoint != _endPoint) {
				_posSprite(endAngle, _endPoint);
			}
		}
		
		private function _posSprite(angle:Number, sp:Sprite):void {
			var r:Number;
			r = angle * Math.PI / 180;
			sp.pos(radius * Math.cos(r), radius * Math.sin(r));
		}
		
		private function _initDragPoints():void {
			_startPoint = createDragPoint();
			_endPoint = createDragPoint();
		}
		
		private function createDragPoint():Sprite {
			var _rstPoint:Sprite;
			_rstPoint = new Sprite();
			_rstPoint.graphics.drawCircle(5, 5, 5, "#ffffff", "#ff0000", 1);
			_rstPoint.size(10, 10);
			_rstPoint.pivot(5, 5);
			_rstPoint.on(Event.MOUSE_DOWN, this, _endPointStargDrag, [_rstPoint]);
			_rstPoint.on(Event.DRAG_END, this, _endPointDragEnd, [_rstPoint]);
			_rstPoint.on(Event.DRAG_MOVE, this, _endPointDraging, [_rstPoint]);
			return _rstPoint;
		}
		
		private function _endPointStargDrag(sp:Sprite, e:Event):void {
			e.stopPropagation();
			_tDragPoint = sp;
			sp.startDrag();
		}
		
		private function _endPointDraging():void {
			updateTos();
		}
		
		private function _endPointDragEnd():void {
			updateTos();
			_tDragPoint = null;
			drawSelf();
			var data:Object;
			data = this["comXml"];
			if (data && data.props) {
				data.props.radius = radius;
				data.props.startAngle = startAngle;
				data.props.endAngle = endAngle;
				IDEAPIS.nodeChange(data, ["radius", "startAngle", "endAngle"], false);
			}
		
		}
		
		private function updateTos():void {
			switch (_tDragPoint) {
			case _startPoint: 
				startAngle = MathUtil.getRotation(0, 0, _startPoint.x, _startPoint.y);
				radius = Math.sqrt(_startPoint.x * _startPoint.x + _startPoint.y * _startPoint.y);
				break;
			case _endPoint: 
				endAngle = MathUtil.getRotation(0, 0, _endPoint.x, _endPoint.y);
				radius = Math.sqrt(_endPoint.x * _endPoint.x + _endPoint.y * _endPoint.y);
				break;
			}
			
			drawSelf();
		}
		
		public function freshIDESelect():void {
			drawSelf();
		}
		
		public function setIDESelectState(isSelect:Boolean):void {
			if (isSelect) {
				this.myAddChild(_startPoint);
				this.myAddChild(_endPoint);
			} else {
				_startPoint.removeSelf();
				_endPoint.removeSelf();
			}
		}
	
	}

}
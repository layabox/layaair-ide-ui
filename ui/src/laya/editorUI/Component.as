package laya.editorUI {
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.ui.IComponent;
	import laya.ui.Component;
	
	/**
	 * 对象的大小经过重新调整时进行调度。
	 * @eventType Event.RESIZE
	 */	
	[Event(name = "resize",type="laya.events.Event")]
	
	/**
	 * <code>Component</code> 是ui控件类的基类。
	 * 
	 * 
	 * <p>生命周期：preinitialize > createChildren > initialize > 组件构造函数</p>
	 */	
	public class Component extends laya.ui.Component implements IComponent{
		private var _mMBounds:Rectangle;
		override public function _getBoundPointsM(ifRotate:Boolean = false):Array 
		{
			if (this._width > 0 && this._height > 0)
			{
				if (!_mMBounds)
				{
					_mMBounds = new Rectangle();
				}
				_mMBounds.setTo(0, 0, width, height);
				return _mMBounds._getBoundPoints();
			}
			return super._getBoundPointsM(ifRotate);
		}
		
		public var disableLayout:Boolean=false;
		override protected function resetLayoutX():void 
		{
			if (disableLayout) return;
			super.resetLayoutX();
		}
		override protected function resetLayoutY():void 
		{
			if (disableLayout) return;
			super.resetLayoutY();
		}
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
				conchModel && conchModel.size(_width, _height);
				//callLater(changeSize);
				if (_layout.enable && (!isNaN(_layout.centerX) || !isNaN(_layout.right) || !isNaN(_layout.anchorX))) resetLayoutX();
				changeSize();
			}
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				conchModel && conchModel.size(_width, _height);
				//callLater(changeSize);
				if (_layout.enable && (!isNaN(_layout.centerY) || !isNaN(_layout.bottom) || !isNaN(_layout.anchorY))) resetLayoutY();
				changeSize();
			}
		}
		
		/**@inheritDoc */
		override public function set scaleX(value:Number):void {
			if (super.scaleX != value) {
				super.scaleX = value;
				//callLater(changeSize);
				_layout.enable && resetLayoutX();
				changeSize();
			}
		}
		override protected function changeSize():void 
		{
			super.changeSize();
			resetLayoutX();
			resetLayoutY();
		}
		/**@inheritDoc */
		override public function set scaleY(value:Number):void {
			if (super.scaleY != value) {
				super.scaleY = value;
				//callLater(changeSize);
				_layout.enable && resetLayoutY();
				changeSize();
			}
		}

	}
}
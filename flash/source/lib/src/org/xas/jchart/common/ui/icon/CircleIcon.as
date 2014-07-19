package org.xas.jchart.common.ui.icon
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class CircleIcon extends Sprite
	{
		private var _point:Point;
		private var _color:uint;
		private var _radius:Number;
		
		public function CircleIcon( _point:Point, _color:uint = 0x000000, _radius:Number = 5 )
		{
			super();
			
			this._point = _point;
			this._color = _color;
			this._radius = _radius;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			this.x = _point.x;
			this.y = _point.y;
			hover();
		}
		
		public function hover():void{
			graphics.clear();
			graphics.beginFill( _color );
			graphics.lineStyle( 2, 0xffffff );
			graphics.drawCircle( 0, 0, _radius );
		}
		
		public function unhover():void{
			graphics.clear();
			graphics.beginFill( 0xffffff );
			graphics.lineStyle( 2, _color );
			graphics.drawCircle( 0, 0, _radius );
		}
	}
}
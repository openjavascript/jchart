package org.xas.jchart.common.ui.icon
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class VLineIcon extends Sprite
	{
		private var _spoint:Point, _epoint:Point;
		private var _color:uint, _hoverColor:uint;
		
		public function VLineIcon( _spoint:Point, _epoint:Point
								   , _color:uint = 0x999999, _hoverColor:uint = 0x000000
		)
		{
			super();
			
			this._spoint = _spoint;
			this._epoint = _epoint;
			this._color = _color;
			this._hoverColor = _hoverColor;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			unhover();
		}
		
		public function hover():void{
			graphics.clear();
			graphics.beginFill( 0xffffff );
			graphics.lineStyle( 1, _hoverColor );
			graphics.moveTo( _spoint.x, _spoint.y );
			graphics.lineTo( _epoint.x, _epoint.y );
		}
		
		public function unhover():void{
			graphics.clear();
			graphics.beginFill( _color );
			graphics.lineStyle( 1, _color );
			graphics.moveTo( _spoint.x, _spoint.y );
			graphics.lineTo( _epoint.x, _epoint.y );
		}
	}
}
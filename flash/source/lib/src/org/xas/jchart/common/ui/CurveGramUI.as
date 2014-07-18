package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	
	public class CurveGramUI extends Sprite
	{
		private var _x:Number, _y:Number, _w:Number, _h:Number;
		private var _color:Number;
		
		public function CurveGramUI( _x:Number, _y:Number, _w:Number, _h:Number, _color:uint )
		{
			super();
			
			this._x = _x;
			this._y = _y;
			this._w = _w;
			this._h = _h;
			this._color = _color;
			
			init();
		}
		
		private function init():void{
			
			graphics.beginFill( _color, 1 );
			graphics.drawRect( 0, 0, _w, _h );
			this.x = _x;
			this.y = _y;
		}
	}
}
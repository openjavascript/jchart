package org.xas.core.ui.geo
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import org.xas.core.utils.GeoUtils;

	public class IsoscelesTriangle extends BaseTriangle
	{
		private var _sideDiameter:Number;
		
		public function IsoscelesTriangle( $diameter:Number = 40, $sideDiameter:Number = 30, $angle:Number = 0 )
		{
			_diameter = $diameter;
			_angle = $angle;
			_sideDiameter = $sideDiameter;
			
			init();
		}
		
		override protected function initPoint():void
		{					
			_p1 = new Point( 0, 0 );
			
			var tempX:Number = _diameter / 2;		
			_p2 = GeoUtils.moveByAngle( 90, new Point( tempX, 0 ), _sideDiameter );
			
			_p3 = _p1.clone()
		}
		
		override public function draw():void
		{
			_sp.graphics.moveTo( _p1.x, _p1.y );
			_sp.graphics.lineTo( _diameter, 0  );
			_sp.graphics.lineTo( _p2.x, _p2.y );
			_sp.graphics.lineTo( _p1.x, _p1.y );
						
			_sp.graphics.endFill();
			
			_sp.x = -(_sp.width / 2);
			_sp.y = -(_sp.height / 2 );
			
			this.rotation = _angle;
		}
	}
}
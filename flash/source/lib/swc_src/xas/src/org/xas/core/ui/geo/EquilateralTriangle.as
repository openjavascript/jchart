package org.xas.core.ui.geo
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class EquilateralTriangle extends BaseTriangle
	{		
		
		public function EquilateralTriangle( $diameter:Number, $angle:Number = 60 )
		{
			_diameter = $diameter;
			_angle = $angle;
			
			init();
		}
		
		override protected function initPoint():void
		{							
			_p1 = new Point( 0, 0 );
			_p2 = new Point( _diameter , 0 );			
			_p3 = new Point( _diameter  / 2, _diameter  );
			
			_p3.x = Math.cos( _angle ) * _diameter ;
			_p3.y = Math.sin( _angle ) * _diameter ;
			
			var radians:Number = _angle * Math.PI / 180;
			_p3.x = Math.cos( radians ) * _diameter;
			_p3.y = Math.sin( radians ) * _diameter;
		}
		
		override public function draw():void
		{
			_sp.graphics.moveTo( _p1.x, _p1.y );
			_sp.graphics.lineTo( _p2.x, _p2.y );
			_sp.graphics.lineTo( _p3.x, _p3.y );
			_sp.graphics.lineTo( _p1.x, _p1.y );
						
			_sp.rotation = -90;
			_sp.x = -(_sp.width / 2);
			_sp.y = (_sp.height / 2); 
			
			_sp.graphics.endFill();
		}
	}
}
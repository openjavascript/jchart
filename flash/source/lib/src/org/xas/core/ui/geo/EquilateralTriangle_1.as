package org.xas.core.ui.geo
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class EquilateralTriangle_1 extends Sprite
	{
		private var _radius:Number;
		private var _angle:Number;
		
		private var _p1:Point;
		private var _p2:Point;
		private var _p3:Point;
		private var _p4:Point;
		
		private var _sp:Sprite;
		public function get sp():Sprite{ return _sp; }
		
		public function EquilateralTriangle_1( $radius:Number = 20, $angle:Number = -90 )
		{
			_radius = $radius;
			_angle = $angle;
			
			init();
		}
		
		private function init():void
		{
			addChild( _sp = new Sprite() );
			
			var diameter :Number = _radius;			
			var angle:Number = 60;			
			_p1 = new Point( 0, 0 );
			_p2 = new Point( diameter , 0 );			
			_p3 = new Point( diameter  / 2, diameter  );
			
			_p3.x = Math.cos( angle ) * diameter ;
			_p3.y = Math.sin( angle ) * diameter ;
			
			var radians:Number = angle * Math.PI / 180;
			_p3.x = Math.cos( radians ) * diameter;
			_p3.y = Math.sin( radians ) * diameter;
			
			
		}
		
		public function draw():void
		{
			_sp.graphics.moveTo( _p1.x, _p1.y );
			_sp.graphics.lineTo( _p2.x, _p2.y );
			_sp.graphics.lineTo( _p3.x, _p3.y );
			_sp.graphics.lineTo( _p1.x, _p1.y );
			_sp.x = -(_sp.width / 2);
			_sp.y = -(_sp.height / 2); 
			
			this.rotation = _angle;
		}
		
		public function show():void
		{
			this.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
	}
}
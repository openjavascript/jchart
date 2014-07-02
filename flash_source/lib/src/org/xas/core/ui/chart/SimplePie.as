package org.xas.core.ui.chart
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import org.xas.core.utils.GeoUtils;
	
	public class SimplePie extends Sprite
	{
		private var _radius:Number;
		private var _percent:Number;
		private var _bgColor:uint;
		private var _areaColor:uint;
		
		private var _bg:Sprite;
		
		private var _area:Sprite;
		private var _angle:Number;
		
		private var _anglePad:Number = -90;
		
		public function SimplePie( $radius:Number, $percent:Number, $bgColor:uint, $areaColor:Number )
		{
			_radius = $radius;
			_percent = $percent;
			_bgColor = $bgColor;
			_areaColor = $areaColor;
			
			init();
		}
		
		private function init():void
		{
			addChild( _bg = new Sprite() );
			
			_bg.graphics.lineStyle( 0, 0, 0 );
			_bg.graphics.beginFill( _bgColor );
			_bg.graphics.drawCircle( 0, 0, _radius );
			_bg.graphics.endFill();
						
			_angle = 360 * _percent;
			
			var angleCount:Number = 0;
			var angleStep:Number = 1;
			var p:Point;
			var centerPoint:Point = new Point( 0, 0 );
			
			addChild( _area = new Sprite() );
			_area.graphics.lineStyle( 0, 0, 0 );
			_area.graphics.beginFill( _areaColor );
			
			
			p = GeoUtils.moveByAngle( angleCount + _anglePad, centerPoint, _radius );
			_area.graphics.moveTo( 0, 0 );
			_area.graphics.lineTo( p.x, p.y );
			
			while( angleCount <= _angle )
			{				
				p = GeoUtils.moveByAngle( angleCount + _anglePad, centerPoint, _radius );
				_area.graphics.lineTo( p.x, p.y );
				
				angleCount += angleStep;
				
				if( angleCount >= _angle )
				{
					angleCount = _angle;					
					p = GeoUtils.moveByAngle( angleCount + _anglePad, centerPoint, _radius );
					_area.graphics.lineTo( p.x, p.y );					
					break;
				}
			}			
			_area.graphics.lineTo( 0, 0 );
			_area.graphics.endFill();
			
		}
	}
}
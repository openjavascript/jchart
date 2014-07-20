package org.xas.jchart.common.ui.widget
{	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.GeoUtils;
	
	public class PiePart extends Sprite
	{
		private var _centerPoint:Point;
		public function get centerPoint():Point{ return _centerPoint; }
		
		private var _radius:Number;
		public function get radius():Number{ return _radius; }
		
		private var _beginAngle:Number;
		public function get beginAngle():Number{ return _beginAngle; }
		
		private var _endAngle:Number;
		public function get endAngle():Number{ return _endAngle; }
		
		public function get midAngle():Number{ return _beginAngle + ( _endAngle - _beginAngle ) / 2; }
		
		private var _offsetPosition:Number;
		public function get offsetPosition():Number{ return _offsetPosition; }
		
		private var _parts:Vector.<PiePart>;
		public function get parts():Vector.<PiePart>{ return _parts; }

		
		public function PiePart( 
			_centerPoint:Point
			 , _beginAngle:Number, _endAngle:Number
			 , _radius:Number
		)
		{
			this._centerPoint = _centerPoint;
			this._beginAngle = _beginAngle;
			this._endAngle = _endAngle;
			this._radius = _radius;
			
			init();
		}
		
		private function init():void
		{
	
			graphics.lineStyle(1, 0xffffff);
			graphics.beginFill( 0x000000 );
			
			graphics.moveTo( _centerPoint.x, _centerPoint.y );
			
			var p1:Point = GeoUtils.moveByAngle
				( 
					_beginAngle
					, _centerPoint
					, _radius 
				);
			graphics.lineTo( p1.x, p1.y );
			
			var countAngle:Number = _beginAngle;
			var angleStep:Number = .5;
			
			var tempPoint:Point;
			
			while( true )
			{
				if( countAngle >= _endAngle )
				{
					tempPoint = GeoUtils.moveByAngle( _endAngle, _centerPoint, _radius );
					graphics.lineTo( tempPoint.x, tempPoint.y );
					break;
				}
				tempPoint = GeoUtils.moveByAngle( countAngle, _centerPoint, _radius );
				graphics.lineTo( tempPoint.x, tempPoint.y );
				
				countAngle += angleStep;
			}
			
			graphics.endFill();

		}
		
		private function mouseOver( _evt:MouseEvent ):void
		{

		}
		
		private function mouseOut( _evt:MouseEvent ):void
		{

		}
		
		private function mouseMove( _evt:MouseEvent ):void
		{
		}

	}
}
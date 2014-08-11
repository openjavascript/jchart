package org.xas.jchart.common.ui.widget
{	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class CyclicPart extends Sprite
	{
		private var _centerPoint:Point;
		public function get centerPoint():Point{ return _centerPoint; }
		
		private var _radius:Number;
		public function get radius():Number{ return _radius; }
		
		private var _sradius:Number;
		public function get sradius():Number{ return _sradius; }
		
		private var _percent:Number;
		public function get percent():Number{ return _percent; }
		
		private var _style:Object;
		private var _hoverStyle:Object;
				
		private var _nerdBg:Boolean = false;
		
		public function CyclicPart( 
			_centerPoint:Point
			, _percent:Number = 0
			 , _radius:Number = 100	
			 , _sradius:Number = 90
			 , _style:Object = null
			 , _nerdBg:Boolean = false
		)
		{
			this._centerPoint = _centerPoint;
			this._percent = _percent;
			this._radius = _radius;
			this._sradius = _sradius;
			
			this._style = _style;
			this._nerdBg = _nerdBg;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
						
			draw();
		}
		
		private function draw():void{
			
			//_percent = .4;
			
			var _h:Number = _radius * 2
				, _maxY:Number = _centerPoint.y + _radius
				, _minY:Number = _centerPoint.y - _radius
				, _maxX:Number = _centerPoint.x + _radius
				, _minX:Number = _centerPoint.x - _radius
				, _x:Number = 0, _y:Number = 0
				, _offsetAngle:Number = 90
				;	
			
			graphics.lineStyle(1, 0xECECEC );
			graphics.beginFill( 0xECECEC );
			
			if( _style ){
				if( _style.color ){
					graphics.lineStyle(1, _style.color );
					graphics.beginFill( _style.color );
				} 
			}
			
			_y = _minY + _h - _percent * _h;
			
			
			var _eangle:Number =  180 * _percent
				, _sangle:Number = 360 - _eangle
				;
			
			_eangle += _offsetAngle;
			_sangle += _offsetAngle;
			
			var _spoint:Point = Common.moveByAngle(  _sangle, _centerPoint,  _radius )
				, _epoint:Point = Common.moveByAngle(  _eangle, _centerPoint,  _radius )
				, _tmpPoint:Point
				;

			graphics.moveTo( _spoint.x, _spoint.y );
			
			if( _sangle > _eangle ) _eangle += 360;
			if( _sangle == _eangle ) _eangle += 360;
			//Log.log( _sangle, _eangle );
			
			while( true ){
				if( _sangle >= _eangle ) {
					_sangle = _eangle;
				}
				
				_tmpPoint =  Common.moveByAngle(  _sangle, _centerPoint, _radius );
				
				graphics.lineTo( _tmpPoint.x, _tmpPoint.y );
				
				if( _sangle == _eangle ) {
					graphics.lineTo( _spoint.x, _spoint.y );
					break;
				};
				_sangle += 1;
			}
			
			
			graphics.beginFill( 0xffffff );
			graphics.lineStyle( 1, 0xffffff );
			
			if( _style && _style.bgFill ){
				graphics.beginFill( _style.bgFill );
				graphics.lineStyle( 1, _style.bgFill );
			}
			
			graphics.drawCircle( _centerPoint.x, _centerPoint.y, _sradius );
			
			if( _nerdBg ){
				
				
				graphics.beginFill( 0xFDF0F2 );
				graphics.lineStyle( 1, 0xFDF0F2 );
				
				if( _style && _style.coverFill ){
					graphics.beginFill( _style.coverFill );
					graphics.lineStyle( 1, _style.coverFill );
				}
				
				var _minusRadius:Number = _radius - _sradius
					, _bgsPoint:Point = _spoint.clone()
					, _bgePoint:Point = _epoint.clone()
					, _bgsAngle:Number
					, _bgeAngle:Number
					;
				
				if( _percent <= .15 ) return;
				
				if(  _percent > .86 ){		
					
					graphics.drawCircle( _centerPoint.x, _centerPoint.y, _sradius );
					
					return;
				}
				//Log.log( _bgsPoint.x, _bgePoint.x, Math.abs( _bgsPoint.x - _bgePoint.x ) )
				_bgsAngle = Common.lineAngle( _centerPoint.x, _centerPoint.y, _bgsPoint.x, _bgsPoint.y );
				_bgeAngle = Common.lineAngle( _centerPoint.x, _centerPoint.y, _bgePoint.x, _bgePoint.y );
				_bgsPoint = GeoUtils.moveByAngle( _bgsAngle, _centerPoint, _radius );
				_bgePoint = GeoUtils.moveByAngle( _bgeAngle, _centerPoint, _radius );
				
				
				_bgsPoint.x -= _minusRadius;
				_bgePoint.x += _minusRadius;
				
				/*
				graphics.lineStyle( 1, 0xFDF8F2 );
				graphics.moveTo( _centerPoint.x, _centerPoint.y );
				graphics.lineTo( _bgsPoint.x, _bgsPoint. y );
				/*
				
				graphics.lineStyle( 1, 0xffff00 );
				graphics.moveTo( _centerPoint.x, _centerPoint.y );
				graphics.lineTo( _bgePoint.x, _bgePoint. y );
				
				
				graphics.moveTo( _centerPoint.x, _centerPoint.y );
				graphics.lineTo( _bgsPoint.x, _bgsPoint.y );
				graphics.moveTo( _centerPoint.x, _centerPoint.y );
				graphics.lineTo( _bgePoint.x, _bgePoint.y );
				*/
				
				
				//Log.log( _bgsAngle, _bgeAngle );
				
				_bgsAngle = Common.lineAngle( _centerPoint.x, _centerPoint.y, _bgsPoint.x, _bgsPoint.y );
				_bgeAngle = Common.lineAngle( _centerPoint.x, _centerPoint.y, _bgePoint.x, _bgePoint.y );
				//Log.log( _bgsPoint.x, _bgePoint.x, _minusRadius, _bgsAngle, _bgeAngle );
				
				if( _bgsAngle > _bgeAngle ) _bgeAngle += 360;
				if( _bgsAngle == _bgeAngle ) _bgeAngle += 360;
				//Log.log( _bgsAngle, _bgeAngle );
				graphics.moveTo( _bgsPoint.x, _spoint.y );
				
				while( true ){
					if( _bgsAngle >= _bgeAngle ) {
						_bgsAngle = _bgeAngle;
					}
					
					_tmpPoint =  Common.moveByAngle(  _bgsAngle, _centerPoint, _sradius );
					
					graphics.lineTo( _tmpPoint.x, _tmpPoint.y );
					
					if( _bgsAngle == _bgeAngle ) {
						graphics.lineTo( _bgsPoint.x, _spoint.y );
						break;
					};
					_bgsAngle += 1;
				}
				
			}
			
		}
		


	}
}
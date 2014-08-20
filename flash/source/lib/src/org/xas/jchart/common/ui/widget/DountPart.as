package org.xas.jchart.common.ui.widget
{	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.sensors.Accelerometer;
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
	
	public class DountPart extends Sprite
	{
		private var _centerPoint:Point;
		public function get centerPoint():Point{ return _centerPoint; }
		
		private var _outRadius:Number;
		public function get outRadius():Number{ return _outRadius; }
		
		private var _inRadius:Number;
		public function get inRadius():Number{ return _inRadius; }
		
		private var _lineRadius:Number;
		public function get lineRadius():Number{ return _lineRadius; }
		
		private var _lineInRadius:Number;
		public function get lineInRadius():Number{ return _lineInRadius; }
		
		private var _beginAngle:Number;
		public function get beginAngle():Number{ return _beginAngle; }
		
		private var _endAngle:Number;
		public function get endAngle():Number{ return _endAngle; }
		
		public function get midAngle():Number{ return _beginAngle + ( _endAngle - _beginAngle ) / 2; }
		
		private var _offsetAngle:Number;
		
		private var _style:Object;
		private var _hoverStyle:Object;
		
		private var _dataIndex:int = 0;
		public function get dataIndex():int{ return _dataIndex; }		
		
		private var _lineColor:uint = 0xffffff, _fillColor:uint = 0x000000;
		
		private var _dountSprite:Sprite;

		
		public function DountPart( 
			_centerPoint:Point
			, _beginAngle:Number, _endAngle:Number
			, _outRadius:Number = 100	
			, _inRadius:Number = 90
			, _dataIndex:int = 0
			, _style:Object = null
			, _hoverStyle:Object = null
			, _offsetAngle:Number = 0
		)
		{
			this._centerPoint = _centerPoint;
			this._beginAngle = _beginAngle + _offsetAngle;
			this._endAngle = _endAngle + _offsetAngle;
			this._outRadius = _outRadius;
			this._inRadius = _inRadius;
			this._dataIndex = _dataIndex;
			this._offsetAngle = _offsetAngle;
			
			this._style = _style;
			this._hoverStyle = _hoverStyle;

			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
						
			draw();
		}
		
		private function draw():void{	
			
			ElementUtility.removeAllChild( this );
			addChild( _dountSprite = new Sprite() );
			
			if( _style && _style.color ){
				_lineColor = _style.color;
				_fillColor = _style.color;
			}
			
			drawDount();
		}
		
		private function drawDount():void{			
			_dountSprite.graphics.lineStyle(1, _lineColor);
			_dountSprite.graphics.beginFill( _fillColor );	
			
			var p1:Point, p2:Point, tmpPoint:Point
				, lp:Point, lp2:Point, ltmpPoint:Point
				, countAngle:Number, angleStep:Number 
				;
			
			p1 = GeoUtils.moveByAngle
				( 
					_beginAngle
					, _centerPoint
					, _inRadius 
				)
				;
			_dountSprite.graphics.moveTo( p1.x, p1.y );
			
			countAngle = _beginAngle;
			angleStep = .5;
			
			
			if( _beginAngle > _endAngle ){
				_endAngle += 360;
			}
			
			if( _beginAngle == _endAngle || ( _beginAngle == 0 && _endAngle == 360 ) ){
				_dountSprite.graphics.lineStyle( 1, _fillColor );
			}
			
			if( _beginAngle == _endAngle ){
				_endAngle += 360;		
			}			
			while( true )
			{
				if( countAngle >= _endAngle )
				{
					tmpPoint = GeoUtils.moveByAngle( _endAngle, _centerPoint, _inRadius );
					_dountSprite.graphics.lineTo( tmpPoint.x, tmpPoint.y );
					break;
				}
				tmpPoint = GeoUtils.moveByAngle( countAngle, _centerPoint, _inRadius );
				_dountSprite.graphics.lineTo( tmpPoint.x, tmpPoint.y );
				
				//Log.log( countAngle, _radius );
				
				countAngle += angleStep;
			}
			
			p2 = GeoUtils.moveByAngle
				( 
					_endAngle
					, _centerPoint
					, _outRadius 
				)
				;
			_dountSprite.graphics.lineTo( p2.x, p2.y );
			
			countAngle = _endAngle;
			angleStep = .5;
			
			
			if( _beginAngle > _endAngle ){
				_endAngle += 360;
			}
			
			if( _beginAngle == _endAngle || ( _beginAngle == 0 && _endAngle == 360 ) ){
				_dountSprite.graphics.lineStyle( 1, _fillColor );
			}
			
			if( _beginAngle == _endAngle ){
				_endAngle += 360;		
			}			
			while( true )
			{
				if( countAngle <= _beginAngle )
				{
					tmpPoint = GeoUtils.moveByAngle( _beginAngle, _centerPoint, _outRadius );
					_dountSprite.graphics.lineTo( tmpPoint.x, tmpPoint.y );
					break;
				}
				tmpPoint = GeoUtils.moveByAngle( countAngle, _centerPoint, _outRadius );
				_dountSprite.graphics.lineTo( tmpPoint.x, tmpPoint.y );
				
				//Log.log( countAngle, _radius );
				
				countAngle -= angleStep;
			}
			_dountSprite.graphics.lineTo( p1.x, p1.y );
		}

	}
}
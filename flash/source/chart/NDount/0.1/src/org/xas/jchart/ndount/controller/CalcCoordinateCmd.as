package org.xas.jchart.ndount.controller
{
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.config.NDountConfig;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.test.DefaultPieData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.ndount.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		private var _config:NDountConfig;
		
		public function CalcCoordinateCmd()
		{
			super();
			_config = BaseConfig.ins as NDountConfig;
		}
		
		override public function execute(notification:INotification):void{
			
			_c = _config.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
			
			_c.minX = _c.x;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _c.width - 5;
			_c.maxY = _c.y + _c.height - 5;
						
			facade.registerMediator( new BgMediator( ) )		
			
			//Log.log( _config.rate.length );
			//Log.log( _config.maxNum, _config.finalMaxNum, _config.chartMaxNum, 11111 );
			
			if( _config.cd ){			
				
				if( _config.cd.title && _config.cd.title.text ){
					facade.registerMediator( new TitleMediator( _config.cd.title.text ) )	
					_config.c.title = { x: _c.width / 2, y: _c.minY, item: pTitleMediator };
					_config.c.minY += pTitleMediator.view.height;			
				}
				
				if( _config.cd.subtitle && _config.cd.subtitle.text ){
					facade.registerMediator( new SubtitleMediator( _config.cd.subtitle.text ) )
					
					_config.c.subtitle = { x: _c.width / 2, y: _c.minY, item: pSubtitleMediator };
					_config.c.minY += pSubtitleMediator.view.height + 5;
				}				
				
				if( _config.cd.yAxis && _config.cd.yAxis.title && _config.cd.yAxis.title.text ){
					facade.registerMediator( new VTitleMediator( _config.cd.yAxis.title.text ) )
					
					_config.c.vtitle = { x: _config.c.minX, y: _config.c.x + _config.c.height / 2, item: pVTitleMediator };
					_config.c.minX += pVTitleMediator.view.width - 5;
				}
				
				if( _config.cd.credits && _config.cd.credits.enabled && ( _config.cd.credits.text || _config.cd.credits.href ) ){
					facade.registerMediator( new CreditMediator( _config.cd.credits.text, _config.cd.credits.href ) )
					
					_config.c.credits = { x: _config.c.maxX, y: _config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}	
				
				if( _config.legendEnabled ){
					facade.registerMediator( new LegendMediator() );
					_config.c.maxY -= pLegendMediator.view.height;
					_config.c.legend = { 
						x: _config.width / 2 - pLegendMediator.view.width / 2
						, y: _config.c.maxY
					};
					_config.c.maxY -= 2;
				}
				
				_config.c.maxX -= 5;
				
				_config.c.arrowLength = 0;
				_config.c.chartWidth = _config.c.maxX - _config.c.minX - 5;
				_config.c.chartHeight = _config.c.maxY - _config.c.minY;	
				
				_config.c.chartX = _config.c.minX + _config.c.arrowLength + 6.5;
				_config.c.chartY = _config.c.minY;
				
				_config.c.chartMaxX = _config.c.chartX + _config.c.chartWidth;
				_config.c.chartMaxY = _config.c.chartY + _config.c.chartHeight;
				
				facade.registerMediator( new GraphicBgMediator() );	
				facade.registerMediator( new TipsMediator() );
								
				calcGraphic();	
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new TestMediator( DefaultPieData.instance.data ) );	
				}
				
				//Log.log( _config.c.chartWidth, _config.c.chartHeight );
			}
					
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{			
			
			facade.registerMediator( new PieLabelMediator() );
			facade.registerMediator( new GraphicMediator() );
			
			_config.c.cx = _config.c.chartX + _config.c.chartWidth / 2;
			_config.c.cy = _config.c.chartY + _config.c.chartHeight / 2;
			_config.c.lineLength = 40;
			_config.c.lineStart = 10;
			_config.c.radius = calcRadius( _config.c.chartWidth, _config.c.chartHeight );
			
			_config.c.piePart = [];
			_config.c.pieLine = [];
			
			if( !( _config.series && _config.series.length ) ) return;
			
			var _angle:Number = 360
				, _angleCount:Number = 0
				, _offsetAngle:Number = _config.offsetAngle
				, _totalNum:Number = _config.totalNum
				, _tmpPoint:Point
				, _cpoint:Point = new Point( _config.c.cx, _config.c.cy )
				;
			
			_config.isPercent && ( _totalNum = 100 );

			Common.each( _config.displaySeries, function( _k:int, _item:Object ):void {
				var _pieP:Object = { 
						cx: _config.c.cx
						, cy: _config.c.cy
						, radius: _config.c.radius 
						, offsetAngle: _offsetAngle
						, totalNum: _totalNum
						, data: _item
					}
					, _pieL:Object  = { data: _item }
					;
					
				_pieP.offsetAngle = _offsetAngle;		
				
				if( _item.y == _totalNum ){
					_pieP.angle = _angle;
					_pieP.percent = 100;
				}else{
					_pieP.percent = _item.y / _totalNum * 100;
					_pieP.angle = _item.y / _totalNum * _angle;
				}
				
				_pieP.startAngle = ( 360 - _pieP.angle + _offsetAngle ) % _angle;
				_pieP.midAngle = ( 360 - _pieP.angle / 2 + _offsetAngle ) % _angle;
				_pieP.endAngle = ( 360 + _offsetAngle ) % _angle;
				
				//Log.log( 'aaa', _pieP.startAngle, _pieP.midAngle, _pieP.endAngle );
				
				
				var _spoint:Point = Common.distanceAngleToPoint( _pieP.radius, _pieP.startAngle )
					, _epoint:Point = Common.distanceAngleToPoint( _pieP.radius, _pieP.endAngle )
					, _expoint:Point = Common.distanceAngleToPoint( _pieP.radius + 10, _pieP.midAngle )
					; 
				
				_pieP.startPoint = { x: _spoint.x + _pieP.cx, y: _spoint.y + _pieP.cy };
				_pieP.endPoint = { x: _epoint.x + _pieP.cx, y: _epoint.y + _pieP.cy };
				
				_spoint = Common.distanceAngleToPoint( _pieP.radius - _config.c.lineStart, _pieP.midAngle );
				_epoint = Common.distanceAngleToPoint( _pieP.radius + _config.c.lineLength, _pieP.midAngle );
				
				_pieL.cx = _config.c.cx;
				_pieL.cy = _config.c.cy;
				_pieL.start = { x: _spoint.x + _pieL.cx, y: _spoint.y + _pieL.cy };
				_pieL.end = { x: _epoint.x + _pieL.cx, y: _epoint.y + _pieL.cy };
				_pieL.ex = { x: _expoint.x + _pieL.cx, y: _expoint.y + _pieL.cy };
				
				var _controlX:Number = _pieL.end.x
					, _controlY:Number = _pieL.end.y
					, _minAngle:Number = 2
					;									
					
				if( Math.abs( 270 - _pieP.midAngle ) <= _minAngle ){
					_pieL.direction = "top";
				}else if( ( Math.abs( 360 - _pieP.midAngle ) <= _minAngle ) || _pieP.midAngle <= _minAngle ){
					_pieL.direction = "right";
				}else if( Math.abs( 90 - _pieP.midAngle ) <= _minAngle ){
					_pieL.direction = "bottom";
				}else if( Math.abs( 180 - _pieP.midAngle ) <= _minAngle ){
					_pieL.direction = "left";
				}else{
					//left top
					if( _pieL.end.x < _pieL.cx && _pieL.end.y < _pieL.cy ){
						_controlY -= 5;
						_controlX += 5;
						_pieL.direction = "left_top";
					}
					//right top
					if( _pieL.end.x > _pieL.cx && _pieL.end.y < _pieL.cy ){
						_controlY -= 5;
						_controlX -= 5;
						_pieL.direction = "right_top";
					}
					//left bottom
					if( _pieL.end.x < _pieL.cx && _pieL.end.y > _pieL.cy ){
						_controlY += 5;
						_controlX += 5;
						_pieL.direction = "left_bottom";
					}
					//right bottom
					if( _pieL.end.x > _pieL.cx && _pieL.end.y > _pieL.cy ){
						_controlY += 5;
						_controlX -= 5;
						_pieL.direction = "right_bottom";
					}
				}
				_pieL.control = { x: _controlX, y: _controlY };
				
				/*
				_tmpPath = JC.f.printf( 'M{0} {1}S{2} {3} {4} {5}'
					, _pieL.start.x, _pieL.start.y
					, _controlX, _controlY 
					, _pieL.end.x, _pieL.end.y
				);
				*/
				
				_config.c.piePart.push( _pieP );
				_config.c.pieLine.push( _pieL );
			});
		}
		
		private function calcRadius( _w:Number, _h:Number ):Number{
			var _radius:Number = Math.min( _w, _h );
			
			if( _config.legendEnabled ){
				_radius -= 30;
			}
			
			if( _config.dataLabelEnabled ){
				_radius -= ( _config.c.lineLength - _config.c.lineStart + 40 ) * 2;
			}else{
				_radius -= 0;
			}
			
			_radius /= 2;
			
			return _radius;
		}
		
		private function get pLegendMediator():LegendMediator{
			return facade.retrieveMediator( LegendMediator.name ) as LegendMediator;
		}
		
		private function get pCreditMediator():CreditMediator{
			return facade.retrieveMediator( CreditMediator.name ) as CreditMediator;
		}
		
		private function get pVTitleMediator():VTitleMediator{
			return facade.retrieveMediator( VTitleMediator.name ) as VTitleMediator;
		}
		
		private function get pSubtitleMediator():SubtitleMediator{
			return facade.retrieveMediator( SubtitleMediator.name ) as SubtitleMediator;
		}
		
		private function get pTitleMediator():TitleMediator{
			return facade.retrieveMediator( TitleMediator.name ) as TitleMediator;
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		private function corner():uint{
			return 20;
		}
	}
}
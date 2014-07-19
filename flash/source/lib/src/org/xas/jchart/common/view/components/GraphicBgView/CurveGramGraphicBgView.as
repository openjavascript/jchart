package org.xas.jchart.common.view.components.GraphicBgView
{
	import flash.events.MouseEvent;
	
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;

	public class CurveGramGraphicBgView extends BaseGraphicBgView
	{
		public function CurveGramGraphicBgView()
		{
			super();
		}
		
		override protected function onMouseMove( _evt:MouseEvent ):void{
			//Log.log( 'GraphicView onMouseMove', new Date().getTime() );
			var _point:Object = { x: _evt.stageX, y: _evt.stageY }
				, _rect:Object = { 
					x: BaseConfig.ins.c.chartX
						, y: BaseConfig.ins.c.chartY
						, x2: BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth 
						, y2: BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartHeight 
				}
				, _ix:int = 0
				;
			if( !Common.pointRectangleIntersection( _point, _rect ) ) return;
			
			_ix = ( _point.x  - _rect.x ) / BaseConfig.ins.c.hpart;
			
			var _itemLen:int = ( BaseConfig.ins.categories.length - 1 ) * 2
				, _partWidth:Number = BaseConfig.ins.c.chartWidth / _itemLen
				, _realX:Number = _evt.stageX - BaseConfig.ins.c.chartX
				;
			
			_ix = Math.floor( _realX / _partWidth  );
			_ix > 1 && ( _ix = Math.round( _ix / 2 ) );
			
			/*
			_partWidth = _c.wsWidth / _itemLen;
			_partWhat = Math.floor( _realX / _partWidth  );
			_partWhat > 1 && ( _partWhat = Math.round( _partWhat / 2 ) );
			*/
			
			
			_ix < 0 && ( _ix = 0 );
			if( BaseConfig.ins.cd && BaseConfig.ins.series && BaseConfig.ins.series.length && BaseConfig.ins.series[0].data ){
				_ix >= BaseConfig.ins.series[0].data.length && ( _ix = BaseConfig.ins.series[0].data.length - 1 );
			}
			
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: _ix } ) );
		}
	}
}
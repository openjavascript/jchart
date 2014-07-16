package org.xas.jchart.common
{
	import flash.display.DisplayObject;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.data.Coordinate;

	public class BaseConfig
	{
		protected static var _ins:BaseConfig;
		public static function setIns( _ins:BaseConfig ):BaseConfig{
			return BaseConfig._ins = _ins;
		}
		
		public static function get ins():BaseConfig{
			return BaseConfig._ins;	
		}
		
		protected var _debug:Boolean = false;		
		public function setDebug( _d:Boolean ):Boolean {
			Log.debug = _d;
			return _debug = _d;
		}		
		public function get debug():Object {
			return _debug;
		}
		
		protected var _params:Object;
		public function setParams( _d:Object ):Object {	return _params = _d; }		
		public function get params():Object { return _params;	}		
		public function get p():Object { return _params;	}
		
		
		protected var _chartData:Object;
		public function setChartData( _d:Object ):Object { 
			_chartData = _d;
			calcRate();
			return _d;
		}		
		public function get chartData():Object { return _chartData; }	
		public function get cd():Object {	return _chartData; }
		public function get rateZeroIndex():int{ return _rateZeroIndex; }
		protected var _rateZeroIndex:int = 0; 
		
		protected var _absNum:Number;
		protected var _finalMaxNum:Number;
		public function get finalMaxNum():Number{ return _finalMaxNum; }
		
		protected var _rate:Array;
		public function get rate():Array{ return _rate; }
		
		protected var _maxNum:Number = 0;
		public function get maxNum():Number{ return _maxNum; }
		
		
		public function get chartMaxNum():Number{
			return finalMaxNum * rate[0];
		}
		
		protected var _minNum:Number = 0;
		public function get minNum():Number{ return _minNum; }
		protected function calcminNum():Number{
			var _r:Number = 0, _tmp:Array;
			if( cd && cd.series ){
				_tmp = [];
				Common.each( cd.series, function( _k:int, _item:Number ):*{
					_tmp = _tmp.concat( cd.series[ _k ].data );
				});
				_tmp.length && ( _r = Math.min.apply( null, _tmp ) );
				
				_r > 0 && ( _r = 0 );
				_r < 0 && ( _r = -Common.numberUp( Math.abs( _r ) ) );
			}
			return _r;
		}

		
		public function get floatLen():int{
			var _r:uint = 2;
			
			if( cd && ( 'floatLen' in cd ) ){
				_r = cd.floatLen;
			}
			
			return _r;
		}

					
		protected var _root:DisplayObject;
		public function get root():DisplayObject{ return _root; }
		public function setRoot( _d:* ):DisplayObject{
			_root = _d as DisplayObject;
			_width = _root.stage.stageWidth;
			_height = _root.stage.stageHeight;
			return _root;
		}
		
		protected var _width:uint;
		public function get width():uint{ return _width; }
		
		protected var _height:uint;
		public function get height():uint{ return _height; }
		
		protected var _coordinate:Coordinate
		public function get c():Coordinate{ return _coordinate; }
		public function get coordinate():Coordinate{	return _coordinate;	}
		public function setCoordinate( _d:Coordinate ):Coordinate{
			_coordinate = _d;
			c.width = width;
			c.height = height;
			c.x = 0;
			c.y = 0;
			return _coordinate;
		}
		
		public function get categories():Array{
			var _r:Array = [];
			if( cd && cd.xAxis && cd.xAxis.categories ){
				_r = cd.xAxis.categories;
			}
			return _r;
		}
		
		public function get tipTitlePostfix():String{
			var _r:String = '{0}';
			if( cd && cd.xAxis && ( 'tipTitlePostfix' in  cd.xAxis ) ){
				_r = cd.xAxis.tipTitlePostfix;
			}
			return _r;
		}
		
		public function get series():Array{
			var _r:Array = [];
			if( cd && cd.series && cd.series.length ){
				_r = cd.series;
			}
			return _r;
		}
		
		public function get legendEnabled():Boolean{
			var _r:Boolean = true;
			
			if( cd && cd.legend && ( 'enabled' in cd.legend ) ){
				_r = StringUtils.parseBool( cd.legend.enabled );
			}
			
			return _r;
		}

		
		protected function calcMaxNum():Number{
			var _r:Number = 0, _tmp:Array;
			if( cd && cd.series ){
				_tmp = [];
				Common.each( cd.series, function( _k:int, _item:Number ):*{
					_tmp = _tmp.concat( cd.series[ _k ].data );
				});
				_tmp.length && ( _r = Math.max.apply( null, _tmp ) );
			}
			
			_r < 0 && ( _r = 0 );
			_r > 0 && _r && ( _r = Common.numberUp( _r ) );
			_r === 0 && ( _r = 10 );
			return _r;
		}
		
		
		protected function calcRate():void{
			var _data:Object = _chartData;
			_rate = [];
			if( !_data ) return;
			
			_maxNum = calcMaxNum();
			_minNum = calcminNum();
			_absNum = Math.abs( _minNum );
			_finalMaxNum = Math.max( _maxNum, _absNum );
			
			if( _data && Common.hasNegative( _data.series ) ){				
				if( _maxNum > _absNum ){
					if( Math.abs( _finalMaxNum * 0.33333 ) > _absNum ){
						_rate = [ 1, 0.66666, 0.33333, 0, -0.33333];
						_rateZeroIndex = 3;
					}
				}else{
					if( _maxNum == 0 ){
						_rate = [ 0, -0.25, -0.5, -0.75, -1 ];
						_rateZeroIndex = 0;
					}else if( Math.abs( _finalMaxNum * 0.33333 ) > _maxNum ){
						_rate = [ 0.33333, 0, -0.33333, -0.66666, -1 ];
						_rateZeroIndex = 1;
					}
				}
				if( !_rate.length ){
					_rate = [ 1, .5, 0, -.5, -1 ];
					_rateZeroIndex = 2;
				} 
				
			}else{
				_rate = [1, .75, .5, .25, 0 ];
				_rateZeroIndex = 4;
			}
		}
				
		public function BaseConfig()
		{
		}
	}
}
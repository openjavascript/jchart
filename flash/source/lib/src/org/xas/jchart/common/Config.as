package org.xas.jchart.common
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.data.Coordinate;
	
	/**
	 * ...
	 * @author suches@btbtd.org
	 */
	public class Config 
	{
		private static var _debug:Boolean = false;		
		public static function setDebug( _d:Boolean ):Boolean {
			Log.debug = _d;
			return Config._debug = _d;
		}		
		public static function get debug():Object {
			return Config._debug;
		}
		
		private static var _params:Object;
		public static function setParams( _d:Object ):Object {	return Config._params = _d; }		
		public static function get params():Object { return Config._params;	}		
		public static function get p():Object { return Config._params;	}
		
		private static var _chartData:Object;
		public static function setChartData( _d:Object ):Object { 
			Config._chartData = _d;
			calcRate();
			//Log.log( 'test', _minNum, _maxNum, _absNum, _finalMaxNum );
			//Log.log( _rate );
			return _d;
		}		
		public static function get chartData():Object {	return Config._chartData; }	
		public static function get cd():Object {	return Config._chartData; }
		public static function get rateZeroIndex():int{ return _rateZeroIndex; }
		private static var _rateZeroIndex:int = 0; 
		
		private static function calcRate():void{
			var _data:Object = Config._chartData;
			Config._rate = [];
			if( !_data ) return;
			
			_maxNum = calcMaxNum();
			_minNum = calcminNum();
			_absNum = Math.abs( _minNum );
			_finalMaxNum = Math.max( _maxNum, _absNum );
			
			if( _data && hasNegative( _data.series ) ){				
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
		private static var _absNum:Number;
		private static var _finalMaxNum:Number;
		public static function get finalMaxNum():Number{ return _finalMaxNum; }
		
		private static var _rate:Array;
		public static function get rate():Array{ return Config._rate; }
		
		private static var _maxNum:Number = 0;
		public static function get maxNum():Number{ return _maxNum; }
		private static function calcMaxNum():Number{
			var _r:Number = 0, _tmp:Array;
			if( Config.cd && Config.cd.series ){
				_tmp = [];
				each( Config.cd.series, function( _k:int, _item:Number ):*{
					_tmp = _tmp.concat( Config.cd.series[ _k ].data );
				});
				_tmp.length && ( _r = Math.max.apply( null, _tmp ) );
			}
			_r < 0 && ( _r = 0 );
			_r > 0 && _r && ( _r = numberUp( _r ) );
			_r === 0 && ( _r = 10 );
			return _r;
		}
		
		public static function get chartMaxNum():Number{
			return Config.finalMaxNum * Config.rate[0];
		}
		
		private static var _minNum:Number = 0;
		public static function get minNum():Number{ return _minNum; }
		private static function calcminNum():Number{
			var _r:Number = 0, _tmp:Array;
			if( Config.cd && Config.cd.series ){
				_tmp = [];
				each( Config.cd.series, function( _k:int, _item:Number ):*{
					_tmp = _tmp.concat( Config.cd.series[ _k ].data );
				});
				_tmp.length && ( _r = Math.min.apply( null, _tmp ) );
				
				_r > 0 && ( _r = 0 );
				_r < 0 && ( _r = -numberUp( Math.abs( _r ) ) );
			}
			return _r;
		}
		
		public static function hasNegative( _data:Array ):Boolean{
			var _r:Boolean = false;
			
			if( _data && _data.length ){
				each( _data, function( _ix:int, _item:Object ):*{
					var _tmp:Number = Math.min.apply( null, _item.data );
					if( _tmp < 0 ){
						_r = true;
						return false;
					}
				});
			}
			
			return _r;
		}
		
		public static function get floatLen():int{
			return 2;
		}
		
		
		public static function numberUp( _in:Number, _floatLen:int = 5 ):Number{
			var _out:Number = 0, _inStr:String = _in.toFixed( _floatLen )
				, _part:Array = _inStr.split( '.' )
				, _int:Number = _part[0], _float:Number = parseFloat( '0.' + _part[ 1 ] )
				, _ar:Array
				, i:int, j:int, tmp:Number
				;
			
			//Log.log( 'xxxxxx', _int.toString() );
			
			if( /[1-9]/.test( _int.toString( ) ) ){
				tmp = Math.pow( 10, _int.toString().length - 1  ), _out = tmp * ( parseInt( _int.toString().charAt(0 )) +  1);
				if( _out < _in ){
					_out = tmp * 10;
				}
				
			}else{						
				for( _ar = _float.toFixed( _floatLen ).split(''), i = 0, j = _ar.length; i < j; i++ ){
					if( _ar[i] != '0' && _ar[i] != '.' ){
						tmp = parseFloat( _ar.slice( 0, i ).join('') + '1'  )
							, _out = tmp + parseFloat( _ar.slice( 0, i ).join('') + parseInt( _ar[i] )  )
							;
						if( _out < _float ){
							_out = tmp * 10;
						}
						
						break;
					}
				}
			}
			
			return _out;
		}
		
		/**
		 * 取小数点的N位
		 * <br />JS 解析 浮点数的时候，经常出现各种不可预知情况，这个函数就是为了解决这个问题
		 * @method  parseFinance
		 * @static
		 * @param   {number}    _i
		 * @param   {int}       _dot, default = 2
		 * @return  number
		 */
		public static function parseFinance( _i:Number, _dot:int = 2 ):Number{
			_i = parseFloat( _i.toString() ) || 0;
			_i && ( _i = parseFloat( _i.toFixed( _dot ) ) );
			return _i;
		}


		public static function each( _items:*, _cb:Function ):*{
			var i:int, j:int, k:String;
			
			if( 'length' in _items ){				
				for( i = 0, j = _items.length; i < j; i++ ){
					if( _cb( i, _items[ i ] ) === false ) break;
				}				
			}else{
				for( k in _items ){
					if( _cb( k, _items[ k ] ) === false ) break;
				}
			}
			
			return _items;
		}
		
		private static var _root:DisplayObject;
		public static function get root():DisplayObject{ return _root; }
		public static function setRoot( _d:* ):DisplayObject{
			Config._root = _d as DisplayObject;
			_width = Config._root.stage.stageWidth;
			_height = Config._root.stage.stageHeight;
			return Config._root;
		}
		
		private static var _width:uint;
		public static function get width():uint{ return _width; }
		
		private static var _height:uint;
		public static function get height():uint{ return _height; }
				
		private static var _coordinate:Coordinate
		public static function get c():Coordinate{ return _coordinate; }
		public static function get coordinate():Coordinate{	return _coordinate;	}
		public static function setCoordinate( _d:Coordinate ):Coordinate{
			Config._coordinate = _d;
			Config.c.width = width;
			Config.c.height = height;
			Config.c.x = 0;
			Config.c.y = 0;
			return Config._coordinate;
		}
		
		public static function get categories():Array{
			var _r:Array = [];
			if( Config.cd && Config.cd.xAxis && Config.cd.xAxis.categories ){
				_r = Config.cd.xAxis.categories;
			}
			return _r;
		}
		
		public static function isNegative( _num:Number ):Boolean{
			return _num < 0;
		}

	}
	
	
	
}
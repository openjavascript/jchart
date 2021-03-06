package org.xas.jchart.common
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.xas.jchart.common.Common;
	
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import org.xas.core.utils.Log;
	
	public class Common
	{		
		
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
			
		public static function isNegative( _num:Number ):Boolean{
			return _num < 0;
		}
		
		public static function　pointRectangleIntersection( p:Object, r:Object ):Boolean {
			return p.x >= r.x && p.x <= r.x2 && p.y >= r.y && p.y <= r.y2;
		}
		
		
		
		/**
		 * 逗号格式化金额
		 * @method  moneyFormat
		 * @param   {int|string}    _number
		 * @param   {int}           _len
		 * @param   {int}           _floatLen
		 * @param   {int}           _splitSymbol
		 * @return  string
		 * @static
		 */
		public static function moneyFormat(_number:*, _len:uint = 3, _floatLen:uint = 2, _splitSymbol:String = ',' ):String{
			var _def:String = '0.00';
			!_len && ( _len = 3 );
			!_splitSymbol && ( _splitSymbol = ',' );
			var _isNegative:Boolean = false, _r:String;
			
			
			_number = parseFinance( _number, _floatLen );
			
			if( typeof _number == 'string' ){
				_number = _number.replace( /[,]/g, '' );
				if( !/^[\d\.]+$/.test( _number ) ) return _def;
				if( _number.split('.').length > 2 ) return _def;
			}
			
			_number = _number || 0;
			_number += ''; 
			
			/^\-/.test( _number ) && ( _isNegative = true );
			
			_number = _number.replace( /[^\d\.]/g, '' );
			
			var _parts:Array = _number.split('.'), _sparts:Array = [];
			
			while( _parts[0].length > _len ){
				var _tmp:String = _parts[0].slice( _parts[0].length - _len, _parts[0].length );
				//console.log( _tmp );
				_sparts.push( _tmp );
				_parts[0] = _parts[0].slice( 0, _parts[0].length - _len );
			}
			_sparts.push( _parts[0] );
			
			_parts[0] = _sparts.reverse().join( _splitSymbol );
			
			if( _floatLen ){
				!_parts[1] && ( _parts[1] = '' );
				_parts[1] += new Array( _floatLen + 1 ).join('0');
				_parts[1] = _parts[1].slice( 0, _floatLen );
			}else{
				_parts.length > 1 && _parts.pop();
			}
			_r = _parts.join('.');
			_isNegative && ( _r = '-' + _r );
			
			return _r;
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
		
		/**
		 * 扩展对象属性
		 * @method  extendObject
		 * @param   {object}    _source
		 * @param   {object}    _new
		 * @param   {bool}      _overwrite      是否覆盖已有属性, default = true  
		 * @return  object
		 * @static
		 */
		public static function extendObject( _source:Object, _new:Object, _overwrite:Boolean = true ):Object{
			if( _source && _new ){
				for( var k:String in _new ){
					if( _overwrite ){
						_source[ k ] = _new[ k ];
					}else if( !( k in _source ) ){
						_source[ k ] = _new[ k ];
					}
				}
			}
			return _source;
		}
		
		public static function implementStyle( _txf:TextField
											  	, _styleList:Array
												, _autoSize:String = TextFieldAutoSize.LEFT 
												  , _selectable:Boolean = false
												  , _mouseEnabled:Boolean = true
												
		):TextField{
		
			if( _styleList && _styleList.length ){
				var _style:Object = {}, _tf:TextFormat = new TextFormat();
				Common.each( _styleList, function( _k:int, _item:Object ):void{
					_style = extendObject( _style, _item );
				});
				
				Common.each( _style, function( _k:String, _item:* ):void{
					_tf[ _k ] = _item;
				});
				
				_txf.setTextFormat( _tf );
				_txf.defaultTextFormat = _tf;
			}
			_txf.selectable = _selectable;
			_txf.mouseEnabled = _mouseEnabled;
			_txf.autoSize = _autoSize;
			
			return _txf;
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
		
		/**
		 * 从长度和角度求坐标点
		 * @method  distanceAngleToPoint
		 * @param  {Number} _distance
		 * @param  {Number} _angle
		 * @return Point
		 * @static
		 */
		public static function distanceAngleToPoint( _distance:Number, _angle:Number ):Point{
			var _radian:Number = Common.radians( _angle );					
			return new Point(
				Math.cos( _radian  ) * _distance
				, Math.sin( _radian ) * _distance
			)
		}
		/**
		 * 从角度获取弧度
		 * @method  radians
		 * @param   {Number} _angle
		 * @return  {Number}
		 * @static
		 */
		public static function radians( _angle:Number ):Number{ return _angle * Math.PI / 180; }
		/**
		 * 从弧度获取角度
		 * @method  degree
		 * @param   {Number} _radians
		 * @return  {Number}
		 * @static
		 */
		public static function degree( _radians:Number ):Number{ return _radians / Math.PI * 180; }

		public static function isFloat( _num:Number ):Boolean{
			_num = Math.abs( _num );
			return ( _num - parseInt( _num + '' ) ) > 0;
		}
		
		/**
		 * 判断两个矩形是否有交集
		 */
		public static function intersectRect( r1:Object, r2:Object ):Boolean {
			return !(
				r2.x > ( r1.x + r1.width ) || 
				( r2.x + r2.width ) < r1.x || 
				r2.y > ( r1.y + r1.height ) ||
				( r2.y + r2.height ) < r1.y
			);
		}
		
		/**
		 * 把坐标和宽高生成一个 rectangle 数据
		 */
		public static function locationToRect( _x:Number, _y:Number, _width:Number, _height:Number ):Object{
			var _r:Object = {
				'left': _x
				, 'top': _y
				, 'right': _x + _width
					, 'bottom': _y + _height 
			};
			return _r;
		}
		/**
		 * 把 rectangle 数据 转换为 中心点坐标数据
		 */
		public static function rectToCenterPoint( _rect:Object ):Object{
			var _r:Object = {
				'x': _rect.left + _rect.width / 2
					, 'y': _rect.top + _rect.height / 2
			};
			return _r;
		}
		public static function displayToCenterPoint( _display:*, _side:int = 0, _offsetX:Number = 0, _offsetY:Number = 0 ):Object{
			var _do:DisplayObject = _display as DisplayObject, _r:Object = { x: 0, y: 0 };			
			if( _do ){
				switch( _side ){
					case 1: //right bottom
					{
						_r = { 'x': _do.x + _do.width + _offsetX, 'y': _do.y + _do.height + _offsetY };
						break;
					}
					case 2: //right mid
					{
						_r = { 'x': _do.x + _do.width + _offsetX, 'y': _do.y + _do.height / 2 + _offsetY };
						break;
					}
					case 3: //left mid
					{
						_r = { 'x': _do.x + _offsetX, 'y': _do.y + _do.height / 2 + _offsetY };
						break;
					}
					case 4: //left bottom
					{
						_r = { 'x': _do.x + _offsetX, 'y': _do.y + _do.height  + _offsetY };
						break;
					}
					case 5: //center bottom
					{
						_r = { 'x': _do.x + _do.width / 2 + _offsetX, 'y': _do.y + _do.height  + _offsetY };
						break;
					}
					case 6: //center top
					{
						_r = { 'x': _do.x + _do.width / 2 + _offsetX, 'y': _do.y + _offsetY };
						break;
					}
					case 7: //center mid
					{
						_r = { 'x': _do.x + _do.width / 2 + _offsetX, 'y': _do.y + _offsetY };
						break;
					}
					default: 
					{						
						_r = { 'x': _do.x + _do.width / 2 + _offsetX, 'y': _do.y + _do.height / 2 +_offsetY };
						break;
					}
						
				}
			};
			return _r;
		}

		public static function lineLength( x1:Number, y1:Number, x2:Number, y2:Number ):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			
			return Math.sqrt( dx * dx + dy * dy );
		}
		
		/**
		 * 求两点之间连线的角度
		 */
		public static function lineAngle(px1:Number, py1:Number, px2:Number, py2:Number):Number 
		{
			//两点的x、y值
			var x:Number = px2-px1;
			var y:Number = py2-py1;
			var h:Number = 0;
			var radian:Number = 0;
			var angle:Number = 0;
			var cos:Number = 0;
			
			h = Math.sqrt(Math.pow(x, 2)+Math.pow(y, 2));
			//斜边长度
			cos = x/h;
			radian = Math.acos(cos);
			//求出弧度
			angle = 180/(Math.PI/radian);
			//用弧度算出角度    
			if (y<0) {
				angle = -angle;
			} else if ((y == 0) && (x<0)) {
				angle = 180;
			}
			
			angle = fixAngle( angle );
			
			return angle;
		}
		
		public static function fixAngle($angle:Number):Number
		{
			if( $angle < 0 ) $angle = 360 + $angle;
			return $angle;
		}
		
		
		public static function moveByAngle( $angle:Number, $centerPoint:Point, $diameter:Number ):Point
		{
			var result:Point = new Point(0, 0);
			var radian:Number;
			
			radian = $angle * Math.PI / 180;					
			result.x = $centerPoint.x + Math.cos( radian  ) * $diameter;
			result.y = $centerPoint.y + Math.sin( radian ) * $diameter;
			
			return result;
		}
		
		public static function floatLen( _n:* ):int{
			var _s:String = parseFinance( _n || 0, 10 ) + '', _r:int = 0, _ar:Array;
			_ar = _s.split( '.' );
			if(_ar.length > 1 ){
				//Log.log( _n, _ar[1], _s );
				_ar[1].length > _r && ( _r = _ar[1].length );
			}
			return _r;
		}
	}
}
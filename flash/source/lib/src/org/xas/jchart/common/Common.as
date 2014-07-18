package org.xas.jchart.common
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.xas.jchart.common.Common;
	
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
			
			if( !_number ) return _def;
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
	}
}
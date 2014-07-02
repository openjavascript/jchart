package org.xas.core.utils
{
	public final class StringUtils
	{
		public function StringUtils()
		{
		}
		
		public static function trim($v:String):String
		{
			return $v.replace(/^[\s]*|[\s]*$/g, '' );
		}

		public static function pad( data:*, how:int = 4, char:String = '0' ):String
		{
			data = data.toString();
			var temp:String = new Array( how + 1 ).join( char ) + data;
			var result:String = temp.slice( temp.length - how );
			
			return result;				
		}
				
		public static function format(number_i:*, len_i:int = 3, symbol_s:String = ','):String
		{/* shawl.qiu code, return string; func: number_comma_f */
			if(!len_i) len_i=3;
			if(!symbol_s) symbol_s=',';
			if(!number_i)return '0';
			number_i += '';
			var ar:Array = number_i.split('.');
			number_i = number_comma_f(ar[0], len_i, symbol_s);
			ar[1] && ( number_i += '.' + ar[1] );
			return number_i;
		}/* function fStrFormat(number_i, len_i, symbol_s) */
		
		public static function number_comma_f(str:String, len_i:int, symbol_s:String):String
		{/* shawl.qiu code, return string, func:none */
			var temp:String='', str_len_i:int=str.length; 
			while(str_len_i>len_i){temp=symbol_s+str.slice(str_len_i-=len_i, str_len_i+len_i)+temp;} 
			if(str_len_i>0&&str_len_i<=3) temp=str.slice(0, str_len_i)+temp;
			return temp;
		}/* function number_comma_f(str, len_i, symbol_s) */
		

		public static function parseBool( _input:Object ):Boolean{
			if( typeof _input == 'string' ){
				_input = _input.replace( /[\s]/g, '' ).toLowerCase();
				if( _input && ( _input == 'false' 
								|| _input == '0' 
								|| _input == 'null'
								|| _input == 'undefined'
			   )) _input = false;
			   else if( _input ) _input = true;
			}
			return !!_input;
		}
	}
}
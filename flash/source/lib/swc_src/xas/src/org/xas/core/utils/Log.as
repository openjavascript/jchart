package org.xas.core.utils
{
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.*;

	/**
	 * 用于打印调试 内容的类
	 * @author 		suches@btbtd.org
	 */
	public final class Log
	{
		public static var debug:Boolean = false;
		
		/**
		 * 输出内容到控制台
		 * <p>本系统所有输出到控制台的内容,都使用该函数</p>
		 * @param $log	要输出到控制台的内容
		 * @param $pad	在输出内容里添加多少个符号
		 * @param $before	添加的 符号放在前面还是后面
		 * @param $symbol	自定义要添加的符号
		 */
		public static function print( $log:*, $pad:int = 0, $before:Boolean = true, $symbol:String = '-' ):void
		{	
			if(!debug) return;
			processLog($log, $pad, $before, $symbol);
		}		
		
		public static function log( ...args ):void{
			if(!debug) return;
			trace( args.join(' ' ) );
		}
		
		public static function  printJSON( _d:Object, $pad:int = 0, $before:Boolean = true, $symbol:String = '-' ):void{
			if(!debug) return;
			processLog( JSON.encode( _d ), $pad, $before, $symbol);
		}
		
		public static function  printClass( _d:*, $pad:int = 0, $before:Boolean = true, $symbol:String = '-' ):void{
			if(!debug) return;
			processLog( flash.utils.describeType( _d ).toString(), $pad, $before, $symbol);
		}
		
		public static function  printObject( _d:*, $pad:int = 0, $before:Boolean = true, $symbol:String = '-' ):void{
			if(!debug) return;
			processLog( JSON.encode( _d as Object ), $pad, $before, $symbol);			
		}
		
		public static function marker( $log:*, $pad:int = 50, $symbol:String = '#' ):void
		{			
			if(!debug) return;
			
			var pad:String = '';
			if( $pad > 0 ){ pad = new Array($pad+1).join($symbol) };
			
			trace( pad, $log, pad );
		}
		
		/**
		 * 输出内容到控制台
		 * <p>打印错误信息, 该函数的信息总是会打印到控制台</p>
		 * @param $log	要输出到控制台的内容
		 * @param $pad	在输出内容里添加多少个符号
		 * @param $before	添加的 符号放在前面还是后面
		 * @param $symbol	自定义要添加的符号
		 */
		public static function error( $log:*, $pad:int = 0, 
									  $before:Boolean = true, $symbol:String = '-' ):void
		{		
			var padString:String = new Array( 50 ).join( '*' );
			
			processLog( [padString, $log, padString].join(''), $pad, $before, $symbol);
		}
		
		private static function processLog( $log:*, $pad:int = 0, 
									 $before:Boolean = true, $symbol:String = '-' ):void
		{
			var pad:String = '';
			if( $pad > 0 ){ pad = new Array($pad+1).join($symbol) };
			
			if( pad )
			{
				if( $before )
				{
					trace( pad, $log );
				}
				else
				{
					trace( $log, pad );
				}
			}
			else
			{
				trace( $log );
			}
		}
	}
}

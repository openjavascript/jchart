package org.xas.core.utils
{
	public class ArrayUtils
	{
		/**
		 * 数据拼加
		 */
		public static function plus( $array:Array ):Number
		{
			var result:Number = 0;
			
			for( var i:int = 0, j:int = $array.length; i < j; i++ )
			{
				result += $array[i];
			}
			
			return result;
		}
		/**
		 * 把数组里的数据转换为浮点数
		 */
		public static function toFloat($ar:Array):Array
		{
			for( var i:int = 0, j:int = $ar.length; i < j; i++ )
			{
				$ar[i] = parseFloat( ($ar[i]||0)+'' );
			}
			return $ar;
		}
		public static function toInt($ar:Array, radix:int = 10):Array
		{
			for( var i:int = 0, j:int = $ar.length; i < j; i++ )
			{
				$ar[i] = parseInt( ($ar[i]||0)+'', radix );
			}
			return $ar;
		}
		
		/**
		 * 拷贝数组 , 除了特定索引
		 */
		public static function arrayCopyExcept( $ar:Array, $ix:int ):Array
		{
			var r:Array = [];			
			r = $ar.slice();
			r.splice( $ix, 1 );			
			return r;
		}
		
		public static function getArrayByKey( $list:*, $key:String ):Array
		{
			var r:Array = [];
			
			for( var i:int = 0; i < $list.length; i++ )
			{
				r.push( $list[i][$key] );
			}
			
			return r;
		}
		
	}
}
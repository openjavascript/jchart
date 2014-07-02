package org.xas.core.utils
{
	public class DigitalUtils
	{
		public function DigitalUtils()
		{
		}
		
		public static function random( $lower:int, $upper:int ):int
		{
			var temp:Number = Math.random() * ($upper - $lower + 1) + $lower;			
			return int(temp);
		}
		
		public static function randomNumber( $lower:Number, $upper:Number ):Number
		{
			var temp:Number = Math.random() * ($upper - $lower) + $lower;			
			return temp;
		}
		
		public static function intUp( $num:int ):int
		{
			var temp:int = ($num.toString().length - 1);
			if( temp <= 0 ) temp = 1;
			
			var pw:int = Math.pow( 10, temp );
			var small:Number = $num / pw - Math.floor( $num / pw );
			
			if( small > 0 )
			{
				$num = ( Math.floor( $num / pw ) + 1 ) * pw; 
			}
			
			return $num;
		}
	}
}
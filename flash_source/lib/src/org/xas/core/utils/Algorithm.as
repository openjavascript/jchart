package org.xas.core.utils
{
	import flash.geom.Point;

	public class Algorithm
	{
		public function Algorithm()
		{
		}
		
		public static function scale( $sourceWidth:Number, 
									  $sourceHeight:Number, $targetWidth:Number ):Number
		{ 
			return $targetWidth * ( $sourceHeight/$sourceWidth );
		}
		
		public static function scaleHeight( $sourceWidth:Number, 
									  $sourceHeight:Number, $targetWidth:Number ):Number
		{ 
			return $targetWidth * ( $sourceHeight/$sourceWidth );
		}
		
		public static function scaleWidth( $sourceWidth:Number, 
									  $sourceHeight:Number
									  , $targetWidth:Number
		):Number
		{ 
			return $targetWidth * ( $sourceWidth/$sourceHeight );
		}
	}
}
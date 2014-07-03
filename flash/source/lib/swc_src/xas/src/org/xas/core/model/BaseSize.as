package org.xas.core.model
{
	public class BaseSize
	{		
		public var width:Number;
		public var height:Number;
		
		public function BaseSize( $w:Number = 0, $h:Number = 0 )
		{
			width = $w;
			height = $h;
		}
		
		public function clone():BaseSize
		{
			return new BaseSize( width, height );
		}
	}
}
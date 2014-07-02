package org.xas.core.model.size
{
	public class FlatSize
	{
		public var left:Number = 0;
		public var right:Number = 0;
		public var top:Number = 0;
		public var bottom:Number = 0;
		
		public function FlatSize($left:Number = 0, $right:Number = 0, $top:Number = 0, $buttom:Number = 0)
		{
			left = $left;
			right = $right;
			top = $top;
			bottom = $buttom;
		}
	}
}
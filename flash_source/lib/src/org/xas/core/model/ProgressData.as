package org.xas.core.model
{
	public class ProgressData
	{
		public var bytesLoaded:uint = 0;
		public var bytesTotal:uint = 0;
		
		public function ProgressData( $bytesLoaded:uint = 0, $bytesTotal:uint = 0 )
		{
			bytesLoaded = $bytesLoaded;
			bytesTotal = $bytesTotal;
		}
		
		public function get percent():uint
		{
			return Math.ceil( bytesLoaded / bytesTotal * 100);
		}
		/**
		 * 把类内容输出为Object
		 */
		public function getData():Object
		{
			var result:Object = {
				bytesLoaded	: bytesLoaded,
				bytesTotal	: bytesTotal,
				percent		: percent
			};
			return result;
		}
	}
}
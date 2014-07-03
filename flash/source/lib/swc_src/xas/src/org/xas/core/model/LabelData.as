package org.xas.core.model
{
	public class LabelData
	{
		public var label:String;
		public var data:String;
		public var labelColor:uint;
		public var textColor:uint;
		
		public function LabelData( $label:String, $data:String = ''
								   , $labelColor:uint = 0x22AC38, $textColor:uint = 0x000000 )
		{
			label = $label;
			data = $data;
			labelColor = $labelColor;
			textColor = $textColor; 
		}
	}
}
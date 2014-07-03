package org.xas.core.model
{
	public class KeyValueData
	{
		public var key:String;
		public var value:*;
		
		private var _data:Object;
		
		private var _keyLabel:String = 'key';
		private var _valueLabel:String = 'value';
		
		public function KeyValueData( $data:Object, $keyLabel:String = '', $valueLabel:String = '' )
		{
			_data = $data;
			
			_keyLabel = $keyLabel || _keyLabel;
			_valueLabel = $valueLabel || _valueLabel;
			
			init();
		}
		
		private function init():void
		{
			key = _data[ _keyLabel ];
			value = _data[ _valueLabel ];
		}
	}
}
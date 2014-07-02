package org.xas.core.model
{
	public class JsPackData
	{
		public var type:String = '';
		public var data:*;
		
		public function JsPackData($type:String, $data:* = null)
		{
			type = $type;
			data = $data;
		}
		
		public function getData():Object
		{
			return {
				type: type,
				data: data
			};
		}
	}
}
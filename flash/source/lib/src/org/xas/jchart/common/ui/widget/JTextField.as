package org.xas.jchart.common.ui.widget
{
	import flash.text.TextField;
	
	public class JTextField extends TextField
	{
		private var _data:Object;
		public function get data():Object{ return _data; }
		public function set data( _data:Object ):void{ this._data = _data; }
		
		public function JTextField( _data:Object = null )
		{
			super();
			this._data = _data;
		}
	}
}
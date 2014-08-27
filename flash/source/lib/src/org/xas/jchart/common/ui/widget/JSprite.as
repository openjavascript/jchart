package org.xas.jchart.common.ui.widget
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class JSprite extends Sprite
	{
		private var _data:Object;
		public function get data():Object{ return _data; }
		public function set data( _data:Object ):void{ this._data = _data; }
		
		public function JSprite( _data:Object = null )
		{
			super();
			this._data = _data;
		}
	}
}
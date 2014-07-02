package org.xas.core.model
{
	import org.xas.core.i.IContextMenu;

	public class ContextMenuData implements IContextMenu
	{
		private var _text:String;
		public function get text():String{ return _text; }
		public function set text($v:String):void{ _text = $v; }
		
		private var _enable:Boolean;
		public function get enable():Boolean{ return _enable; }
		public function set enable($v:Boolean):void{ _enable = $v; }
		
		public function ContextMenuData( $text:String, $enable:Boolean )
		{
			text = $text;
			enable = $enable;
		}
	}
}
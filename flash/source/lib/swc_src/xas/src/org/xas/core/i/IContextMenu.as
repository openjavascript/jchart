package org.xas.core.i
{
	public interface IContextMenu
	{
		function get text():String;
		function set text($v:String):void;
		
		function get enable():Boolean;
		function set enable($v:Boolean):void;
	}
}
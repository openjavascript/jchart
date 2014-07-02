package org.xas.core.utils
{	
	import flash.display.DisplayObjectContainer;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.xas.core.i.IContextMenu;
	
	public class SystemUtils
	{
		
		public static function contentmenu( $root:DisplayObjectContainer, $list:Vector.<IContextMenu> ):ContextMenu
		{			
			var cm:ContextMenu;
			var cmi:ContextMenuItem;
			var icm:IContextMenu;
			
			if( $list && $list.length )
			{
				cm = new ContextMenu();		
				
				for( var i:int = 0; i < $list.length; i++ )
				{
					icm = $list[i];
					cmi = new ContextMenuItem( icm.text );
					cmi.enabled = icm.enable;
					cm.customItems.push(cmi);
				}
				$root.contextMenu = cm;	
			}
			
			return cm;
		}
	}
}
package org.xas.core.ui.nav
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.xas.core.ui.button.XButton;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	
	public class NavLinks extends Sprite
	{
		public function NavLinks()
		{
			super();
		}
		
		public function update( $current:int, $pageTotal:int, $total:int ):void
		{
			reset();
			Log.print( 'NavLinks.update: ' );
			Log.print( $current +', ' + $pageTotal + ', ' +$total );
			
			var beginPosition:int = Math.ceil( $current / $pageTotal ) * $pageTotal + 1 - $pageTotal;
			
			var i:int, j:int;
			
			for( i = 0; i < $pageTotal; i++ )
			{
				var now:int = beginPosition + i;
				
				if( now > $total ) break;
				
				var item:XButton = new XButton( now + '' ); 				
				addChild( item );
				
				item.x = i * 27;				
				if( now === $current )
				{
					item.setTextStyle( {color:0xffff00} );
					item.isCurrent = true;
				}
				
				item.addEventListener(MouseEvent.CLICK, onItemClick);
			}
		}
		
		private function onItemClick($evt:Event):void
		{
			Log.print( 'NavLinks.onItemClick: ' );
			
			var nowItem:XButton = XButton( $evt.currentTarget );
			
			//if( nowItem.isCurrent ) return; 			
			for( var i:int = 0, j:int = this.numChildren; i < j; i++ )
			{
				var item:* = this.getChildAt(i);				
				//Log.print( 'item is XButton: ' + (item is XButton));
				if( !(item is XButton) ) continue;
				item.isCurrent = false;
				item.setTextStyle( {color:0xffffff} );
			}
			
			nowItem.isCurrent = true;	
			nowItem.setTextStyle( {color:0xffff00} );		
			dispatchEvent
			( 
				new NavigatorEvent( NavigatorEvent.ON_ITEM_CLICK, parseInt(nowItem.text) ) 
			);
		}
		
		private function reset():void
		{
			ElementUtility.removeAllChild( this );
		}
	}
}
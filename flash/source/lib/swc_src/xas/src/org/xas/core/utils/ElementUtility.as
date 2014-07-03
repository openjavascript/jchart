package org.xas.core.utils
{
	import flash.display.DisplayObject;

	public final class ElementUtility
	{
		public function ElementUtility()
		{
		}
		
		/*********************************************************
		 * 清除给定对象的所有子容器
		 * @param	disp 显示对象
		 * @date	2010-
		 * @author 	邱少伟
		 **********************************************************/
		public static function removeAllChild( disp:* ):void
		{
			try
			{				
				while( disp.numChildren )
				{
					var child:* = disp.getChildAt( 0 );
					if( child )
					{
						disp.removeChild( child );	
					}					
					child = null;
				}	
			}
			catch(ex:Error){}
		}
		
		public static function center($v:DisplayObject):void
		{
			$v.x = ($v.root.stage.stageWidth - $v.width) / 2;
			$v.y = ($v.root.stage.stageHeight - $v.height) / 2;
		}
		
		public static function topIndex($display:DisplayObject):void
		{
			try{ $display.parent.addChild( $display ); } catch( ex:Error ){}
		}
	}
}
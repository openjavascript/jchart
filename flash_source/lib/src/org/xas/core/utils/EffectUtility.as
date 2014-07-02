package org.xas.core.utils
{
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class EffectUtility
	{
		public function EffectUtility()
		{
		}
		
		/*********************************************************
		 * 对一个文本框的字体产生阴影效果
		 * @param	arg			要产生滤镜效果的文本框
		 * @param	formats		一个包含特定参数的 Object
		 * <p>
		 * 		textShadow( _textField, { font: 'Verdana', color: 0x000000, size: 12 }, 0x000000 );
		 * </p>
		 * @param	filterColor	阴影的颜色, 默认值为 0x000000
		 * @date	2010-
		 * @author 	邱少伟
		 **********************************************************/
		public static function textShadow( arg:TextField, formats:Object = null, 
										   filterColor:int = 0x000000 ):void
		{
			formats = formats || {};
			
			if( typeof( formats.font ) == 'undefined' ){ formats.font = 'Verdana'; }
			if( typeof( formats.color ) == 'undefined' ){ formats.color = 0x000000; }
			if( typeof( formats.size ) == 'undefined' ){ formats.size = 12; }
			
			var tf:TextFormat = new TextFormat();
			
			for( var key:String in formats )
			{
				tf[ key ] = formats[ key ];
			}
			
			arg.setTextFormat( tf );
			arg.defaultTextFormat = tf;
			
			arg.filters = [new GlowFilter(filterColor, 1, 2, 2, 16)];
		}
		
		public static function textFormat( arg:TextField, formats:Object = null ):void
		{
			formats = formats || {};
			
			if( typeof( formats.font ) == 'undefined' ){ formats.font = 'Verdana'; }
			if( typeof( formats.color ) == 'undefined' ){ formats.color = 0x000000; }
			if( typeof( formats.size ) == 'undefined' ){ formats.size = 12; }
			
			var tf:TextFormat = new TextFormat();
			
			for( var key:String in formats )
			{
				tf[ key ] = formats[ key ];
			}
			
			arg.setTextFormat( tf );
			arg.defaultTextFormat = tf;
			
			//arg.filters = [new GlowFilter(filterColor, 1, 2, 2, 16)];
		}
	}
}
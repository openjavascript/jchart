package org.xas.core.ui.text.xmovingtext
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Model extends EventDispatcher
	{
		private var _w:Number = 100;
		public function get width():Number{ return _w; }
		public function set width($w:Number):void{ _w = $w; }
		
		private var _h:Number = 30;
		public function get height():Number{ return _h; }
		
		private var _queue:Vector.<String> = new Vector.<String>();
		public function get queue():Vector.<String>{ return _queue; }
		
		public function Model( $w:Number, $h:Number )
		{
			_w = $w;
			_h = $h;
		}
		
		public function add( $text:String ):void
		{
			_queue.push( $text );
		}
		
		public function getText():String
		{
			var r:String = '';
			
			while( _queue.length )
			{
				r = _queue[0];
				_queue.shift();
				
				if( r.length ) break;				
			}
			
			return r;
		}
	}
}
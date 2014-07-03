package org.xas.core.ui.text.xmovingtext
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	
	public class View extends Sprite
	{
		private var _model:Model;
		
		private var _text:TextField;
		private var _textFormat:TextFormat;
		
		private var _timer:Timer;
		private var _spaceWidth:Number;
		
		public function View( $model:Model )
		{
			_model = $model;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}
		
		private function init():void
		{
			var rect:Rectangle = new Rectangle( 0, 0, _model.width, _model.height );
			this.scrollRect = rect;
						
			addChild( _text = new TextField() );
			
			_text.height = 30;
			_text.wordWrap = false;
			_text.textColor = 0xffffff;
			_text.autoSize = TextFieldAutoSize.LEFT;
			//_text.htmlText = '<b>xxx</b>';
			
			_textFormat = new TextFormat();
			_textFormat.font = 'arial';
			_textFormat.bold = true;
			_textFormat.letterSpacing = 2;
			_textFormat.size = 14;
			_textFormat.leading = 3;
			
			_timer = new Timer( 10 );
			_timer.addEventListener( TimerEvent.TIMER, onTimer);
			_text.addEventListener(MouseEvent.ROLL_OUT,_mouseHandler);
			_text.addEventListener(MouseEvent.ROLL_OVER,_mouseHandler);
			_text.htmlText = ' ';
			_spaceWidth = _text.width;
			_text.htmlText = '';
			_text.selectable = false;
			
			_text.filters =
				[
					new GlowFilter(0xffffff,1,0,0,0,1)
				];
			
			this.filters =
				[
					new GlowFilter(0xFF6666,1,4,4,2.5,1)
				];
			
			var styleContent:Array = [];			
			styleContent.push( "a{ text-docaration:underline; }" );
			
			_text.styleSheet = new StyleSheet();
			_text.styleSheet.parseCSS( styleContent.join( '\n' ) );
//			_text.defaultTextFormat = _textFormat;
//			_text.setTextFormat( _textFormat );
		}
		private function _mouseHandler(e:MouseEvent):void
		{
			switch(e.type){
				case MouseEvent.ROLL_OUT:
					_timer.start();
					break;
				case MouseEvent.ROLL_OVER:
					_timer.stop();
					break;
			}
		}
		public function setSize($w:Number):void
		{
			_model.width = $w;
			var rect:Rectangle = new Rectangle( 0, 0, _model.width, _model.height );
			this.scrollRect = rect;
		}
		
		public function update():void
		{
			if( !_timer.running )
			{
				var text:String = _model.getText();
				
				if( !text ) 
				{
					this.dispatchEvent
						(
							new Event( XMovingTextEvent.PLAY_DONE ) 
						);
					return;
				}
				else
				{
					this.dispatchEvent
						(
							new Event( XMovingTextEvent.PLAY ) 
						);
				}
					
				
				_text.x = _model.width;				
				_text.htmlText = '<p>'+text+'</p>' 
				_timer.start();
			}
		}
		
		private function onTimer($evt:TimerEvent):void
		{
			if( _text.x + _text.width <= 0 )
			{
				_timer.stop();
				_text.htmlText = '';
				_text.x = _model.width;
				trace('done');
				update();
			}
			else
			{
				_text.x -= 1;
			}
		}
	}
}
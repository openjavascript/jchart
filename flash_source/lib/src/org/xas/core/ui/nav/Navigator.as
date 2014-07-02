package org.xas.core.ui.nav
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.xas.core.events.BaseEvent;
	import org.xas.core.i.IVisible;
	import org.xas.core.ui.button.XButton;
	import org.xas.core.ui.layout.BaseBg;
	import org.xas.core.ui.nav.INav;
	import org.xas.core.ui.text.XHtmlLabel;
	import org.xas.core.utils.Log;
	
	public class Navigator extends Sprite implements INav, IVisible
	{
		private var _navLinks:NavLinks;
		private var _navHolder:Sprite;
		private var _statusHolder:Sprite;
		
		private var _bg:BaseBg;
		
		private var _pageTotal:int = 10;
		private var _total:int;
		private var _current:int;
		
		private var _offsetPos:Point = new Point( 20, 5 );
		private var _itemSpace:Point = new Point( 5, 10 );
		
		private var _firstBtn:XButton, _prevTenBtn:XButton, _prevBtn:XButton
					, _nextBtn:XButton, _nextTenBtn:XButton, _lastBtn:XButton;
					
		private var _closeBtn:XButton;
		
		private var _width:Number = 310;
		private var _height:Number = 104;
		
		private var _statusLabel:XHtmlLabel;
		
		private var _preX:Number = 0;
		private var _preY:Number = 0;
		
		public function Navigator( $total:int = 0, $current:int = 1 )
		{
			_total = $total;
			_current = $current;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}
		
		private function init():void
		{
			addChild( _bg = new BaseBg() );
			addChild( _navLinks = new NavLinks() );
			addChild( _navHolder = new Sprite() );
			addChild( _statusHolder = new Sprite() );
			
			_navHolder.addChild( _firstBtn = new XButton('首页') );
			_navHolder.addChild( _prevTenBtn = new XButton('上一页') );
			_navHolder.addChild( _prevBtn = new XButton('上一个') );
			_navHolder.addChild( _nextBtn = new XButton('下一个') );
			_navHolder.addChild( _nextTenBtn = new XButton('下一页') );
			_navHolder.addChild( _lastBtn = new XButton('末页') );
			
			_statusHolder.addChild( _closeBtn = new XButton('关闭') );
			_statusHolder.addChild( _statusLabel = new XHtmlLabel( '' ) );
						
			initAction();
			initPosition();
			initEvent();
		}
		
		private function initAction():void
		{
			if( _total > 0 )
			{
				_navLinks.update( _current, _pageTotal, _total );	
			}			
			
			updateStatus();
		}
		private function updateStatus():void
		{
			var s:String =
				[
					_current
					, _total
				]
				.join('/');
			
			_statusLabel.text = s;
			_statusLabel.setTextStyle( {color:0xffff00} );
		}
		
		private function initPosition():void
		{						
			_statusHolder.x = _offsetPos.x;
			_statusHolder.y = _offsetPos.y;
			
			_closeBtn.x = _width - _offsetPos.x * 2 - _closeBtn.width;
			
			_navLinks.y = _statusHolder.y + _statusHolder.height + _itemSpace.y;			
			_navLinks.x = (_width - _navLinks.width) / 2 ;
			
			_navHolder.x = _offsetPos.x;
			_navHolder.y = _navLinks.y + _navHolder.height + _itemSpace.y;
			
			_firstBtn.x = 0;
			_prevTenBtn.x = _firstBtn.x + _firstBtn.width + _itemSpace.x;
			_prevBtn.x = _prevTenBtn.x + _prevTenBtn.width + _itemSpace.x;
			_nextBtn.x = _prevBtn.x + _prevBtn.width + _itemSpace.x;
			_nextTenBtn.x = _nextBtn.x + _nextBtn.width + _itemSpace.x;
			_lastBtn.x = _nextTenBtn.x + _nextTenBtn.width + _itemSpace.x;
						
			_bg.resize( _width, _height );
		}
		
		private function initEvent():void
		{			
			_firstBtn.addEventListener(MouseEvent.CLICK, onFirst);
			_prevTenBtn.addEventListener(MouseEvent.CLICK, onPrevTen);
			_nextTenBtn.addEventListener(MouseEvent.CLICK, onNextTen);
			_prevBtn.addEventListener(MouseEvent.CLICK, onPrev);
			_nextBtn.addEventListener(MouseEvent.CLICK, onNext);
			_lastBtn.addEventListener(MouseEvent.CLICK, onLast);
			
			_navLinks.addEventListener(NavigatorEvent.ON_ITEM_CLICK, onItemClick);
			
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClick);	
			_bg.addEventListener(MouseEvent.MOUSE_DOWN, onBgDown);
		}
		private function onItemClick($evt:NavigatorEvent):void
		{
			Log.print( 'Navigator.onItemClick: ' );
			Log.print( $evt.data );		
			dispatchEvent
			( 
				new NavigatorEvent( NavigatorEvent.ON_ITEM_CLICK, $evt.data ) 
			);
		}
		private function onBgDown($evt:MouseEvent):void
		{
			_preX = root.stage.mouseX - this.x;
			_preY = root.stage.mouseY - this.y;
			
			root.stage.addEventListener(MouseEvent.MOUSE_UP, onBgUp);			
			root.stage.addEventListener(MouseEvent.MOUSE_MOVE, onBgMove);
		}
		
		private function onBgUp($evt:MouseEvent):void
		{
			root.stage.removeEventListener(MouseEvent.MOUSE_UP, onBgUp);			
			root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onBgMove);
			
			var pos:Point = new Point( this.x, this.y );
			this.dispatchEvent( new NavigatorEvent( NavigatorEvent.ON_POPUP_POSITION_CHANGE, pos) );
		}
		private function onBgMove($evt:MouseEvent):void
		{			
			var newX:Number = root.stage.mouseX - _preX;
			var newY:Number = root.stage.mouseY - _preY;
			
			var maxX:Number = root.stage.stageWidth - this.width;			
			var maxY:Number = root.stage.stageHeight - this.height;
			
			if( newX <= 0)
			{
				newX = 0;
			}
			if( newY <= 0)
			{
				newY = 0;
			}
			
			if( newX >= maxX )
			{
				newX = maxX;
			}
			
			if( newY >= maxY )
			{
				newY = maxY;
			}
			
			this.x = newX;
			this.y = newY;
		}
		private function onCloseBtnClick($evt:Event):void
		{
			Log.print( 'Navigator.onCloseBtnClick: ' );
			dispatchEvent( new NavigatorEvent( NavigatorEvent.ON_CLOSE ) );
			hide();
		}
		private function onFirst($evt:MouseEvent):void
		{
			if( _total < 1 ) return;
			_current = 1;
			updateLinks();
			onItemClick( new NavigatorEvent( NavigatorEvent.ON_ITEM_CLICK, _current ) );
		}
		private function onLast($evt:MouseEvent):void
		{
			if( _total < 1 ) return;
			_current = _total;
			updateLinks();
			onItemClick( new NavigatorEvent( NavigatorEvent.ON_ITEM_CLICK, _current ) );
		}
		private function onPrev($evt:MouseEvent):void
		{
			Log.print( 'Navigator.onPrev: ' );
			
			var next:int = _current-1;			
			if( next >= 1 )
			{
				_current = next;
				updateLinks();
				onItemClick( new NavigatorEvent( NavigatorEvent.ON_ITEM_CLICK, _current ) );
			}
		}
		
		private function onNext($evt:MouseEvent):void
		{
			Log.print( 'Navigator.onNext: ' );
			
			var next:int = _current+1;			
			if( next <= _total )
			{
				_current = next;
				updateLinks();
				onItemClick( new NavigatorEvent( NavigatorEvent.ON_ITEM_CLICK, _current ) );
			}
		}
		
		private function onPrevTen($evt:MouseEvent):void
		{
			Log.print( 'Navigator.onPrevTen: ' );
			
			var itemPos:int = _current % _pageTotal;
			
			var begin:int = Math.ceil( _current / _pageTotal ) * _pageTotal + itemPos - _pageTotal;
			
			var next:int = begin - (itemPos>0?_pageTotal:0);
			
			if( next >=1 )
			{
				_current = next;
				updateLinks();
				onItemClick( new NavigatorEvent( NavigatorEvent.ON_ITEM_CLICK, _current ) );
			}
		}
		
		private function onNextTen($evt:MouseEvent):void
		{
			Log.print( 'Navigator.onNextTen: ' );
			
			var itemPos:int = _current % _pageTotal;
			var begin:int = Math.ceil( _current / _pageTotal ) * _pageTotal + itemPos - _pageTotal;
			var next:int = begin + _pageTotal;
			
			if( !itemPos )  next += _pageTotal;
			
			if( next > _total )
			{
				var mod:int = next % _pageTotal===0?_pageTotal:next % _pageTotal;
				next = next - mod + 1 ;
			}
			
			if( next <= _total )
			{
				_current = next;
				updateLinks();
				onItemClick( new NavigatorEvent( NavigatorEvent.ON_ITEM_CLICK, _current ) );
			}
		}
		private function updateLinks():void
		{
			_navLinks.update( _current, _pageTotal, _total );		
			_navLinks.x = (_width - _navLinks.width) / 2 ;	
			updateStatus();
		}
		
		private function reset():void
		{
			
		}
		
		public function update( $total:int, $current:int = 0 ):void
		{
			_total = $total;
			if( _total < 1 ) return;
			if( $current >= 1 ) _current = $current;
			if( _current === 0 ) _current = _total;
			updateLinks();
		}
		public function hide():void
		{
			this.visible = false;
		}
		public function show():void
		{
			this.visible = true;
		}
		public function toggle():void
		{
			this.visible = !this.visible;	
		}
	}
}
package org.xas.core.ui.tips
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.model.LabelData;
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.ElementUtility;
	
	public class GraphicTips extends Sprite
	{
		private var _label:String;
		private var _labelColor:uint;
		private var _items:Vector.<LabelData>;
		
		private var _contentBox:Sprite;
		private var _dataTf:Vector.<TextField>;
		private var _labelTf:Vector.<TextField>;
		
		private var _titleFontSize:int = 12;
		private var _offsetX:int = 9;
		private var _offsetY:int = 4;
		public function get titleFontSize():int{ return _titleFontSize; }
		public function set titleFontSize( $v:int ):void{ _titleFontSize = $v; }
		
		public function GraphicTips()
		{
			init();
		}
		
		private function init():void
		{
			addChild( _contentBox = new Sprite() );
			_contentBox.mouseEnabled = false;
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			this.filters = [ new DropShadowFilter( 4, 45, 0xaaaaaa) ];
		}
		
		public function update( $label:String, $items:Vector.<LabelData>
								, $labelColor:uint = 0x9C8C41, _displayPercent:Boolean = false ):void
		{
			_label = $label;
			_items = $items;
			_labelColor = $labelColor;
			
			process( _displayPercent );
		}
		
		private function process( _displayPercent:Boolean = false ):void
		{			
			graphics.clear();
			ElementUtility.removeAllChild( _contentBox ); 
			
			var label:TextField;
			
			if( _label )
			{
				label = new TextField();
				label.mouseEnabled = false;
				label.selectable = false;
				label.autoSize = TextFieldAutoSize.LEFT;
				label.text = _label +'';
				EffectUtility.textFormat( label, { color: _labelColor, size: _titleFontSize } );
				label.y = 3;
				label.x = _offsetX;
				_contentBox.addChild( label );
				
				offsetY += label.height + 0;
			}
			_offsetY = offsetY;
			
			var offsetY:Number = 4;
			var bodyBox:Sprite = new Sprite();
			_contentBox.addChild( bodyBox );
			bodyBox.y = label.y + label.height + 4;
			
			if( _items && _items.length )
			{
				var labelMaxWidth:Number = 0;
				var maxWidth:Number = 0;
				_dataTf = new Vector.<TextField>();
				_labelTf = new Vector.<TextField>();
				for( var i:int = 0; i < _items.length; i++ )
				{
					var item:LabelData = _items[i];
					
					label = new TextField();
					label.mouseEnabled = false;
					label.selectable = false;
					label.autoSize = TextFieldAutoSize.LEFT;
					label.text = item.label;					
					EffectUtility.textFormat( label, { color: item.labelColor } );
					label.y = offsetY;
					label.x = _offsetX;
					bodyBox.addChild( label );
					if( label.width > labelMaxWidth )
					{
						labelMaxWidth = label.width;
					}
					_labelTf.push( label );
					
					var _dstr:String = item.data
						, _dnum:Number = Number( item.data )
						;
					if( _displayPercent ){
						_dstr = (_dnum * 100).toFixed(10);
						_dstr = _dstr.replace( /[0]+$/, '').replace( /[\.]+$/, '' ) + '%';
					}
					
					
					var data:TextField = new TextField();
					data.mouseEnabled = false;
					data.selectable = false;
					data.autoSize = TextFieldAutoSize.LEFT;
					data.text = _dstr;
					EffectUtility.textFormat( data, { color: item.textColor, bold: false } );
					data.y = offsetY;
					data.x = label.x + label.width + 15;
					bodyBox.addChild( data );
					
					_dataTf.push( data );
					if( data.width > maxWidth )
					{
						maxWidth = data.width;
					}
					offsetY += label.height + 0;
				}
				
				for( i = 0; i < _labelTf.length; i++ )
				{
					if( _labelTf[i].width < labelMaxWidth )
					{
						_labelTf[i].x += (labelMaxWidth - _labelTf[i].width);
					}
				}
				
				for( i = 0; i < _dataTf.length; i++ )
				{
					_dataTf[i].x = labelMaxWidth + 15 + maxWidth - _dataTf[i].width;
				}
			}
			
			
			var bgW:int = _contentBox.width + 20;
			var bgH:int = _contentBox.height + 12;
			
			graphics.lineStyle( 1, 0xEAE1C0 );
			graphics.beginFill( 0xFAF1CA );
			graphics.drawRoundRectComplex(  0, 0, bgW, bgH, 5, 5, 0, 0 );
			graphics.endFill();
						
			bodyBox.graphics.lineStyle( 0, 0, 0 );
			bodyBox.graphics.beginFill( 0xFFFAE4 );
			bodyBox.graphics.drawRoundRectComplex(  0, 0, bgW, bodyBox.height + 10, 0, 0, 8, 8 );
			bodyBox.graphics.endFill();
			
			bodyBox.graphics.lineStyle( 1, 0xEAE1C0 );
			bodyBox.graphics.moveTo( 0, 0 );
			bodyBox.graphics.lineTo( bgW, 0 );
		}
	}
}
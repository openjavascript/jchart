package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class TipsUI extends Sprite
	{
		/*
		{
			"items":[
				{"name":"Temperature","value":-30}
				,{"name":"Rainfall1","value":-20}
				,{"name":"Rainfall2","value":-20}
				,{"name":"Rainfall3","value":-20}
			]
			,"name":"9月"
		}
		*/
		private var _data:Object;
		private var _layout:Sprite;
		
		private var _nameTxf:TextField;
		private var _valTxf:TextField;
		
		private var _eleData:Object;
		
		public function TipsUI()
		{
			super();
			
			visible = false;
			addChild( _layout = new Sprite() );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );	
		}
		
		public function update( _data:Object, _position:Point = null ):TipsUI{
			_position && dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { data: _data, point: _position } ) );
			return this;
		}
		
		public function show( _position:Point = null ):TipsUI{
			_position && dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { point: _position } ) );
			visible = true;
			return this;
		}
		
		public function hide():TipsUI{
			visible = false;
			return this;
		}
		
		public function buildLayout( _data:Object ):TipsUI{			
			this._data = _data;
			_layout.graphics.clear();
			graphics.clear();
			ElementUtility.removeAllChild( _layout );
			
			_layout.addChild( _nameTxf = new TextField() );
			Common.implementStyle( _nameTxf, [ DefaultOptions.tooltip.style ] );
			
			_nameTxf.text = _data.name || '';
						
			var _offsetY:Number = 10
				, _y:Number = _offsetY + _nameTxf.height
				;
			
			_eleData = {
				name: _nameTxf
				, items: []
			};
			
			if( _data.items ){
				Common.each( _data.items, function( _k:int, _item:Object ):void{
					if( !_item ) return;					
					var _styles:Object = { color: BaseConfig.ins.itemColor( _k ) };
					
					_layout.addChild( _nameTxf = new TextField() );
					_nameTxf.text = _item.name
					Common.implementStyle( _nameTxf, [ _styles ] );
					_nameTxf.y = _y;
					
					
					_layout.addChild( _valTxf = new TextField() );
					_valTxf.text = _item.value;
					Common.implementStyle( _valTxf, [ _styles ] );
					_valTxf.y = _y;
					
					_y += _nameTxf.height;
					
					Common.implementStyle( _nameTxf, [ _styles ] );

					_eleData.items.push( { 'name': _nameTxf, 'value': _valTxf } );
				});

			}
			
			updateLayout();
			
			return this;
		}
		
		private function updateLayout( _data:Object = null ):void{
			
			if( !_eleData ) return;
			
			_layout.graphics.clear();
			graphics.clear();
			graphics.beginFill( 0xffffff, .9 );
			graphics.lineStyle( 2, 0x999999 );
			
			_nameTxf = _eleData.name as TextField;
			
			var _nameMaxLen:Number = 0
				, _valueMaxLen:Number = 0
				, _offsetX:Number = 15
				, _offsetY:Number = 10
				, _y:Number = _offsetY + _nameTxf.height
				;
			
			_nameTxf.x = _offsetX;
			_nameTxf.y = _offsetY;
			
			if( _data ){
				_nameTxf.text = _data.name;
			}
			
			Common.each( _eleData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_nameTxf.text = _data.items[ _k ].name;
					_valTxf.text = _data.items[ _k ].value;					
				}
				
				_nameTxf.width > _nameMaxLen && ( _nameMaxLen = _nameTxf.width );
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			
			Common.each( _eleData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				_nameTxf.x = _offsetX * 2;					
				_valTxf.x = _offsetX * 3 + _nameMaxLen + ( _valueMaxLen - _valTxf.width );
			});
			
			graphics.drawRoundRect( 
				0, 0
				, _layout.width + _offsetX * 2
				, _layout.height + _offsetY * 2
				, 10, 10 
			);
		}
		
		private function updateTips( _evt:JChartEvent ):void{
			var _point:Point = _evt.data.point as Point
				, _data:Object = _evt.data.data as Object
				;
			if( !_point ) return;
			
			updateLayout( _data );
			
			var _x:Number = _point.x + 15
				, _y:Number = _point.y + 18
				, _x2:Number = _x + this.width
				, _y2:Number = _y + this.height
				;
			
			if( _x2 >= root.stage.x + root.stage.width ){
				_x = _point.x - this.width;
			}
			
			if( _y2 >= root.stage.y + root.stage.height ){
				_y = _point.y - this.height;
			}
			
			_x < 0 && ( _x = 0 );
			_y < 0 && ( _y = 0 );
			
			//Log.log( _x2, root.stage.x + root.stage.width );
			
			this.x = _x;
			this.y = _y;
			//Log.log( 'TipsUI updateTips', _point.x, _point.y );
		}
	}
}
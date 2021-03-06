package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.EffectUtility;
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
		
		private var _serialData:Object;
		private var _afterSerialData:Object;
				
		public function TipsUI()
		{
			super();
			
			visible = false;
			addChild( _layout = new Sprite() );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );	
		}
		
		public function update( _data:Object, _position:Object = null, _colors:Array = null, _rect:Object = null ):TipsUI{
			_position && dispatchEvent( 
				new JChartEvent( JChartEvent.UPDATE_TIPS, { data: _data, point: _position, colors: _colors, rect: _rect } ) 
			);
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
	
			//Log.printJSON( _afterSerial  );
			
			_layout.graphics.clear();
			graphics.clear();
			ElementUtility.removeAllChild( _layout );
			
			_layout.addChild( _nameTxf = new TextField() );
			Common.implementStyle( _nameTxf, [ { bold: true }, DefaultOptions.tooltip.style ] );
			
			_nameTxf.text = _data.name || '';
						
			var _offsetY:Number = 15
				, _y:Number = _offsetY + _nameTxf.height
				;
			
			_eleData = {
				name: _nameTxf
				, items: []
			};
			
			_serialData = {
				items: []
			};
			
			_afterSerialData = {
				items: []
			};
			
			if( _data.beforeItems ){
				Common.each( _data.beforeItems, function( _k:int, _item:Object ):void{
					if( !_item ) return;					
					var _styles:Object = { color: BaseConfig.ins.tooptipSerialItemColor( _k ) };
					
					_layout.addChild( _nameTxf = new TextField() );
					_nameTxf.text = _item.name + ': ';
					Common.implementStyle( _nameTxf, [ _styles ] );
					_nameTxf.y = _y;
					
					
					_layout.addChild( _valTxf = new TextField() );
					_valTxf.text = '0';
					Common.implementStyle( _valTxf, [ _styles ] );
					_valTxf.y = _y;
					
					_y += _nameTxf.height;
					
					Common.implementStyle( _nameTxf, [ _styles ] );
					
					_serialData.items.push( { 'name': _nameTxf, 'value': _valTxf } );
				});
			}
			
			if( _data.items ){
				Common.each( _data.items, function( _k:int, _item:Object ):void{
					if( !_item ) return;					
					var _styles:Object = { color: BaseConfig.ins.itemColor( _k ) };
					
					_layout.addChild( _nameTxf = new TextField() );
					_nameTxf.text = _item.name + ': ';
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
			
			if( _data.afterItems && _data.afterItems.length ){
				Common.each( _data.afterItems, function( _k:int, _item:Object ):void{
					if( !_item ) return;					
					var _styles:Object = { color: BaseConfig.ins.tooptipAfterSerialItemColor( _k ) };
					
					_layout.addChild( _nameTxf = new TextField() );
					_nameTxf.text = _item.name + ': ';
					Common.implementStyle( _nameTxf, [ _styles ] );
					_nameTxf.y = _y;
					
					
					_layout.addChild( _valTxf = new TextField() );
					_valTxf.text = '0';
					Common.implementStyle( _valTxf, [ _styles ] );
					_valTxf.y = _y;
					
					_y += _nameTxf.height;
					
					Common.implementStyle( _nameTxf, [ _styles ] );
					_afterSerialData.items.push( { 'name': _nameTxf, 'value': _valTxf } );
				});
			}
			
			/*
			_exEleData = [];
			Common.each( _extendData, function( _k:int, _item:Object ):void{
				//Log.log( 'tooltip serial ' );
				if( !_item ) return;		
				//Log.log( 'tooltip serial 1' );			
				var _styles:Object = { color: 0x999999 };
				
				_layout.addChild( _nameTxf = new TextField() );
				_nameTxf.text = _item.name + ': ';
				Common.implementStyle( _nameTxf, [ _styles ] );
				_nameTxf.y = _y;
				
				
				_layout.addChild( _valTxf = new TextField() );
				_valTxf.text = _item.value;
				Common.implementStyle( _valTxf, [ _styles ] );
				_valTxf.y = _y;
				
				_y += _nameTxf.height;
				
				Common.implementStyle( _nameTxf, [ _styles ] );
				
				_exEleData.push( { 'name': _nameTxf, 'value': _valTxf } );
			});
			*/
			
			updateLayout();
			
			return this;
		}
		
		private function updateLayout( _data:Object = null, _colors:Array = null ):void{
			
			if( !_eleData ) return;
			
			_layout.graphics.clear();
			graphics.clear();
			graphics.beginFill( 0xffffff, .95 );
			graphics.lineStyle( 1, 0x999999, .35 );
			
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
			
			Common.each( _serialData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_nameTxf.text = _data.beforeItems[ _k ].name + ': ';		
					_valTxf.text = _data.beforeItems[ _k ].value;		
				}
				
				_nameTxf.width > _nameMaxLen && ( _nameMaxLen = _nameTxf.width );
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			Common.each( _eleData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_nameTxf.text = _data.items[ _k ].name + ': ';		
					_valTxf.text = _data.items[ _k ].value;		
				}
				
				_nameTxf.width > _nameMaxLen && ( _nameMaxLen = _nameTxf.width );
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			Common.each( _afterSerialData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_nameTxf.text = _data.afterItems[ _k ].name + ': ';		
					_valTxf.text = _data.afterItems[ _k ].value;		
				}
				
				_nameTxf.width > _nameMaxLen && ( _nameMaxLen = _nameTxf.width );
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			
			
			Common.each( _serialData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				_nameTxf.x = _offsetX * 2 + _nameMaxLen - _nameTxf.width;					
				_valTxf.x = _offsetX * 3 + _nameMaxLen + ( _valueMaxLen - _valTxf.width );
			});
			
			Common.each( _eleData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				_nameTxf.x = _offsetX * 2 + _nameMaxLen - _nameTxf.width;					
				_valTxf.x = _offsetX * 3 + _nameMaxLen + ( _valueMaxLen - _valTxf.width );
			});
			
			Common.each( _afterSerialData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				_nameTxf.x = _offsetX * 2 + _nameMaxLen - _nameTxf.width;					
				_valTxf.x = _offsetX * 3 + _nameMaxLen + ( _valueMaxLen - _valTxf.width );
			});
			
			/*
			Common.each( _exEleData, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				_nameTxf.x = _offsetX * 2 + _nameMaxLen - _nameTxf.width;	
				_valTxf.x = _offsetX * 3 + _nameMaxLen + ( _valueMaxLen - _valTxf.width );
			});
			*/
			
			if( _colors && _colors.length ){
				if( _colors.length === 1 ){
					Common.each( _eleData.items, function( _k:int, _item:Object ):void{
						_nameTxf = _item.name as TextField;
						_valTxf = _item.value as TextField;
						
						/*
						EffectUtility.textShadow( _nameTxf, { color: 0xffffff }, _colors[0] );
						EffectUtility.textShadow( _valTxf, { color: 0xffffff }, _colors[0] );
						*/
						
						_nameTxf.textColor = _colors[0];
						_valTxf.textColor = _colors[0];
					});
				}else{
					
				}
			}
			
			graphics.drawRoundRect( 
				0, 0
				, _layout.width + _offsetX * 2
				, _layout.height + _offsetY * 2
				, 10, 10 
			);
		}
		
		private function updateTips( _evt:JChartEvent ):void{
			var _point:Object = _evt.data.point as Object
				, _data:Object = _evt.data.data as Object
				, _colors:Array = _evt.data.colors as Array
				, _rect:Object = _evt.data.rect as Object
				;
			if( !_point ) return;
			
			updateLayout( _data, _colors );
			
			if( _rect ){
				rectPosition( _point, _rect );
			}else{
				normalPosition( _point, _rect );
			}
		}
		
		private function normalPosition( _point:Object, _rect:Object ):void{
			
			var _x:Number = _point.x + 15
				, _y:Number = _point.y + 18
				, _x2:Number = _x + this.width
				, _y2:Number = _y + this.height
				;
			
			if( _x2 >= root.stage.x + root.stage.stageWidth ){
				_x = _point.x - this.width;
			}
			
			if( _y2 >= root.stage.y + root.stage.stageHeight ){
				_y = _point.y - this.height;
			}
			
			_x < 0 && ( _x = 0 );
			_y < 0 && ( _y = 0 );
			
			//Log.log( _x2, root.stage.x + root.stage.width );
			
			//Log.log( _x, _y, this.width, this.height, _y + this.height, _y2, this.root.stage.stageHeight );
			
			this.x = _x;
			this.y = _y;
			//Log.log( 'TipsUI updateTips', _point.x, _point.y );
			
		}
		
		private function rectPosition( _point:Object, _rect:Object ):void{
			
			var _x:Number = _rect.x + _rect.width
				, _y:Number = _point.y 
				, _x2:Number = _x + this.width
				, _y2:Number = _y + this.height
				;
			
			if( _x2 >= root.stage.x + root.stage.width ){
				_x = _rect.x - this.width;
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
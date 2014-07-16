package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class TipsUI extends Sprite
	{
		/*
		{
			"data":[
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
		
		private var _tmpTxf:TextField;
		private var _tmpTxf1:TextField;
		
		public function TipsUI()
		{
			super();
			
			visible = false;
			addChild( _layout = new Sprite() );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );	
		}
		
		public function update( _data:Object, _position:Point = null ):TipsUI{
			_position && dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, _position ) );
			return this;
		}
		
		public function show( _position:Point = null ):TipsUI{
			_position && dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, _position ) );
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
			
			_layout.addChild( _tmpTxf = new TextField() );
			_tmpTxf.autoSize = TextFieldAutoSize.LEFT;
			_tmpTxf.text = _data.name || '';
			
			var _tmpData:Array = []
				, _nameMaxLen:Number = 0
				, _valueMaxLen:Number = 0
				, _offsetX:Number = 15
				, _offsetY:Number = 10
				, _y:Number = _offsetY + _tmpTxf.height
				;
			
			_tmpTxf.x = _offsetX;
			_tmpTxf.y = _offsetY;
			
			if( _data.data ){
				Config.each( _data.data, function( _k:int, _item:Object ):void{
					
					_layout.addChild( _tmpTxf = new TextField() );
					_tmpTxf.text = _item.name
					_tmpTxf.autoSize = TextFieldAutoSize.LEFT;
					_tmpTxf.y = _y;
					
					_layout.addChild( _tmpTxf1 = new TextField() );
					_tmpTxf1.text = _item.value
					_tmpTxf1.autoSize = TextFieldAutoSize.LEFT;
					_tmpTxf1.y = _y;
					
					_y += _tmpTxf.height;
					
					_tmpTxf.width > _nameMaxLen && ( _nameMaxLen = _tmpTxf.width );
					_tmpTxf1.width > _valueMaxLen && ( _valueMaxLen = _tmpTxf1.width );

					_tmpData.push( { 'name': _tmpTxf, 'value': _tmpTxf1 } );
				});
				
				Config.each( _tmpData, function( _k:int, _item:Object ):void{
					_tmpTxf = _item.name as TextField;
					_tmpTxf1 = _item.value as TextField;
					
					_tmpTxf.x = _offsetX * 2;					
					_tmpTxf1.x = _offsetX * 3 + _nameMaxLen + ( _valueMaxLen - _tmpTxf1.width );
				});
			}
			
			graphics.beginFill( 0xffffff, .8 );
			graphics.lineStyle( 2, 0x999999 );
			
			graphics.drawRoundRect( 
				0, 0
				, _layout.width + _offsetX * 2
				, _layout.height + _offsetY * 2
				, 10, 10 
			);
			
			return this;
		}
		
		private function updateTips( _evt:JChartEvent ):void{
			var _point:Point = _evt.data as Point;
			if( !_point ) return;
			
			this.x = _point.x + 15;
			this.y = _point.y + 18;
			//Log.log( 'TipsUI updateTips', _point.x, _point.y );
		}
	}
}
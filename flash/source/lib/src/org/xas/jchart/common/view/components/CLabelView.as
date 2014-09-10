package org.xas.jchart.common.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	public class CLabelView extends Sprite
	{
		private var _labels:Vector.<Sprite>;
		public function get labels():Vector.<Sprite>{ return _labels; }
		
		private var _maxHeight:Number = 0;
		public function get maxHeight():Number{ return _maxHeight; }
		
		private var _config:Config;
		
		public function CLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
		}
		
		private function addToStage( _evt:Event ):void{
			_labels = new Vector.<Sprite>();
			var _v:Number, _t:String, _titem:TextField, _nitem:TextField, _itemWidth:Number, _sp:Sprite;
			if( !( _config.displaySeries && _config.displaySeries.length ) ) return;
			
			_itemWidth = _config.c.radius * 2 -  _config.displaySeries.length * _config.radiusStep * 2 - 20;

			Log.log( _config.floatLen );
			//[{"y":45,"name":"全体覆盖率"},{"y":35,"name":"样本覆盖率"}]
			Common.each( _config.displaySeries, function( _k:int, _item:* ):*{
				_t = Common.moneyFormat( _item.y + '', 3, _config.floatLen );
				
				if( _config.isPercent ) _t += '%';
				
				_sp = new Sprite();
				_sp.x = 10000;
				
				_nitem = new TextField();
				_nitem.text = _t;
				_nitem.autoSize = TextFieldAutoSize.LEFT;
				
				_titem = new TextField();
				_titem.text = _item.name;
				_titem.autoSize = TextFieldAutoSize.LEFT;
				//_titem.width = _itemWidth;
				//_titem.wordWrap = true;
				_titem.y = _nitem.height + 2;

				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.xAxis.labels.style
					, _config.labelsStyle
					, { color: _config.itemColor( _k ), size: 14  }
				] );
				
				Common.implementStyle( _nitem, [
					DefaultOptions.title.style
					, DefaultOptions.xAxis.labels.style
					, _config.labelsStyle
					, { color: _config.itemColor( _k ), size: 18, font: 'Verdana'  }
				] );
				
				
				if( !_config.displayAllLabel ){
					if( !( _k in _config.labelDisplayIndex ) ){
						_titem.visible = false;
						_nitem.visible = false;
					}
				}
				
				_sp.addChild( _nitem );
				_sp.addChild( _titem );
				addChild( _sp );
				
				_labels.push( _sp );
				
				_titem.height > _maxHeight && ( _maxHeight = _titem.height );
			});		
			//Log.log( '_maxHeight', _maxHeight );
		}
		
		public function update():void{
			if( !( _labels && _labels.length ) ) return;
			var _space:Number = _config.radiusStep * _config.displaySeries.length + 20;
			
			//Log.log( _config.c.cx, _config.c.radius, _space );
			
			switch( _config.displaySeries.length ){
				case 1:
				{
					_labels[0].x = _config.c.cx - _labels[0].width / 2;
					_labels[0].y = _config.c.cy - _labels[0].height / 2;
					break;
				}
					
				case 2:
				{
					Log.log( _config.c.cx, _config.c.radius, _labels[1].width, _space );
					_labels[0].x = _config.c.cx - _config.c.radius + _space;
					_labels[0].y = _config.c.cy - _labels[0].height;
					
					_labels[1].x = _config.c.cx + _config.c.radius - _labels[1].width - _space;
					_labels[1].y = _config.c.cy;
					break;
				}
			}
		}
	}
}
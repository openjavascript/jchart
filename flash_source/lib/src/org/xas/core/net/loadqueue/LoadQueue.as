package org.xas.core.net.loadqueue
{
	import org.xas.core.events.*;
	import org.xas.core.model.HttpResultData;
	import org.xas.core.model.ProgressData;
	import org.xas.core.net.BaseLoad;
	import org.xas.core.net.Http;
	import org.xas.core.utils.Log;
	
	import flash.display.MovieClip;	
	import flash.events.EventDispatcher;
	import flash.display.Loader;
	
	public class LoadQueue extends EventDispatcher
	{
		private var _model:LoadQueueData;
		private var _loadedItems:Vector.<HttpResultData> = new Vector.<HttpResultData>();
		
		private var _iview:ILoadQueueView;
				
		public function LoadQueue( $iview:ILoadQueueView = null )
		{
			_iview = $iview;
			init();
		}
		
		private function init():void
		{
			_model = new LoadQueueData();
		}
		
		public function addItem( $url:String ):void
		{
			_model.addItem( $url );
		}
		
		public function load():void
		{
			if( !_model.length ){ return; }
			_model.reset();
			if( _iview )
			{
				_iview.setLoadDetail('正在加载资源, 请稍候...');
				_iview.setLoaded( { currentLoad: _model.success, total: _model.length, error:_model.error } );
			}
			laodItem();
		}
		
		private function laodItem():void
		{
			var $url:String = _model.currentItem;
			
			if( !$url )
			{
			    dispatchEvent( new BaseEvent( LoadEvent.ALL_COMPLTE, _loadedItems ) );
				return;
			}
			
			var bload:BaseLoad = new BaseLoad( $url, loadCallback, progressCallback );
			bload.load( false );
			
			function progressCallback($data:ProgressData):void
			{
//				/Log.print( $data.bytesLoaded, $data.bytesTotal );
				if( _iview )
				{
					_iview.setProgress($data);
				}
			}
			
			function loadCallback( $data:HttpResultData ):void
			{
				if( $data.CODE == 200 )
				{
					_model.success++;
					_loadedItems.push( $data );
				}
				else
				{
					_model.error++;
					Log.error( 'load fail: ' + $data.URL, 120 );
				}
				if( _iview )
				{
					_iview.setLoaded( { currentLoad: _model.success, total: _model.length, error:_model.error } );
				}
				laodItem();
			}
		}
	}
}
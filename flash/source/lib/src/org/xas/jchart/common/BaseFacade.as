package org.xas.jchart.common
{
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.xas.core.utils.Log;
	
	public class BaseFacade extends Facade implements IFacade
	{
		private var _name:String;
		public function get name():String{ return _name; }
		
		public function BaseFacade( _name:String)
		{
			this._name = _name;
			super( _name );
		}
	}
}
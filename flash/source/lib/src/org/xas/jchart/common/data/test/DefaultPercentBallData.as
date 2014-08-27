package org.xas.jchart.common.data.test
{
	public class DefaultPercentBallData
	{
		private var _data:Vector.<Object>;
		public function get data():Vector.<Object>{ return _data;}
		
		private static var _ins:DefaultPercentBallData;
		
		public static function get instance():DefaultPercentBallData{
			if( !_ins ){
				_ins = new DefaultPercentBallData();		
			}
			return _ins;
		}
		
		public function DefaultPercentBallData()
		{
			init();
		}
		
		private function init():void{
			_data = new Vector.<Object>();
			
			
			_data.push({
				score: 0
				, style: {
					
				}
			});
			
			_data.push({
				score: 10
				, style: {
					
				}
			});
			
			_data.push({
				score: 20
				, style: {
					
				}
			});
			
			_data.push({
				score: 30
				, style: {
					
				}
			});
			
			_data.push({
				score: 40
				, style: {
					
				}
			});
			
			_data.push({
				score: 50
				, style: {
					
				}
			});
			
			_data.push({
				score: 60
				, style: {
					
				}
			});
			
			_data.push({
				score: 70
				, style: {
					
				}
			});
			
			_data.push({
				score: 80
				, style: {
					
				}
			});
			
			_data.push({
				score: 90
				, style: {
					
				}
			});
			
			_data.push({
				score: 100
				, style: {
					
				}
			});
			
			_data.push({
				score: 34.1
				, style: {
					
				}
			});
		}
		
	}
}
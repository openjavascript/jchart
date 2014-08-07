package org.xas.jchart.common.data.test
{
	public class DefaultPieData
	{
		private var _data:Vector.<Object>;
		public function get data():Vector.<Object>{ return _data;}
		
		private static var _ins:DefaultPieData;
		
		public static function get instance():DefaultPieData{
			if( !_ins ){
				_ins = new DefaultPieData();		
			}
			return _ins;
		}
		
		public function DefaultPieData()
		{
			init();
		}
		
		private function init():void{
			_data = new Vector.<Object>();
			
			_data.push({
				title: {
					text:'浏览器使用份额'
				},
				subtitle: {
					text: 'for PC'
				}, 
				series:[{
					name: 'Browser share',
					data: [
						['Firefox',   45.0],
						['IE',       26.8],
						{
							name: 'Chrome',
							y: 12.8,
							selected: true
						},
						['Safari',    8.5],
						['Opera',     6.2],
						['Others',   50]
					]
				}]
				, legend: {
					enabled: false
				}
			});
			
			_data.push({
				title: {
					text:'浏览器使用份额'
				},
				subtitle: {
					text: 'for PC'
				}, 
				series:[{
					name: 'Browser share',
					data: [
						['Firefox',   45.0],
						['IE',       26.8],
						{
							name: 'Chrome',
							y: 12.8,
							selected: true
						},
						['Safari',    8.5],
						['Opera',     6.2],
						['Others',   0.7]
					]
				}]
				,offsetAngle: 0
				, plotOptions: {
					pie: {
						dataLabels: {
							enabled: false
						}
					}
				}
				, legend: {
					enabled: false
				}
			});
			
			_data.push({
				title: {
					text:'浏览器使用份额'
				},
				subtitle: {
					text: 'for PC'
				}, 
				series:[{
					name: 'Browser share',
					data: [
						['Firefox',   45.0],
						['IE',       26.8],
						{
							name: 'Chrome',
							y: 12.8,
							selected: true
						},
						['Safari',    8.5],
						['Opera',     6.2],
						['Others',   0.7]
					]
				}]
				,offsetAngle: 90
				, plotOptions: {
					pie: {
						dataLabels: {
							enabled: false
						}
					}
				}
			});
			
			_data.push({
				title: {
					text:'浏览器使用份额'
				},
				subtitle: {
					text: 'for PC'
				}, 
				series:[{
					name: 'Browser share',
					data: [
						['Firefox',   45.0],
						['IE',       26.8],
						{
							name: 'Chrome',
							y: 12.8,
							selected: true
						},
						['Safari',    8.5],
						['Opera',     6.2],
						['Others',   0.7]
					]
				}]
				,offsetAngle: 180
			});
			
			_data.push({
				title: {
					text:'浏览器使用份额'
				},
				subtitle: {
					text: 'for PC'
				}, 
				series:[{
					name: 'Browser share',
					data: [
						['Firefox',   45.0]
						, ['IE',       26.8]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, {
							name: 'Chrome',
							y: 12.8,
							selected: true
						}
						, ['Safari',    8.5]
						, ['Opera',     6.2]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, ['Others',   0.7]
						, ['Others',   0.7]
					]
				}]
				//,offsetAngle: 180
			});
		}
		
	}
}
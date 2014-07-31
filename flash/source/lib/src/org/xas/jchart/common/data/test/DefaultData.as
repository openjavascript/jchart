package org.xas.jchart.common.data.test
{
	public class DefaultData
	{
		private var _data:Vector.<Object>;
		public function get data():Vector.<Object>{ return _data;}
		
		private static var _ins:DefaultData;
		
		public static function get instance():DefaultData{
			if( !_ins ){
				_ins = new DefaultData();		
			}
			return _ins;
		}
		
		public function DefaultData()
		{
			init();
		}
		
		private function init():void{
			_data = new Vector.<Object>();
			
			_data.push( {
				title: { text: 'test title 中文' }
				, subtitle: { text: 'test subtitle 中文' }
				, yAxis: { title: { text: 'vtitle 中文' } }
				, credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://jchart.openjavascript.org/'
				},
				xAxis: {
					categories: [2111111111111, 2, 3, 4, 5, 6, 7, 8, 999999999999]
					, tipTitlePostfix: '{0}月'
				}, 
				series:[{
					name: 'Temperature',
					data: [-50, -1, -3, 10.01, -20, -27, -28, -32, -30]
				}, {
					name: 'Rainfall1',
					data: [-20.10, -21, 50, 100, -10, -210, -220, -100, -20]
				}, {
					name: 'Rainfall2',
					data: [-30, -21, -20, -100, -10, -210, -20, -100, -20]
				}, {
					name: 'Rainfall3',
					data: [-40, -21, -20, -100, -10, -210, -120, -100, -20]
				}
					
				],
				legend: {
					enabled: true
				}
				, displayAllLabel: false
			});
			
			_data.push( {
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
					, tipTitlePostfix: '{0}月'
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
				},
				series:[{
					name: 'Temperature'
					, data: [-50, 0, 3, -20, -20, 27, 28, 32, 30, 25, 15, -58]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [20, 21, 20, 100, 200, 210, 220, 100, 20, 10, 20, 10]
				}],
				credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://jchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: true
				}
			});
			
			_data.push( {
				title: {
					text:'北京每月平均温度和降水'
				},
				subtitle: {
					text: '北京气象局'
				}, 
				xAxis: {
					categories: [1, 2, 3, 4, 5, 6, 7, 8, 9]
					, tipTitlePostfix: '{0}月'
				}, 
				yAxis: {
					title: {
						text: '平均温度'
					}
				},
				series:[{
					name: 'Temperature',
					data: [-50, -1, -3, -10, -20, -27, -28, -32, -30]
				}, {
					name: 'Rainfall',
					data: [-120, -211, 0, -100, -10, -210, -220, -80, -20]
				}, {
					name: 'Rainfall',
					data: [-220, -121, -20, -110, -10, -200, -230, -90, -30]
				}, {
					name: 'Rainfall',
					data: [-20, -21, 20, -120, -10, -205, -240, -100, -40]
				}
				],
				legend: {
					enabled: true
				}
			});
			
			_data.push( {"title":{},"subtitle":{},"xAxis":{"categories":["111111","2","3","4","5","6","7","8","9","10","11","122222"]},"yAxis":{"title":{}},"series":[{"name":"Temperature","data":[10,0,3,10,20,27,28,32,30,25,15,5]},{"name":"Rainfall","data":[20,21,20,100,200,210,220,100,20,10,20,10]}],"credits":{"enabled":false,"text":"jchart.openjavascript.org","href":"http://jchart.openjavascript.org/"},"displayAllLabel":true});
		}
		
	}
}
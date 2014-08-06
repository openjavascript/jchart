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
			
			_data.push(                     {
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
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
					enabled: false
				}
			});
			
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
			
			_data.push(                     {
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
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
					enabled: false
				}
			});
			
			_data.push(                     {
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ "2014-01-24","2014-01-25","2014-01-26","2014-01-27"
						,"2014-01-28","2014-01-29","2014-01-30","2014-01-31","2014-02-01"
						,"2014-02-02","2014-02-03","2014-02-04","2014-02-05","2014-02-06"
						,"2014-02-07","2014-02-08","2014-02-09","2014-02-10","2014-02-11"
						,"2014-02-12","2014-02-13","2014-02-14","2014-02-15","2014-02-16"
						,"2014-02-17","2014-02-18","2014-02-19","2014-02-20","2014-02-21"
						,"2014-02-22","2014-02-23","2014-02-24" ]
				}, 
				yAxis: {
				},
				series:[{
					name: '公司1',
					data: [0.018773,0.021724,0.022130,0.021296,0.022255,0.022128,0.020949
						,0.023862,0.026974,0.028055,0.024992,0.024721,0.025100,0.021803
						,0.019327,0.020149,0.020714,0.017774,0.017844,0.018313,0.018225
						,0.017863,0.019568,0.019308,0.017606,0.017649,0.016645,0.016310
						,0.014451,0.017606,0.018455,0]
				}, {
					name: '公司2',
					data: [0.018069,0.018495,0.018264,0.017527,0.016857,0.017398,0.016539
						,0.017144,0.018039,0.018798,0.018521,0.019580,0.019071,0.019078
						,0.017415,0.018997,0.018585,0.018417,0.018958,0.019772,0.018243
						,0.018742,0.020183,0.022000,0.020125,0.020549,0.019577,0.017468
						,0.015819,0.017709,0.018943,0]
				}, {
					name: '公司3',
					data: [0.017261,0.018625,0.019226,0.018777,0.019406,0.019887,0.022632
						,0.020445,0.019140,0.020957,0.021089,0.020967,0.021576,0.021357
						,0.020665,0.019415,0.018805,0.016842,0.016483,0.016688,0.016102
						,0.015717,0.016570,0.017390,0.016249,0.016616,0.016699,0.016514
						,0.016597,0.016476,0.016742,0]
				}
				],
				credits: {
					enabled: true,
					text: 'jchart.openjavascript.org',
					href: 'http://jchart.openjavascript.org/'
				}
				, floatLen: 6
				, displayAllLabel: false
			} );
		}
		
	}
}
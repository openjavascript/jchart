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
			
			_data.push({
				
				xAxis: {
					categories: [ 
						'04/01', '04/05', '04/10', '04/15', '04/20', '04/25'
						, '05/01', '05/05', '05/10', '05/15', '05/20', '05/25'
						, '05/31', '06/04', '06/09', '06/14', '06/19', '06/24'
						, '06/29'
					]
					, tipsHeader: [ 
						'2014-04-01', '2014-04-05', '2014-04-10', '2014-04-15', '2014-04-20', '2014-04-25'
						, '2014-05-01', '2014-05-05', '2014-05-10', '2014-05-15', '2014-05-20', '2014-05-25'
						, '2014-05-31', '2014-06-04', '2014-06-09', '2014-06-14', '2014-06-19', '2014-06-24'
						, '2014-06-29'
					]
					, wordwrap: false
				}
				, yAxis: {
					format: '{0}%'
				}
				, series:[{
					name: '词1'
					, data: [ 10, 0, 38, 53, 51, 38, 39, 38, 34, 59, 37, 34, 51, 58, 57, 39, 58, 44, 31 ]
				}, {
					name: '词2',
					data: [ 20, 0, 18, 25, 59, 19, 26, 18, 40, 21, 42, 22, 30, 42, 30, 39, 59, 30, 50 ]
				}, {
					name: '词3',
					data: [ 30, 0, 55, 41, 54, 53, 55, 54, 57, 55, 54, 59, 55, 39, 47, 43, 46, 42, 45 ]
				}, {
					name: '词4',
					data: [ 35, 0, 65, 51, 64, 63, 65, 64, 67, 65, 64, 69, 65, 59, 57, 53, 56, 52, 45 ]
				}, {
					name: '词5',
					data: [ 5, 0, 45, 31, 44, 43, 45, 44, 47, 45, 44, 49, 45, 29, 37, 33, 36, 32, 35 ]
				}
				]
				, tooltip: {		
					enabled: true
					, "headerFormat": "{0}"			
					, "pointFormat": "{0}"
				}
				, isPercent: true
				, isItemPercent: true
				, rateLabel: {
					enabled: true
					//, maxvalue: 100
					, data: [ 1, .8, .6, .4, .2, .0 ]
				}
				, displayAllLabel: false
				, legend: {
					enabled: true
				}
				, vline: {
					//enabled: false
				}
				, hline: {
					//enabled: true
				}
				, colors: [		
					0x61CA7D
					, 0x00ABEF
					, 0xFCBC2B
					, 0xF47672
					, 0xBDA5E6
					, 0xFF7C27
					
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]    	
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
				, toggleBg: {
					enabled: true
				}
			});
			
			_data.push({
				
				xAxis: {
					categories: [ '02/24', '02/25', '02/26', '02/27', '02/28', '02/29', '03/01' ]
				}
				, yAxis: {
					format: '{0}%'
				}
				, series:[{
					name: '目标PV'
					, data: [ 70, 49, 76, 30, 55, 26, 78 ]
				}, {
					name: '目标UV',
					data: [ 48, 62, 50, 50, 30, 40, 35 ]
				}]
				, tooltip: {		
					enabled: true
					, "headerFormat": "{0}"			
					, "pointFormat": "{0} %"
					, serial: [
						{
							name: '区分度', 'value': 1.04
						}
					]
				}
				//isPercent: true,
				, rateLabel: {
					enabled: true
					, maxvalue: 100
				}
				, displayAllLabel: true
				, legend: {
					//enabled: false
				}
				, dataLabels: {
					enabled: true
					, format: '{0}%'
				}
				, vline: {
					//enabled: false
				}
				, hline: {
					//enabled: true
				}
				, colors: [
					0x03ACEF
					, 0x5DC979
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]    				
				, credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://jchart.openjavascript.org/'
				}
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
					, graphicHeight: 220
				}
				, hoverBg: {
					enabled: true		
					, style: {
						borderColor: 0xB4B4B4
						, borderWidth: 2
						, bgColor: 0xF0F0F0
					}										
				}
			});
			
			
			_data.push({
				xAxis: {
					categories: [ '初中\n以下', '高中\n中专\n技校', '大专', '本科', '研究生\n及以上' ]
					, wordwrap: true
				}, 
				series:[{
					name: '学历'
					, data: [ 12, 19, 21, 46, 10 ]
				}],
				//isPercent: true,
				rateLabel: {
					enabled: false
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}				
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
					, graphicHeight: 220
				}
			});
			
			_data.push({
				
				xAxis: {
					categories: [ '网页游戏', '游戏平台', '桌面游戏', '手机游戏', '个体经营', '小游戏', '网页游戏', '游戏平台', '桌面游戏', '手机游戏' ]
				}
				, series:[{
					name: '全体覆盖率'
					, data: [26, 36, 46, 56, 77, 76, 86, 72, 62, 52]
				}, {
					name: '样式覆盖率',
					data: [81, 71, 61, 51, 41, 31, 21, 11, 29, 39]
				}]
				, tooltip: {		
					"headerFormat": "{0}"			
					, "pointFormat": "{0} %"
					//, enabled: false
					, serial: [
						{
							name: '区分度', 'value': 1.04
						}
					]
				}
				//isPercent: true,
				, rateLabel: {
					enabled: false
				}
				, displayAllLabel: true
				, legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true
					, format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]       
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
				, hoverBg: {
					enabled: true		
					, style: {
						borderColor: 0xB4B4B4
						, borderWidth: 2
						, bgColor: 0xF0F0F0
					}										
				}
			});
			
			
			_data.push({
				xAxis: {
					categories: [ 
						'兴趣点1', '兴趣点2', '兴趣点3', '兴趣点4', '兴趣点5'
					]
					, wordwrap: true
				}, 
				yAxis: {
					format: '{0}%'
				},
				series:[{
					name: '时段分布'
					, data: [
						80.12, 70.12, 50.12, 30.12, 10.12
					]
				}],
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, vline: {
					enabled: true
				}
				, hline: {
					enabled: true
				}
				, tooltip: {		
					enabled: false
				}
				, rateLabel: {
					maxvalue: 100
					, enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}                
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
				, hoverBg: {
					enabled: true												
				}
				
			});
			
			_data.push({
				xAxis: {
					categories: [ 
						'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
						, '10', '11', '12', '13', '14', '15', '16', '17', '18', '19'
						, '20', '21', '22', '23', '0'
					]
					, wordwrap: false
					, tipsHeader: [
						'0 时~', '1 时~', '2 时~', '3 时~', '4 时~', '5 时~', '6 时~', '7 时~', '8 时~', '9  时~'
						, '10 时~', '11 时~', '12 时~', '13 时~', '14 时~', '15 时~', '16 时~', '17 时~', '18 时~', '19 时~'
						, '20 时~', '21 时~', '22 时~', '23 时~', '0 时~'
					]
				}, 
				yAxis: {
					format: '{0}%'
				},
				series:[{
					name: '时段分布'
					, data: [
						0, 1, 2, 3, 4, 5, 6, 7, 8, 9
						, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
						, 20, 21, 22, 23, 0
					]
				}]
				, tooltip: {		
					"headerFormat": "{0}"			
					, "pointFormat": "{0} %"
					//, enabled: false
					, serial: [
						{
							name: '区分度', 'value': 1.04
						}
						, {
							name: '其他 ', 'value': 1.05
						}
					]
				}
				, displayAllLabel: true
				, legend: {
					enabled: false
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: true
				}
				, rateLabel: {
					maxvalue: 100
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
					
			_data.push({
				
				xAxis: {
					categories: [ '1', '2', '3', '4', '5' ]
				}, 
				series:[{
					name: 'Temperature'
					, data: [50, 60, 3, 20, 20]
					, style: { 'stroke': 0xff7100 } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [20, 21, 20, 100, 200]
				}],
				//isPercent: true,
				rateLabel: {
					enabled: false
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true
				}
				, vline: {
					enabled: true
				}
				, hline: {
					enabled: true
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]       
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
			});

			
			_data.push({
				xAxis: {
					categories: [ 
						'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
						, '10', '11', '12', '13', '14', '15', '16', '17', '18', '19'
						, '20', '21', '22', '23', '0'
					]
					, wordwrap: false
				}, 
				yAxis: {
					format: '{0}%'
				},
				series:[{
					name: '时段分布'
					, data: [
						0, 1, 2, 3, 4, 5, 6, 7, 8, 9
						, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
						, 20, 21, 22, 23, 0
					]
				}],
				isPercent: true,
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: true
				}
				, tooltip: {
					"headerFormat": "{0} 日"			
					, "pointFormat": "{0}%"		
					, enabled: true
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
			
			_data.push({
				xAxis: {
					categories: [ '学生', '公司职员', '公司管理者', '公务员', '事业单位', '个体经营', '自由职业', '产业\n服务员\n工人', '农业\n劳动者', '其他' ]
					, wordwrap: true
				}, 
				series:[{
					name: '职业'
					, data: [ 11, 14, 43, 12, 21, 8, 4, 6, 8, 5 ]
				}],
				//isPercent: true,
				rateLabel: {
					enabled: false
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
			
			
			
			_data.push({
				xAxis: {
					categories: [ '<18', '19-24', '23-34', '35-49', '>49' ]
					, wordwrap: true
				}, 
				series:[{
					name: '年龄'
					, data: [ 69, 19, 21, 18, 10 ]
				}],
				//isPercent: true,
				rateLabel: {
					enabled: false
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619

				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
			
			_data.push({
				xAxis: {
					categories: [ '低', '偏低', '中等', '偏高', '高' ]
					, wordwrap: true
				}, 
				series:[{
					name: '购买力'
					, data: [ 43, 19, 21, 18, 10 ]
				}],
				//isPercent: true,
				rateLabel: {
					enabled: false
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});

			
			_data.push({
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
					data: [20, 21, 20.8, 100, 200, 210, 220, 100, 20, 10, 20, 10]
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
					, wordwrap: false
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
				, displayAllLabel: false
			} );
			
			_data.push({
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
					, format: '{0}%'
				},
				tooltip: {					
					"pointFormat": "{0}%", 
					"headerFormat": "{0}月"
				},
				series:[{
					name: 'Temperature'
					, data: [-5000, 0, 300, -2000, -2000, 2700, 2800, 3200, 3000, 2500, 1500, -5800]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [2000, 2100, 2000, 10000, 20000, 21000, 22000, 10000, 2000, 1000, 2000, 1000]
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
			
			_data.push({
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
					, format: '{0}%'
				},
				tooltip: {					
					"pointFormat": "{0}", 
					"headerFormat": "{0}月"
				},
				series:[{
					name: 'Temperature'
					, data: [1, 2, 4, 8, 8, 33, 60, 0, 50.33, 66, 77, 88]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [1.01, 44, 3, 55, 3, 5, 83, 1, 33, 55, 44, 33]
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
				, isPercent: true
			});
			
			_data.push({
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3' ]
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
					, format: '{0}%'
				},
				tooltip: {					
					"pointFormat": "{0}", 
					"headerFormat": "{0}月"
				},
				series:[{
					name: 'Temperature'
					, data: [1, 2, 4]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [1.01, 44, 3]
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
				, isPercent: true
			});
		}
		
	}
}
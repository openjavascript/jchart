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
				
				series:[{
					data: [
						['全体覆盖率',   60],
						['样本覆盖率',   20]
					]
				}]
				, isPercent: true 
				
				, colors: [ 
					0x00ABEF
					, 0xFF6297
					
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
			});
			
			_data.push({
				
				series:[{
					data: [
						['全体覆盖率',   0],
						['样本覆盖率',   0]
					]
				}]
				, isPercent: true
				
				, radiusStep: 10
				
				, plotOptions: {
					ndount: {
						cdataLabels: {
							enabled: true
						}
					}
				}
				
				, colors: [ 
					0x9DADB3
					, 0x00ABEF
					
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
						['Firefox',   100]
					]
				}]
				, legend: {
					enabled: false
				}
			});
						
			_data.push({
				
				series:[{
					data: [
						['全体覆盖率',   45],
						['样本覆盖率',   35]
					]
				}]
				
				, radiusStep: 10
				
				, plotOptions: {
					ndount: {
						cdataLabels: {
							enabled: true
						}
					}
				}
				
				, colors: [ 
					0x9DADB3
					, 0x00ABEF
					
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
			}); 
			
			_data.push({
				
				series:[{
					data: [
						['全体覆盖率',   100],
						['样本覆盖率',   0]
					]
				}]
				
				, isPercent: true
				, radiusStep: 10
				
				, plotOptions: {
					ndount: {
						cdataLabels: {
							enabled: true
						}
					}
				}
				
				, colors: [ 
					0x9DADB3
					, 0x00ABEF
					
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
			}); 
			
			_data.push({
				
				series:[{
					data: [
						['全体覆盖率',   0],
						['样本覆盖率',   100]
					]
				}]
				
				, isPercent: true
				, radiusStep: 10
				
				, plotOptions: {
					ndount: {
						cdataLabels: {
							enabled: true
						}
					}
				}
				
				, colors: [ 
					0x9DADB3
					, 0x00ABEF
					
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
			}); 
			
			_data.push({
				
				series:[{
					data: [
					]
				}]
			});
			
			_data.push({
				
				series:[{
					data: [
						['男',   99],
						['女',   1]
					]
				}]				
				, colors: [ 
					0x00ABEF
					, 0xFF6297
					
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
			});
			
			_data.push({
				series:[{
					name: 'Browser share',
					data: [
						['Firefox',   45.0],
						['IE',       26.8],
						{
							name: 'Chrome',
							y: 12.8
						},
						['Safari',    8.5],
						['Opera',     6.2],
						['Others',   50]
					]
				}]
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
							enabled: true
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
						['Opera',     6.2]
						, ['Others 13',   0.7]
						, ['Others 14',   0.7]
						, ['Others 15',   0.7]
						, ['Others 16',   0.7]
						, ['Others 17',   0.7]
						, ['Others 18',   0.7]
						, ['Firefox',   5.0]
						, ['Others 19',   0.7]
						, ['Others 20',   0.7]
						, ['Others 21',   0.7]
						, ['Others 22',   0.7]
						, ['Others 23',   0.7]
						, ['Others 24',   0.7]
						, ['IE',       5.8]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, {
							name: 'Chrome',
							y: 8.8,
							selected: true
						}
						, ['Safari',    8.5]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Others 11',   0.7]
						, ['Others 12',   0.7]
					]
				}]
				//,offsetAngle: 180
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
						['Opera',     30]
						, ['Opera',     10]
						, ['Opera',     10]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Firefox',   3.0]
						, ['Others 19',   10]
						, ['Others 20',   10]
						, ['Others 21',   10]
						, ['Others 22',   10]
						, ['Others 23',   10]
						, ['Others 24',   10]
					]
				}]
				//,offsetAngle: 180
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
						['Opera',     10]
						, ['Opera',     10]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Firefox',   3.0]
						, ['Opera',     30]
						, ['Others 19',   10]
						, ['Others 20',   10]
						, ['Others 21',   10]
						, ['Others 22',   10]
						, ['Others 23',   10]
						, ['Others 24',   10]
					]
				}]
				//,offsetAngle: 180
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
						['Opera',     10]
						, ['Opera',     10]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Firefox',   3.0]
						, ['Others 19',   10]
						, ['Others 20',   10]
						, ['Others 21',   10]
						, ['Opera',     30]
						, ['Others 22',   10]
						, ['Others 23',   10]
						, ['Others 24',   10]
					]
				}]
				//,offsetAngle: 180
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
						['Opera',     10]
						, ['Opera',     10]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Firefox',   3.0]
						, ['Others 19',   10]
						, ['Others 20',   10]
						, ['Others 21',   10]
						, ['Others 22',   10]
						, ['Others 23',   10]
						, ['Others 24',   10]
						, ['Opera',     30]
					]
				}]
				//,offsetAngle: 180
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
						['Opera',     1]
						, ['Opera',     10]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Firefox',   3.0]
						, ['Others 19',   10]
						, ['Others 20',   10]
						, ['Others 21',   10]
						, ['Others 22',   10]
						, ['Others 23',   10]
						, ['Others 24',   10]
						, ['Opera',     30]
					]
				}]
				//,offsetAngle: 180
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
						['Opera',     36]
						, ['Opera',     1]
						, ['Opera',     10]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Firefox',   3.0]
						, ['Others 19',   10]
						, ['Others 20',   10]
						, ['Others 21',   10]
						, ['Others 22',   10]
						, ['Others 23',   10]
						, ['Others 24',   10]
						, ['Opera',     30]
					]
				}]
				//,offsetAngle: 180
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
						['Opera',     38]
						, ['Opera',     42]
						, ['Opera',     1]
						, ['Opera',     10]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Firefox',   3.0]
						, ['Others 19',   10]
						, ['Others 20',   10]
						, ['Others 21',   10]
						, ['Opera',     30]
					]
				}]
				//,offsetAngle: 180
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
						['Opera',     38]
						, ['Opera',     42]
						, ['Opera',     42]
						, ['Opera',     1]
						, ['Opera',     10]
						, ['Others 1',   0.7]
						, ['Others 2',   0.7]
						, ['Others 3',   0.7]
						, ['Others 4',   0.7]
						, ['Others 5',   0.7]
						, ['Others 6',   0.7]
						, ['Others 7',   0.7]
						, ['Others 8',   0.7]
						, ['Others 9',   0.7]
						, ['Others 10',   0.7]
						, ['Firefox',   3.0]
						, ['Others 19',   10]
						, ['Others 20',   10]
					]
				}]
				//,offsetAngle: 180
			});
		}
		
	}
}
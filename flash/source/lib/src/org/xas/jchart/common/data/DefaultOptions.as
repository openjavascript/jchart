package org.xas.jchart.common.data
{
	import flash.sensors.Accelerometer;

	public dynamic class DefaultOptions
	{

		public static var tooltip:Object =	
			{
				"dateTimeLabelFormats":
				{
					"hour": "%A, %b %e, %H:%M", 
					"second": "%A, %b %e, %H:%M:%S", 
					"year": "%Y", 
					"month": "%B %Y", 
					"minute": "%A, %b %e, %H:%M", 
					"day": "%A, %b %e, %Y", 
					"millisecond": "%A, %b %e, %H:%M:%S.%L", 
					"week": "Week from %A, %b %e, %Y"
				}, 
				"pointFormat": "<span style=\"color:{series.color}\">{series.name}</span>: <b>{point.y}</b><br/>", 
				"headerFormat": "<span style=\"font-size: 10px\">{point.key}</span><br/>", 
				"snap": 10, 
				"borderWidth": 1, 
				"animation": true, 
				"borderRadius": 3, 
				"backgroundColor": "rgba(255, 255, 255, .85)", 
				"style":
				{
					"size": 12,  
					"color": 0x333333
				}, 
				"shadow": true, 
				"enabled": true
			};
		
		public static var loading:Object =
			{
				"labelStyle":
				{
					"fontWeight": "bold", 
					"position": "relative", 
					"top": "1em"
				}, 
				"style":
				{
					"position": "absolute", 
					"textAlign": "center", 
					"backgroundColor": "white", 
					"opacity": 0.5
				}
			};
		
		public static var xAxis:Object =
			{
				"lineColor": "#000", 
				"title":
				{
					"style":
					{
						"bold": true, 
						"font": 'Trebuchet MS, Verdana, sans-serif',
						"size": 14, 
						"color": 0x333333
					}
				}, 
				"gridLineWidth": 1, 
				"tickColor": "#000", 
				"labels":
				{
					"style":
					{
						"font": "Trebuchet MS, Verdana, sans-serif",
						"size": 11,
						"color": 0x000000
					}
				}
			};
		
		public static var title:Object =
			{
				"align": "center", 
				"margin": 15, 
				"style":
				{
					//"font": "bold 16px \"Trebuchet MS\", Verdana, sans-serif", 
					'font': 'Trebuchet MS, Verdana, sans-serif',
					'bold': false,
					"size": 12, 
					"color": 0x000000
				}, 
				"text": "Chart title"
			};
		
		public static var symbols:Array =
			[
				"circle", 
				"diamond", 
				"square", 
				"triangle", 
				"triangle-down"
			];
		
		public static var plotOptions:Object =
			{
				"pie":
				{
					"center":
					[
						null, 
						null
					], 
					"point":
					{
						"events":
						{
						}
					}, 
					"clip": false, 
					"ignoreHiddenPoint": true, 
					"cropThreshold": 300, 
					"legendType": "point", 
					"showCheckbox": false, 
					"events":
					{
					}, 
					"pointRange": 0, 
					"size": null, 
					"borderWidth": 1, 
					"lineWidth": 2, 
					"states":
					{
						"select":
						{
							"marker":
							{
							}
						}, 
						"hover":
						{
							"marker":
							{
							}, 
							"brightness": 0.1, 
							"shadow": false
						}
					}, 
					"tooltip":
					{
						"followPointer": true
					}, 
					"marker": null, 
					"dataLabels":
					{
						"x": 0, 
						"align": "center", 
						"style":
						{
							"lineHeight": "14px", 
							"fontSize": "11px", 
							"cursor": "default", 
							"color": "#666"
						}, 
						"enabled": true, 
						"verticalAlign": "bottom", 
						"y": 0, 
						"distance": 30
					}, 
					"borderColor": "#FFFFFF", 
					"animation":
					{
						"duration": 1000
					}, 
					"allowPointSelect": false, 
					"showInLegend": false, 
					"colorByPoint": true, 
					"stickyTracking": false, 
					"slicedOffset": 10
				}, 
				"spline":
				{
					"point":
					{
						"events":
						{
						}
					}, 
					"cropThreshold": 300, 
					"showCheckbox": false, 
					"events":
					{
					}, 
					"pointRange": 0, 
					"lineWidth": 2, 
					"states":
					{
						"select":
						{
							"marker":
							{
							}
						}, 
						"hover":
						{
							"marker":
							{
							}
						}
					}, 
					"marker":
					{
						"lineWidth": 0, 
						"radius": 4, 
						"states":
						{
							"select":
							{
								"lineWidth": 2, 
								"lineColor": "#000000", 
								"fillColor": "#FFFFFF"
							}, 
							"hover":
							{
								"enabled": true
							}
						}, 
						"lineColor": "#FFFFFF", 
						"enabled": true
					}, 
					"dataLabels":
					{
						"x": 0, 
						"align": "center", 
						"style":
						{
							"lineHeight": "14px", 
							"fontSize": "11px", 
							"cursor": "default", 
							"color": "#666"
						}, 
						"enabled": false, 
						"verticalAlign": "bottom", 
						"y": 0
					}, 
					"animation":
					{
						"duration": 1000
					}, 
					"allowPointSelect": false, 
					"showInLegend": true, 
					"stickyTracking": true
				}, 
				"scatter":
				{
					"tooltip":
					{
						"headerFormat": "<span style=\"font-size: 10px; color:{series.color}\">{series.name}</span><br/>", 
						"followPointer": true, 
						"pointFormat": "x: <b>{point.x}</b><br/>y: <b>{point.y}</b><br/>"
					}, 
					"point":
					{
						"events":
						{
						}
					}, 
					"cropThreshold": 300, 
					"showCheckbox": false, 
					"events":
					{
					}, 
					"pointRange": 0, 
					"lineWidth": 0, 
					"states":
					{
						"select":
						{
							"marker":
							{
							}
						}, 
						"hover":
						{
							"marker":
							{
							}
						}
					}, 
					"marker":
					{
						"lineWidth": 0, 
						"radius": 4, 
						"states":
						{
							"select":
							{
								"lineWidth": 2, 
								"lineColor": "#000000", 
								"fillColor": "#FFFFFF"
							}, 
							"hover":
							{
								"enabled": true
							}
						}, 
						"lineColor": "#FFFFFF", 
						"enabled": true
					}, 
					"dataLabels":
					{
						"x": 0, 
						"align": "center", 
						"style":
						{
							"lineHeight": "14px", 
							"fontSize": "11px", 
							"cursor": "default", 
							"color": "#666"
						}, 
						"enabled": false, 
						"verticalAlign": "bottom", 
						"y": 0
					}, 
					"animation":
					{
						"duration": 1000
					}, 
					"allowPointSelect": false, 
					"showInLegend": true, 
					"stickyTracking": false
				}, 
				"line":
				{
					"point":
					{
						"events":
						{
						}
					}, 
					"cropThreshold": 300, 
					"showCheckbox": false, 
					"events":
					{
					}, 
					"pointRange": 0, 
					"lineWidth": 2, 
					"states":
					{
						"select":
						{
							"marker":
							{
							}
						}, 
						"hover":
						{
							"marker":
							{
							}
						}
					}, 
					"marker":
					{
						"lineWidth": 0, 
						"radius": 4, 
						"states":
						{
							"select":
							{
								"lineWidth": 2, 
								"lineColor": "#000000", 
								"fillColor": "#FFFFFF"
							}, 
							"hover":
							{
								"enabled": true
							}
						}, 
						"lineColor": "#FFFFFF", 
						"enabled": true
					}, 
					"dataLabels":
					{
						"x": 0, 
						"align": "center", 
						"style":
						{
							"lineHeight": "14px", 
							"fontSize": "11px", 
							"cursor": "default", 
							"color": "#666"
						}, 
						"enabled": false, 
						"verticalAlign": "bottom", 
						"y": 0
					}, 
					"animation":
					{
						"duration": 1000
					}, 
					"allowPointSelect": false, 
					"showInLegend": true, 
					"stickyTracking": true
				}, 
				"areaspline":
				{
					"point":
					{
						"events":
						{
						}
					}, 
					"cropThreshold": 300, 
					"showCheckbox": false, 
					"events":
					{
					}, 
					"pointRange": 0, 
					"lineWidth": 2, 
					"states":
					{
						"select":
						{
							"marker":
							{
							}
						}, 
						"hover":
						{
							"marker":
							{
							}
						}
					}, 
					"marker":
					{
						"lineWidth": 0, 
						"radius": 4, 
						"states":
						{
							"select":
							{
								"lineWidth": 2, 
								"lineColor": "#000000", 
								"fillColor": "#FFFFFF"
							}, 
							"hover":
							{
								"enabled": true
							}
						}, 
						"lineColor": "#FFFFFF", 
						"enabled": true
					}, 
					"dataLabels":
					{
						"x": 0, 
						"align": "center", 
						"style":
						{
							"lineHeight": "14px", 
							"fontSize": "11px", 
							"cursor": "default", 
							"color": "#666"
						}, 
						"enabled": false, 
						"verticalAlign": "bottom", 
						"y": 0
					}, 
					"animation":
					{
						"duration": 1000
					}, 
					"threshold": 0, 
					"allowPointSelect": false, 
					"showInLegend": true, 
					"stickyTracking": true
				}, 
				"area":
				{
					"point":
					{
						"events":
						{
						}
					}, 
					"cropThreshold": 300, 
					"showCheckbox": false, 
					"events":
					{
					}, 
					"pointRange": 0, 
					"lineWidth": 2, 
					"states":
					{
						"select":
						{
							"marker":
							{
							}
						}, 
						"hover":
						{
							"marker":
							{
							}
						}
					}, 
					"marker":
					{
						"lineWidth": 0, 
						"radius": 4, 
						"states":
						{
							"select":
							{
								"lineWidth": 2, 
								"lineColor": "#000000", 
								"fillColor": "#FFFFFF"
							}, 
							"hover":
							{
								"enabled": true
							}
						}, 
						"lineColor": "#FFFFFF", 
						"enabled": true
					}, 
					"dataLabels":
					{
						"x": 0, 
						"align": "center", 
						"style":
						{
							"lineHeight": "14px", 
							"fontSize": "11px", 
							"cursor": "default", 
							"color": "#666"
						}, 
						"enabled": false, 
						"verticalAlign": "bottom", 
						"y": 0
					}, 
					"animation":
					{
						"duration": 1000
					}, 
					"threshold": 0, 
					"allowPointSelect": false, 
					"showInLegend": true, 
					"stickyTracking": true
				}, 
				"column":
				{
					"point":
					{
						"events":
						{
						}
					}, 
					"groupPadding": 0.2, 
					"borderRadius": 0, 
					"cropThreshold": 50, 
					"showCheckbox": false, 
					"events":
					{
					}, 
					"pointRange": null, 
					"threshold": 0, 
					"borderWidth": 1, 
					"lineWidth": 2, 
					"states":
					{
						"select":
						{
							"borderColor": "#000000", 
							"marker":
							{
							}, 
							"shadow": false, 
							"color": "#C0C0C0"
						}, 
						"hover":
						{
							"marker":
							{
							}, 
							"brightness": 0.1, 
							"shadow": false
						}
					}, 
					"marker": null, 
					"dataLabels":
					{
						"x": 0, 
						"align": null, 
						"style":
						{
							"lineHeight": "14px", 
							"fontSize": "11px", 
							"cursor": "default", 
							"color": "#666"
						}, 
						"enabled": false, 
						"verticalAlign": null, 
						"y": null
					}, 
					"pointPadding": 0.1, 
					"borderColor": "#FFFFFF", 
					"animation":
					{
						"duration": 1000
					}, 
					"minPointLength": 0, 
					"allowPointSelect": false, 
					"showInLegend": true, 
					"stickyTracking": false
				}, 
				"bar":
				{
					"point":
					{
						"events":
						{
						}
					}, 
					"groupPadding": 0.2, 
					"borderRadius": 0, 
					"cropThreshold": 50, 
					"showCheckbox": false, 
					"events":
					{
					}, 
					"pointRange": null, 
					"threshold": 0, 
					"borderWidth": 1, 
					"lineWidth": 2, 
					"states":
					{
						"select":
						{
							"borderColor": "#000000", 
							"marker":
							{
							}, 
							"shadow": false, 
							"color": "#C0C0C0"
						}, 
						"hover":
						{
							"marker":
							{
							}, 
							"brightness": 0.1, 
							"shadow": false
						}
					}, 
					"marker": null, 
					"dataLabels":
					{
						"x": 0, 
						"align": null, 
						"style":
						{
							"lineHeight": "14px", 
							"fontSize": "11px", 
							"cursor": "default", 
							"color": "#666"
						}, 
						"enabled": false, 
						"verticalAlign": null, 
						"y": null
					}, 
					"pointPadding": 0.1, 
					"borderColor": "#FFFFFF", 
					"animation":
					{
						"duration": 1000
					}, 
					"minPointLength": 0, 
					"allowPointSelect": false, 
					"showInLegend": true, 
					"stickyTracking": false
				}
			};
		
		public static var chart:Object =
			{
				"spacing":
				[
					10, 
					10, 
					15, 
					10
				], 
				"borderWidth": 2, 
				"plotBorderColor": "#C0C0C0", 
				"plotBackgroundColor": "rgba(255, 255, 255, .9)", 
				"plotShadow": true, 
				"resetZoomButton":
				{
					"position":
					{
						"x": -10, 
							"align": "right", 
							"y": 10
					}, 
					"theme":
					{
						"zIndex": 20
					}
				}, 
				"plotBorderWidth": 1, 
				"defaultSeriesType": "line", 
				"style":
				{
					"fontFamily": "\"Lucida Grande\", \"Lucida Sans Unicode\", Verdana, Arial, Helvetica, sans-serif", 
					"fontSize": "12px"
				}, 
				"ignoreHiddenSeries": true, 
				"borderRadius": 5, 
				"backgroundColor":
				{
					"stops":
					[
						[
							0, 
							"rgb(255, 255, 255)"
						], 
						[
							1, 
							"rgb(240, 240, 255)"
						]
					], 
					"linearGradient":
					{
						"x2": 1, 
						"x1": 0, 
						"y2": 1, 
						"y1": 0
					}
				}, 
				"borderColor": "#4572A7"
			};
		
		public static var yAxis:Object =
			{
				"lineWidth": 1, 
				"title":
				{
					"style":
					{
						"bold": false, 
						"font": "Trebuchet MS, Verdana, sans-serif", 
						"size": 14, 
						"color": 0x333333
					}
				}, 
				"tickWidth": 1, 
				"minorTickInterval": "auto", 
				"lineColor": "#000", 
				"labels":
				{
					"style":
					{
						"font": "Trebuchet MS, Verdana, sans-serif",
						"size": 11,
						"color": 0x000000
					}
				}, 
				"tickColor": "#000"
			};
		
		public static var colors:Array =
			[
				0x058DC7, 
				0x50B432, 
				0xED561B, 
				0xDDDF00, 
				0x24CBE5, 
				0x64E572, 
				0xFF9655, 
				0xFFF263, 
				0x6AF9C4
			];
		
		public static var labels:Object =
		{
			"style":
			{
				"color": 0x9999bb
			}
		};
		
		public static var subtitle:Object =
			{
				"align": "center", 
				"style":
				{
					"font": "Trebuchet MS, Verdana, sans-serif", 
					"bold": false,
					"size": 12,
					"color": "#666666"
				}, 
				"text": ""
			};
		
		public static var navigation:Object =
			{
				"buttonOptions":
				{
					"theme":
					{
						"stroke": "#CCCCCC"
					}
				}
			};
		
		public static var legend:Object =
			{
				"itemStyle":
				{
					"font": "Trebuchet MS, Verdana, sans-serif", 
					"size": 12, 
					"color": 0x000000
				}, 
				"verticalAlign": "bottom", 
				"layout": "horizontal", 
				"itemCheckboxStyle":
				{
					"width": 13, 
					"height": 13
				}, 
				"borderWidth": 1, 
				"symbolWidth": 16, 
				"itemHoverStyle":
				{
					"color": "#039"
				}, 
				"title":
				{
					"style":
					{
						"bold": true
					}
				}, 
				"y": 0, 
				"shadow": false, 
				"enabled": true, 
				"x": 0, 
				"align": "center", 
				"symbolPadding": 5, 
				"itemHiddenStyle":
				{
					"color": "gray"
				}, 
				"borderColor": 0x909090, 
				"borderRadius": 5, 
				"navigation":
				{
					"inactiveColor": 0xCCCCCC, 
					"activeColor": 0x274b6d
				}
			};
		
		public static var lang:Object =
			{
				"numericSymbols":
				[
					"k", 
					"M", 
					"G", 
					"T", 
					"P", 
					"E"
				], 
				"loading": "Loading...", 
				"resetZoom": "Reset zoom", 
				"shortMonths":
				[
					"Jan", 
					"Feb", 
					"Mar", 
					"Apr", 
					"May", 
					"Jun", 
					"Jul", 
					"Aug", 
					"Sep", 
					"Oct", 
					"Nov", 
					"Dec"
				], 
				"resetZoomTitle": "Reset zoom level 1:1", 
				"months":
				[
					"January", 
					"February", 
					"March", 
					"April", 
					"May", 
					"June", 
					"July", 
					"August", 
					"September", 
					"October", 
					"November", 
					"December"
				], 
				"weekdays":
				[
					"Sunday", 
					"Monday", 
					"Tuesday", 
					"Wednesday", 
					"Thursday", 
					"Friday", 
					"Saturday"
				], 
				"thousandsSep": ",", 
				"decimalPoint": "."
			};
		
		public static var credits:Object =
			{
				"enabled": true, 
				"position":
				{
					"x": -10, 
						"verticalAlign": "bottom", 
						"align": "right", 
						"y": -5
				}, 
				"style":
				{
					"size": 9, 
					"color": 0x909090
				}, 
				"href": "http://jchart.openjavascript.org", 
				"text": "jchart.openjavascript.org"
			}
		
		public function DefaultOptions()
		{
			
		}
		
	}
}
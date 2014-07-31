;(function(define, _win) { 'use strict'; define( [], function(){
/**
 * JChart.DefaultOptions 是 JChart 图表库的默认配置, 提供所有图表的默认参数
 * <p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.Histogram.html' target='_blank'>API docs</a></p>
 *  
 * @namespace   JChart
 * @class       DefaultOptions
 * @version dev 0.1 2014-06-20
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 */
    window.JChart = window.JChart || {};
    JChart.DefaultOptions = 
        {
            "tooltip":
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
                    "whiteSpace": "nowrap", 
                    "padding": "8px", 
                    "fontSize": "12px", 
                    "cursor": "default", 
                    "color": "#333333"
                }, 
                "shadow": true, 
                "enabled": true
            }, 
            "loading":
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
            }, 
            "xAxis":
            {
                "lineColor": "#000", 
                "title":
                {
                    "style":
                    {
                        "fontWeight": "bold", 
                        "fontFamily": "Trebuchet MS, Verdana, sans-serif", 
                        "fontSize": "12px", 
                        "color": "#333"
                    }
                }, 
                "gridLineWidth": 1, 
                "tickColor": "#000", 
                "labels":
                {
                    "style":
                    {
                        "font": "11px Trebuchet MS, Verdana, sans-serif", 
                        "color": "#000"
                    }
                }
            }, 
            "title":
            {
                "align": "center", 
                "margin": 15, 
                "style":
                {
                    "font": "bold 16px \"Trebuchet MS\", Verdana, sans-serif", 
                    "fontSize": "16px", 
                    "color": "#000"
                }, 
                "text": "Chart title"
            }, 
            "symbols":
            [
                "circle", 
                "diamond", 
                "square", 
                "triangle", 
                "triangle-down"
            ], 
            "plotOptions":
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
            }, 
            "chart":
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
            }, 
            "yAxis":
            {
                "lineWidth": 1, 
                "title":
                {
                    "style":
                    {
                        "fontWeight": "bold", 
                        "fontFamily": "Trebuchet MS, Verdana, sans-serif", 
                        "fontSize": "12px", 
                        "color": "#333"
                    }
                }, 
                "tickWidth": 1, 
                "minorTickInterval": "auto", 
                "lineColor": "#000", 
                "labels":
                {
                    "style":
                    {
                        "font": "11px Trebuchet MS, Verdana, sans-serif", 
                        "color": "#000"
                    }
                }, 
                "tickColor": "#000"
            }, 
            "colors":
            [
                "#09c100", 
                "#0c76c4", 
                "#ff0619", 

                "#ffbf00", 
                "#ff7100", 
                "#ff06b3", 

                "#41e2e6", 
                "#c3e2a4", 
                "#ffb2bc",

                "#dbb8fd"
            ], 
            "labels":
            {
                "style":
                {
                    "position": "absolute", 
                    "color": "#99b"
                }
            }, 
            "subtitle":
            {
                "align": "center", 
                "style":
                {
                    "font": "bold 12px \"Trebuchet MS\", Verdana, sans-serif", 
                    "color": "#666666"
                }, 
                "text": ""
            }, 
            "navigation":
            {
                "buttonOptions":
                {
                    "theme":
                    {
                        "stroke": "#CCCCCC"
                    }
                }
            }, 
            "legend":
            {
                "itemStyle":
                {
                    "font": "9pt Trebuchet MS, Verdana, sans-serif", 
                    "fontSize": "12px", 
                    "cursor": "pointer", 
                    "color": "black"
                }, 
                "verticalAlign": "bottom", 
                "layout": "horizontal", 
                "itemCheckboxStyle":
                {
                    "position": "absolute", 
                    "width": "13px", 
                    "height": "13px"
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
                        "fontWeight": "bold"
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
                "borderColor": "#909090", 
                "borderRadius": 5, 
                "navigation":
                {
                    "inactiveColor": "#CCC", 
                    "activeColor": "#274b6d"
                }
            }, 
            "lang":
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
            }, 
            "credits":
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
                    "fontSize": "9px", 
                    "cursor": "pointer", 
                    "color": "#909090"
                }, 
                "href": "http://jchart.openjavascript.org", 
                "text": "jchart.openjavascript.org"
            }
        };

    return JChart.DefaultOptions;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);

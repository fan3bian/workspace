$(function () {
    // Prepare random data
//    var data = [
//        {
//			"postal":'05',
//            "value": 72
//        },
//        {
//			"postal":'01',
//            "value": 71
//        },
//        {
//			"postal":'02',
//            "value": 96
//        },
//        {
//			"postal":'03',
//            "value": 54
//        },
//        {
//			"postal":'06',
//            "value": 62
//        },
//        {
//			"postal":'04',
//            "value": 10
//        },
//        {
//			"postal":'07',
//            "value": 26
//        },
//        {
//			"postal":'08',
//            "value": 34
//        },
//        {
//			"postal":'09',
//            "value": 42
//        },
//        {
//			"postal":'10',
//            "value": 50
//        },
//        {
//			"postal":'11',
//            "value": 66
//        },
//        {
//			"postal":'12',
//            "value": 74
//        },
//        {
//			"postal":'13',
//            "value": 82
//        },
//        {
//			"postal":'14',
//            "value": 96
//        },
//        {
//			"postal":'15',
//            "value": 104
//        },
//        {
//			"postal":'16',
//            "value": 112
//        },
//        {
//			"postal":'17',
//            "value": 122
//        }
//    ];

        // 告警分布图
        $('#chart_jgfb').highcharts('Map', {
			chart:{
				backgroundColor:'#fff'
			},
            title : {
                text : ''
            },

            mapNavigation: {
                enabled: false
            },
			credits:{
				enabled:false
			},
            colorAxis: {
				min:0,
				maxColor:'#dd2211'
            },
			legend: {
                align: 'right',
                verticalAlign: 'middle',
				layout:'vertical',
				reversed:true
            },
			tooltip:{
				headerFormat:'<span style="color:#777">{series.name}</span><br/>',
				pointFormat:'{point.name}: <span style="color:#2E71CC">{point.value}</span>',
				valueSuffix:'起',
				style:{
					color: '#333',
					fontSize: '14px',
					padding: '8px',
					fontWeight:'bold'
				}
			},
            series : [{
            	data:resourceListJson_gaojing,
                mapData: geo_SD,
                joinBy: ['postal', 'postal'],
                name: '交通事故',
                states: {
                    hover: {
                        color: '#BADA55'
                    }
                },
                dataLabels: {
                    enabled: true,
					style:{
						"color":"#010",
						"fontWeight":"normal",
						"HcTextStroke": "0 rgba(0,0,0,0)"},
                    format: '{point.name}'
                }
            }]
        });
    	 
        debugger
        //计算资源
        $('#chart_jszy').highcharts({
        	        chart: {                                                                             
        	            type: 'scatter',                                                                 
        	            zoomType: 'xy'                                                                   
        	        },                                                                                   
        	        title: {                                                                             
        	            text: '内存、CPU超配'                        
        	        },                                                                                   
        	        credits:{
        				enabled:false
        			},                                                                               
        	        xAxis: {                                                                gridLineWidth: 1,              
        	            title: {                                                                         
        	                enabled: true,                                                               
        	                text: 'CPU利用率(%)'                                                          
        	            },                                                                               
        	            startOnTick: true,                                                               
        	            endOnTick: true,                                                                 
        	            showLastLabel: true                                                              
        	        },                                                                                   
        	        yAxis: {                                                                             
        	            title: {                                                                         
        	                text: '内存利用率(%)'                                                           
        	            }                                                                                
        	        },
        			legend: {
                        enable:false
                    },
        	        plotOptions: {                                                                       
        	            scatter: {                                                                       
        	                  marker: {                                                                    
        	                    radius: 5,                                                               
        	                    states: {                                                                
        	                        hover: {                                                             
        	                            enabled: true,                                                   
        	                            lineColor: 'rgb(100,100,100)'                                    
        	                        }                                                                    
        	                    }                                                                        
        	                },                                                                         
        	                states: {                                                                    
        	                    hover: {                                                                 
        	                        marker: {                                                            
        	                            enabled: false                                                   
        	                        }                                                                    
        	                    }                                                                        
        	                },                                                                           
        	                tooltip: {                                                                   
        	                    headerFormat: '<b>{series.name}</b><br>',                                
        	                    pointFormat: 'CPU：{point.x}, 内存：{point.y}'                                
        	                }                                                                            
        	            }                                                                                
        	        },                                                                                   
        	       /* series: [{                                                                           
        	            name: '省局', 
        	            data: [[80, 50]]  
        	        },
        	        {                                                                           
        	            name: '济南', 
        	            data: [[16, 5] ]  
        	        }
        	        
        	        ]    */
        	        series: resourceListJson_jisuan
        	    });
    	 
        //存储资源
        $("#chart_cczy").highcharts({
    		chart: {
                type: 'area',
    			backgroundColor:'#fff',
    			style:{				
    				fontFamily:'LantingHei'
    			}
            },
            title: {
                text:'',
                style:{fontSize:'18px'}
            },
//            xAxis: {
//    			type:'datetime',
//    			dateTimeLabelFormats:{
//    				day:"%m-%e",
//    				week:"%m-%e"
//    			}
//            },
            xAxis: {
               // categories: ['1750', '1800', '1850', '1900', '1950', '1999', '2050'],
            	 categories: resourceListJson_cunchu.cat,
                tickmarkPlacement: 'on',
                title: {
                    enabled: false
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: '利用率(%)'  
                },
                labels: {
                    overflow: 'justify'
                }
            },
    		credits: {
                enabled: false
            },
    		legend:{
    			enabled:true
    		},
            plotOptions: {
                area: { 
    				fillColor: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, Highcharts.getOptions().colors[0]],
                            [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                        ]
                    },
                    marker: {
                        enabled: false,
                        symbol: 'circle',
                        radius: 2,
                        states: {
                            hover: {
                                enabled: true
                            }
                        }
                    }
                }
            },
    		tooltip:{
    			dateTimeLabelFormats:{
    				day:"%Y-%m-%e",
    				week:"%m-%e"
    			}
    		},
            series: [{
                name: '利用率',
    			/*pointInterval: 24 * 3600 * 1000,
                pointStart: Date.UTC(2014, 10, 01),*/
                //data: [ 2,23, 10, 12, 17, 10, 1]
                data:resourceListJson_cunchu.data
            }
            ]
        });
        
        //集群个数
        
        $('#chart_hadoop_jqgs').highcharts({
            chart: {
                type: 'pie',
    			borderRadius:5,
    			style:{
    				fontFamily:"'Microsoft Yahei',sans-serif"
    			}
            },
            title: {
                text: '集群个数'
            },
    		credits: {
                enabled: false
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
    		legend:{
    			enabled:true
    		},
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '{point.percentage:.1f} %',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: '所占比例',
                data: [
                    ['省厅',   20.0],
                    ['济南',   20],
                    ['青岛',    20],
                    ['潍坊',    20],
                    ['日照',   20]
                ]
            }]
        });
        
        //节点个数
        $('#chart_hadoop_jdgs').highcharts({
            chart: {
                type: 'pie',
                options3d: {
                    enabled: true,
                    alpha: 45
                }
            },
            title: {
                text: '节点个数'
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                pie: {
                    innerSize: 100,
                    depth: 45
                }
            },
            series: [{
                name: '节点个数',
                data: [
                    ['省厅', 20],
                    ['济南', 20],
                    ['青岛', 20],
                    ['日照', 20],
                    ['枣庄', 20]
                ]
            }]
        });
});


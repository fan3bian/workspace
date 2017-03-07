/**
 * 
 */

function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(localhostPaht+projectName);
}

function initIndexPage(){
	Highcharts.setOptions({  
		global: {  
		useUTC: false  
          }  
}); 
	load3dhighchart();
	loadUseRatio();
}



function  loadUseRatio() {
	var rootpath = getRootPath();
	
	var dataChart =  null;
     $.ajax({  
         type:"Post", 
         async:false,
         //后台获取数据的函数，注意当对该页面重命名时，  
          //必须手动更改该选项  
           url: rootpath+"/eqUseRatio.do",  
           contentType:"application/json; charset=utf-8",  
           dataType:"json",  
           //成功获取数据  
           success:function (data){ 
        	   dataChart = data ;
        	   
           },  
           //显示错误                                         
           error:function (err){  
            alert(err + "调用后台程序出现错误，请尝试刷新！");  
        }  
     }); 
     if(("#containerScatter").length<=0){
		   console.log("size is less than 0");
		   return;
	  };
     var scatterchart = new Highcharts.Chart({                                                             
	        chart: {                                                                             
	            type: 'scatter',                                                                 
	            zoomType: 'xy' ,
	            renderTo:'containerScatter',
	            width:850,
	        },  
	        credits: {
	            enabled: false
	       } ,
	        title: {                                                                             
	            text: '资源利用率分布图'  ,
	            align:'left'
	        },                                                                                   
	                                                                                        
	        xAxis: {                                                                             
	            title: {                                                                         
	                enabled: true,                                                               
	                text: '内存利用率 (%)'                                                          
	            },  
	            plotLines: [{   //一条延伸到整个绘图区的线，标志着轴中一个特定值。
	                color: '#000',
	                dashStyle: 'solid', //Dash,Dot,Solid,默认Solid
	                width: 1.5,
	                value: 50,  //x轴显示位置，一个标记为1
	                zIndex: 5
	            }],
	            labels:{
                 x:10,//调节x偏移
                 //y:-35,//调节y偏移
                 rotation:0//调节倾斜角度偏移
              },
	  		 
	            startOnTick: true,                                                               
	            endOnTick: true,                                                                 
	            showLastLabel: true                                                              
	        },                                                                                   
	        yAxis: {                                                                             
	            title: {                                                                         
	                text: 'cpu利用率 (%)'                                                          
	            } ,
	            plotLines: [{   //一条延伸到整个绘图区的线，标志着轴中一个特定值。
	                color: '#000',
	                dashStyle: 'solid', //Dash,Dot,Solid,默认Solid
	                width: 1.5,
	                value: 60,  //y轴显示位置
	                zIndex: 5
	            }]
	        },                                                                                   
	        legend: {                                                                            
	            layout: 'horizontal',                                                              
	            align: 'right',  
	            verticalAlign: 'top',
	            backgroundColor: '#FFFFFF',                                                      
	            borderWidth: 1                                                                   
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
	                    pointFormat: '{point.x}%, {point.y} %'                                
	                }                                                                            
	            }                                                                                
	        },                                                                                   
	        series: dataChart                                                                      
	    });
                                                                                         
}; 



function load3dhighchart() {
	  if(("#container").length<=0){
		   console.log("size is less than 0");
		   return;
	   };
	 // Give the points a 3D feel by adding a radial gradient
	Highcharts.getOptions().colors = $.map(
			Highcharts.getOptions().colors, function(color) {
				return {
					radialGradient : {
						cx : 0.4,
						cy : 0.3,
						r : 0.5
					},
					stops : [
							[ 0, color ],
							[1,	Highcharts.Color(color).brighten(-0.2).get('rgb') ] ]
				};
			});

	// Set up the chart
	
	var chart3d = new Highcharts.Chart({
		credits: {
		     enabled: false
		} ,
		chart : {
			//width:500,
			renderTo : 'container',
		//	margin : 100,
			type : 'scatter',
			//position: 'absolute';
			options3d : {
				enabled : true,
				alpha : 10,
				beta : 10,
				depth : 250,
				viewDistance : 5,

				frame : {
					bottom : {
						size : 1,
						color : 'rgba(0,0,0,0.02)'
					},
					back : {
						size : 1,
						color : 'rgba(0,0,0,0.04)'
					},
					side : {
						size : 1,
						color : 'rgba(0,0,0,0.06)'
					}
				}
			}
		},
		title : {
			text : '宿主机利用分布图'
		},
		tooltip : {
			 formatter: function () {
	                var s = '<b>资源池' + this.x + '</b>,';
	                	//s += '<b>宿主机类型' + this.z + '</b>';
	                	s += this.y+'个';
	                	

	                //$.each(this.points, function () {
	                 //   s += '<br/>' + this.series.name + ': ' +
	                 //       this.y +this.z+ 'm';
	                //});

	                return s;
	            },
	            shared: true
		},
	
		plotOptions : {
			 scatter: {
	                width: 10,
	                height: 10,
	                depth: 10
	            }
			
		},
		yAxis : {
			min : 0,
			title : {
				text : '数量',
				verticalAlign:'middle',
				margin:80
			}
		
		},
		xAxis : {
//			min:0,
//			max:12,
//			gridLineWidth : 1,
			title : {
				text : '资源池',
				verticalAlign:'bottom',
				margin:80
				
			},
//			algin:'low',
//			margin:120,
//		//	offset:50,
			
			 categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
			                'Jul', 'Aug', 'Sep', 'Oct']
		},
		zAxis : {
			min : 0,
			title : {
				text : '宿主机类型'
			}
		},
		legend : {
			enabled : false
		},
		series : [ {
			name : '数量',
			colorByPoint : true,
			 data : [ [0, 6, 6 ], [ 8, 7,6 ], //[ 'Mar', 3, 6],
					[ 4, 6, 8 ], [ 5, 7, 8 ], [ 6, 9,8 ], [ 7, 0, 8 ],
					//[ 'Mar', 3, 9 ], [ 0, 9, 9], [ 3, 6, 9 ], [ 4, 9, 9 ],
					//[ 'Mar', 3, 7 ], [ 6, 9, 7], [ 'Feb', 7, 7 ], [ 'Feb', 7, 7 ],
					[ 7, 2, 3 ], [ 2, 6, 3 ], [ 4, 6, 3 ], [ 3, 7, 3 ],[9,8,2]
					
					 ] 
		} ]
	});

	
	// Add mouse events for rotation
	$(chart3d.container).bind('mousedown.hc touchstart.hc',function(e) {
						e = chart3d.pointer.normalize(e);

						var posX = e.pageX, posY = e.pageY, alpha = chart3d.options.chart.options3d.alpha, 
						beta = chart3d.options.chart.options3d.beta, newAlpha, newBeta, sensitivity = 5; // lower is more sensitive

						$(document).bind({'mousemove.hc touchdrag.hc' : function(e) {
												// Run beta
												newBeta = beta+ (posX - e.pageX)/ sensitivity;
												newBeta = Math.min(100,Math.max(-100,newBeta));
												chart3d.options.chart.options3d.beta = newBeta;

												// Run alpha
												newAlpha = alpha+ (e.pageY - posY)/ sensitivity;
												newAlpha = Math.min(100,Math.max(-100,newAlpha));
												chart3d.options.chart.options3d.alpha = newAlpha;
												chart3d.redraw(false);
											},
											'mouseup touchend' : function() {
												$(document).unbind(
														'.hc');
											}
										});
					}); 

};


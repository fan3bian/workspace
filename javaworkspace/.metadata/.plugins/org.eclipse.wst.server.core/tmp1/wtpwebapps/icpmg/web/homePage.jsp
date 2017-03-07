<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>浪潮云服务</title>
		
		
		<meta http-equiv="refresh" content="3600"/>
		<%@ include file="/icp/include/import.jsp"%>
		<% String contextPath = request.getContextPath(); %>
		
    <script>
        $(function (){
            $("#tabs").tabs({
                //event: "mouseover"
            });
            alerm();
         	resource();
        });
        
//         function alerm(){
// 			 $('#alarmdg').datagrid({
// 				url:'${pageContext.request.contextPath}/homepage/queryAlarm.do',
// 				pagination:false,//分页控件
// 				 showFooter:false,
// 				 width:'100%',
// 				 height:300,
// 				pageSize:5,
// 				pageList:[5],
// 				align:'center',
// 				halign:'center',
// 				fitColumns:true,
// 				singleSelect:true,
// 				border:false,
// 				scrollbarSize:0,
// 				columns:[[{
// 					title:'类型',
// 					field:'eventype',
// 					width:'15%',
// 					align:'center',
// 					 styler: function(value,row,index){
//                                return 'vertical-align:middle;';
//                        },
//                        formatter:function(value,row,index){
//                        	switch (value) {
//                            	case 'alarm':
//                            		return "<font color=\"#000\">故障</font>";
//                            	case 'event':
//                            		return "<font color=\"#000\">事件</font>";
//                            	case 'degradation':
//                            		return "<font color=\"#000\">劣化</font>";
//                            	case 'notice':
//                            		return "<font color=\"#000\">通知</font>";
// 							}
								
// 					},
// 				},{
// 					title:'重要',
// 					field:'serious',
// 					width:'17%',
// 					fit:true,
// 					align:'center',
// 					styler: function(value,row,index){
//                                return 'vertical-align:middle;';
//                        },
//                        formatter:function(value,row,index){
// 								return "<font color=\"#fc0e02\">"+value+"</font>";
// 					},
// 				},{
// 					title:'主要',
// 					field:'major',
// 					width:'17%',
// 					align:'center',
// 					styler: function(value,row,index){
//                                return 'vertical-align:middle;';
//                        },
//                        formatter:function(value,row,index){
// 								return "<font color=\"#021afc\">"+value+"</font>";
// 					},
// 				},{
// 					title:'次要',
// 					field:'secondary',
// 					width:'17%',
// 					align:'center',
// 					styler: function(value,row,index){
//                                return 'vertical-align:middle;';
//                        },
//                        formatter:function(value,row,index){
// 								return "<font color=\"#02fc14\">"+value+"</font>";
// 					},
// 				},{
// 					title:'一般',
// 					field:'commonly',
// 					width:'17%',
// 					align:'center',
// 					styler: function(value,row,index){
//                                return 'vertical-align:middle;';
//                        },
//                        formatter:function(value,row,index){
// 								return "<font color=\"#fc8902\">"+value+"</font>";
// 					},
//                        },{
// 					title:'警告',
// 					field:'warning',
// 					width:'17%',
// 					align:'center',
// 					styler: function(value,row,index){
//                                return 'vertical-align:middle;';
//                        },
//                        formatter:function(value,row,index){
// 								return "<font color=\"#fcf302\">"+value+"</font>";
// 					},
// 				}]]
// 			});
//    }
        
//         function resource(){
//         	$.ajax({
//    				  		type : 'post',
//    				  		url:'${pageContext.request.contextPath}/homepage/queryResource.do',
//    				  		success:function(rets){
//    				  		var ret = JSON.parse(rets);
//    				  			$('#homepageTenants').html(ret.custnum);
   				  			
//    				  			$('#homepageRedRquipment').html(ret.errnenum );
//    				  			$('#homepageGreenRquipment').html(ret.normalnenum );
   				  			
//    				  			$('#homepageRedApply').html(ret.errappnum);
//    				  			$('#homepageGreenApply').html(ret.normalappnum );
   				  			
// 				  			/* $('#homepageRedSystem').html(ret.homepageRedSystem);
// 				  			$('#homepageGreenSystem').html(ret.homepageGreenSystem ); */
				  			
//    				  			$('#homepageAttack').html(ret.attacknum);
   				  			
//    				  			$('#homepageRedIP').html(ret.ipused );
// 				  			$('#homepageGreenIP').html(ret.ipunused);
				  			
// 				  			$('#homepageInhost').html(ret.hostnum );
//    				  			$('#homepageInserver').html(ret.vmnum);
//    				  			queryHighcharts(ret);
//    				  			homepagecpulan(ret);
   				  			
//    				  		}
// 		   	});
//         }
        
//         function queryHighcharts(rets){
//         	var obj = JSON.parse(rets.cpuloadtop10);
// 	  		highchartsOne (obj.categories,obj.data);
// 	  		var mobj = JSON.parse(rets.memloadtop10);
// 	  		highchartsTwo (mobj.categories,mobj.data);
        	
//         }
//           function queryHighchartsOne(){
// 	        	$.ajax({
// 	   				  		type : 'post',
// 	   				  		url:'${pageContext.request.contextPath}/homepage/queryResource.do',
// 	   				  		success:function(rets){
// 		   				  		var obj = JSON.parse(rets.cpuloadtop10);
// 		   				  		highchartsOne (obj.categories,obj.data);
// 	   				  		}
// 	   			});
//    			}
   			function queryHighchartsTwo(){
	        	$.ajax({
	   				  		type : 'post',
	   				  		url:'${pageContext.request.contextPath}/homepage/queryResource.do',
	   				  		success:function(rets){
		   				  		var mobj = JSON.parse(rets.memloadtop10);
		   				  		highchartsTwo (mobj.categories,mobj.data);
	   				  		}
	   			});	  		
   			}
   				  		
         function highchartsOne(categoriess,datas){
			categories =categoriess,
			//categories = ['主机1', '主机2', '主机3', '主机4', '主机5','主机6', '主机7', '主机8', '主机9', '主机10'],
			name = ' ',
			data = datas;

		    function setChart(name, categories, data) {
			chart.xAxis[0].setCategories(categories, false);
			chart.series[0].remove(false);
			chart.addSeries({
				data: data,
			}, false);
			chart.redraw();
		    }

		    var chart = $('#container').highcharts({
		         chart: {
		            type: 'column'
		        },
		        title: {
		            text:null
		        },
		        subtitle: {
		            text: null
		        },
		        tooltip:{
		      	   formatter:function(){
		      	      return'名称：'+this.x+'<br/>数值： '+Highcharts.numberFormat(this.y,2,'.')+"%";
		      	   }
		      	},
		        xAxis: {
		            categories: categories
		        },
		        yAxis: {
		            title: {
		                text:null
		            },
		        },
		        plotOptions: {
		            column: {
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: false,
		                    formatter: function() {
		                        return this.y +'%';
		                    }
		                }
		            }
		        },
		       
		        series: [{
		            name: name,
		            data: data,
		        }],
		    })
    .highcharts();
};	
	function highchartsTwo(categoriess,datas){
			categories = categoriess;
			name = ' ',
			data = datas;
		    function setChart(name, categories, data, color) {
			chart.xAxis[0].setCategories(categories, false);
			chart.series[0].remove(false);
			chart.addSeries({
				data: data,
				color: color
			}, false);
			chart.redraw();
		    }

		    var chart = $('#container2').highcharts({
		        chart: {
		            type: 'column'
		        },
		        title: {
		            text:null
		        },
		        subtitle: {
		            text: null
		        },
		        tooltip:{
		      	   formatter:function(){
		      	      return'名称：'+this.x+'<br/>数值： '+Highcharts.numberFormat(this.y,2,'.')+"%";
		      	   }
		      	},
		        xAxis: {
		            categories: categories
		        },
		        yAxis: {
		            title: {
		                text: ''
		            }
		        },
		        plotOptions: {
		            column: {
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: false,
		                    formatter: function() {
		                        return this.y +'%';
		                    }
		                }
		            }
		        },
		       
		        series: [{
		            name: name,
		            data: data,
		        }],
		    })
		    .highcharts();
		};							
        
        function homepagecpulan(ret) {
        	var num1 = ret.throughput;
        	var num2 = ret.bandwidthusage;
        	var num3 = ret.vmcpuusage;
        	var num4 = ret.storagecentused;
        	var num5 = ret.storagedistused;
        	var num6 = ret.vmmemusage;
        	var num7 = ret.hostcpuusage;
        	var num8 = ret.hostmemusage;
        	//alert(num1+"--"+num2+"--"+num3+"--"+num4+"--"+num5+"--"+num6+"--"+num7+"--"+num8);
            $('#homepagethroughput').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false,
                    width:106,
                    height:98,
                },
                //colors:['deepskyblue','silver'],
                 colors:['#66c96f','#ccc'],
                title: {
                    text: num1+'%',
                    align: 'center',
                    verticalAlign: 'middle',
                    style:{
                    	fontSize: '11px',
                    }
                },
                credits:{
                    enabled: false,
                },
                tooltip: {
                    pointFormat: '数值: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white',
                                textShadow: '0px'
                            }
                        },
                        startAngle: -180,
                        endAngle: 180,
                    }
                },
                series: [{
                    type: 'pie',
                    name: '',
                    innerSize: '50%',
                    data: [
                        {
                            name: '吞吐利用率',
                            y: num1,
                            dataLabels: {
                                enabled: false
                            }
                        },
                        ['其它',100-num1],
                    ]
                }]
            }),
            
            $('#homepagebandwidth').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false,
                    width:106,
                    height:98,
                },
                colors:['#ff9c2a','#ccc'],
                title: {
                    text: num2+'%',
                    align: 'center',
                    verticalAlign: 'middle',
                    style:{
                    	fontSize: '11px',
                    }
                },
                credits:{
                    enabled: false,
                },
                tooltip: {
                    pointFormat: '数值: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white',
                                textShadow: '0px 1px 2px 0px'
                            }
                        },
                        startAngle: -180,
                        endAngle: 180,
                    }
                },
                series: [{
                    type: 'pie',
                    name: '',
                    innerSize: '50%',
                    data: [
                        {
                            name: '带宽利用率',
                            y: num2,
                            dataLabels: {
                                enabled: false
                            }
                        },
                        ['带宽剩余',100-num2],
                    ]
                }]
            }),
            $('#homepageinservercpu').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false
                },
                colors:['#59a70e','#ccc'],
                title: {
                    text: num3+'%',
                    align: 'center',
                    verticalAlign: 'middle',
                    style:{
                    	fontSize: '16px',
                    }
                },
                credits:{
                    enabled: false,
                },
                tooltip: {
                    pointFormat: '数值: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white',
                                textShadow: '0px 1px 2px 0px'
                            }
                        },
                        startAngle: -180,
                        endAngle: 180,
                    }
                },
                series: [{
                    type: 'pie',
                    name: '',
                    innerSize: '50%',
                    data: [
                        {
                            name: '虚拟机CPU利用率',
                            y: num3,
                            dataLabels: {
                                enabled: false
                            }
                        },
                        ['虚拟机CPU剩余',100-num3],
                    ]
                }]
            }),
            $('#homepageCentralized').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false
                },
                colors:['#ff7070','silver'],
                title: {
                    text: num4+'%',
                    align: 'center',
                    verticalAlign: 'middle',
                    style:{
                    	fontSize: '16px',
                    }
                },
                credits:{
                    enabled: false,
                },
                tooltip: {
                    pointFormat: '数值: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white',
                                textShadow: '0px 1px 2px 0px'
                            }
                        },
                        startAngle: -180,
                        endAngle: 180,
                    }
                },
                series: [{
                    type: 'pie',
                    name: '',
                    innerSize: '50%',
                    data: [
                        {
                            name: '集中存储利用率',
                            y: num4,
                            dataLabels: {
                                enabled: false
                            }
                        },
                        ['集中存储剩余',100-num4],
                    ]
                }]
            }),
            $('#homepageDistributed').highcharts({
            	 chart: {
                     plotBackgroundColor: null,
                     plotBorderWidth: 0,
                     plotShadow: false
                 },
                colors:['#23b1f3','#ccc'],
                title: {
                    text: num5+'%',
                    align: 'center',
                    verticalAlign: 'middle',
                    style:{
                    	fontSize: '16px',
                    }
                },
                credits:{
                    enabled: false,
                },
                tooltip: {
                    pointFormat: '数值: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white',
                                textShadow: '0px 1px 2px 0px'
                            }
                        },
                        startAngle: -180,
                        endAngle: 180,
                    }
                },
                series: [{
                    type: 'pie',
                    name: '',
                    innerSize: '50%',
                    data: [
                        {
                            name: '分布式存储利用率',
                            y: num5,
                            dataLabels: {
                                enabled: false
                            }
                        },
                        ['分布式存储剩余',100-num5],
                    ]
                }]
            }),
            $('#homepageinservermemory').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false
                },
                colors:['#fb320b','#ccc'],
                title: {
                    text: num6+'%',
                    align: 'center',
                    verticalAlign: 'middle',
                    style:{
                    	fontSize: '16px',
                    }
                },
                credits:{
                    enabled: false,
                },
                tooltip: {
                    pointFormat: '数值: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white',
                                textShadow: '0px 1px 2px 0px'
                            }
                        },
                        startAngle: -180,
                        endAngle: 180,
                    }
                },
                series: [{
                    type: 'pie',
                    name: '',
                    innerSize: '50%',
                    data: [
                        {
                            name: '虚拟机内存利用率',
                            y: num6,
                            dataLabels: {
                                enabled: false
                            }
                        },
                        ['虚拟机内存剩余',100-num6],
                    ]
                }]
            }),
            $('#homepageinhostcpu').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false
                },
                colors:['#4EEE94','#ccc'],
                title: {
                    text: num7+'%',
                    align: 'center',
                    verticalAlign: 'middle',
                    style:{
                    	fontSize: '16px',
                    }
                },
                credits:{
                    enabled: false,
                },
                tooltip: {
                    pointFormat: '数值: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white',
                                textShadow: '0px 1px 2px 0px'
                            }
                        },
                        startAngle: -180,
                        endAngle: 180,
                    }
                },
                series: [{
                    type: 'pie',
                    name: '',
                    innerSize: '50%',
                    data: [
                        {
                            name: '物理机内存利用率',
                            y: num7,
                            dataLabels: {
                                enabled: false
                            }
                        },
                        ['物理机内存剩余',100-num7],
                    ]
                }]
            }),
            $('#homepageinhostmemory').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false
                },
                colors:['#EE5C42','#ccc'],
                title: {
                    text: num8+'%',
                    align: 'center',
                    verticalAlign: 'middle',
                    style:{
                    	fontSize: '16px',
                    }
                },
                credits:{
                    enabled: false,
                },
                tooltip: {
                    pointFormat: '数值: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false,
                            distance: -50,
                            style: {
                                fontWeight: 'bold',
                                color: 'white',
                                textShadow: '0px 1px 2px 0px'
                            }
                        },
                        startAngle: -180,
                        endAngle: 180,
                    }
                },
                series: [{
                    type: 'pie',
                    name: '',
                    innerSize: '50%',
                    data: [
                        {
                            name: '物理机内存利用率',
                            y: num8,
                            dataLabels: {
                                enabled: false
                            }
                        },
                        ['物理机内存剩余',100-num8],
                    ]
                }]
            });
        }
        function passwdChange(){
        	window.parent.window.querymenu('%/systemMg/userMgr.jsp%');
        }
        
        function enterAlarm(){
        	window.parent.window.querymenu('%/alarmMg/eventActive.jsp%');
        }
        function refreshOne(){
        	//queryHighchartsOne();
        	queryHighcharts();
        } 
        
        function refreshTwo(){
        	//queryHighchartsTwo();
        	queryHighcharts();
        } 
        function Over(o){o.style.backgroundColor='#fff'; o.style.border='1px solid #58c9f3';}
        function Out(o){o.style.backgroundColor='#fff'; o.style.border='1px dotted #CCC';}

      //修改密码
      function passwordChange() {
        	$('<div></div>').dialog({
        		id: 'passwdID',
        		title: '密码修改',
        		width: 500,
        		height: 260,
        		closed: false,
        		cache: false,
        		href: '${ctx}/web/systemMg/passwordChange.jsp',
        		modal: true,
        		buttons: [{
        			text: '确定',
        			iconCls: 'icon-ok',
        			handler: function () {
        							
        				$('#passwdChange_email').val("${sessionUser.email}");
        				$('#passwdChange_Form').form('submit',{
        							url:'${pageContext.request.contextPath}/authMgr/changePasswd.do',
        							onSubmit:function(){
        						           var flag = passwdChangeCheck();
        						           if(!flag){
        						            return flag;  
        						           }
        						           return true;
        						         },
        							success:function(r){
        								var obj = jQuery.parseJSON(r);
        								if(obj.success){
        									$('#passwdID').dialog('close');							
        									$.messager.alert("提示", obj.msg+",请重新登录!", "info", function () {  
        										//logout(); 
        										//window.parent.location.href = "${pageContext.request.contextPath}/userMgr/logout.do";
        									    window.parent.location.href = "${pageContext.request.contextPath}/login.jsp";
        							        });  
        								}else{
        									$.messager.show({
        										title:'提示',
        										msg:obj.msg
        									});
        								}
        							}
        						});		
        			}
        		}, {
        			text: '取消',
        			iconCls: 'icon-cancel',
        			handler: function () {
        				$("#passwdID").dialog('destroy');
        			}
        		}]
        	});
       }
      
    </script>
		
	</head>
	<body>
		<div class="homepagecontainer">
		<!-- 上部 -->
			<div class="homepagecontainer_k"></div>
			<div class="homepagecontainer_top" >
				<div class="homepagecontainer_top_space" style="float: left;" onmouseover=Over(this); onmouseout=Out(this);>
					<div class="homepagecontainer_top_space_title">
						<div class=homepagecontainer_top_space_title_fant>账户信息</div>
						<img src="${ctx}/icp/style/images/admin2.png" />
						<div class="homeleft_top_center_name">
							<span title="用户名">${sessionUser.uname}</span> ·
							<%--
							<span title="用户类型">
								<c:if test="${sessionUser.usertype eq '1'}">政府客户</c:if>
								<c:if test="${sessionUser.usertype eq '2'}">企业客户</c:if>
								<c:if test="${sessionUser.usertype eq '3'}">公众客户</c:if>
								<c:if test="${sessionUser.usertype eq '4'}">管理员</c:if>
							</span>
							 --%>
							 <a href="#">
							 	<span onclick="passwordChange()">修改密码</span>
							</a>
						</div >
						<div class="homeleft_third">
							<div class="homeleft_third_one" style="border-right: 1px solid #ddd;">
								<a href="#">
									<p>
										<span title="邮箱">
											<c:if test="${sessionUser.email == null}">没有数据</c:if>
											<c:if test="${sessionUser.email!=null}">${sessionUser.email}</c:if>
										</span> 
										<br />
										<span title="手机">
											<c:if test="${sessionUser.mobile == null}">没有数据</c:if>
											<c:if test="${sessionUser.mobile!=null}">${sessionUser.mobile}</c:if>
										</span>
									</p> 
								</a>
							</div>
							<div class="homeleft_third_one">
								<a href="#">
									<p>
										<span id="gdname"  title="上次登陆时间">
											<c:if test="${sessionUser.lastlogin == null}">没有数据</c:if>
											<c:if test="${sessionUser.lastlogin!=null}">${sessionUser.lastlogin}</c:if>
											
										</span>
										<br />
										<span id="unitname" title="系统名称">
												<c:if test="${sessionUser.sysname == null}">没有数据</c:if>
											<c:if test="${sessionUser.sysname!=null}">${sessionUser.sysname}</c:if>
										</span>
									</p> 
								</a>
							</div>
						</div>
						<div class="homeleft_button">
							<a href="#" onclick="passwdChange()" >管理账户</a>
						</div>
					</div>
				</div>
				<div class="homepagecontainer_top_space" style="float: left;margin-left: 1.3%" onmouseover=Over(this); onmouseout=Out(this);>
<!-- 					 <div id="tabs"> -->
<!-- 				        <ul> -->
<!-- 				            <li><a href="${ctx}/icp/include/tab1.jsp">待办工单</a></li> -->
<!-- 				            <li><a href="${ctx}/icp/include/tab2.jsp">已办工单</a></li> -->
<!-- 				            <li><a href="${ctx}/icp/include/tab3.jsp">办结工单</a></li> -->
<!-- 				        </ul> -->
<!--   					  </div> -->
                <iframe id="omshomepage_frame" src="${ctx}/icp/include/tab0.jsp" style="width:100%;height:100%;border:0px"></iframe>	
				</div>
				<div class="homepagecontainer_top_space" style="float: right;" onmouseover=Over(this); onmouseout=Out(this);>
					<div class="homerighrt-up-space">
							<div class="homerighrt-up-space-fonts">
								<div class="homerighrt-up-space-fonts-span">
									<span>告警信息</span>
								</div>
								<div class="homerighrt-up-space-fonts-img">
									<img src="${ctx}/icp/style/images/enter.png"  onclick="enterAlarm()"/>
								</div>
							</div>
						</div>
						<div class="homerighrt-down-space">
							<div id="homealem-layout" class="easyui-layout"  >
								<div >
									<table id="alarmdg" style="background:#eee;text-align:center;"></table>
								</div>
							</div>
						</div>
				</div>
			</div>
		<!-- 中部 -->
			<div class="homepagecontainer_center">
				<div class="homepagecontainer_k"></div>
				<div class="homepagecontainer_center_top">
					<div class="homepagecontainer_center_top_space" style="width:24.5%;float: left;" onmouseover=Over(this); onmouseout=Out(this);>
						<div class="homepagecontainer_center_top_space_left_xg">
							<div class="homepagecontainer_center_top_space_right_backgroud_xg"></div>
						</div >
						<div class="homepagecontainer_center_top_space_left_left" style="cursor: pointer"title="租户数量" >
								<div class="homepagecontainer_center_top_space_left_left_top" style="cursor: pointer"title="租户数量" >
									<span  id = "homepageTenants" title="租户数量" >0</span>个
								</div>
								<div class="homepagecontainer_center_top_space_left_left_bottom">
									<span>租户数量</span>
								</div>
							</div>
						<div class="homepagecontainer_center_top_space_left_left" style="cursor: pointer"title="应用数量" >
								<div class="homepagecontainer_center_top_space_left_left_top" style="cursor: pointer"title="应用数量" >
									<span  id = "homepageRedApply" title="应用数量" >0</span>个
								</div>
								<div class="homepagecontainer_center_top_space_left_left_bottom">
									<span>应用数量</span>
								</div>
							</div>
					</div>
					<div class="homepagecontainer_center_top_space" style="width:74.5%;float: right;padding: 0;" onmouseover=Over(this); onmouseout=Out(this);>
						<div class="homepagecontainer_center_top_space_left">
							<div class="homepagecontainer_center_top_space_left_backgroud"></div>
							<div class="homepagecontainer_center_top_space_left_left" style="cursor: pointer"title="物理机数量" >
								<div class="homepagecontainer_center_top_space_left_left_top" style="cursor: pointer"title="物理机" >
									<span  id = "homepageInhost" title="物理机" >0</span>台
								</div>
								<div class="homepagecontainer_center_top_space_left_left_bottom">
									<span>物理机</span>
								</div>
							</div>
							<div class="homepagecontainer_center_top_space_left_left"  style="cursor: pointer"title="虚拟机数量" >
								<div class="homepagecontainer_center_top_space_left_left_top" style="cursor: pointer"title="虚拟机" >
									<span id = "homepageInserver"  title="虚拟机" >0</span>台
								</div>
								<div class="homepagecontainer_center_top_space_left_left_bottom">
									<span>虚拟机</span>
								</div>
							</div>
						</div>
						<div class="homepagecontainer_center_top_space_right">
							<div	class="homepagecontainer_center_top_space_right_left" >
								<div id = "homepageinhostcpu" class="homepagecontainer_center_top_space_right_left_top" ></div>
								<div class="homepagecontainer_center_top_space_right_left_botm"><span>物理机CPU利用率</span></div>
							</div>
							<div	class="homepagecontainer_center_top_space_right_left">
								<div id = "homepageinhostmemory" class="homepagecontainer_center_top_space_right_left_top" ></div>
								<div class="homepagecontainer_center_top_space_right_left_botm"><span>物理机内存利用率</span></div>
							</div>
							
						</div>
						<div class="homepagecontainer_center_top_space_right">
							<div	class="homepagecontainer_center_top_space_right_left">
								<div id = "homepageinservercpu"  class="homepagecontainer_center_top_space_right_left_top" ></div>
								<div class="homepagecontainer_center_top_space_right_left_botm"><span>虚拟机CPU利用率</span></div>
							</div>	 
							<div class="homepagecontainer_center_top_space_right_left">
								<div id = "homepageinservermemory" class="homepagecontainer_center_top_space_right_left_top" ></div>
								<div class="homepagecontainer_center_top_space_right_left_botm"><span>虚拟机内存利用率</span></div>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		<!-- 下部 -->
			<div class="homepagecontainer_k"></div>
			<div class="homepagecontainer_bottom">
				<div class="homepagecontainer_bottom_space" style="float: left;" onmouseover=Over(this); onmouseout=Out(this);>
					<div class="homecontainer-bot-left-space">
						<div class="homecontainer-bot-left-space-fonts">
								<span>CPU负荷TOP10</span>
								<img src="${ctx}/icp/style/images/refresh.png"  onclick="refreshOne()"/>
						</div>
					</div>
					<div class="homecontainer-bot-items-space">
						<div id="container" style="min-width:100%;height:100%"></div>
					</div>
				</div>
				<div class="homepagecontainer_bottom_space" style="float: right;" onmouseover=Over(this); onmouseout=Out(this);>
					<div class="homecontainer-bot-right-space">
						<div class="homecontainer-bot-right-space-fonts">
								<span>内存利用率TOP10</span>
								<img src="${ctx}/icp/style/images/refresh.png"  onclick="refreshTwo()"/>
						</div>
					</div>
					<div class="homecontainer-bot-items-space">
						<div id="container2" style="min-width:100%;height:100%"></div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>

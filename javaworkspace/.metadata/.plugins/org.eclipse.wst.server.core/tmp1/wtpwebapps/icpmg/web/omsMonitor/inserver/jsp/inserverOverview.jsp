<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.inspur.icpmg.systemMg.vo.UserEntity" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>虚拟机概况统计</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/inserver/css/inserverOverview.css" />
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/jquery.more.js" type="text/javascript" charset="UTF-8"></script>
	<%-- <script src="${pageContext.request.contextPath}/web/omsMonitor/inserver/js/inserverOverview.js" type="text/javascript" charset="UTF-8"></script> --%>
<%
UserEntity  entity = (UserEntity)session.getAttribute("sessionUser");
String datasql = entity.getDatasql();
String  unitid= entity.getUnitid();
String roleid = entity.getRoleid();
boolean isOperater = false;
if(StringUtils.isBlank(unitid)||StringUtils.isBlank(datasql)||roleid.contains("1000000050")||roleid.contains("1000000052")||roleid.contains("1000000049")||roleid.contains("1000000053")){
	isOperater = true;
}
%>

<script type="text/javascript">
 var isOperater = <%=isOperater%>;
$(document).ready(function() {
	if(!isOperater){
		//如果不是管理员账户，不需要显示平台选择下拉框
		$("#inserveroverview_platformdiv").css("display","none");
	}
	queryVmSummary();
	queryVmList();
	$('#inserveroverview_platformcombobox').combobox({
		onSelect: function(rec){
			$('#inserveroverview_searchplatform').val(rec.selekey);
			$("#inserveroverview_1").children().remove();
			afterChangePlatform();
			queryVmSummary();
		}
	});
   


});

//查询物理机统计
function queryVmSummary(){
	var platformId = $('#inserveroverview_searchplatform').val();
	$.ajax({
	  		type : 'post',
	  		url:'${pageContext.request.contextPath}/oms_summary/queryVmSummary.do?platformId='+platformId,
	  		success:function(retr){
	  			var ret =  JSON.parse(retr); 
	  			$('#inserveroverview_totnenum').html(ret.totnenum);
	  			$('#inserveroverview_errnenum').html(ret.errnenum);
	  			$('#inserveroverview_newnenum').html(ret.newnenum);
	  			$('#inserveroverview_outnenum').html(ret.outnenum);
	  			addInserveroverviewCensusDg(JSON.parse(ret.alarmsummary));
	  			addchart('inserveroverview_cpu_chart',JSON.parse(ret.cpuusagetop10));
	  			addchart('inserveroverview_mem_chart',JSON.parse(ret.memusagetop10));
	  			addInserveroverviewPie('inserveroverview_cpu_use_pie',ret.cpuusage);
	  			addInserveroverviewPie('inserveroverview_mem_use_pie',ret.memusage);
	  		}
	});
}

function addInserveroverviewCensusDg(datas){
	var inserveroverview_dg_width =($(".layout-panel-center").width()-40)*0.79/7 ; ;
    var sss = ($(".layout-panel-center").width()-20)*0.79;
    $("#inserveroverview_census_dg").datagrid({
    	pagination:false,//分页控件
		 showFooter:false,
		 width:sss,
		 height:300,
		pageSize:5,
		pageList:[5],
		align:'center',
		halign:'center',
		fitColumns:true,
		singleSelect:true,
		border:false,
		scrollbarSize:0,
        columns: [
            [
                {field: 'type', title: '类型', align: 'center', width: inserveroverview_dg_width},
                {
                    field: 'Serious', title: '严重', align: 'center', width: inserveroverview_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#F9243D';
                    }
                },
                {
                    field: 'Main', title: '主要', align: 'center', width: inserveroverview_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#FEBC3B';
                    }
                },
                {
                    field: 'Secondary', title: '次要', align: 'center', width: inserveroverview_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#4EC6BA';
                    }
                },
                {
                    field: 'General', title: '一般', align: 'center', width: inserveroverview_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#88CB5A';
                    }
                },
                {
                    field: 'Warning', title: '警告', align: 'center', width: inserveroverview_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#EB28DA';
                    }
                },
                {
                    field: 'Allnum', title: '总数', align: 'center', width: inserveroverview_dg_width + 1,
                    styler: function (value, row, index) {
                        return 'border-right:none';
                    }
                }
            ]
        ],
        data: datas
    });
}

function addchart(id,ret){
	
	var categories = ret.categories;
	var data = ret.data;
	new Highcharts.Chart({
        colors: ['#2EA2F9'],
        chart: {
            renderTo: id,
            type: 'column',
            height: 260,
            width:  ($(".layout-panel-center").width()-20)*0.79 * 0.49 
        },
        title: {
            text: null
        },
        legend: {
            enabled: false
        },
        credits: {
            enabled: false
        },
        tooltip:{
      	   formatter:function(){
      	      return'名称：'+this.x+'<br/>数值： '+Highcharts.numberFormat(this.y,2,'.')+"%";
      	   }
      	},
        xAxis: {
            tickWidth: '0',
            takemarkPlacement: 'on',
           // categories: ['主机一', '主机一', '主机一', '主机一', '主机一', '主机一', '主机一', '主机一', '主机一', '主机一']
            categories:categories
        },
        yAxis: {
            title: {
                text: null
            },
        },
        series: [{
            //data: [100, 90, 80, 70, 60, 50, 40, 30, 20, 10]
        	data:data
        }]
    });
}

function addInserveroverviewPie(id,num){
	var newnum = 0;
	if(num > 100){
		newnum = 100;
	}else{
		newnum = num;
	}
	 new Highcharts.Chart({
	        chart: {
	            renderTo: id,
	            type: 'pie',
	            width: 180,
	            height: 180
	        },
	        title: {
	        	text: num+'%',
	            verticalAlign: 'middle',
	            y: 9,
	            style: {
	                color: '#1DBEAF',
	                fontSize: '25px'
	            }
	        },
	        legend: {
	            enabled: false
	        },
	        tooltip: {
	            enabled: false
	        },
	        credits: {
	            enabled: false
	        },
	        plotOptions: {
	            pie: {
	                dataLabels: {
	                    enabled: false
	                },
	                colors: ['#1DBEAF', '#E5E5E5']
	            }
	        },
	        series: [{
	            data: [newnum, 100-newnum],
	            innerSize: '70%',
	            states: {
	                hover: {
	                    enabled: false
	                }
	            }
	        }]
	    });
}

//查询虚拟机设备列表
function queryVmList(){
	 $('#inserverOverviewmore').more({'address': '${pageContext.request.contextPath}/oms_summary/queryVmList.do'});
}

//按条件查询物理主机设备列表
function searchVmServerList(value,name){
	if (typeof(value) == "undefined") {
		   value = "";
		}
	$("#inserveroverview_1").children().remove();
	var onclicktypes = $("#inserveronclicktype").val();
	var platformId = $('#inserveroverview_searchplatform').val();
	var orgUrl = '${pageContext.request.contextPath}/oms_summary/queryVmList.do?nename='+value;
	$.ajax({
  		type : 'post',
  		url:encodeURI(orgUrl),
  		data:{
  			last:'0',
  			amount:'5',
  			onclicktype:onclicktypes,
  			platformId:platformId
  			
  		},
  		success:function(retr){
  			var data =  JSON.parse(retr); 
  			$("#inserveroverview_searchtype").val("1");
  			$("#inserveroverview_searchvalue").val(value);
  			if(data){
	       		 for(var i=0;i<data.length;i++){
	       			 var aa = data[i];
	       			 $("#inserveroverview_1").append("<div  class='inserveroverview_list'><div class='inserveroverview_list_one' title="+aa.neid+">" + aa.neid+ "</div><div class='inserveroverview_list_two'>" + changecolor(aa.opstat)+ "</div><div class='inserveroverview_list_three' style='color:blue;cursor: pointer;' onclick='JumpInserverPage(this)'>详情</div><input type=hidden value="+aa.neid+"></input></div>");
	       		 }
       		}
  		}
	});
}
function JumpInserverPage(ele){
	var neid = $(ele).next().val();
	var orghref = '/icpmg/web/omsMonitor/inserver/jsp/runOverview.jsp';
	var oskhref = '/icpmg/web/omsMonitor/inserver/jsp/osRunOverview.jsp';
	
	var platformTypeUrl = '${pageContext.request.contextPath}/oms_summary/queryVmPlatformType.do';
	$.ajax({
  		type : 'post',
  		url:encodeURI(platformTypeUrl),
  		data:{
  			serverId:neid  			
  		},
  		dataType:'json',
  		success:function(retr){
  		   var currentServerName = retr.servername;
  		   var currentPlattype =	retr.plattype;
  			if(currentPlattype == 'vmware'){
  				$('#centerTab').panel({
  					href:encodeURI(orghref),
  					queryParams:{
  						neid:neid
  					}
  					});	
  				
  			}else if(currentPlattype == 'openstack'){
  				$('#centerTab').panel({
  					href:encodeURI(oskhref),
  					queryParams:{
  						nename:currentServerName,
  						neid:neid
  					}
  					});	 				
  			}else{
  				$('#centerTab').panel({
  					href:encodeURI(orghref),
  					queryParams:{
  						neid:neid
  					}
  					});	
  				
  			}
  			
  			
  		}
	});
	
	
	

}

function afterChangePlatform(){
	var platformId = $('#inserveroverview_searchplatform').val();
	var onclicktypes = $("#inserveronclicktype").val();
	var orgUrl = '${pageContext.request.contextPath}/oms_summary/queryVmList.do';
		$.ajax({
	  		type : 'post',
	  		url:encodeURI(orgUrl),
	  		data:{
	  			last:'0',
	  			amount:'5',
	  			onclicktype:onclicktypes,
	  			platformId:platformId
	  			
	  		},
	  		success:function(retr){
	  			var data =  JSON.parse(retr); 
	  			$("#inserveroverview_searchtype").val("1");
	  			$("#inserveroverview_searchvalue").val("");
	  			$("#inserveroverview_searchbox").searchbox('clear');
	  			if(data){
		       		 for(var i=0;i<data.length;i++){
		       			 var aa = data[i];
		       			 $("#inserveroverview_1").append("<div  class='inserveroverview_list'><div class='inserveroverview_list_one' title="+aa.neid+">" + aa.neid+ "</div><div class='inserveroverview_list_two'>" + changecolor(aa.opstat)+ "</div><div class='inserveroverview_list_three' style='color:blue;cursor: pointer;' onclick='JumpInserverPage(this)'>详情</div><input type=hidden value="+aa.neid+"></input></div>");
		       		 }
	       		}
	  		}
		});
	 
}

function inserverNum(onclicktype){
	if(onclicktype=='all'){
		$("#inserveronclickall").css('border','1px solid #58c9f3');
		$("#inserveronclickerr").css('border','1px solid #DDDDDD');
		$("#inserveronclicknew").css('border','1px solid #DDDDDD');
		$("#inserveronclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='err'){
		$("#inserveronclickall").css('border','1px solid #DDDDDD');
		$("#inserveronclickerr").css('border','1px solid #58c9f3');
		$("#inserveronclicknew").css('border','1px solid #DDDDDD');
		$("#inserveronclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='new'){
		$("#inserveronclickall").css('border','1px solid #DDDDDD');
		$("#inserveronclickerr").css('border','1px solid #DDDDDD');
		$("#inserveronclicknew").css('border','1px solid #58c9f3');
		$("#inserveronclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='out'){
		$("#inserveronclickall").css('border','1px solid #DDDDDD');
		$("#inserveronclickerr").css('border','1px solid #DDDDDD');
		$("#inserveronclicknew").css('border','1px solid #DDDDDD');
		$("#inserveronclickout").css('border','1px solid #58c9f3');
	}
	$("#inserveronclicktype").val(onclicktype);
	searchVmServerList();
}
</script>
<input type="hidden" id="inserveronclicktype" ></input>
	<!--container包含容器-->
	<div class="inserveroverview_container">
	  	 <!--左侧-->
	    <div class="inserveroverview_left">
	    	<div class="inserveroverview_number">
		    	 <div class="inserveroverview_status"  style="cursor: pointer;" id ="inserveronclickall" onclick="inserverNum('all')">
		    	 	 <div id="inserveroverview_img_all" style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/host.png)"></div>
	                <span class="inserveroverview_num" id="inserveroverview_totnenum">0</span>
	                <span class="inserveroverview_name">总台数</span>
		    	 </div>
		    	 <div class="inserveroverview_status" style="float: left;margin-left: 1%;cursor: pointer;" id ="inserveronclickerr" onclick="inserverNum('err')">
		    	 	<div id="inserveroverview_img_fault" style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/host.png)"></div>
	                <span class="inserveroverview_num" id="inserveroverview_errnenum">0</span>
	                <span class="inserveroverview_name">未启动台数</span>
		    	 </div>
		    	 <div class="inserveroverview_status" style="float: left;margin-left: 1%;cursor: pointer;" id ="inserveronclicknew"  onclick="inserverNum('new')">
		    	 	 <div id="inserveroverview_img_new"  style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/host.png)"></div>
	                <span class="inserveroverview_num" id="inserveroverview_newnenum">0</span>
	                <span class="inserveroverview_name">本月新增数</span>
		    	 </div>
		    	 <div class="inserveroverview_status" style="float: right;cursor: pointer;" id ="inserveronclickout"  onclick="inserverNum('out')">
		    	 	<div id="inserveroverview_img_offline"  style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inserver/img/host.png)"></div>
	                <span class="inserveroverview_num" id="inserveroverview_outnenum">0</span>
	                <span class="inserveroverview_name">本月退网数</span>
		    	 </div>
		    </div>
		    <div class="inserveroverview_kk"></div>
		      <!--信息统计-->
	        <div class="inserveroverview_inf">
	        	<span class="inserveroverview_span">信息统计</span>
	        	 <!--信息统计左部分-->
	            <div id="inserveroverview_inf_left">
	            	 <span id="inserveroverview_inf_left_span">最大CPU利用率</span>
	                <!--CPU利用率圆环图-->
	                <div id="inserveroverview_cpu_use_pie"></div>
	            </div>
	             <!--信息统计右部分-->
	            <div id="inserveroverview_inf_right">
	                <span id="inserveroverview_inf_right_span">最大内存利用率</span>
	                <!--内存利用率圆环图-->
	                <div id="inserveroverview_mem_use_pie"></div>
	            </div>
	        </div>
	        <!--设备告警信息统计-->
	        <div id="inserveroverview_census">
	        	<span class="inserveroverview_span">设备告警信息统计</span>
	            <table id="inserveroverview_census_dg"></table>
	        </div>
	        <!--图表监控-->
	        <div id="inserveroverview_charts">
	        	 <!--CPU负载监控-->
	            <div id="inserveroverview_cpu">
	                <span class="inserveroverview_span">CPU负荷TOP10</span>
	                <div id="inserveroverview_cpu_chart"></div>
	            </div>
	             <!--内存负载监控-->
	            <div id="inserveroverview_mem">
	                <span class="inserveroverview_span">内存利用率TOP10</span>
	                <div id="inserveroverview_mem_chart"></div>
	            </div>
	        </div>
	    </div>
	     <!--右侧-->
	    <div class="inserveroverview_right">
	    	<div class="inhostoverview_right_all">
	    	 	   <div id="inserveroverview_platformdiv" class = "inserveroverview_right_all_title">
			    		 <span class="inserveroverview_right_span">平台选择</span>
			    		 <div class = "inserveroverview_right_all_title_right">
			    		 	<input id='inserveroverview_platformcombobox' class="easyui-combobox"  style="width:120px;height:20px;align-text:center" data-options="value:'-1',multiple:false, valueField:'selekey',textField:'selevalue',url:'${pageContext.request.contextPath}/common/getPlatformSelelist.do?defaultSelect=-1' "/>
			    		 	<input id='inserveroverview_searchplatform' type=hidden ></input>
			    		 	
			    		 </div>
			    	</div>
	    	
	    		<div class = "inserveroverview_right_all_title">
			    		 <span class="inserveroverview_right_span">设备列表</span>
			    		 <div class = "inserveroverview_right_all_title_right">
			    		 	<input id='inserveroverview_searchbox'  class="easyui-searchbox"  style="width:120px;height:20px;align-text:center" data-options="searcher:searchVmServerList,prompt:'请输入名称查询' "/>
			    		 	<input id='inserveroverview_searchtype' type=hidden ></input>
			    		 	<input id='inserveroverview_searchvalue' type=hidden ></input>
			    		 </div>
			    	</div>
	        <div id="inserveroverview_list" class="inserveroverview_list">
	                <div class="inserveroverview_list_one" >名称</div>
			        <div class="inserveroverview_list_two">状态</div>
			        <div class="inserveroverview_list_three">操作</div>
	        </div>
	        <div id="inserveroverview_1"></div>
	        <!-- <span id="inserveroverview_more">more...</span> -->
	        <div id="inserverOverviewmore">
	                    <div class="single_item" >
	                    	<div class="neid" ></div>
	                    	<div class="nename" ></div>
	                    	<div class="opstat" ></div>
	                    </div>
	                    <div style="width: 100%;height: 30px;line-height: 30px;">
	                    	<a href="javascript:;" class="get_more" style="float: right; ">点击加载更多内容</a>
	                    </div>
	                </div>
	    	</div>
	    </div>
	</div>
</body>
</html>
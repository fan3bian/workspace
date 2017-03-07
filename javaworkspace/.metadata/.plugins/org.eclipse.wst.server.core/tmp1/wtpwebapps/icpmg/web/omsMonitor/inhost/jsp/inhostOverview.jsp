<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>物理主机服务</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/inhost/css/inhostOverview.css" />
	<script src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/jquery.more.js" type="text/javascript" charset="UTF-8"></script>
	<%-- <script src="${pageContext.request.contextPath}/web/omsMonitor/hostservice/js/hostserviceOverview.js" type="text/javascript" charset="UTF-8"></script> --%>
	
	
<script type="text/javascript">

$(document).ready(function() {
	queryInhostSummary();
	queryInhostList();
});

//查询物理主机统计
function queryInhostSummary(){
	$.ajax({
  		type : 'post',
  		url:'${pageContext.request.contextPath}/oms_summary/queryInhostSummary.do',
  		success:function(retr){
  			var ret =  JSON.parse(retr); 
  			$('#hostserviceoverview_totnenum').html(ret.totnenum);
  			$('#hostserviceoverview_errnenum').html(ret.errnenum);
  			$('#hostserviceoverview_newnenum').html(ret.newnenum);
  			$('#hostserviceoverview_outnenum').html(ret.outnenum);
  			addInhostoverviewDatagrid(JSON.parse(ret.alarmsummary));
  			addchart('hostserviceoverview_cpu_chart',JSON.parse(ret.cpuusagetop10));
  			addchart('hostserviceoverview_mem_chart',JSON.parse(ret.memusagetop10));
  			addchart2('hostserviceoverview_flow_in_chart',JSON.parse(ret.innictop10));
  			addchart2('hostserviceoverview_flow_out_chart',JSON.parse(ret.outnictop10));
  		}
	});
}

function addInhostoverviewDatagrid(datas){
	var census_width =  ($(".layout-panel-center").width()-20)*0.79;
    var hostserviceoverview_census_dg_width = ($(".layout-panel-center").width()-40)*0.79/7;
    $("#hostserviceoverview_census_dg").datagrid({
    	 pagination:false,//分页控件
		 showFooter:false,
		 width:census_width,
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
                {field: 'type', title: '类型', align: 'center', width: hostserviceoverview_census_dg_width},
                {
                    field: 'Serious', title: '严重', align: 'center', width: hostserviceoverview_census_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#F9243D'
                    }
                },
                {
                    field: 'Main', title: '主要', align: 'center', width: hostserviceoverview_census_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#FEBC3B'
                    }
                },
                {
                    field: 'Secondary', title: '次要', align: 'center', width: hostserviceoverview_census_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#4EC6BA'
                    }
                },
                {
                    field: 'General', title: '一般', align: 'center', width: hostserviceoverview_census_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#88CB5A'
                    }
                },
                {
                    field: 'Warning', title: '警告', align: 'center', width: hostserviceoverview_census_dg_width,
                    styler: function (value, row, index) {
                        return 'color:#EB28DA'
                    }
                },
                {
                    field: 'Allnum', title: '总数', align: 'center', width: hostserviceoverview_census_dg_width + 1,
                    styler: function (value, row, index) {
                        return 'border-right:none'
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
function addchart2(id,ret){
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
     	      return'名称：'+this.x+'<br/>数值： '+Highcharts.numberFormat(this.y/1000000,2,'.')+' M';
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

//查询物理主机设备列表
function queryInhostList(){
	 $('#hosrserverOverviewmore').more({'address': '${pageContext.request.contextPath}/oms_summary/queryInhostList.do'});
}
//按条件查询物理主机设备列表
function searchHostServerList(value,name){
	$("#hostserviceoverview_1").children().remove();
	if (typeof(value) == "undefined") {
		   value = "";
		}
	if (typeof(name) == "undefined") {
		name = "";
		}
	var onclicktypes = $("#inhostonclicktype").val();
	var orgUrl = '${pageContext.request.contextPath}/oms_summary/queryInhostList.do?nename='+value;
	$.ajax({
  		type : 'post',
  		url:encodeURI(orgUrl),
  		data:{
  			last:'0',
  			amount:'5',
  			onclicktype:onclicktypes
  		},
  		success:function(retr){
  			var data =  JSON.parse(retr);  
  			$("#hostserviceoverview_searchtype").val("1");
  			$("#hostserviceoverview_searchvalue").val(value);
  			if(data){
	       		 for(var i=0;i<data.length;i++){
	       			 var aa = data[i];
	       			 $("#hostserviceoverview_1").append("<div  class='hostserviceoverview_list'><div class='hostserviceoverview_list_one' title="+aa.unitname+">" + aa.unitname+ "</div><div class='hostserviceoverview_list_two'>" + aa.num+ "</div><div class='hostserviceoverview_list_three' style='color:blue;cursor: pointer;' onclick='JumpHostServerPage(this)'>详情</div><input type=hidden value="+aa.unitid+"></input></div>");
	       		 }
       		}
  		}
	});
}

function JumpHostServerPage(ele){
	var unitid = $(ele).next().val();
	var orghref = '/icpmg/web/omsMonitor/inhost/jsp/inhostUserOverview.jsp';
	$('#centerTab').panel({
		href:encodeURI(orghref),
		queryParams:{
			unitid:unitid
		}
	});	
}

function inhostNum(onclicktype){
	if(onclicktype=='all'){
		$("#inhostonclickall").css('border','1px solid #58c9f3');
		$("#inhostonclickerr").css('border','1px solid #DDDDDD');
		$("#inhostonclicknew").css('border','1px solid #DDDDDD');
		$("#inhostonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='err'){
		$("#inhostonclickall").css('border','1px solid #DDDDDD');
		$("#inhostonclickerr").css('border','1px solid #58c9f3');
		$("#inhostonclicknew").css('border','1px solid #DDDDDD');
		$("#inhostonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='new'){
		$("#inhostonclickall").css('border','1px solid #DDDDDD');
		$("#inhostonclickerr").css('border','1px solid #DDDDDD');
		$("#inhostonclicknew").css('border','1px solid #58c9f3');
		$("#inhostonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='out'){
		$("#inhostonclickall").css('border','1px solid #DDDDDD');
		$("#inhostonclickerr").css('border','1px solid #DDDDDD');
		$("#inhostonclicknew").css('border','1px solid #DDDDDD');
		$("#inhostonclickout").css('border','1px solid #58c9f3');
	}
	$("#inhostonclicktype").val(onclicktype);
	searchHostServerList();
}
</script>
<input type="hidden" id="inhostonclicktype" ></input>
		<!--外层包含容器container-->
		<div class="hostserviceoverview_container">
		    <!--左侧-->
		    <div class="hostserviceoverview_left">
		        <!--顶部数量监控-->
		        <div class="hostserviceoverview_number">
		            <div class="hostserviceoverview_status" style="margin-right: 1%;cursor: pointer;"  id="inhostonclickall"  onclick="inhostNum('all')">
		                <div class="hostserviceoverview_img_all" 
		                style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/host.png)"></div>
		                <span class="hostserviceoverview_num" id="hostserviceoverview_totnenum">0</span>
		                <span class="hostserviceoverview_name">总台数</span>
		            </div>
		            <div class="hostserviceoverview_status" style="margin-right: 1%;cursor: pointer;" id ="inhostonclickerr" onclick="inhostNum('err')">
		                <div class="hostserviceoverview_img_fault" 
		                style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/host.png)"></div>
		                <span class="hostserviceoverview_num" id="hostserviceoverview_errnenum">0</span>
		                <span class="hostserviceoverview_name">未启动台数</span>
		            </div>
		            <div class="hostserviceoverview_status" style="cursor: pointer;" id ="inhostonclicknew" onclick="inhostNum('new')">
		                <div class="hostserviceoverview_img_new" 
		                style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/host.png)"></div>
		                <span class="hostserviceoverview_num" id="hostserviceoverview_newnenum">0</span>
		                <span class="hostserviceoverview_name">本月新增数</span>
		            </div>
		            <div class="hostserviceoverview_status" style="margin-right: 0px;float: right;cursor: pointer;" id ="inhostonclickout" onclick="inhostNum('out')">
		                <div class="hostserviceoverview_img_offline" 
		                style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/host.png)"></div>
		                <span class="hostserviceoverview_num"  id="hostserviceoverview_outnenum">0</span>
		                <span class="hostserviceoverview_name">本月退网数</span>
		            </div>
		            <div class="hostserviceoverview_clear"></div>
		        </div>
		        <!--告警信息统计-->
		        <div id="hostserviceoverview_census">
		           <div class="inhostoverview_title"> <span class="hostserviceoverview_span">设备告警信息统计</span></div>
		            <table id="hostserviceoverview_census_dg"></table>
		        </div>
		        <!--图表监控-->
		        <div class="hostserviceoverview_charts">
		            <!--CPU负载监控-->
		            <div class="hostserviceoverview_cpu" style="overflow: hidden;">
		               <div class="inhostoverview_title"> <span class="hostserviceoverview_span">CPU负荷TOP10</span></div>
		                <div id="hostserviceoverview_cpu_chart"></div>
		            </div>
		            <!--内存负载监控-->
		            <div class="hostserviceoverview_mem" style="margin-right: 0px;overflow: hidden;">
		               <div class="inhostoverview_title"> <span class="hostserviceoverview_span">内存利用率TOP10</span></div>
		                <div id="hostserviceoverview_mem_chart"></div>
		            </div>
		            <!--流入带宽监控-->
		            <div class="hostserviceoverview_flow_in" style="overflow: hidden;">
		               <div class="inhostoverview_title"> <span class="hostserviceoverview_span">流入带宽TOP10</span></div>
		                <div id="hostserviceoverview_flow_in_chart"></div>
		            </div>
		            <!--流出带宽监控-->
		            <div class="hostserviceoverview_flow_out" style="margin-right: 0px;overflow: hidden;">
		               <div class="inhostoverview_title"> <span class="hostserviceoverview_span">流出带宽TOP10</span></div>
		                <div id="hostserviceoverview_flow_out_chart"></div>
		            </div>
		            <div class="hostserviceoverview_clear"></div>
		        </div>
		    </div>
		    <!--右侧-->
		    <div class="hostserviceoverview_right">
		    	<div class="hostserviceoverview_right_all">
			    	<div class = "hostserviceoverview_right_all_title">
			    		 <span class="hostserviceoverview_span">用户列表</span>
			    		 <div class = "hostserviceoverview_right_all_title_right">
			    		 	<input class="easyui-searchbox"  style="width:120px;height:20px;align-text:center" data-options="searcher:searchHostServerList,prompt:'请输入用户查询' "/>
			    		 	<input id='hostserviceoverview_searchtype' type=hidden ></input>
			    		 	<input id='hostserviceoverview_searchvalue' type=hidden ></input>
			    		 </div>
			    	</div>
			        <div id="hostserviceoverview_list" class="hostserviceoverview_list">
			                <div class="hostserviceoverview_list_one" >用户</div>
			                 <div class="hostserviceoverview_list_two" >台数</div>
			                 <div class="hostserviceoverview_list_three" >操作</div>
			        </div>
		        	<div id="hostserviceoverview_1"></div>
		        	<div id="hosrserverOverviewmore">
	                    <div class="single_item" ></div>
	                    <div style="width: 100%;height: 30px;line-height: 30px;">
	                    	<a href="javascript:;" class="get_more" style="float: right; ">点击加载更多内容</a>
	                    </div>
	                </div>
		    	</div>
		    </div>
		    <div class="hostserviceoverview_clear"></div>
		</div>
</body>
</html>
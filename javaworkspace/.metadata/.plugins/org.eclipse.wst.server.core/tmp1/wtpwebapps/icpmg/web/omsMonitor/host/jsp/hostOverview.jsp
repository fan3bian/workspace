<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>物理机概况</title>
<!-- <meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> -->
</head>
<body>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/host/css/hostOverview.css" />
	<script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/host/js/jquery.more.js" charset="UTF-8"></script>
	<%-- <script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/inhostOverview.js" charset="UTF-8"></script> --%>
	
<script type="text/javascript">

$(document).ready(function() {
	queryHostSummary();
	queryHostList();
});

//查询物理机统计
function queryHostSummary(){
	$.ajax({
	  		type : 'post',
	  		url:'${pageContext.request.contextPath}/oms_summary/queryHostSummary.do',
	  		success:function(retr){
	  			var ret =  JSON.parse(retr); 
	  			$('#inhostoverview_totnenum').html(ret.totnenum);
	  			$('#inhostoverview_errnenum').html(ret.errnenum);
	  			$('#inhostoverview_newnenum').html(ret.newnenum);
	  			$('#inhostoverview_outnenum').html(ret.outnenum);
	  			addInhostoverviewDatagrid(JSON.parse(ret.alarmsummary));
	  			addchart('inhostoverview_cpu_chart',JSON.parse(ret.cpuusagetop10));
	  			addchart('inhostoverview_mem_chart',JSON.parse(ret.memusagetop10));
	  			addchart2('inhostoverview_flow_in_chart',JSON.parse(ret.innictop10));
	  			addchart2('inhostoverview_flow_out_chart',JSON.parse(ret.outnictop10));
	  		}
	});
}

function addInhostoverviewDatagrid(datas){
    var inhostoverview_census_dg_width =($(".layout-panel-center").width()-40)*0.79/7;
    var sss = ($(".layout-panel-center").width()-20)*0.79;
    $("#inhostoverview_census_dg").datagrid({
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
                {
                	field: 'type', title: '类型', align: 'center', width: inhostoverview_census_dg_width
                },
                {
                    field: 'Serious', title: '严重', align: 'center', width: inhostoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#F9243D';
	                    }
                },
                {
                    field: 'Main', title: '主要', align: 'center', width: inhostoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#FEBC3B';
	                    }
                },
                {
                    field: 'Secondary', title: '次要', align: 'center', width: inhostoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#4EC6BA';
	                    }
                },
                {
                    field: 'General', title: '一般', align: 'center', width: inhostoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#88CB5A';
	                    }
                },
                {
                    field: 'Warning', title: '警告', align: 'center', width: inhostoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#EB28DA';
	                    }
                },
                {
                    field: 'Allnum', title: '总数', align: 'center', width: inhostoverview_census_dg_width,
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
        tooltip:{
     	   formatter:function(){
     	      return'名称：'+this.x+'<br/>数值： '+Highcharts.numberFormat(this.y,2,'.')+"%";
     	   }
     	},
        credits: {
            enabled: false
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


//查询物理机设备列表
function queryHostList(){
	 $('#inhostOverviewmore').more({'address': '${pageContext.request.contextPath}/oms_summary/queryHostList.do'});
}

//按条件查询物理机设备列表
function searchHostList(value,name){
	if (typeof(value) == "undefined") {
		   value = "";
		}
	if (typeof(name) == "undefined") {
		name = "";
		}
	$("#inhostoverview_1").children().remove();
	var onclicktypes = $("#hostonclicktype").val();
	var orgUrl = '${pageContext.request.contextPath}/oms_summary/queryHostList.do?nename='+value+'&typeid='+name;
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
  			$("#inhostoverview_searchtype").val("1");
  			$("#inhostoverview_searchvalue").val(value);
  			$("#inhostoverview_searchname").val(name);
  			if(data){
	       		 for(var i=0;i<data.length;i++){
	       			 var aa = data[i];
	       			 $("#inhostoverview_1").append("<div  class='inhostoverview_list'><div class='inhostoverview_list_one' title="+aa.nename+">" + aa.nename+ "</div><div class='inhostoverview_list_two'>" + changecolor(aa.opstat)+ "</div><div class='inhostoverview_list_three' style='color:blue;cursor: pointer;' onclick='JumpInhostPage(this)'>详情</div><input type=hidden value="+aa.neid+"></input></div>");
	       		 }
       		}
  		}
	});
}
function JumpInhostPage(ele){
	var neid = $(ele).next().val();
	var orgUrl = '/icpmg/web/omsMonitor/inhost/jsp/runOverview.jsp';
	
	//alert(neid);
	$('#centerTab').panel({
		href:encodeURI(orgUrl),
		queryParams:{
			typeid:'HOST',
			neid:neid
		}
		});	
}

function hostNum(onclicktype){
	if(onclicktype=='all'){
		$("#hostonclickall").css('border','1px solid #58c9f3');
		$("#hostonclickerr").css('border','1px solid #DDDDDD');
		$("#hostonclicknew").css('border','1px solid #DDDDDD');
		$("#hostonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='err'){
		$("#hostonclickall").css('border','1px solid #DDDDDD');
		$("#hostonclickerr").css('border','1px solid #58c9f3');
		$("#hostonclicknew").css('border','1px solid #DDDDDD');
		$("#hostonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='new'){
		$("#hostonclickall").css('border','1px solid #DDDDDD');
		$("#hostonclickerr").css('border','1px solid #DDDDDD');
		$("#hostonclicknew").css('border','1px solid #58c9f3');
		$("#hostonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='out'){
		$("#hostonclickall").css('border','1px solid #DDDDDD');
		$("#hostonclickerr").css('border','1px solid #DDDDDD');
		$("#hostonclicknew").css('border','1px solid #DDDDDD');
		$("#hostonclickout").css('border','1px solid #58c9f3');
	}
	$("#hostonclicktype").val(onclicktype);
	searchHostList();
}

</script>
<input type="hidden" id="hostonclicktype" ></input>
		<!--外层包含容器container-->
		<div class="inhostoverview_container">
			<!--左侧-->
			<div class="inhostoverview_left">
				<div class="inhostoverview_number">
					 <div class="inhostoverview_status" style="cursor: pointer;"  id="hostonclickall"  onclick="hostNum('all')">
					 	<div id="inhostoverview_img_all"  style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/host.png)"></div>
		                <span class="inhostoverview_num" id="inhostoverview_totnenum">0</span>
		                <span class="inhostoverview_name">总台数</span>
					 </div>
					 <div class="inhostoverview_status" style="float: left;margin-left: 1%;cursor: pointer;" id ="hostonclickerr" onclick="hostNum('err')">
					 	<div id="inhostoverview_img_fault"   style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/host.png)"></div>
		                <span class="inhostoverview_num" id="inhostoverview_errnenum">0</span>
		                <span class="inhostoverview_name">未启动台数</span>
					 </div>
					 <div class="inhostoverview_status" style="float: left;margin-left: 1%;cursor: pointer;" id ="hostonclicknew" onclick="hostNum('new')">
					 	<div id="inhostoverview_img_new"   style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/host.png)"></div>
		                <span class="inhostoverview_num" id="inhostoverview_newnenum">0</span>
		                <span class="inhostoverview_name">本月新增数</span>
					 </div>
					 <div class="inhostoverview_status" style="float: right;cursor: pointer;" id ="hostonclickout" onclick="hostNum('out')">
					 	<div id="inhostoverview_img_offline"   style="background-image: url(${pageContext.request.contextPath}/web/omsMonitor/inhost/img/host.png)"></div>
		                <span class="inhostoverview_num" id="inhostoverview_outnenum">0</span>
		                <span class="inhostoverview_name">本月退网数</span>
					 </div>
				</div>
				<!--告警信息统计-->
				<div class="inhostoverview_census">
				<div class="inhostoverview_title"><span class="inhostoverview_span">设备告警信息统计</span></div>
					
		            <table id="inhostoverview_census_dg"></table>
				</div>
				 <!--图表监控-->
		        <div class="inhostoverview_charts">
		        	 <!--CPU负载监控-->
		            <div class="inhostoverview_cpu"><div class="inhostoverview_title"><span class="inhostoverview_span">CPU负荷TOP10</span></div>
		            	
		                <div id="inhostoverview_cpu_chart"></div>
		            </div>
		             <!--内存负载监控-->
		            <div class="inhostoverview_mem" ><div class="inhostoverview_title"> <span class="inhostoverview_span">内存利用率TOP10</span></div>
		               
		                <div id="inhostoverview_mem_chart"></div>
		            </div>
		        </div>
		        <div class="inhostoverview_charts" style="margin-bottom: 65px;">
		        	 <!--CPU负载监控-->
		            <div class="inhostoverview_cpu"><div class="inhostoverview_title"><span class="inhostoverview_span">流入带宽TOP10</span></div>
		            	
		                <div id="inhostoverview_flow_in_chart"></div>
		            </div>
		             <!--内存负载监控-->
		            <div class="inhostoverview_mem" >
		               <div class="inhostoverview_title"> <span class="inhostoverview_span">流出带宽TOP10</span></div>
		                <div id="inhostoverview_flow_out_chart"></div>
		            </div>
		        </div>
		        
			</div>
			
			 <!--右侧-->
		    <div class="inhostoverview_right">
		    	 <div class = "inhostoverview_right_all">
		    	 	 <div class = "inhostoverview_right_all_title">
			    		 <span class="inhostoverview_span">设备列表</span>
			    		 <div class = "inhostoverview_right_all_title_right">
			    		 <input id = "inhostoverview_searchmmss" class="easyui-searchbox"  style="width:140px;height:20px;align-text:center" data-options="searcher:searchHostList,prompt:'输入名称查询' ,menu:'#inhostoverview_searchmm'"/>
			    		 	<input id='inhostoverview_searchtype' type=hidden ></input>
			    		 	<input id='inhostoverview_searchvalue' type=hidden ></input>
			    		 	<input id='inhostoverview_searchname' type=hidden ></input>
			    		 <div id="inhostoverview_searchmm" style="width:120px"> 
							<div data-options="name:'all' " onclick="searchHostList('','all')">全部</div> 
							<div data-options="name:'vm'" onclick="searchHostList('','vm')">宿主机</div>
							<div data-options="name:'other'"  onclick="searchHostList('','other')">其他</div> 
							</div>
			    		 </div>
			    	</div>
			        <div id="inhostoverview_list" class="inhostoverview_list">
			                <div class="inhostoverview_list_one" >名称</div>
			        		<div class="inhostoverview_list_two">状态</div>
			        		<div class="inhostoverview_list_three">操作</div>
			        </div>
			        <div id="inhostoverview_1"></div>
			      <!--  <span class="get_more"  id="inhostoverview_more">more...</span> -->
			        <div id="inhostOverviewmore">
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
		    <div class= "inhostoverview_k"></div>
		</div>
		
</body>
</html>
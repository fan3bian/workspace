<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>防火墙概况</title>
<!-- <meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> -->
</head>
<body>
	<script src="${pageContext.request.contextPath}/web/cfwMonitor/js/jquery.more.js" type="text/javascript" charset="UTF-8"></script>
	<script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/inhost/js/inhostOverview.js" charset="UTF-8"></script>
<style type="text/css">
.incfwoverview_container {
	padding-top:10px;
    margin: 0 auto;
    color: #666666;
    width: 98%;
    min-height:500px;
    position: relative; overflow: hidden;
}
.incfwoverview_k{
	{padding-top: 20px;}
}
.incfwoverview_left {
    float: left;
    width: 79%;
    /*height: 500px;*/
}
.incfwoverview_number{
	width: 100%;
	 height: 68px;
	 margin: 0 auto;
	 position:  relative;
}
.incfwoverview_status {
    float: left;
    width: 24%;
     height: 68px;
    background-color: white;
    border: 1px solid #DDDDDD;
}

#incfwoverview_img_all {
    float: left;
    width: 68px;
    height: 68px;
}

#incfwoverview_img_fault {
    background-position: 294px 0;
    float: left;
    width: 68px;
    height: 68px;
}

#incfwoverview_img_new {
    background-position: 213px 0;
    float: left;
    width: 68px;
    height: 68px;
}

#incfwoverview_img_offline {
    background-position: 133px 0;
    float: left;
    width: 68px;
    height: 68px;
}

.incfwoverview_num {
    display: block;
    font-size: 25px;
    margin-left: 80px;
}

.incfwoverview_name {
    display: block;
    font-size: 15px;
    margin-left: 80px;
}

.incfwoverview_census {
	width:100%;
	height:205px;
    margin-top: 15px;
    background-color: white;
    border: 1px solid #DDDDDD;
    border-bottom: none;
    overflow: hidden;
}

.incfwoverview_span {
    float:left;
   display: block;
    height: 40px;
    line-height: 40px;margin:0 0 0 10px; font-size: 16px; color: #666;
}


.datagrid-cell {
    padding: 0;
}

.incfwoverview_charts {
    margin-top: 15px;
    width: 100%;
    height: 300px;
}

.incfwoverview_cpu {
    float: left;
    width: 49%;
    height: 300px;
    background-color: white;
    border: 1px solid #DDDDDD;
    overflow: hidden;
}

.incfwoverview_mem {
    float: right;
    width: 49%;
    height: 300px;
    background-color: white;
    border: 1px solid #DDDDDD;
    overflow: hidden;
}

#incfwoverview_cpu_chart {
    width: 100%;
    height: 260px;
    overflow: hidden;
}

#incfwoverview_mem_chart {
    width: 100%;
    height: 260px;
     overflow: hidden;
}

.incfwoverview_right {
    float: right;
    width: 20%;
    min-height:100px;
    background-color: white;
    border: 1px solid #DDDDDD ;
    overflow: hidden;  position: absolute;
    right: 0;
    bottom: 65px;
    top: 10px;
    
}
.incfwoverview_right_all{
	float: left;
    width: 107%;
    min-height:100px;
    max-height:920px;
    overflow-y:scroll;
}
.incfwoverview_right_all_title{
	 height: 40px;
    line-height: 40px;
	margin: 0px 0px 10px 0px;
    border-bottom: 1px solid #DDDDDD;
}
.incfwoverview_right_all_title_right{
	float:right;
	width: 140px; margin-right: 5px;
}
#incfwoverview_more {
    float: right;
    cursor: pointer;
}

#incfwoverview_new {
    display: none;
}

.incfwoverview_list {
     margin: 0 auto;
    position: relative;
    width: 97%;
}

.incfwoverview_list_one{
	float: left;
    width: 40%;
    height: 30px;
    line-height:30px;
    text-align: center;
    display:block;
    word-break:keep-all;
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
}
.incfwoverview_list_two{
	float: left;
    width: 30%;
    height: 30px;
    line-height:30px;
    text-align: center;
}
.incfwoverview_list_three{
	float: left;
    width: 30%;
    height: 30px;
    line-height:30px;
    text-align: center;
}
.incfwoverview_new table {
    width: 100%;
    position: relative;
    left: -10px;
}

.incfwoverview_clear {
    clear: both;
}

.m-btn-downarrow, .s-btn-downarrow {
    display: inline-block;
    font-size: 1px;
    height: 16px;
    margin-top: -15px;
    position: absolute;
    right: 0;
    top: 50%;
    width: 16px;
}
.l-btn-icon {
    display: inline-block;
    font-size: 1px;
    height: 16px;
    line-height: 16px;
    margin-top: -15px;
    position: absolute;
    top: 50%;
    width: 16px;
}
.incfwoverview_title{ 
margin:0 10px 10px 10px;border-bottom: 1px solid #ddd; 
overflow: hidden; 
}
.incfwoverview_container .get_more{
margin-right: 10%;
}
</style>	
<script type="text/javascript">

$(document).ready(function() {
	querycfwList();
	querycfwSummary();
	
});


function querycfwSummary(){
	$.ajax({
	  		type : 'post',
	  		url:'${pageContext.request.contextPath}/cfwOverView/querycfwSummary.do',
	  		success:function(retr){
	  			var ret =  JSON.parse(retr); 
	  			$('#incfwoverview_totnenum').html(ret.totnenum);
	  			$('#incfwoverview_errnenum').html(ret.errnenum);
	  			$('#incfwoverview_newnenum').html(ret.newnenum);
	  			$('#incfwoverview_outnenum').html(ret.outnenum);
	  			//addIncfwoverviewDatagrid(JSON.parse(ret.alarmsummary));
	  			addchart('incfwoverview_cpu_chart',JSON.parse(ret.securityThreatTop));
	  			//addchart('incfwoverview_mem_chart',JSON.parse(ret.sessionNumTop10));
	  			addchart2('incfwoverview_session_in_chart',JSON.parse(ret.hostSessionTop));
	  			//addchart2('incfwoverview_flow_out_chart',JSON.parse(ret.outnictop10));
	  		}
	});
}

function addIncfwoverviewDatagrid(datas){
    var incfwoverview_census_dg_width =($(".layout-panel-center").width()-40)*0.79/7;
    var sss = ($(".layout-panel-center").width()-20)*0.79;
    $("#incfwoverview_census_dg").datagrid({
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
                	field: 'type', title: '类型', align: 'center', width: incfwoverview_census_dg_width
                },
                {
                    field: 'Serious', title: '严重', align: 'center', width: incfwoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#F9243D';
	                    }
                },
                {
                    field: 'Main', title: '主要', align: 'center', width: incfwoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#FEBC3B';
	                    }
                },
                {
                    field: 'Secondary', title: '次要', align: 'center', width: incfwoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#4EC6BA';
	                    }
                },
                {
                    field: 'General', title: '一般', align: 'center', width: incfwoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#88CB5A';
	                    }
                },
                {
                    field: 'Warning', title: '警告', align: 'center', width: incfwoverview_census_dg_width,
	                    styler: function (value, row, index) {
	                        return 'color:#EB28DA';
	                    }
                },
                {
                    field: 'Allnum', title: '总数', align: 'center', width: incfwoverview_census_dg_width,
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
     	      return'名称：'+this.x+'<br/>威胁数: '+Highcharts.numberFormat(this.y,2,'.')+"";
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
            }
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
        	      return'名称：'+this.x+'<br/>会话数： '+Highcharts.numberFormat(this.y,2,'.')+' ';
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
function querycfwList(){

	 $('#incfwOverviewmore').more({'address': '${pageContext.request.contextPath}/cfwOverView/querycfwList.do'});
	
}

//按条件查询物理机设备列表
function searchcfwList(value,name){
	if (typeof(value) == "undefined") {
		   value = "";
		}
	if (typeof(name) == "undefined") {
		name = "";
		}
	$("#incfwoverview_1").children().remove();
	var onclicktypes = $("#cfwonclicktype").val();
	var orgUrl = '${pageContext.request.contextPath}/cfwOverView/querycfwList.do?value='+value+'&typeid='+name;
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
  			$("#incfwoverview_searchtype").val("1");
  			$("#incfwoverview_searchvalue").val(value);
  			$("#incfwoverview_searchname").val(name);
  			if(data){
	       		 for(var i=0;i<data.length;i++){
	       			 var aa = data[i];
	       			 $("#incfwoverview_1").append("<div  class='incfwoverview_list'>" +
                             "<div class='incfwoverview_list_one' title="+aa.displayname+">" + aa.displayname+ "</div>" +
                             "<div class='incfwoverview_list_two'>" + changecolor(aa.curstat)+ "</div>" +
                             "<div class='incfwoverview_list_three' style='color:blue;cursor: pointer;' onclick='JumpIncfwPage(this)'>详情</div>" +
                             "<input type=hidden value="+aa.serviceid+"></input>" +
                             "<input name=\"protype\" type=hidden value="+aa.protype+"></input>" +
                             "<input name=\"neid\" type=hidden value="+aa.neid+"></input>" +
                             "</div>");
	       		 }
       		}
  			
  		}
	});
}
function JumpIncfwPage(ele) {
    var neid = $(ele).next().val();
    var orgUrl = '/icpmg/web/cfwMonitor/jsp/runOverview.jsp';

    //alert(neid);
    $('#centerTab').panel({
        href: encodeURI(orgUrl),
        queryParams: {
            typeid: 'HOST',
            neid: neid
        }
    });
}

function cfwNum(onclicktype){
	if(onclicktype=='run'){
		$("#cfwonclickall").css('border','1px solid #58c9f3');
		$("#cfwonclickerr").css('border','1px solid #DDDDDD');
		$("#cfwonclicknew").css('border','1px solid #DDDDDD');
		$("#cfwonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='err'){
		$("#cfwonclickall").css('border','1px solid #DDDDDD');
		$("#cfwonclickerr").css('border','1px solid #58c9f3');
		$("#cfwonclicknew").css('border','1px solid #DDDDDD');
		$("#cfwonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='new'){
		$("#cfwonclickall").css('border','1px solid #DDDDDD');
		$("#cfwonclickerr").css('border','1px solid #DDDDDD');
		$("#cfwonclicknew").css('border','1px solid #58c9f3');
		$("#cfwonclickout").css('border','1px solid #DDDDDD');
	}
	if(onclicktype=='out'){
		$("#cfwonclickall").css('border','1px solid #DDDDDD');
		$("#cfwonclickerr").css('border','1px solid #DDDDDD');
		$("#cfwonclicknew").css('border','1px solid #DDDDDD');
		$("#cfwonclickout").css('border','1px solid #58c9f3');
	}
	$("#cfwonclicktype").val(onclicktype);
	searchcfwList();
}




</script>
<input type="hidden" id="cfwonclicktype" />
		<!--外层包含容器container-->
		<div class="incfwoverview_container">
			<!--左侧-->
			<div class="incfwoverview_left">
				<div class="incfwoverview_number">
					 <div class="incfwoverview_status" style="cursor: pointer;"  id="cfwonclickall"  onclick="cfwNum('run')">
					 	<div id="incfwoverview_img_all"  style="background-image: url(${pageContext.request.contextPath}/web/cfwMonitor/img/cfw.png)"></div>
		                <span class="incfwoverview_num" id="incfwoverview_totnenum">0</span>
		                <span class="incfwoverview_name">总台数</span>
					 </div>
					 <div class="incfwoverview_status" style="float: left;margin-left: 1%;cursor: pointer;" id ="cfwonclickerr" onclick="cfwNum('err')">
					 	<div id="incfwoverview_img_fault"   style="background-image: url(${pageContext.request.contextPath}/web/cfwMonitor/img/cfw.png)"></div>
		                <span class="incfwoverview_num" id="incfwoverview_errnenum">0</span>
		                <span class="incfwoverview_name">未启动台数</span>
					 </div>
					 <div class="incfwoverview_status" style="float: left;margin-left: 1%;cursor: pointer;" id ="cfwonclicknew" onclick="cfwNum('new')">
					 	<div id="incfwoverview_img_new"   style="background-image: url(${pageContext.request.contextPath}/web/cfwMonitor/img/cfw.png)"></div>
		                <span class="incfwoverview_num" id="incfwoverview_newnenum">0</span>
		                <span class="incfwoverview_name">本月新增数</span>
					 </div>
					 <div class="incfwoverview_status" style="float: right;cursor: pointer;" id ="cfwonclickout" onclick="cfwNum('out')">
					 	<div id="incfwoverview_img_offline"   style="background-image: url(${pageContext.request.contextPath}/web/cfwMonitor/img/cfw.png)"></div>
		                <span class="incfwoverview_num" id="incfwoverview_outnenum">0</span>
		                <span class="incfwoverview_name">本月退网数</span>
					 </div>
				</div>
				<!--告警信息统计-->
				
				 <!--图表监控-->
		        <div class="incfwoverview_charts">
		        	 <!--CPU负载监控-->
		            <div class="incfwoverview_cpu"><div class="incfwoverview_title"><span class="incfwoverview_span">受威胁防火墙TOP10</span></div>
		            	
		                <div id="incfwoverview_cpu_chart">
                            <%--<img src="../cfwMonitor/images/fhqwx.png"  alt="" width="95%" height="260px" >--%>
            	</div>
		            </div>
		             <!--内存负载监控-->
		            <div class="incfwoverview_mem" ><div class="incfwoverview_title"> <span class="incfwoverview_span">防火墙告警数TOP10</span></div>
		               
		                <div id="incfwoverview_mem_chart"><img src="../cfwMonitor/images/fhqwx.png"  alt="" width="95%" height="260px" ></div>
		            </div>
		        </div>
		        <div class="incfwoverview_charts" style="margin-bottom: 65px;">
		        	 <!--CPU负载监控-->
		            <div class="incfwoverview_cpu"><div class="incfwoverview_title"><span class="incfwoverview_span">主机会话Top10</span></div>
		            	
		                <div id="incfwoverview_session_in_chart">
                            <%--<img src="../cfwMonitor/images/hhzxt.png"  alt="" width="95%" height="260px" >--%>
                        </div>
		            </div>
		             <!--内存负载监控-->
		            <div class="incfwoverview_mem" >
		               <div class="incfwoverview_title"> <span class="incfwoverview_span">主机流量TOP10</span></div>
		                <div id="incfwoverview_flow_out_chart"><img src="../cfwMonitor/images/llzxt.png"  alt="" width="95%" height="260px" ></div>
		            </div>
		        </div>
		        
			</div>
			
			 <!--右侧-->
		    <div class="incfwoverview_right">
		    	 <div class = "incfwoverview_right_all">
		    	 	 <div class = "incfwoverview_right_all_title">
			    		 <span class="incfwoverview_span">设备列表</span>
			    		 <div class = "incfwoverview_right_all_title_right">
			    		 <input id = "incfwoverview_searchmmss" class="easyui-searchbox"  style="width:140px;height:20px;align-text:center" data-options="searcher:searchcfwList,prompt:'输入名称查询' ,menu:'#incfwoverview_searchmm'"/>
			    		 	<input id='incfwoverview_searchtype' type=hidden />
			    		 	<input id='incfwoverview_searchvalue' type=hidden />
			    		 	<input id='incfwoverview_searchname' type=hidden />
			    		 <div id="incfwoverview_searchmm" style="width:120px"> 
							<div data-options="name:'all' " onclick="searchcfwList('','')">全部</div> 
							<div data-options="name:'displayname' ">名称</div>
							<div data-options="name:'funip'">IP</div> 
							</div>
			    		 </div>
			    	</div>
			        <div id="incfwoverview_list" class="incfwoverview_list">
			                <div class="incfwoverview_list_one" >名称</div>
			        		<div class="incfwoverview_list_two">状态</div>
			        		<div class="incfwoverview_list_three">操作</div>
			        </div>
			        <div id="incfwoverview_1"></div>
			        <div id="incfwOverviewmore">
	                    <div class="single_item" >
	                    	<div class="serviceid" ></div>
	                    	<div class="displayname" ></div>
	                    	<div class="funip" ></div>
	                    </div>
	                    <div style="width: 100%;height: 30px;line-height: 30px;">
	                    	<a href="javascript:;" class="get_more" style="float: right; ">点击加载更多内容</a>
	                    </div>
	                </div> 
		    	 </div>
		    </div>
		    <div class= "incfwoverview_k"></div>
		</div>
		
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
	<style type="text/css">
.title{
	text-align:left;
	background-color:#F0F8FF;
	border:#BCD2EE 1px solid;
}
.titlefont{
	text-align:right;
	font-size:15px;
	color:#4048B0;
	font-family:"arial";
}
#toptable{
	border-style:none;
	padding:0 0 0 0 !important;
}
.wotable{
	border-left:#BCD2EE 1px solid !important; 
	border-bottom:#BCD2EE 1px solid !important;   
}
.showarea {
	height:25px;
    background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
    text-align: left;
    word-wrap: break-word;
    padding-top:0px !important;
    padding-bottom:0px !important;
    border:#BCD2EE 1px solid !important;  
}
.datafont{
	text-align:center;
	font-size:12px;
	color:#000000;
	font-family:"arial";
	font-weight:bold
}
</style>
	<script type="text/javascript">
		var staticdatath = 5;
		var staticdatato = 0;
		var toolbar = [ {
			text : '立即更新',
			iconCls : 'icon-reload',
			handler : function() {
				$.messager
						.confirm(
								'确认',
								'数据更新操作可能较慢，是否在线更新？',
								function(r) {
									if (r) {
										$
												.ajax({
													type : 'post',
													url : '${pageContext.request.contextPath}/vm/updateStaticVmData.do',
													success : function(retr) {
														var data = JSON
																.parse(retr);
														$.messager.alert('消息',
																data.msg);
													}
												});
									}
								});

			}
		} ];
		$(document)
				.ready(
						function() {
							
							$.ajax({
										url : '${pageContext.request.contextPath}/vm/getStaticData4VM.do',
										type : 'post',
										async : false,
										dataType : 'json',
										success : function(data) {
										
											if (data.success) {
												
												loadVmStaticData(data.obj.staticdata,data.obj.updatetime);
												loadDataGrid(data.obj.col);
											}
										},

									});

						});
		function loadDataGrid(columns) {
			$('#dg')
					.datagrid(
							{
								rownumbers:true,
								border:false,
								striped:true,
								nowarp:false,
								singleSelect:true,
								method:'post',
								loadMsg:'数据装载中......',
								fitColumns:false,
								//idField:'fid',
								//fit:true,
								pagination:true,
								pageSize:10,
								pageList:[10,20,30,40,50],
								//toolbar : toolbar,
								columns : 	[[    
										        {field:'ov_com',title:'',width:100,hidden:true},    
										        {field:'ov_type',title:'',align:'center',width:200},    
										        {field:'ov_sum1',title:columns.ov_attr1,width:columns.ov_attr1.length*20,align:'center',formatter:totalFormater},
										        {field:'ov_sum2',title:columns.ov_attr2,width:columns.ov_attr1.length*20,align:'center',formatter:runningFormater}
										    ]],    

								url : '${pageContext.request.contextPath}/vm/getStaticDataByDept.do'
							});
		}

		function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#vmdept_searchform')));
		};
		function loadVmStaticData(data,time) {
			var content = "";
			
			content +="<div style=\"float:left;margin-left:40px;display:inline; padding-top:65px;\"><a href=\"javascript:void(0)\" onclick=\"static2left()\"><img src=\"${pageContext.request.contextPath}/images/scroll-left.png\"></a></div>";
			for (var th in data) { 
				var dis = "inline";
				if(th>=4){
					dis = "none";
				}
				//alert(data[th].header.length);
				content +="<div style=\"float:left;margin-left:40px;display:"+dis+"; padding-top:40px\"><table id=\"toptable\" style=\"width:200px\">"
						+"<caption class=\"title\" ><strong><font class=\"titlefont\">"+data[th].header+"</font></strong></caption></table><table class=\"wotable\" style=\"width:200px\">";
						for(var fi in data[th].list)
						{
							content+="<tr><td class=\"showarea\" style=\"border-top:none !important;\">	<strong>&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"transferDetail()\">"+data[th].list[fi]+"</a></strong></td></tr>";
						}
					content+="</table></div>"; 
        	}
        	staticdatato = data.length;
        	content +="<div style=\"float:left;margin-left:40px;display:inline; padding-top:65px;\"><a href=\"javascript:void(0)\" onclick=\"static2right()\"><img src=\"${pageContext.request.contextPath}/images/scroll-right.png\"></a></div>";
        	content+="<div style=\"float:right;margin-right:20px;display:inline; padding-top:150px\">统计个数："+data.length+"，更新时间："+time+"</div>"; 
			$("#staticdatadiv").append(content);
		}
		function totalFormater(value,row,index)
			 {
			 	return "<a href=\"javascript:void(0)\" onclick=\"transferDetail('puserid','"+row.ov_com+"')\">"+value+"</a>";
				
			 } 
		 function runningFormater(value,row,index)
		 {
		 	{
			 	return "<a href=\"javascript:void(0)\" onclick=\"transferDetail('puserid','"+row.ov_com+"','status','Running')\">"+value+"</a>";
			 } 
		 } 
		 function transferDetail()
		 {
		 	
	 	  	var n = arguments.length;
            var t = '';
            for (var i = 0; i < arguments.length; i++) {
                t = t + arguments[i];
            }
            //alert(t);
		 }
		 function static2left()
		 {	
		  if(staticdatath<=5)
			 {
			 	return;
			 }
		 	$("#staticdatadiv").children().eq(staticdatath-5).css("display", "inline");
		 	$("#staticdatadiv").children().eq(staticdatath-1).css("display", "none");
		 	staticdatath--;
			
		 }
		  function static2right()
		 {
		 	 if(staticdatath>staticdatato)
			 {
			 	return;
			 }
		 	$("#staticdatadiv").children().eq(staticdatath-4).css("display", "none");
		 	$("#staticdatadiv").children().eq(staticdatath).css("display", "inline");
		 	staticdatath++;
		 }
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div id="staticdatadiv" data-options="region:'north',border:true"
			style="height:180px;overflow:hidden;">
				
		</div>
		<div data-options="region:'center',border:false">
			<form id="vmdept_searchform">
				<table>
					<tr>
						<td>单位：<input class="easyui-textbox" name="ov_com"
							id="searchov_com" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="searchDataGrid()">查询</a>
						</td>
					</tr>
				</table>
			</form>
			<table title="" style="width:100%;" id="dg">
			</table>
		</div>
	</div>
</body>


<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ page language="java" import="com.inspur.icpmg.util.WebLevelUtil"%>
<%@ page language="java" import="com.inspur.icpmg.systemMg.vo.UserEntity"%>
<%
	String muser = null;
	UserEntity ue = WebLevelUtil.getUser(request);
	if(ue != null){
		if(ue.getAlias() != null){
			muser = ue.getAlias();
		}else{
			muser = ue.getEmail();
		}
	}
%>	
	
<body>
<style type="text/css">
.product-product-close {
  position: absolute;
  top: 50%;
  margin-top: -8px;
  height: 16px;
  overflow: hidden;
  background: url('${pageContext.request.contextPath}/easyui-1.4/themes/default/images/panel_tools.png') no-repeat -16px 0px;
}
.FieldInput2 {
	width: 37%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}

.FieldLabel2 {
	width: 13%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
#addtoolbar{
	margin-left: 70%;
	width: 30%;
	vertical-align: middle;
	}
	#addtoolbar img{
	width: 30px;
	height:15px;
	margin-right: 5px;
	vertical-align: middle;
	}
	.a_t{
		
		width: 100%;
		height: 25px;
		margin:5px 0 auto;
	}
	.a_t_1{
		float:left;
		width: 14%;
		height: 25px;
	
	}
	.a_t_1 span{
		font-size:14px;
		float:right;
		height: 25px;
		line-height: 25px;
		padding-right: 20px;
	}
	.a_t_2{
		float:left;
		width: 36%;
		height: 25px;
	}
	.a_t_2 input{
		font-size:13px;
		width: 98%;
		margin: 0 auto;
		line-height: 25px;
		height: 25px;
		border: 0 silver;
		background: #fff;
	}
	.a_t_3{
		float:left;
		width: 86%;
		height: 25px;
	}
		.a_t_3 input{
		font-size:13px;
		width: 98%;
		margin: 0 auto;
		height: 25px;
		line-height: 25px;
		border: 0 silver;
		background: #fff;
	}
	.a_t_4{
		float:left;
		width: 14%;
		height: 25px;
	
	}
	.a_t_4 span{
		font-size:14px;
		float:right;
		height: 25px;
		line-height: 25px;
		padding-right: 20px;
	}
	.a_t_5{
		float:left;
		width: 86%;
		height: 25px;
	}
		.a_t_5 input{
		font-size:13px;
		margin: 2px 2px auto;
		line-height: 23px;
		height: 23px;
		background: #fff;
	}
	#addtoolbar span{
	width: 20%;
	margin-right: 5px;
	vertical-align: middle;
	}
</style>
<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/sockjs-0.3.min.js"></script>
	<script type="text/javascript">
	var  locklockflag = 0;
	var locknameflag=0;
		//点击查询时，记录查询条件
		var  qsearchresourcename = '';
		var qsearchvendorid = '';
		var qsearchsuname = '';
		var qsearchseverity = -1;
		var qsearcheventype = -1;
		var qsearchoccurtime = '';
		var qsearchinserttime = '';
		var qsearchresourcetypeid = $("#searchresourcetypeid").val();
		
		function saveDate(){
			qsearchresourcename =  $("#searchresourcename").val();
			qsearchvendorid =  $("#searchvendorid").val();
			qsearchsuname =  $("#searchsuname").val();
			qsearchseverity =  $("#searchseverity").combobox('getValue');
			qsearcheventype =  $("#searcheventype").combobox('getValue');
			qsearchoccurtime =  $("#searchoccurtime").datetimebox('getValue');
			qsearchinserttime =  $("#searchinserttime").datetimebox('getValue');
			qsearchresourcetypeid =  $("#searchresourcetypeid").val();
		}
		
		var ws = null;
        var url = null;
        var lockRowIndex=0;
        var transports = [];
	   var muser = '<%=muser%>';
		var toolbar = [
				{
				    id:'almclr',
				    disabled:true,
					text : '清除',
					iconCls : 'icon-almclr',
					handler : function() { 
						var rows = $('#dg').datagrid('getChecked');
						if(rows.length!=1)
						{
							$.messager.alert('消息','请选择一条记录！'); 
							return; 
						}
						
						var pids = "";
						 $.each(rows,function(index,object){
						 		//pids+="'"+object.id+"',";
						 		pids= object.id;
		   				 });
						 
		   				 $.messager.confirm('确认','您确认想要清除告警么？',function(r){   
		   					 
		   					 if (r){ 
		   				  	$.ajax({
		   				  		type : 'post',
		   				  		url:'${pageContext.request.contextPath}/alarm/clearEvent.do',
		   				  		data:{pids:pids},
		   				  		success:function(retr){
		   				  			var data =  JSON.parse(retr); 
		   				  			$.messager.alert('消息',data.msg);  
						  			if(data.success)
							    	{
							    		$('#dg').datagrid('unselectAll');
							    		$('#dg').datagrid('load',
												icp.serializeObject($('#alarmevent_searchform')));
							  			 $('#almclr').linkbutton('disable');
										 $('#almack').linkbutton('disable');
										 $('#almunack').linkbutton('disable');
									     $('#almtt').linkbutton('disable');
							    		
							    	} 
		   				  		}
		   				  	});
		   				  }
		   				 });
					}
				},
				{
				    id:'almack',
				    disabled:true,
					text : '确认',
					iconCls : 'icon-almack',
					handler : function() {
						var rows = $('#dg').datagrid('getChecked');
						if(rows.length<1)
						{
							$.messager.alert('消息','请至少选择一条记录！'); 
							return; 
						}
						
						var pids = "";
						 $.each(rows,function(index,object){
						 	pids+="'"+object.id+"',";
		   				 });
		   				 $.messager.confirm('确认','您确认想要确认告警么？',function(r){   
		   				  if (r){ 
		   				  	$.ajax({
		   				  		type : 'post',
		   				  		url:'${pageContext.request.contextPath}/alarm/confirmEvent.do',
		   				  		data:{pids:pids,
		   				  			almOperate:'ack'
		   				  			},
		   				  		success:function(retr){
		   				  			var data =  JSON.parse(retr); 
		   				  			$.messager.alert('消息',data.msg);  
						  			if(data.success)
							    	{
							    		$('#dg').datagrid('unselectAll');
							    		$('#dg').datagrid('load',
												icp.serializeObject($('#alarmevent_searchform')));
							  			 $('#almclr').linkbutton('disable');
										 $('#almack').linkbutton('disable');
										 $('#almunack').linkbutton('disable');
									     $('#almtt').linkbutton('disable');
							    		
							    	} 
		   				  		}
		   				  	});
		   				  }
		   				 });
						
					}
				},
				{
				    id:'almunack',
				    disabled:true,
					text : '取消确认',
					iconCls : 'icon-almunack',
					handler : function() {
							var rows = $('#dg').datagrid('getChecked');
							if(rows.length<1)
							{
								$.messager.alert('消息','请至少选择一条记录！'); 
								return; 
							}
							
							var pids = "";
							 $.each(rows,function(index,object){
							 	pids+="'"+object.id+"',";
			   				 });
			   				 $.messager.confirm('确认','您确认想要取消确认么？',function(r){   
			   				  if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/alarm/confirmEvent.do',
			   				  		data:{pids:pids,
		   				  			almOperate:'unack'
		   				  			},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg);  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('load',
													icp.serializeObject($('#alarmevent_searchform')));
								  			 $('#almclr').linkbutton('disable');
											 $('#almack').linkbutton('disable');
											 $('#almunack').linkbutton('disable');
										     $('#almtt').linkbutton('disable');
								    		
								    	} 
			   				  		}
			   				  	});
			   				  }
			   				 });
						}
				} ,
				/* {
				    id:'almtt',
				    disabled:true,
					text : '派单',
					iconCls : 'icon-almtt',
					handler : function() {
					            var row  = $('#dg').datagrid('getSelected');
					            $('#tthead').textbox('setText',row.head);
					            $('#almid').textbox('setText',row.id);
					            $('#almname').textbox('setText',row.head);
					            $('#ttsender').textbox('setText',muser);
					            $('#ttseverity').combobox('clear');
					            $('#window4tt').window('open');
							}
				} , */
				{
				    id:'almexp',
				    disabled:false,
					text : '导出',
					iconCls : 'icon-almexport',
					handler : function() {
						var rows = $('#dg').datagrid('getChecked');
						var pids = "";
						 $.each(rows,function(index,object){
						 	pids+="'"+object.id+"',";
		   				 });
						exportExcel(pids);
					} 
				}
				 ];
		$(document).ready(function() {
			updateUrl('/icpmg/sockjs/alarm');
			connect();
			loadDataGrid();
			loadAlarmNum();
			bindClick();
			//renameLock("锁定");

		});
		
		 function connect(){
			 if(window.eventactive){
				 window.eventactive.close();
				 window.eventactive=null;
			 }
		if (!url) {
			alert('Select whether to use W3C WebSocket or SockJS');
			return;
		}
		ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
			protocols_whitelist : transports
		}) : new WebSocket(url);
		window.eventactive = ws;
		ws.onopen = function() {
			
			//setConnected(true);
		};
		ws.onmessage = function(event) {
			var  json = JSON.parse(event.data);
			json.lockState=0;
			var method = json.method;
			var id = json.id;
			var data = json.datas;
			 if(method=='confirm'){
				updateDatagrid(id,data);
			}else  if(method=='clear'){
				deletegrid(id);
			}else{
				var json = JSON.parse(data);
				var  pageopt = $('#dg').datagrid('getPager').data("pagination").options;
				var  pazesize = pageopt.pageSize;
				var  pagenuber = pageopt.pageNumber;
					if(justAddNum(json)){
						setNum(json.severity);
						if(pagenuber==1){
							if(lockRowIndex>=pazesize){
								lockRowIndex = pazesize;
							}else if(lockRowIndex<0){
								lockRowIndex = 0;
							}else{
								$('#dg').datagrid('insertRow', {
									index : 0, 
									row : json
								});
								var   rows = $('#dg').datagrid('getRows');
									for(var jss=rows.length-1;jss>=0;jss--){
										var row = rows[jss];
										if(typeof(row)=="undefined"){
										}else{
										var stic = row.lockState;
											 if(stic==0){
												$('#dg').datagrid('deleteRow', jss);
												break;
											} 
										}
									}
							}
						}
					}
			}
			//			$('#dg').datagrid('freezeRow',0);			
		};
		ws.onclose = function(event) {
			//			setConnected(false);
		};
	}
	function justLockRowIndex(pazesize){
		if(lockRowIndex<pazesize){
		
		}
	}
	function deletegrid(id){
		var rows = $('#dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			var row = rows[i];
			if(row.id==id){
				$('#dg').datagrid('deleteRow', i);
			}
		}
	}
	function updateDatagrid(id,data){
		var  datass = JSON.parse(data);
		var rows = $('#dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			var row = rows[i];
			if(row.id==id){
				$('#dg').datagrid('updateRow', {
								index : i, 
								row : datass
				});
			}
		}
	}
	function justAddNum(obj){
		var flag = 0;
		var rscname =obj.resourcename;
		if(rscname.indexOf(qsearchresourcename)>=0){
			flag++;
		}
		var hsvendorid =obj.vendorid;
		if(hsvendorid.indexOf(qsearchvendorid)>=0){
			flag++;
		}
		var snhead =obj.head;
		if(snhead.indexOf(qsearchsuname)>=0){
			flag++;
		}
		if(qsearchseverity==-1){
			flag++;
		}else if(qsearchseverity==obj.severity){
			flag++;
		}
		if(qsearcheventype==-1){
			flag++;
		}else if(qsearcheventype==obj.eventype){
			flag++;
		}
		var d1 = new Date(Date.parse(qsearchoccurtime));
		var d2 = new Date(Date.parse(obj.occurtime));
		if(qsearchoccurtime==null){
			flag++;
		}else if(qsearchoccurtime==''){
			flag++;
		}else if(d1<=d2){
			flag++;
		}
		var d3 = new Date(Date.parse(qsearchinserttime));
		if(qsearchinserttime==null){
			flag++;
		}else if(qsearchinserttime==''){
			flag++;
		}else if(d2<=d3){
			flag++;
		}
		if(flag==7){
			return true;
		}else{
			return false;
		}
	}
	
	function setNum(alevel) {
		//console.log("alevel-------->"+alevel);normalAlarm
		if (alevel == 0) {
			var $normalAlarmN = $('#normalAlarm');
			$normalAlarmN.text(parseInt($normalAlarmN.text()) + 1);
		}else if (alevel == 1) {
			var $warnAlarmN = $('#warnAlarm');
			$warnAlarmN.text(parseInt($warnAlarmN.text()) + 1);
		} else if (alevel == 2) {
			var $minorAlarmN = $('#minorAlarm');
			$minorAlarmN.text(parseInt($minorAlarmN.text()) + 1);
		} else if (alevel == 3) {
			var $majorAlarmN = $('#majorAlarm');
			$majorAlarmN.text(parseInt($majorAlarmN.text()) + 1);
		} else if (alevel == 4) {
			var $criticalAlmN = $('#criticalAlm');
			$criticalAlmN.text(parseInt($criticalAlmN.text()) + 1);
		}
	}
	function disconnect() {
		if (ws != null) {
			ws.close();
			ws = null;
		}
		setConnected(false);
	}

	function echo() {
		if (ws != null) {
			var message = document.getElementById('message').value;
			log('Sent: ' + message);
			ws.send(message);
		} else {
			alert('connection not established, please connect.');
		}
	}

	function updateUrl(urlPath) {
		if (urlPath.indexOf('sockjs') != -1) {
			url = urlPath;
		} else {
			if (window.location.protocol == 'http:') {
				url = 'ws://' + window.location.host + urlPath;
			} else {
				url = 'wss://' + window.location.host + urlPath;
			}
		}
	}
		function loadAlarmNum(){
			   	$('#alarmevent_searchform').form('submit', {   
			   			url:'${pageContext.request.contextPath}/alarm/countNum.do',
					    success: function(data){    
					   			var obj = JSON.parse(data);
					   			var $normalAlarmM = $('#normalAlarm');
								$normalAlarmM.text(obj.normalAlarm);
					   			var $criticalAlmM = $('#criticalAlm');
								$criticalAlmM.text(obj.criticalAlm);
								var $majorAlarmM = $('#majorAlarm');
								$majorAlarmM.text(obj.majorAlarm);
								var $minorAlarmM = $('#minorAlarm');
								$minorAlarmM.text(obj.minorAlarm);
								var $warnAlarmM = $('#warnAlarm');
								$warnAlarmM.text(obj.warnAlarm);
					   			
					    }    
					});  
			   	
		}
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'occurtime',
								sortOrder : 'desc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								//idField : 'pid',
								queryParams: {
									resourcetypeid: '<%=request.getParameter("type")%>'
								},
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/alarm/queryEvent.do?almCategory=act',
								onCheck:doCheck,
								onUncheck:unDoCheck,
							});
			
			var monitorToolbar = "<div id='addtoolbar'><img src=\"${pageContext.request.contextPath}/images/almcritical.png\"  /><span id=\"criticalAlm\" >0</span><img src=\"${pageContext.request.contextPath}/images/almmajor.png\"  /><span id=\"majorAlarm\" >0</span><img src=\"${pageContext.request.contextPath}/images/almminor.png\"  /><span id=\"minorAlarm\" >0</span><img src=\"${pageContext.request.contextPath}/images/almnormal.png\"  /><span id=\"normalAlarm\" >0</span><img src=\"${pageContext.request.contextPath}/images/almwarn.png\"  /><span id=\"warnAlarm\" >0</span></div>";
			$(".datagrid-toolbar table").css("float","left");
			$(".datagrid-toolbar").append(monitorToolbar);
		}
		
		
		function doCheck(rowIndex,rowData){
			if(locklockflag==1){
				var lockState = rowData.lockState;
			if(lockState==0){
				$('#dg').datagrid('updateRow', {
					index : rowIndex,
					row : {
						lockState:1
					}
				});
				lockRowIndex++;
			}else{
				$('#dg').datagrid('updateRow', {
					index : rowIndex,
					row : {
						lockState:0
					}
				});
				lockRowIndex--;
			}
			}
			locklockflag=0;
		  var rows  = $('#dg').datagrid('getSelections');
			if(rows.length==1)
			{
			$('#almclr').linkbutton('enable');
			$('#almack').linkbutton('enable');
			$('#almunack').linkbutton('enable');
		    $('#almtt').linkbutton('enable');
		      $('#almlock').linkbutton('enable');
		      $('#almunlock').linkbutton('enable');
		      $('#almexp').linkbutton('enable');
			}else if(rows.length>1){
					 $('#almclr').linkbutton('enable');
					 $('#almack').linkbutton('enable');
					 $('#almunack').linkbutton('enable');
				     $('#almtt').linkbutton('disable');
				      $('#almlock').linkbutton('enable');
				      $('#almunlock').linkbutton('enable');
				      $('#almexp').linkbutton('enable');
			}else{
  					 $('#almclr').linkbutton('disable');
					 $('#almack').linkbutton('disable');
					 $('#almunack').linkbutton('disable');
				     $('#almtt').linkbutton('disable');
				      $('#almlock').linkbutton('disable');
				      $('#almunlock').linkbutton('disable');
				      $('#almexp').linkbutton('enable');
			}
			
		}
		
		function unDoCheck(rowIndex,rowData){
		    doCheck(rowIndex,rowData);
		}
			
		function searchDataGrid() {
			loadAlarmNum();
			$('#dg').datagrid('load',
				icp.serializeObject($('#alarmevent_searchform')));
				saveDate();
		};
		function reloadDateGrid(){
			$('#alarmevent_searchform input').val('');
			$('#searchpname').textbox('clear');
			$('#dg').datagrid('load',{});
			saveDate();
			loadAlarmNum();
		}
		function exportExcel(pids){
				$('#alarmevent_searchform').form('submit',{
						url:'${pageContext.request.contextPath}/alarm/exportExcel.do',
						onSubmit: function(param){
							param.id = pids;
							}
					});
		}
		function customLockformater(value, row, index) {
			
		}
		function customSeverityformater(value, row, index) {
				switch (value) {
							case 0:
								return "<div style=\"background-color:yellow;\">警告</div>";
							case 1:
								return "<div style=\"background-color:gray; \">一般</div>";
							case 2:
								return "<div style=\"background-color:orange; \">次要</div>";
							case 3:
								return "<div style=\"background-color:purple; \">主要</div>";
							case 4:
								return "<div style=\"background-color:red; \">严重</div>";
						}
		}
		
		function effectformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:green\">成功</span>";
							case "0":
								return "<span style=\"color:gray\">尝试</span>";
							case "2":
								return "<span style=\"color:orange\">失败</span>";
						}
		}
		function featureformater(value, row, index) {
				switch (value) {
							case "1":
								return "<span style=\"color:yellow\">可疑</span>";
							case "0":
								return "<span style=\"color:red\">攻击</span>";
							case "2":
								return "<span style=\"color:blue\">扫描</span>";
								case "3":
							return "<span style=\"color:green\">正常</span>";
									case "4":
							return "<span style=\"color:orange\">异常</span>";
						}
		}
		function severityformater(value) {
				switch (value) {
							case "0":
								return "警告";
							case "1":
								return "一般";
							case "2":
								return "次要";
								case "3":
							return "主要";
									case "4":
							return "严重";
						}
		}
		
		function severityformater2(value) {
			switch (value) {
						case 0:
							return "警告";
						case 1:
							return "一般";
						case 2:
							return "次要";
							case 3:
						return "主要";
								case 4:
						return "严重";
					}
	}
		
		function effectformater(value) {
				switch (value) {
							case "1":
								return "成功";
							case "0":
								return "尝试";
							case "2":
								return "失败";
						}
		}
		function featureformater(value) {
				switch (value) {
							case "1":
								return "可疑";
							case "0":
								return "攻击";
							case "2":
								return "扫描";
								case "3":
							return "正常";
									case "4":
							return "异常";
						}
		}
		function categoryformater(value) {
				switch (value) {
							case "1":
								return "故障";
							case "0":
								return "事件";
						}
		}
		function detailformater(value, row, index) {
		
				return "<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetails('"+ row.id+"');\">详情</a>";
		}
	
		function viewDetails(id)
		{
			$('#hiswindow').window('close');
			$.ajax({
			  		type : 'post',
			  		dataType:'json',
			  		url:'${pageContext.request.contextPath}/alarm/getEventDetail.do',
			  		data:{
			  			almCategory:'act',
			  			id:id},
			  		success:function(data){
			  			if(data.success)
				    	{
				    	
							for (var item in data.obj) {
							//	debugger;
								if($("#"+item).length>0)
								{
									if(item=="orgseverity"){
										$("#"+item).val(severityformater(data.obj[item]));
									}else	if(item=="severity")
									{
										$("#"+item).val(severityformater2(data.obj[item]));
									}else if(item=="eventeffect")
									{
									$("#"+item).val(effectformater(data.obj[item]));
									}else if(item=="eventfeature")
									{
									$("#"+item).val(featureformater(data.obj[item]));
									}else if(item=="eventcategory")
									{
									$("#"+item).val(categoryformater(data.obj[item]));
									}else
									{
										$("#"+item).val(data.obj[item]);
									}
								}
							}
				    		$('#window').window('open');
				    	} 
			  		}
				  	});
		}
		
		function submitTicket(){
			$('#window4tt').window('close');
			$.messager.alert('消息',"派单成功!");
		}
		
		function dolockformater(value, row, index) {
				var str = row.id;
				var imgunlock = "imgunlock"+str;
				var imglock = "imglock"+str;
				switch (value) {
					case 0:
						return "<img id="+imglock+" src='${pageContext.request.contextPath}/images/row-unlock.png' onclick='dolock(1)'>";
					case 1:
						return "<img id="+imgunlock+" src='${pageContext.request.contextPath}/images/row-lock.png' onclick='dolock(1)'>";
					}
		}
		function dolock(lockstic){
			locklockflag = lockstic;
		}
		
		function bindClick(){
			$("#locklockname").click(function(){
				locknameflag++;
				$('#dg').datagrid('selectAll');
				var rows = $('#dg').datagrid('getSelections');
				if(locknameflag%2==0){
						renameLock("锁定");
						for(var i=0;i<rows.length;i++){
								var row = rows[i];
								indexnum = $('#dg').datagrid('getRowIndex',row);
								$('#dg').datagrid('updateRow', {
									index : indexnum,
									row : {
										lockState:0
									}
								});
								lockRowIndex--;
						}
				}else{
						renameLock("解锁");
						for(var i=0;i<rows.length;i++){
								var row = rows[i];
								indexnum = $('#dg').datagrid('getRowIndex',row);
								$('#dg').datagrid('updateRow', {
									index : indexnum,
									row : {
										lockState:1
									}
								});
								lockRowIndex++;
						}
				}
				$('#dg').datagrid('unselectAll');
			});
		}
		function renameLock(name){
			if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
				document.getElementById('locklockname').textContent = name;
			}else{
				document.getElementById('locklockname').innerText = name;
			}
		} 
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="background:#eee;height:30px;overflow:hidden;border:false">
			<form id="alarmevent_searchform" method="post">
				<table>
					<tr>
						<td>设备：<input class="easyui-textbox" name="resourcename"
							id="searchresourcename" style="width:90px;height:30px;border:false">
							<%-- 厂商：<input id="searchvendorid"  class="easyui-combobox" name="vendorid" style="width:90px;height:30px;align-text:center"
								data-options="panelHeight:200,
								url:'${pageContext.request.contextPath}/alarm/getVendorids.do',
								valueField:'id',
								textField:'name',
								"/> --%>
							单位：<input id="searchCompany"  class="easyui-combobox" name="searchCompany" style="width:190px;height:30px;align-text:center"
								data-options="panelHeight:100,
								url:'${pageContext.request.contextPath}/alarm/getCompany.do',
								valueField:'id',
								textField:'name',
								"/>
							标题：<input class="easyui-textbox" name="head"
							id="searchsuname" style="width:90px;height:30px;border:false">
							级别：<select id="searchseverity" class="easyui-combobox" name="severity" style="width:90px;height:30px;border:false" data-options="panelHeight:160">   
										<option value="-1">请选择</option> 
									    <option value="4" >严重</option>   
									    <option value="3" >主要</option>   
									    <option value="2" >次要</option>
									    <option value="1" >一般</option>
									    <option value="0">警告</option>
								  </select>  
							<!-- 类型：<select id="searcheventype" class="easyui-combobox" name="eventype" style="width:90px;height:30px;border:false">   
										<option value="-1">请选择</option> 
									    <option value="alarm">故障</option>   
									    <option value="event" >事件</option>   
									    <option value="degradation" >裂化</option>   
									    <option value="notice" >通知</option>   
								  </select>   -->
							发生时间：<input class="easyui-datetimebox" name="occurtime"
							id="searchoccurtime" style="width:145px;height:30px;border:false">
							到<input class="easyui-datetimebox" name="inserttime"
							id="searchinserttime" style="width:145px;height:30px;border:false">
							<input name="resourcetypeid"
							id="searchresourcetypeid" type="hidden" value="<%=request.getParameter("type")%>">
							</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" 
							onclick="searchDataGrid()">查询</a>&nbsp;<a
							href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" 
							onclick="reloadDateGrid()">重置</a><!-- &nbsp;&nbsp;<a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-almexport'"
							onclick="exportExcel()">导出</a> -->
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;" id="dg">
				<thead>
					<tr>
					    <th data-options="field:'ck',checkbox:true"></th>
					    <th data-options="field:'lockState',width:20,align:'center',formatter:dolockformater"><a  href="#"   id="locklockname" style="color:#FFFFFF"  >锁定</a></th>
						<th data-options="field:'id',width:1,align:'center',hidden:'true'"></th>
						<th data-options="field:'orgid',width:1,align:'center',hidden:'true'"></th>
						<th data-options="field:'resourceid',width:40,align:'center'">设备</th>
						<th data-options="field:'vendorid',width:20,align:'center',hidden:'true'">厂商</th>
						<th data-options="field:'resourceip',width:30,align:'center'">IP</th>
						<th data-options="field:'occurtime',width:40,align:'center'">发生时间</th>
						<th data-options="field:'head',width:50,align:'center'">事件标题</th>
						<th data-options="field:'eventypename',width:30,align:'center'">事件类型</th>
						<th data-options="field:'severity',width:30,align:'center',formatter:customSeverityformater">事件级别</th>
						<th data-options="field:'ackby',width:30,align:'center'">确认人</th>
						<th data-options="field:'acktime',width:40,align:'center'">确认时间</th>
						<th data-options="field:'content',width:20,align:'center',formatter:detailformater">操作</th>
					</tr>
				</thead>
			</table>
		</div>
			<div id="window4tt" class="easyui-window" title="告警派单" data-options=" closed : true, cache : false,iconCls:'icon-save',modal: true"
			style="width:800px;height:300px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="alarmeventform" method="post" enctype="multipart/form-data" >
						<fieldset>
							<legend>派单信息</legend>
							<div class="a_t">
								<div class="a_t_4">
									<span>工单标题：</span>
								</div>
								<div class="a_t_5">
									<input class="easyui-textbox" data-options="validType:'isBlank'" id="tthead" name="tthead" style="width: 320px ;height: 25px;"><span  style="color: red">*</span>
								</div>
							</div>
							<div class="a_t">
								<div class="a_t_4">
									<span>工单级别：</span>
								</div>
								<div class="a_t_5">
									<input class="easyui-combobox" id="ttseverity" name="ttseverity" style="width: 320px ;height: 25px;" data-options="
											valueField: 'value',
											textField: 'label',
											data: [{
												label: '重要',
												value: '4'
											},{
												label: '主要',
												value: '3'
											},{
												label: '次要',
												value: '2'
											},{
												label: '一般',
												value: '1'
											}
											,{
												label: '警告',
												value: '0'
											}
											]" ><span  style="color: red">*</span>
								</div>
							</div>
							<div class="a_t">
								<div class="a_t_4">
									<span>告警ID：</span>
								</div>
								<div class="a_t_5">
									<input class="easyui-textbox" data-options="validType:'isBlank'" id="almid" name="almid" style="width: 320px ;height: 25px;"  />
								</div>
							</div>
							<div class="a_t">
								<div class="a_t_4">
									<span>告警名称：</span>
								</div>
								<div class="a_t_5">
									<input class="easyui-textbox" data-options="validType:'isBlank'" id="almname" name="almname" style="width: 320px ;height: 25px;"  />
								</div>
							</div>
							<div class="a_t">
								<div class="a_t_4">
									<span>派单人：</span>
								</div>
								<div class="a_t_5">
									<input class="easyui-textbox" data-options="validType:'isBlank'" id="ttsender" name="ttsender"  style="width: 320px ;height: 25px;"  />
								</div>
							</div>
							<div class="a_t" style="margin-bottom: 10px;">
								<div class="a_t_4">
									<span>工单详情：</span>
								</div>
								<div class="a_t_5">
									<input class="easyui-textbox" data-options="validType:'isBlank'" id="ttcause" name="ttcause" style="width: 647px ;height: 25px;"  />
								</div>
							</div>
						</fieldset>
					</form>
				</div>
				<div data-options="region:'south',border:false"
					style="text-align:center;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
						id="saveBtn" href="javascript:void(0)" onclick="submitTicket();"
						style="width:80px">确定</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
						onclick="$('#window4tt').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
		
		<div id="window" class="easyui-window" title="事件详情" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:800px;height:410px;padding:5px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center',border:false" style="padding:5px;">
			<form id="alarmdetaileventform" method="post" enctype="multipart/form-data" >
				<fieldset>
					<legend>基本信息</legend>
						<div class="a_t">
							<div class="a_t_1">
								<span>设备：</span>
							</div>
							<div class="a_t_2">
								<input id="resourceid" name="resourceid"  readonly />
							</div>
							<div class="a_t_1">
								<span>厂商：</span>
							</div>
							<div class="a_t_2">
								<input id="vendorid" name="vendorid"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>主机名称：</span>
							</div>
							<div class="a_t_2">
								<input  id="host" name="host" readonly />
							</div>
							<div class="a_t_1">
								<span>主机IP：</span>
							</div>
							<div class="a_t_2">
								<input id="resourceip" name="resourceip" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>发生时间：</span>
							</div>
							<div class="a_t_2">
								<input id="occurtime" name="occurtime"  readonly />
							</div>
							<div class="a_t_1">
								<span>事件标题：</span>
							</div>
							<div class="a_t_2">
								<input id="head" name="head" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>事件类型：</span>
							</div>
							<div class="a_t_2">
								<input id="eventypename" name="eventypename" readonly />
							</div>
							<div class="a_t_1">
								<span>事件级别：</span>
							</div>
							<div class="a_t_2">
								<input id="severity" name="severity" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>影响用户：</span>
							</div>
							<div class="a_t_2">
								<input id="suname" name="suname" readonly />
							</div>
							<div class="a_t_1">
								<span>设备类型：</span>
							</div>
							<div class="a_t_2">
								<input  id="resourcetypename" name="resourcetypename"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>原始模块：</span>
							</div>
							<div class="a_t_2">
								<input id="facility" name="facility" readonly />
							</div>
							<div class="a_t_1">
								<span>原始级别：</span>
							</div>
							<div class="a_t_2">
								<input  id="orgseverity" name="orgseverity" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>采集协议：</span>
							</div>
							<div class="a_t_2">
								<input id="protocal" name="protocal" readonly />
							</div>
							<div class="a_t_1">
								<span>告警数量：</span>
							</div>
							<div class="a_t_2">
								<input  id="eventcount" name="eventcount"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>入库时间：</span>
							</div>
							<div class="a_t_2">
								<input id="inserttime" name="inserttime" readonly />
							</div>
							<div class="a_t_1">
								<span>确认人：</span>
							</div>
							<div class="a_t_2">
								<input  id="ackby" name="ackby"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>确认时间：</span>
							</div>
							<div class="a_t_3">
								<input id="acktime" name="acktime"  readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>事件内容：</span>
							</div>
							<div class="a_t_3">
								<input id="content" name="content" readonly />
							</div>
						</div>
						<div class="a_t">
							<div class="a_t_1">
								<span>可能原因：</span>
							</div>
							<div class="a_t_3">
								<input id="procause" name="procause" readonly />
							</div>
						</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>
	</div>
</body>


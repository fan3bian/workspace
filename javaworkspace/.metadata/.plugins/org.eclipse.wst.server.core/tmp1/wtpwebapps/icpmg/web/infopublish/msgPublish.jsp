<%@page import="com.inspur.icpmg.util.ConfigProperties"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<html>
  <head>
	<title>消息发布</title>
  </head>
  <body>
  <script type="text/javascript">
	
	$(function(){
	  	//获取当前用户id
	  	var unitidCurrent = $('#unitCurrent').val();
	  	var msgType = [{
            id: '',
            text: '---请选择---'
        },{
            id: '1',
            text: '站内消息'
        },{
            id: '0',
            text: '公告'
        }];
	  	$('#selecttype').combobox({
            data: msgType,
            valueField: 'id',
            textField: 'text',
            loadFilter:function(data){
            	if("10005"!=unitidCurrent){          		           		 
	            	data = data.reverse();
					data.shift(); 
            	}
				return data;
		    }
        });
	  	 
	  	 var msgpub = ""; 
	     $.ajaxSettings.async = false; //全局设置同步
	  	 $.getJSON('${ctx}/tips.json', function(data) {
	  	 
            msgpub =  data.msgpub;//获取指定对象（数组形式）
             msgpub = msgpub[0].info;//如果只有一个（即一个{}）选择第一个即可，如果多个，按需选择或遍历
           
        });
	  	$.ajaxSettings.async = true;//全局设置异步（改为默认方式）
	  	
		$('#tipshow').tooltip({
			position : 'right',
			content : msgpub,
			hideDelay:600,
			trackMouse:true,
			onShow : function() {
				 $(this).tooltip('tip').css({
			     backgroundColor : '#EEE',
			     borderColor : '#95B8E7'
				});
			}
		});	
		
		$('#selecttype').combobox({
			onSelect: selectType,
			
		});  
		
	})

  	function submitSave(){
  		$('#messageform').form('submit',{
		    url:'${pageContext.request.contextPath}/infopublish/messageAdd.do', 
		    onSubmit: function(){
		    	if(!$("#messageform input[name='title']")[0].value)
				{
					$.messager.alert('消息', "标题不能为空！");
					return false;
				}
				if($("#selecttype").combobox("getValue")==null || $.trim($("#selecttype").combobox("getValue"))=="" )
		    	{
		    		$.messager.alert('消息',"请选择消息类别!");  
		    		return false;
		    	}
				var selecttype = $('#selecttype').combobox('getValue');
		    	if(selecttype=="1"){
		    		if(!$("#messageform input[name='unitname']")[0].value)
					{
						$.messager.alert('消息', "请选择发送对象！");
						return false;
					}
		    		$('#searchbtn').linkbutton('enable');
		    	}else{
		    		$('#windowunitname').textbox('readonly');
		  			$('#searchbtn').linkbutton('disable');
		  			$("#windowunitname").textbox('setValue','');
					$("#windowunitid").val('');
		    	}
				if(!$("#messageform input[name='starttime']")[0].value)
				{
					$.messager.alert('消息', "有效时间（开始）不能为空！");
					return false;
				}
				if(!$("#messageform input[name='endtime']")[0].value)
				{
					$.messager.alert('消息', "有效时间（结束）不能为空！");
					return false;
				}
				if($("#messageform input[name='endtime']")[0].value<getToday())
				{
					$.messager.alert('消息', "有效时间（结束）不能早于当前日期！");
					return false;
				}
				
				var starttime = $('#starttime').datebox('getValue');;
				var endtime = $('#endtime').datebox('getValue');;
				var msg = compareTime(starttime, endtime);
				if(msg != ""){
					$.messager.alert('提示', msg, 'info');
					return false;
				}
		    	if($("#content").attr("value")==null || $.trim($("#content").attr("value"))=="" )
		    	{
		    		$.messager.alert('消息',"内容不能为空!");  
		    		return false;
		    	}
		    	var filetype = $("#messageform input[name='filepathss']")[0].value;
				var fileTemp = filetype.substring(filetype.lastIndexOf(".")+1);
				var arr = new Array("doc","docx","txt","pdf","xls","xlsx");
				var flag = 0;
				if(filetype){
					for(var i=0;i<arr.length;i++){
						if(arr[i]==fileTemp){
							flag = "1";
						}
					}
					if(flag=="0"){
						$.messager.alert('消息', '暂不支持该类型附件上传！<br><span style="color: #babbbc">支持的文件格式有：【.doc】【.docx】【.txt】【.pdf】【.xls】【.xlsx】。</span>',"info");
						return false;
					}
				}
		    	//return $(this).form('validate');
		    }, 
		    success:function(retr){
		    	var _data =  JSON.parse(retr); 
		    	$.messager.alert('消息',_data.msg);  
		    	$("#messageform").form('clear');
		    }
		});
  	}
  	//选择消息类型
   	function selectType(){
  		var selecttype = $('#selecttype').combobox('getValue');
  		if(selecttype=="0"){
  			$('#windowunitname').textbox('readonly');
  			$('#searchbtn').linkbutton('disable');
  			$("#windowunitname").textbox('setValue','');
			$("#windowunitid").val('');
  		}else{
  			$('#windowunitname').textbox('readonly',false);
  			$('#searchbtn').linkbutton('enable');
  		}
  	}
  	
  	function showSelectWin()
	{
		 $('#condiSearch').textbox({onClickButton:function()
		 {
		 	$('#condiSearchTable').datagrid('clearChecked');
		 	$('#condiSearchTable').datagrid('reload',{
					username: this.value
					});
		 }});
		 condiSearchTableLoad();
		 $('#w').window('open');
	}
  	function condiSearchTableLoad()
	{
		$('#condiSearchTable').datagrid({
			rownumbers:false,
			border:false,
			striped:true,
			nowarp:false,
			singleSelect:false,
			method:'post',
			loadMsg:'数据装载中......',
			fitColumns:true,
			pagination:true,
			pageSize:5,
			pageList:[5,10,20,30,40,50],
		    url:'${pageContext.request.contextPath}/infopublish/getDeparts.do',
		    onLoadSuccess: function (data) {
				var pageopt = $('#condiSearchTable').datagrid('getPager').data("pagination").options;
				var  _pageSize = pageopt.pageSize;
				var  _rows = $('#condiSearchTable').datagrid("getRows").length
				var total = pageopt.total; //显示的查询的总数
				if (_pageSize >= 5) {
					for(i=5;i>_rows;i--){
//						{ itemid: '<div style="text-align:center;color:red">没有相关记录！</div>' }
						//添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
						$(this).datagrid('appendRow', {unitName:''  })
					}
					 $('#condiSearchTable').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
								    		total: total,
								    	});
					//	$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
				}else{
					//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				}
				 var rows = data.rows;
				      if (rows.length) {
							 $.each(rows, function (idx, val) {
								if(val.unitName==''){  
									$('#condiSearchTablediv input:checkbox').eq(idx+1).css("display","none");
									 
								}
								
							}); 
				      }
		    },
			 //没数据的行不能被点击选中
			 onClickRow: function (rowIndex, rowData) {
					if(rowData.unitName==''){
						 $('#condiSearchTable').datagrid('unselectRow', rowIndex);
					}else{
						//点击有数据的行  标志位变为0
						flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
						$('condiSearchTable div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
			}, 
			 //点击全选
			onCheckAll: function(rows) {
					//全选时，标志位变为1
					flagck = 1;
					$.each(rows, function (idx, val) {
						if(val.unitName==''){
							//如果是空行，不能被选中
							$("#condiSearchTable").datagrid('uncheckRow', idx);
							//增加全选复选框被选中
							$('condiSearchTable div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");	
						}
					});
			}, 
			 //点击全选
			onUncheckAll: function(rows) {
				//取消全选时，标志位变为0
				flagck = 0;
			}
		}); 
	}
  	function writeToInput()
	{
		var rows  = $('#condiSearchTable').datagrid('getSelections');
		if(rows.length==0)
		{
			$.messager.alert('消息','请至少选择一项！'); 
			return;
		}
		var values = "";
		var names = "";
		$.each(rows,function(index,object){
			if(object.unitName!=''){
			 	values+=object.unitId+",";
			 	names+=object.unitName+",";
			}
		});
		values=values.substring(0,values.length-1);
		names=names.substring(0,names.length-1);
        $('#windowunitid').val(values);
        $('#windowunitname').textbox('setValue',names);
        $('#condiSearchTable').datagrid('clearChecked');
		$('#condiSearch').textbox('setValue','');
        $('#condiSearch').textbox('setText','');
		$('#w').window('close');
	}
  	//判断时间选择条件
	function compareTime(startDate, endDate) { 
	    var startDateTemp = startDate.split("-");   
	    var endDateTemp = endDate.split("-");     
		  
		var allStartDate = new Date(startDateTemp[0], startDateTemp[1], startDateTemp[2]);   
		var allEndDate = new Date(endDateTemp[0], endDateTemp[1], endDateTemp[2]);   
		                   
		if (allStartDate.getTime() >= allEndDate.getTime()) {   
	        return "有效时间有误：开始时间不能大于结束时间！";   
		}else{
			return "";
		}   
	}
  	function getToday(){
  		var tody = new Date(); 
  		var year = tody.getFullYear();
  		var month = tody.getMonth() + 1; 
  		var day = tody.getDate(); 
  		month =month <10?"0"+month :month 
  		day=day<10?"0"+day:day
  		return (year+"-"+month+"-"+day);
  	}
	
  </script>
  	<input type='hidden' id='unitCurrent' value='${sessionUser.unitid}' >
    <div class="easyui-layout" data-options="fit:true,border:false">
    	<div data-options="region:'center',border:false" style="background:#eee;height:30px;overflow_y:scroll;">
    		<img alt="top" src="${ctx}/images/newsfabu.png" style="margin-top:20px">
    		<div class="pro-wrap">
    			<form id="messageform" method="post" enctype="multipart/form-data">
    				<div class="detail-line" style="margin: 18px auto; width:530px;">
						<span>
							<span style="display: inline-block;width: 100px;text-align: right;">
								标题：
							</span>
							<input class="easyui-textbox" style="width: 395px ;height: 30px;" id="title" name="title" >&nbsp;&nbsp;&nbsp;<font color="red">*</font>
						</span> 	  
					</div>
					<div class="detail-line" style="margin: 18px auto; width:530px;"">
						<span>
							<span style="display: inline-block;width: 100px;text-align: right;">
								消息类型：
							</span>
							<input style="width: 395px;height: 30px" id="selecttype" name="type" >
			
		      				<a class="easyui-linkbutton" id="tipshow" data-options="iconCls:'icon-tishi',plain:true" href="javascript:void(0)"></a>
						</span>
					</div>
					<div class="detail-line" style="margin: 18px auto; width:530px;"">
						<span>
							<span style="display: inline-block;width: 100px;text-align: right;">
								发送对象：
							</span>
							<input class="easyui-textbox" style="width: 395px;height: 30px" id="windowunitname" name="unitname"/>
		   					<input type="hidden"  id="windowunitid" name="unitid"/>
		   					<a href="#" id="searchbtn" onClick="javascript:showSelectWin();" class="easyui-linkbutton" data-options="iconCls:'icon-sousuo',plain:true"></a>
						</span>
					</div>
					<div class="detail-line" style="margin: 18px auto;width:530px;"">
							<span style="display: inline-block;width: 100px;text-align: right;">
								有效时间：
							</span>
							<input class="easyui-datebox" name="starttime"
							id="starttime" style="width:178px;height:30px;border:false">
							&nbsp;<span style="color:#5599FF">——</span>&nbsp;&nbsp;<input class="easyui-datebox" name="endtime"
							id="endtime" style="width:178px;height:30px;border:false">&nbsp;&nbsp;&nbsp;<font color="red">*</font>
					</div>
					<div class="detail-line"  style="margin: 18px auto; width:530px;"">
						<span>
							<span style="display: inline-block;width: 100px;text-align: right;">
								内容：
							</span>
						 	<input class="easyui-textbox" data-options="multiline:true" style="width: 395px;height: 120px;" id="content" name="content">
						 	&nbsp;&nbsp;<font color="red">*</font>
						</span>
					</div>
					<div style="margin: 18px auto; width:530px;" class="detail-line">
					    <span>
					    	<span style="display: inline-block;width: 100px;text-align: right;">
								附件上传：
							</span>
					    	<input style="width:395px;height:30px" type="file" id="filepath" name="filepathss"/>				        	
					    </span>					
					</div>
					<div style="margin: 18px auto;width:530px;" class="detail-line">
						<div style="margin-left: 100px">
							<a id="btn" href="javascript:void(0)" onclick="submitSave()" data-options="iconCls:'icon-ok'" class="easyui-linkbutton" style="margin-left: 153px;width: 78px;height: 30px">发布</a>
						</div>
					</div>
    			</form>
    		</div>
    	</div>
    </div>
    <!-- 选择发送对象 弹窗 -->
	<div id="w" class="easyui-window" title="选择部门" data-options="modal:true,closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:320px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;" id="condiSearchTablediv">
					<table id="condiSearchTable" title="" style="width:95%;" data-options="">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'unitId',width:30,align:'center'">部门编码</th>
							<th data-options="field:'unitName',width:30,align:'center'">部门名称</th>
						</tr>
					</thead>
				</table>
				</div>
				<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="writeToInput();" style="width:80px">确定</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#w').window('close');" style="width:80px">取消</a>
				</div>
		  </div>
	</div>
  </body>
</html>

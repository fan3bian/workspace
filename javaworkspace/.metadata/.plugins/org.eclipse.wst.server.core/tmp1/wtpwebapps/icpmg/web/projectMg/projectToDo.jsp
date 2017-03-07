<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<script type="text/javascript" charset="utf-8">
$(function(){
	searchForm = $('#promgr_searchform').form();
	
	var status_data = [{"value":"0","text":"首次提交"},{"value":"1","text":"未处理"},{"value":"2","text":"已审批"},{"value":"3","text":"生产中"},{"value":"4","text":"试运行"},{"value":"5","text":"运行中"},{"value":"6","text":"停止服务"}];
	
	datagrid = $('#datagrid_pro').datagrid({
		url:'${ctx}/project/projectsToDo.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		/* fit:true, */		
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'orderid',
		sortName:'otime',
		sortOrder:'asc',
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'订单',
			field:'orderid',
			width:100,
			hidden:true,
			sortable:true
		},
		{
			title:'项目名',
			field:'proname',
			width:100,
			align:'center'
		},{
			title:'标题',
			field:'protitle',
			width:100,
		},
		{
		   title:'单位',
		   field:'department',
		   width:100,
		},
		{
			title:'提交时间',
			field:'otime',
			width:100,
		 
		},{
			title:'正式申请',
			field:'ptime',
			width:100
		},{
			title:'开通时间',
			field:'rstime',
			width:100
		},{
			title:'计费时间',
			field:'stime',
			width:100,
			 
		},{
			title:'结束时间',
			field:'etime',
			width:100,
		 
		},
		{
			title:'备注',
			field:'obrief',
			hidden:true
		},
		{
			title:'提交人',
			field:'uname',
			hidden:true
		},
		{
			title:'项目进程',
			field:'process',
			hidden:true
		},
		{
			title:'状态',
			field:'ostatus',
			width:100,
			align:'center',
			formatter:function(value,row,index){
			    for(var i = 0; i < status_data.length; i++){
			        if (status_data[i].value == value){
			            return status_data[i].text;
			        }
			    }
			},
            styler: function(value, row, index){
                if (value == "1") {
                 return 'background-color:#999;color:#fff';
               }
                 if (value == "2") {
                 return 'background-color:#66CC00;color:#fff';
               }
                 if (value == "3") {
                 return 'background-color:#FF9900;color:#fff';
               }
                 if (value == "0") {
                 return 'background-color:#CCC; color:#fff';
               }
                 if (value == "4") {
                 return 'background-color:#FFFF00;color:#666';
               }
                 if (value == "5") {
                 return 'background-color:#00BB00;color:#fff';
               }
                 if (value == "6") {
                 return 'background-color:#FF2D2D;color:#fff';
               }
            },
			editor:{
				type:'combobox',
				options:{
					data:status_data,
					valueField:"value",
					textField:"text"
				}
			}
		},
		{
			title:'操作',
			field:'fileurl',
			width:80,
		    align:'center',
		    formatter:function(value,row,index){
			   
			        if (value!=null&& row.ostatus=="1"){
			            return "<a href=javascript:detailShow()>查看</a>|"+"<a href='javascript:dealit()'>审批</a>";
			        }
			        if (value!=null&& row.ostatus=="2"){
			            return "<a href=javascript:detailShow()>查看</a>|"+"<a href='javascript:dealit()'>生产</a>";
			        }
			        if (value!=null&& row.ostatus=="3"){
			            return "<a href=javascript:detailShow()>查看</a>|"+"<a href='javascript:tocarry()'>试运行</a>";
			        }
			         if (value!=null&& row.ostatus=="4"){
			            return "<a href=javascript:detailShow()>查看</a>|"+"<a href='javascript:dealit()'>计费</a>";
			        }
			         if (value!=null&& row.ostatus=="5"){
			            return "<a href=javascript:detailShow()>查看</a>|"+"<a href='javascript:dealit()'>停止计费</a>";
			        }
			    }
			
		}]]
	});
	searchFun=function(){
		datagrid.datagrid('load',icp.serializeObject(searchForm));
	};
	cleanSearchFun=function(){
		searchForm.find('input').val('');
		datagrid.datagrid('load',{});
	};

});
 
</script>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="promgr_searchform">
			<table>
				<tr>
					<td>项目名：<input class="easyui-textbox" name="proname" style="width:110px;height:28px;border:false"></td>
					 
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;
		   &nbsp;&nbsp; &nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="startDo()">批量执行</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div data-options="region:'center',border:false" style="background:#eee;">
		<table id="datagrid_pro" style="background:#eee;width:100%;"></table>
	</div>
</div>
	<div id="winfile" class="easyui-window" title="文档详情" data-options="iconCls:'icon-file',modal:true,shadow:true,collapsible:false,minimizable:false,closed:true" style="width:600px;height:450px;padding:10px;">
		    <div id="winfile-wrap" style="margin-left: 40px; font-size: 16px">
		     
		     <div id="winfile-process" style="width: 85%;height: 35px;margin-left: -16px;padding-top: 5px;">
		        
		     </div>
		     <p style="margin-top: 10px"><span><b> 标&nbsp;&nbsp;&nbsp;题：<span id="winfile-title"></span></b></span></p> 
		     <p style="margin-top: 10px">时&nbsp;&nbsp;&nbsp;间：<span id="winfile-time"></span></p> 
		     <p style="margin-top: 10px">申请人：<span id="winfile-user"></span></p> 
		     <p style="margin-bottom: 10px;margin-top: 10px">备&nbsp;&nbsp;&nbsp;注：<span id="winfile-snote"></span></p> 
		     <div id="winfile-list" class="easyui-accordion"  style="width:500px;height:200px">  
             <div title="<img src='${ctx}/images/sbfirst.png'/>" data-options="selected:true" style="overflow:auto;">   
                 <p>附件一：<span id="winfile-file11"></span></p><br>   
                 <p>附件二：<span id="winfile-file12"></span></p><br>
             </div>   
              <div title="<img src='${ctx}/images/sbsecond.png'/> "  style="padding:10px;">     
                 <p>附件一：<span id="winfile-file21"></span></p><br>   
                 <p>附件二：<span id="winfile-file22"></span></p><br>
             </div>   
             </div>
		    </div>
	    </div>
	    <!-- 实施 -->
	   <div id="uploadFile" class="easyui-window" title="上传实施报告" data-options="iconCls:'icon-file',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:430px;height:125px;">
        <form action="" method="post" id="fileup" enctype="multipart/form-data">
        <div data-options="region:'center'" style="padding:10px;">
			<div class="detail-line" >
				<span>实施报告：<input class="easyui-filebox" data-options="validType:'isBlank'" buttonText="上传实施报告"  id="lineFiles" style="width: 330px ;height: 30px;"  name="report">
				</span> 	  
		    </div>
			<input type="hidden" name="status" id="prostatus"><input type="hidden" name="procode" id="procode">
			 <input type="hidden" name="ids" id="ids">
			 <div data-options="region:'south',border:false" style="text-align:center;padding:10px 0 0;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="submitFile()" style="width:80px">提交</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#uploadFile').dialog('close')" style="width:80px">取消</a>
            </div>
		</form>
	  </div>
<script type="text/javascript" charset="utf-8">
 
 function startDo(){
	 	var roleids = ${sessionUser.roleid}+",";	 
	 	var roleid = roleids.split(",");
	    for(var i=0;i<roleid.length;i++){
	      if(roleid[i]=="1000000050"){
	        $.messager.alert('提醒','【您不能使用该功能！】'); 
	        return;
	      }
	    }
	 	var rows  = $('#datagrid_pro').datagrid('getSelections');
		if(rows.length==0)
		{
			$.messager.alert('消息','请至少选择一项！'); 
			return;
		}
	    $.messager.confirm("操作提示", "您确定要执行操作吗？",function (data) {
	    if(data){
		var values = "";
		var status = "";
		var procode = "";
		$.each(rows,function(index,object){
			 	values+=object.orderid+",";
			 	status+=object.ostatus+",";
			 	procode+=object.process+","
				 });
		  values=values.substring(0,values.length-1);
		  status=status.substring(0,status.length-1);
		  procode=procode.substring(0,procode.length-1);
		  $.ajax({
				url:'${pageContext.request.contextPath}/project/changStatus.do',
			    data:{
						ids: values,
						status:status,
						procode:procode
					},
						cache:false,
						dataType:"json",
						success:function(r){
							if(r.success){
								 
								$.messager.alert('提示',r.msg);
							}else{
							 
								$.messager.alert('提示',r.msg);
							}
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('load');
						}
					});
					}
		})
	}
	
	function  tocarry(){
	        var rows  = $('#datagrid_pro').datagrid('getSelections');
		    if(rows.length!=1)
		     {
			    $.messager.alert('消息','不能为空且仅能选择一项！'); 
			    return;
		     }
		     
             $("#prostatus").val(rows[0].ostatus);
             $("#procode").val(rows[0].process); 
             $("#ids").val(rows[0].orderid); 
             
	   $("#uploadFile").window('open');
	}
	
	function submitFile() {

		$('#fileup').form('submit', {
			url : "${pageContext.request.contextPath}/project/changStatus.do",
			onSubmit : function() {
			  
			 var fileTypes =  $("#lineFiles").textbox('getValue');
             var fileType = fileTypes.split(".");
             var fileTypeName = fileType[fileType.length-1];
             if(fileTypeName!=="xlsx" && fileTypeName!=="xls"){
               $.messager.alert('提示',"【实施报告】不能为空且仅支持【excel】上传！"); 
                 return false;
             }   
				return true;
			},
			success : function(data) {
			 
              $("#uploadFile").window('close');
			}
		});
	}
	function dealit(){
	  
	    var rows  = $('#datagrid_pro').datagrid('getSelections');
		if(rows.length!=1)
		{
			$.messager.alert('消息','不能为空且仅能选择一项！'); 
			return;
		}
	    $.messager.confirm("操作提示", "您确定要执行操作吗？",function (data) {
	      if(data){
	        
	        $.ajax({
				url:'${pageContext.request.contextPath}/project/changStatus.do',
			    data:{
						ids: rows[0].orderid,
						status:rows[0].ostatus,
						procode:rows[0].process
					},
						cache:false,
						dataType:"json",
						success:function(r){
							if(r.success){
								 
								$.messager.alert('提示',r.msg);
							}else{
							 
								$.messager.alert('提示',r.msg);
							}
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('load');
						}
					}); 
	      }
	    })
	}
	
	function detailShow(){
	    $("#winfile").window('close');
         var rows  = $('#datagrid_pro').datagrid('getSelections');
		if(rows.length!=1)
		{
			$.messager.alert('消息','不能为空且仅能选择一项！'); 
			return;
		}
	    $("#winfile-title").html(rows[0].protitle);
	    $("#winfile-time").html(rows[0].otime);
	    $("#winfile-user").html(rows[0].uname);
	    $("#winfile-snote").html(rows[0].obrief);
	    var prodata = rows[0].process;
	    process(prodata);
	    $("#winfile").window('open');
	}
    function process(data){
           if(data == '0'){
            $("#winfile-process").html("<img src='${ctx}/images/liucheng1.png'/>");  
	     }
		 if(data == '1'){
			 $("#winfile-process").html("<img src='${ctx}/images/liucheng2.png'/>");  
		  }
		 if(data == '2'){
		     $("#winfile-process").html("<img src='${ctx}/images/liucheng3.png'/>");   
		  }
		 if(data == '3'){
		   $("#winfile-process").html("<img src='${ctx}/images/liucheng4.png'/>");   
		  }
		 if(data == '4'){
	      $("#winfile-process").html("<img src='${ctx}/images/liucheng5.png'/>");  
	     }
	     if(data == '5'){
	      $("#winfile-process").html("<img src='${ctx}/images/liucheng6.png'/>");  
	     }
   }
</script>
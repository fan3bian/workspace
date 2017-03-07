<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<body>
 
	<script type="text/javascript">
	 var fileid;
		$(document).ready(function() {
			loadDataGrid();
			loadDataGrid1();
			 downfile = function(downid){
     
             var url;
            $.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/project/downFile.do',
   				  		data:{
   				  		  fileid:downid
   				  		},
   				  		async: false,
   				  	    dataType:'text',
   				  		success:function(result){
   				  		 
   				  		  url = '${ctx}/'+result;
   				  		   var temp = url.split(".");
   				  		  var str = temp[temp.length-1];
   				  		 
   				  		  if(str=="doc"||str=="docx"||str=="xls"||str=="xlsx"){
   				  		   window.location.href = url;
   				  		  }else{
   				  		   window.open(url);
   				  		  }
   				  		}
   				  	}); 
  
    }
    
    
     implment = function(checkid){
       $.messager.confirm("操作提示", "您确定要执行此操作吗？", function (data){ 
          if (data){ 
           $.ajax({
		  		type : 'post',
		  		url:'${ctx}/resourceinfo/resourceImplment.do',
		  		data:{fileid:checkid},
		  		async: false,
		  		success:function(data){
		  		var data = JSON.parse(data);
                 if(data.success){
		            $.messager.alert('提示',data.msg,"info");
	              $('#rescorceApply').datagrid('unselectAll');
	              $('#rescorceApply').datagrid('reload');
				  $('#rescorceStop').datagrid('unselectAll');
				  $('#rescorceStop').datagrid('reload');
		    
		           }else{
		            $.messager.alert('提示',data.msg,"info");
		           }
		      }
   		 });
   		 }
     });
   	}
   	
  
		});
		 
		function loadDataGrid() {
			$('#rescorceApply').datagrid(
					{
						rownumbers : false,
						border : false,
						striped : true,
						scrollbarSize : 0,
						sortName : 'fileid',
						sortOrder : 'asc',
						singleSelect : true,
						method : 'post',
						loadMsg : '数据装载中......',
						fitColumns : true,
						pagination : true,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						height:400,
						onLoadSuccess:function (data){
							console.log(data);
							var pageopt = $('#rescorceApply').datagrid('getPager').data("pagination").options;
							var  _pageSize = pageopt.pageSize;
							var  _rows = $('#rescorceApply').datagrid("getRows").length;
							console.log(_pageSize+",,,,"+_rows);
							if (_pageSize >= 10) {
								for(i=10;i>_rows;i--){
									//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
									$(this).datagrid('appendRow', {status:'',filename:'',checkstatus:''})
								}
								// $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
							}else{
								//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
								$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
							}
						},
					 
						url : '${ctx}/resourceinfo/getApplyFilesOfPass.do?filetype=7'
					});
			}

	 function operformater(value, row, index) {
		if(value!=''){

			return "<a onclick=\"downfile('" + row.fileid + "');\"><img style='padding-top:10px;padding-right:15px' src='${ctx}/images/download.png'/></a>" + "<a onclick=\"implment('" + row.fileid + "');\"><img style='padding-top:10px;padding-right:15px' src='${ctx}/images/shishi.png'/></a>";
		}
	 }

	 function nameformater(value, row, index) {

		 var filename = row.filename.substring(13);
		 if (value != null) {
			 return filename;
		 }
	 }
	 function statusformater(value, row, index) {
		 if (value == "0") {
			 return "待审批";
		 }
		 if (value == "1") {
			 return "审批通过";
		 }
		 if (value == "2") {
			 return "审批未通过";
		 }
	 }
	
		 function loadDataGrid1() {
			$('#rescorceStop').datagrid(
					{
						rownumbers : false,
						border : false,
						striped : true,
						scrollbarSize : 0,
						sortName : 'fileid',
						sortOrder : 'asc',
						singleSelect : true,
						method : 'post',
						loadMsg : '数据装载中......',
						fitColumns : true,
						pagination : true,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						onLoadSuccess:function (data){
							console.log(data);
							var pageopt = $('#rescorceStop').datagrid('getPager').data("pagination").options;
							var  _pageSize = pageopt.pageSize;
							var  _rows = $('#rescorceStop').datagrid("getRows").length;
							console.log(_pageSize+",,,,"+_rows);
							if (_pageSize >= 10) {
								for(i=10;i>_rows;i--){
									//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
									$(this).datagrid('appendRow', {status:'',filename:'',checkstatus:''})
								}
								// $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
							}else{
								//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
								$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
							}
						},
				 
						url : '${ctx}/resourceinfo/getApplyFilesOfPass.do?filetype=8'
					});
			}
			 
			 
	</script>
    	<div id="tt" class="easyui-tabs" style="width:1180px;height:500px">
	        <div title="资源使用申请" style="padding:20px">
	           
		 
				<div data-options="region:'center',border:false">
					<table title="" style="width:100%;" id="rescorceApply">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fileid',width:30,align:'center',hidden:true"></th>
								<th data-options="field:'filename',width:80,align:'left',formatter:nameformater">名称</th>
								<th data-options="field:'proid',width:30,align:'center',hidden:true">项目ID</th>
								<th data-options="field:'proname',width:30,align:'center'">所属项目</th>
								<th data-options="field:'ctime',width:50,align:'center'">上传时间</th>
								<th data-options="field:'unitid',width:40,align:'center',hidden:true">项目单位</th>
								<th data-options="field:'unitname',width:40,align:'center'">项目单位</th>
							    <th data-options="field:'checkstatus',width:40,align:'center',formatter:statusformater">审批状态</th>

								<th data-options="field:'status',width:30,height:40,align:'center',formatter:operformater">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			<!-- </div> -->		
	   	</div>
	    <div title="资源终止申请" style="padding:20px">
	        
				<div data-options="region:'center',border:false">
					<table title="" style="width:100%;" id="rescorceStop">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fileid',width:30,align:'center',hidden:true"></th>
								<th data-options="field:'filename',width:80,align:'left',formatter:nameformater">名称</th>
								<th data-options="field:'proid',width:30,align:'center',hidden:true">项目ID</th>
								<th data-options="field:'proname',width:30,align:'center'">所属项目</th>
								<th data-options="field:'ctime',width:50,align:'center'">上传时间</th>
								<th data-options="field:'unitid',width:40,align:'center',hidden:true">项目单位</th>
								<th data-options="field:'unitname',width:40,align:'center'">项目单位</th>
								<th data-options="field:'checkstatus',width:40,align:'center',formatter:statusformater">审批状态</th>
								<th data-options="field:'status',width:30,height:40,align:'center',formatter:operformater">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			<!-- </div> -->
	    </div>
	</div>
	<!-- 弹窗 -->
	<div id="dlg" class="easyui-window" title="资源审批" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:600px;height:400px;padding:5px;">
		
		<p class="divcss" id="checkTitle" style="font-weight:bold;  font-size:16px;margin-bottom: 10px" align="center"></p>
		<div id="checkContent" style="font-size: 14px;text-indent:30px"></div>
		<div id="filepath" style="font-size:14px;font-weight: bold;margin-bottom: 5px">附件信息</div>
		
		<div data-options="region:'south',border:false" 
			style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
			 onclick="$('#dlg').window('close');" style="width:80px">关闭</a>
		</div>
		
	</div>	
	
	
	<div id="procheck" class="easyui-window" title="审批意见" data-options="iconCls:'icon-shenpi',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:400px;height:250px;">
        <form action="" method="post" id="checkform">
        <div data-options="region:'center'" style="padding:10px;">
			<div class="detail-line" >
			  <p style="padding: 10px;font-size: 14px"> 是否通过 <span id="checkFileName"></span>?</p>	  
		    </div>
		    <div class="detail-line"style="padding: 10px" >
			   <span><input class="easyui-textbox" data-options="validType:'isBlank',multiline:true,prompt:'审阅意见'"  id="snote" style="width: 250px ;height: 90px;"  name="checknote">
			   </span> 
		    </div>
		    <div class="detail-line" style="padding-top: 10px;margin-left: 20px">
		    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="checkfile2('1')">通过</a>&nbsp;&nbsp;
	        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="checkfile2('2')">拒绝</a>&nbsp;&nbsp;
	        </div>
	  </div>
		</form>
</div>
</body>

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
  
     };
      
     checkfile = function(checkid){
      var status;
      fileid = checkid;
      
      $.ajax({
				  type : 'post',
				  url:'${ctx}/project/getFile.do',
				  data:{fileid:checkid},
				  async: false,
				  dataType:'json',
				  success:function(data){
				  	 filename = data.filename;
				  	 status = data.checkstatus;
				  	 }
   		})
   			 
         if(status!="0"){
          $.messager.alert('提示',"您已经审批过了！","info");
         }else{
          $("#checkFileName").html("【"+filename.substring(13)+"】");
          $("#snote").textbox("setValue",'');
          $("#procheck").window('open');
         } 
   			   	  		
   	
   	};
   	
   	 checkfile2 = function(status){
 
         $('#checkform').form('submit',{
      
         url:'${ctx}/project/checkFile.do',
         queryParams:{checkstatus:status,fileid:fileid},
         onSubmit:function(){
           return $(this).form('validate');  
         },
         success:function(data){
           $('#procheck').window('close');
           var data = JSON.parse(data);
           if(data.success){
           $('#rescorceApply').datagrid('unselectAll');
		   $('#rescorceApply').datagrid('reload');
		   $('#rescorceStop').datagrid('unselectAll');
		   $('#rescorceStop').datagrid('reload');
            $.messager.alert('提示',data.msg,"info");
    
           }else{
            $.messager.alert('提示',data.msg,"info");
           }
         }
      })
    };
    
    searchForm1 = $('#promgr_searchform1').form();
    searchFun1=function(){
	    
       $('#rescorceApply').datagrid('load',icp.serializeObject(searchForm1));
	};
	cleanSearchFun1=function(){
		searchForm1.find('input').val('');
	 
		$('#rescorceApply').datagrid('load',{});
	};
	
	searchForm2 = $('#promgr_searchform2').form();
    searchFun2=function(){
	    
       $('#rescorceStop').datagrid('load',icp.serializeObject(searchForm2));
	};
	cleanSearchFun2=function(){
		searchForm2.find('input').val('');
	 
		$('#rescorceStop').datagrid('load',{});
	};
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
					 
						url : '${ctx}/resourceinfo/getApplyFiles.do?filetype=7'
					});
			}
		 
			function operformater(value, row, index) {
		 
				return "<a onclick=\"downfile('"+row.fileid+"');\"><img style='padding-top:10px;padding-right:12px' src='${ctx}/images/download.png'/></a>" +"<a onclick=\"checkfile('"+row.fileid+"');\"><img style='padding-top:10px;padding-right:8px' src='${ctx}/images/shenpi.png'/></a>";
			}
		 
			function nameformater(value, row, index){
			
			var filename = row.filename.substring(13);  
                            if(value!=null){
                             return  filename;
                            }
			}
			function statusformater(value, row, index){
		         if(value=="0"){
                            return "待审批";
                           }
                            if(value=="1"){
                            return "审批通过";
                           }
                            if(value=="2"){
                            return "审批未通过";
                           }
                           if(value=="3"){
                            return "实施完成";
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
				 
						url : '${ctx}/resourceinfo/getApplyFiles.do?filetype=8'
					});
			}
			 
			 
	</script>
    	<div id="tt" class="easyui-tabs" style="width:1180px;height:500px">
    	
    	
	        <div title="资源使用申请" style="padding:20px">
	       <div style="padding: 10px 0;">  
		     <form id="promgr_searchform1">
			<table>
				<tr>
						<td>
					  单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：<input id="unitid2" style="width:200px;height: 30px; "  name="unitid" class="easyui-combobox" data-options=" 
				 valueField: 'unitId',    
                 textField: 'unitName',    
                 url: '${ctx}/project/getUnits.do',    
                 onSelect: function(rec){    
                 var url = '${ctx}/project/getProjects.do?unitid='+rec.unitId;    
                 
                 $('#proid2').combobox({    
                    url:url,    
                    valueField:'proid',    
                    textField:'proname',  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项
                    var data = $('#proid2').combobox('getData');
                  if (data.length > 0) {
                 $('#proid2').combobox('select', data[0].proid);
             } 
           }   
   });
              },
               onLoadSuccess: function () { //加载完成后,设置选中第一项
              var data = $('#unitid2').combobox('getData');
             if (data.length > 0) {
                 $('#unitid2').combobox('select', data[0].unitId);
             } 
            } 
        ">
					</td>
					<td style="margin-left: 10px">
					&nbsp;&nbsp; 项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目：<input class="easyui-combobox" data-options="valueField:'proid',textField:'proname'"   id="proid2" style="width: 200px;height: 30px; "  name="proid">
					</td>
					 
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun1()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun1()">重置</a>&nbsp;&nbsp;

					</td>
				</tr>
			</table>
		</form>
		</div>
				<div data-options="region:'center',border:false">
					<table title="" style="width:100%;" id="rescorceApply">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fileid',width:30,align:'center',hidden:true"></th>
								<th data-options="field:'filename',width:60,align:'left',formatter:nameformater">名称</th>
								<th data-options="field:'proid',width:30,align:'center',hidden:true">项目ID</th>
								<th data-options="field:'proname',width:50,align:'center'">所属项目</th>
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
	        <div style="padding: 10px 0;">  
		     <form id="promgr_searchform2">
			<table>
				<tr>
						<td>
					  单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：<input id="unitid" style="width:200px;height: 30px; "  name="unitid" class="easyui-combobox" data-options=" 
				 valueField: 'unitId',    
                 textField: 'unitName',    
                 url: '${ctx}/project/getUnits.do',    
                 onSelect: function(rec){    
                 var url = '${ctx}/project/getProjects.do?unitid='+rec.unitId;    
                 
                 $('#proid').combobox({    
                    url:url,    
                    valueField:'proid',    
                    textField:'proname',  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项
                    var data = $('#proid').combobox('getData');
                  if (data.length > 0) {
                 $('#proid').combobox('select', data[0].proid);
             } 
           }   
   });
              },
               onLoadSuccess: function () { //加载完成后,设置选中第一项
              var data = $('#unitid').combobox('getData');
             if (data.length > 0) {
                 $('#unitid').combobox('select', data[0].unitId);
             } 
            } 
        ">
					</td>
					<td style="margin-left: 10px">
					&nbsp;&nbsp; 项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目：<input class="easyui-combobox" data-options="valueField:'proid',textField:'proname'"   id="proid" style="width: 200px;height: 30px; "  name="proid">
					</td>
					 
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun2()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun2()">重置</a>&nbsp;&nbsp;

					</td>
				</tr>
			</table>
		</form>
		</div>
				<div data-options="region:'center',border:false">
					<table title="" style="width:100%;" id="rescorceStop">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
								<th data-options="field:'fileid',width:30,align:'center',hidden:true"></th>
								<th data-options="field:'filename',width:60,align:'left',formatter:nameformater">名称</th>
								<th data-options="field:'proid',width:30,align:'center',hidden:true">项目ID</th>
								<th data-options="field:'proname',width:50,align:'center'">所属项目</th>
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
			  <p style="padding: 10px;font: bold 14px"; align="center"> 是否通过 <span id="checkFileName"></span>?</p>	  
		    </div>
		    <div class="detail-line"style="padding: 10px;margin-left:45px;" >
			   <span><input class="easyui-textbox" data-options="validType:'isBlank',multiline:true,prompt:'审阅意见'"  id="snote" style="width: 250px ;height: 90px;"  name="checknote">
			   </span> 
		    </div>
		    <div class="detail-line" style="padding-top: 10px;margin-left: 115px">
		    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="checkfile2('1')">通过</a>&nbsp;&nbsp;&nbsp;&nbsp;
	        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="checkfile2('2')">拒绝</a>&nbsp;&nbsp;
	        </div>
	  </div>
		</form>
</div>
</body>

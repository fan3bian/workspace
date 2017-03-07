<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
 <script type="text/javascript" charset="UTF-8">
  		var context_path = '${pageContext.request.contextPath}';
 </script>
 
<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/network/css/flowContrastList.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/web/omsMonitor/network/js/flowContrastList.js"></script>

	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="background:#eee;height:30px;overflow:hidden;border:false">
			<form id="flow_contrast_searchform">
	  		 	 	<div style="margin: -1px 20px;">
	  		 	 		<div class="lcy-search">
	  		 	 				<div class="netflow_one">名称：<input class="easyui-textbox" name="groupname" id="groupname" style="width:150px"/></div>
	  		 	 				<div class="netflow_one">
	  		 	 						<a href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-search',plain:true" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
										<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="reloadDataGrid()">重置</a>
								</div>
	  		 	 		</div>
	  		 	 	</div>
	  		 	 </form>
		</div>
		<div data-options="region:'center',border:false" id="addflowconctrast">
			<table title="" style="width:100%;" id="flow_contrast_dg">
				<thead >
					<tr>
					    <th id="ckck" data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'groupname',width:40,align:'center',formatter:addGroupname">名称</th>
						<th data-options="field:'discrible',width:60,align:'center'">描述</th>
						<th data-options="field:'createtime',width:50,align:'center'">创建时间</th>
						<th data-options="field:'modifytime',width:50,align:'center'">修改时间</th>
						<th data-options="field:'groupid',width:20,align:'center',formatter:folwcontrasteditformater">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>	
	<div id="addfolwcontrast" class="easyui-window" title="" data-options="closed:true,cache : false,iconCls:'icon-save',modal:true"style="width:380px;height:240px;padding:5px;">
    	<form id="addfolwcontrastwindowform" method="post" style="margin-left : 60px" >
    		<input type="hidden" name="groupid" id="floegroupid"/>
    		<div style="margin-top: 20px;">
    			 <label for="groupname" style="font-size :14px;">名称:</label>   
                 <input class="easyui-textbox" type="text" name="groupname"  style="width:200px;height:28px;background:white;" /> 
    		</div>
    		
    		<div style="margin-top: 20px;">
    			 <label for="discrible" style="font-size :14px;">描述:</label>   
    			 <input class="easyui-textbox" type="text" name="discrible"  data-options="multiline:true" style="width:200px;height:90px;background:white;" /> 
    		</div>
    	</form>
			<div class="button" style="text-align: center;margin-top: 10px;">
				<a id="flowcontrastsavebtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFlowContrastList()">   保存   </a> 
				<a id="flowcontrastretbtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" style="margin-right: 42px;" onclick="addreceiverHide()">   取消   </a> 
			</div>
	</div>
</body>


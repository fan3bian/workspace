<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../icp/include/taglib.jsp"%>
<body>
<style type="text/css">
	.datagrid-header td,
	.datagrid-body td,
	.datagrid-footer td {
	  border-width: 0 0px 1px 0;
	  border-style: dotted;
	  margin: 0;
	  padding: 0;
	}
	.product-product-close {
	  position: absolute;
	  top: 50%;
	  margin-top: -8px;
	  height: 16px;
	  overflow: hidden;
	  background: url('${pageContext.request.contextPath}/easyui-1.4/themes/default/images/panel_tools.png') no-repeat -16px 0px;
	}
	.FieldInput2 {
		width: 75%;
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
		width: 25%;
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

</style>
	<script type="text/javascript">
		var pid;
		var pname;
		var url;
		var Cunitid;
		var Cunitname;
		var flag = false;
		$(document).ready(function() {
			url = '${pageContext.request.contextPath}/documentMg/filesList.do';
			loadDataGrid();
		});
		//文档查询
		function loadDataGrid() {
			$('#dg').datagrid(
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
						pagination : false,
						pageSize : 10,
						pageList : [ 5, 10, 20, 30, 40, 50 ],
						url : url,
						//双击事件
						onDblClickRow: function (rowIndex, rowData) { 
							var fileid = rowData.fileid;
							var filename = rowData.filename;
							//判断是文件夹 才能双击进下一层
							if(rowData.type==1){							
								showDetail(fileid,filename);
							}
						}

					});			
			}
			
			function searchDataGrid() {
				//var selectType = $('input:radio:checked').val();  //获取选中radio的值
				$('#dg').datagrid('load',icp.serializeObject($('#file_searchform')));
			};
			
			//类型
			function typeformater(value, row, index) {
				switch (value) {
					case "1":
						return "<span>文件夹</span>";
					case "2":
						return "<span>文件</span>";
				}
			} 
			
			//文件夹名称 前加图片
			function nameformater(value, row, index) {
				var _fileid = row['fileid']
				switch (row.type) {
					case "1":
						return "<img src='${ctx}/images/files.png' onclick='showDetail(\""+_fileid+"\",\""+row['filename']+"\")' />"+"&nbsp;"+value;
					case "2":
						if(row['filetype']!=0){						
							var filename = row.filename.substring(13);
							return "<img src='${ctx}/images/wenben.png'/>"+"&nbsp;"+filename; 
						}else{
							var filename = row.filename;
							return "<img src='${ctx}/images/wenben.png'/>"+"&nbsp;"+filename;
						}
				}
			} 
			
			//点击名称前图片或者双击当前行   触发方法
			function showDetail(fileid,filename){
				$('#dg').datagrid({
					queryParams: {
						pid: fileid
					}
				});
				$('#dg').datagrid('reload');
				pid = fileid;
				pname = filename;
			}
			
			function check(){				
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length==0){
					if($('#dg').datagrid('getRows')[0]!=null){
						pid = $('#dg').datagrid('getRows')[0].pid;
					}
					$.ajax({
						type : 'post',
						url :'${ctx}/documentMg/checkFunction.do',
						data:{
							parentid:pid
					  	},
				  		async: false,//同步
 				  		success:function(result){
 				  			var data =  JSON.parse(result); 
				  			if(data.success)
					    	{
				  				return flag = true;
					    	}else{
					    		return flag = false;
					    	}
 				  		}
				 	});
				}else{
					var folder = rows[0].filename;
					//文件夹内容不为空时，获取当前页面第一行的pid
					if($('#dg').datagrid('getRows')[0]!=null){
						pid = $('#dg').datagrid('getRows')[0].pid;
					}
					$.ajax({
						type : 'post',
						url :'${ctx}/documentMg/checkFunction.do',
						data:{
							parentid:pid,
							folder:folder
					  	},
				  		async: false,//同步
 				  		success:function(result){
 				  			var data =  JSON.parse(result); 
				  			if(data.success)
					    	{
				  				return flag = true;
					    	}else{
					    		return flag = false;
					    	}
	 				  	}
				 	});
				}
			}
				
			
			//返回按钮
			function backFun(){
				//文件夹内容不为空时，获取当前页面第一行的pid
				if($('#dg').datagrid('getRows')[0]!=null){
					pid = $('#dg').datagrid('getRows')[0].pid;
				}
				fileid = pid;
				$('#dg').datagrid({
					queryParams: {
						fileid: pid
					}
				});
				$('#dg').datagrid('reload');
				filename = pname;
			}
			
			//下载按钮
			function downloadFileFun(){
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length!=1){
					$.messager.alert('消息','请选择一个文件进行下载！',"info"); 
					return; 
				}else if(rows[0].type==1){
					$.messager.alert('消息','暂不支持文件夹下载，请选择文件进行下载！',"info");
					return; 
				}
				var fileid = rows[0].fileid;
				/* $("#filename").val(rows[0].filename);
				$("#fileurl").val(rows[0].fileurl); */
				$.ajax({
					type : 'post',
					url : '${ctx}/documentMg/loadFile.do',
					data:{
				  		  fileid:fileid
			  			},
			  		dataType:'text',
			  		async: false,
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
				
			$(function(){
				//上传按钮
				uploadFileFun=function(){
					var uploadfiles='';
					var index=0;
					var rows = $('#dg').datagrid('getRows'); //获取当前页面所有行
					for(var i=0;i<rows.length;i++){
						if(rows[i].type==2){//类型为文件
							//index = rows[i].filename.lastIndexOf(".");
							uploadfiles += rows[i].filename+",";
						}
					}
					//当前页面的文件夹名称
					uploadfiles=uploadfiles.substring(0,uploadfiles.length-1);//删掉字符串最后一位','
					$("#fileurl").val('');
					$("#uploadfiles").val(uploadfiles);
					check();
					if(flag==true){	
						url='${pageContext.request.contextPath}/documentMg/uploadFile.do';
						$('#uploadwindow').window('open');
					}else{
						$.messager.alert('警告',"抱歉，您没有权限进行此操作！","warning");
					}
				};
				
				//新建文件夹按钮
				addFolderFun=function(){
					var filenames='';
					var rows = $('#dg').datagrid('getRows'); //获取当前页面所有行
					for(var i=0;i<rows.length;i++){
						if(rows[i].type==1){//类型为文件夹							
							filenames += rows[i].filename+",";
						}
					}
					//当前页面的文件夹名称
					filenames=filenames.substring(0,filenames.length-1);//删掉字符串最后一位','
					$("#filename").textbox('setValue','');
					$("#filenames").val(filenames);
					check();
					if(flag==true){
						url='${pageContext.request.contextPath}/documentMg/createDir.do';
						$('#window').window('open');
					}else{
						$.messager.alert('警告',"抱歉，您没有权限进行此操作！","warning");
					}
				};
				
				//分享按钮
				shareFileFun=function(){
					check();
					if(flag==true){				
						var rows = $('#dg').datagrid('getChecked');
						if(rows.length!=1){
							$.messager.alert('消息',"请选择一个文件进行分享！","info"); 
							return; 
						}else if(rows[0].type==1){
							$.messager.alert('消息',"暂不支持文件夹分享，请选择文件进行分享！","info");
							return; 
						}
					 
						Cunitid = rows[0].unitid;
						Cunitname = rows[0].unitname;
						
						url='${pageContext.request.contextPath}/documentMg/shareFile.do';
						$('#sharewindow').window('open');
					}else{
						$.messager.alert('警告',"抱歉，您没有权限进行此操作！","warning");
					}
				};
				
				//删除按钮
				deleteFileFun=function(){
					check();
					if(flag==true){
						var rows = $('#dg').datagrid('getSelections');
						if(rows.length<1)
						{
							$.messager.alert('消息','请至少选择一条记录！',"info"); 
							return; 
						}
						var fileids = "";
						var parentid = rows[0].fileid;
						$.each(rows,function(index,object){
							fileids+=object.fileid+",";
		   				});
						//alert(fileids);
		   				$.messager.confirm('确认','您确定要删除选中记录吗？<br><span style="color: #babbbc">删除后可在回收站还原。</span>',function(r){   
		   					if (r){ 
			   				  	$.ajax({
			   				  		type : 'post',
			   				  		url:'${pageContext.request.contextPath}/documentMg/deleteFile.do',
			   				  		data:{fileids:fileids,parentid:parentid},
			   				  		success:function(retr){
			   				  			var data =  JSON.parse(retr); 
			   				  			$.messager.alert('消息',data.msg,'info');  
							  			if(data.success)
								    	{
								    		$('#dg').datagrid('unselectAll');
								    		$('#dg').datagrid('reload');
								    	} 
			   				  		}
			   				  	});
			   				 }
			   			});
					}else{
						$.messager.alert('警告',"抱歉，您没有权限进行此操作！","warning");
					}
					
				};
				
				//重命名按钮
				updateNameFun=function(){
					var filenames='';//当前页面所有文件(夹)名称
					var fileChoose='';//选中文件夹名称
					var rows = $('#dg').datagrid('getRows'); //获取当前页面所有行
					for(var i=0;i<rows.length;i++){
						if(rows[i].type==1){//类型为文件夹							
							filenames += rows[i].filename+",";
						}
					}
					//当前页面的文件(夹)名称
					filenames=filenames.substring(0,filenames.length-1);//删掉字符串最后一位','
					$("#filenames").val(filenames);
					check();
					if(flag==true){	
						var row = $('#dg').datagrid('getChecked');
						if(row.length!=1)
						{
							$.messager.alert('消息','请选择一条记录！',"info"); 
							return; 
						}
						$("#filename").textbox('setValue',row[0].filename);
						$("#fileid").val(row[0].fileid);
						$("#type").val(row[0].type);
						url='${pageContext.request.contextPath}/documentMg/updateName.do';
						$('#window').window('open');
					}else{
						$.messager.alert('警告',"抱歉，您没有权限进行此操作！","warning");
					}
				};
			})
	
			//保存或修改 提交按钮
			function submitSave(){
				$('#folderForm').form('submit',{
					queryParams:{parentid:pid,pname:pname},
					url:url, 
					onSubmit:function(){
						if($("#filename").attr("value")==null || $.trim($("#filename").attr("value"))=="" )
				    	{
				    		$.messager.alert('消息',"文件夹名称不能为空!","info");  
				    		return false;
				    	}
					},
					success:function(retr){
				    	var _data =  JSON.parse(retr); 
				    	$.messager.alert('消息',_data.msg,'info');  
						if(_data.success){
							$('#dg').datagrid('reload');
							$('#window').window('close');
				    	}
				    } 
				});
			}
			
			<%-- function confirmUpload(){
				var parentid = '';
				var uploadfiles='';
				var index=0;
				var rows = $('#dg').datagrid('getRows'); //获取当前页面所有行
				for(var i=0;i<rows.length;i++){
					if(rows[i].type==2){//类型为文件
						uploadfiles += rows[i].filename+",";
					}
				}
				//当前页面的文件夹名称
				uploadfiles=uploadfiles.substring(0,uploadfiles.length-1);//删掉字符串最后一位','
				$("#file_upload").val('');
				$("#uploadfiles").val(uploadfiles);
				$('#file_upload').uploadify({
					  debug:true,
	                  auto:false,
	                  height: 30,
	                  width  : 110,
	                  //cancelImg : '${ctx}/js/uploadify/uploadify-cancel.png',
	                  queueID:'fileQueue',
	                  buttonText:'选择文件', 
	                  buttonImg:'${ctx}/js/uploadify/bgc.png',
	                  swf : '${ctx}/js/uploadify/uploadify.swf',
	                  uploader : '${ctx}/documentMg/uploadFile.do;jsessionid=<%=session.getId()%>',
	                  multi:false,//允许多文件上传
	                  //queueSizeLimit:'5',//同时上传个数
	                  fileObjName:'filepath',
	                  fileTypeDesc:'上传文件支持的文件格式:doc,pdf,xls,xlsx,txt',
	                  fileTypeExts:'*.doc;*.pdf;*.xls;*.xlsx;*.txt',
	                  removeCompleted:true,
	                  method:'post',
	                  formData:{
	                	  'parentid':'',
	                	  'pname':'',
	                	  'uploadfiles':''
	                  },
	                  onSelectError:function(file, errorCode, errorMsg){
	                	  switch (errorCode) {
	                	  	case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
	                	  		$.messager.alert('消息','暂不支持多文件上传',"info");
	                	  }
	                  },
					  onUploadStart:function(file){
						  /* if(''==file.name||null==file.name){
							  $.messager.alert('消息','请选择要上传的文件！');
							  return;
						  } */
                          $("#file_upload").uploadify("settings", "formData", {'parentid':pid,'pname':pname,'uploadfiles':uploadfiles});  
                      },
                      onUploadSuccess:function(file, data, response) {
                    	  var _data =  JSON.parse(data);
  				    	  $.messager.alert('消息',_data.msg);  
	  					  if(_data.success){
		  					  $('#uploadwindow').window('close');
		  					  $('#dg').datagrid('reload');
	  				      }
                      }

				});
			}
			 --%>
			//上传文件 确定按钮
			function confirmUpload(){
				$('#uploadForm').form('submit',{
					queryParams:{parentid:pid,pname:pname},
					url:url,
					onSubmit:function(){
						var filetype = $("#uploadForm input[name='filepath']")[0].value;
						var fileTemp = filetype.substring(filetype.lastIndexOf(".")+1);
						var arr = new Array("doc","docx","txt","pdf","xls","xlsx");
						var flag = 0;
						if(!filetype){
							$.messager.alert('消息', "请选择要上传的文件！","info");
							return false;
						}else{
							for(var i=0;i<arr.length;i++){
								if(arr[i]==fileTemp){
									flag = "1";
								}
							}
							if(flag=="0"){
								$.messager.alert('消息', '暂不支持该类型文件上传！<br><span style="color: #babbbc">支持的文件格式有：【.doc】【.docx】【.txt】【.pdf】【.xls】【.xlsx】。</span>',"info");
								return false;
							}
						}
					},
					success:function(retr){
				    	var _data =  JSON.parse(retr); 
				    	$.messager.alert('消息',_data.msg);  
						if(_data.success){
							$('#dg').datagrid('reload');
							$('#uploadwindow').window('close');
				    	}
				    }
				});	
			}
			
			//分享文件 确定按钮
			function confirmShare(){
				var rows = $('#dg').datagrid('getChecked');
				$("#shareFileid").val(rows[0].fileid);
				$('#shareForm').form('submit',{
					url:url, 
					onSubmit:function(){
						var windowunitnameshow =  $("#windowunitnameshow").textbox('getValue');
			        	if(""==windowunitnameshow || null==windowunitnameshow){ 
			                $.messager.alert('提示',"请选择分享单位！","info"); 
			                return false;
			            }
					},
					success:function(retr){
				    	var _data =  JSON.parse(retr); 
				    	$.messager.alert('消息',_data.msg);  
						if(_data.success){
							$('#dg').datagrid('load',
								icp.serializeObject($('#file_searchform')));
							$('#sharewindow').window('close');
				    	}
				    } 
				});
			}
			
			//打开选择分享对象的窗口
		  	function showSelectWin()
			{
				 $('#condiSearch').textbox({
					 onClickButton:function()
						 {
						 	$('#condiSearchTable').datagrid('clearChecked');
						 	$('#condiSearchTable').datagrid('reload',{username: this.value});
						 }
				 });
				 condiSearchTableLoad();
				 $('#w').window('open');
			}
			
			//分享对象列表展示
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
					    url:'${pageContext.request.contextPath}/infopublish/getDeparts.do'
						}); 
			}
			
			//选择分享对象并写入input框
		  	function writeToInput()
			{
				var rows  = $('#condiSearchTable').datagrid('getSelections');
				if(rows.length==0)
				{
					$.messager.alert('消息','请至少选择一项！',"info"); 
					return;
				}
				var values = "";
				var names = "";
				$.each(rows,function(index,object){
					 	values+=object.unitId+",";
					 	names+=object.unitName+",";
						 });
				nameshow=names.substring(0, names.length-1);	 
				values=values+Cunitid;
				names=names+Cunitname;
		        $('#windowunitid').val(values);
		        $('#windowunitname').val(names);
		         $('#windowunitnameshow').textbox('setValue',nameshow);
		       
		        $('#condiSearchTable').datagrid('clearChecked');
				$('#condiSearch').textbox('setValue','');
		        $('#condiSearch').textbox('setText','');
				$('#w').window('close');
			}
			//窗口查询
			function queryInput(){
				var searchname = $('#searchname').textbox('getValue');
				console.log('名称：',searchname);
				url = '${ctx}/documentMg/queryInput.do?filename='+searchname;
				loadDataGrid();
			}
			//小贴士信息
			/* $(function(){
				$('#tipshow').tooltip({
					position : 'right',
					content : '分享小贴士：<br>若不选择，默认发给所有单位<br>若分享指定单位，请选择具体发送对象<br>',
					hideDelay:600,
					trackMouse:true,
					onShow : function() {
						 $(this).tooltip('tip').css({
					     backgroundColor : '#EEE',
					     borderColor : '#95B8E7'
						});
					}
				});	 
			}) */
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:75px;overflow:hidden;border:false">
			<form id="file_searchform">
				<tr>
					<!-- 选择文档类型 -->
					<td align="left">
							&nbsp;&nbsp;
						<input type="radio" id="selectFiletype1" name="filetype" checked="checked" onclick="searchDataGrid()" value=""/>
							<span style="font-size:15px;font-family:微软雅黑">&nbsp;全部</span>&nbsp;&nbsp; &nbsp;&nbsp;
						<input type="radio" id="selectFiletype2" name="filetype" onclick="searchDataGrid()" value="1" />
							<span style="font-size:15px;font-family:微软雅黑">&nbsp;项目文档</span>&nbsp;&nbsp; 
						<input type="radio" id="selectFiletype3" name="filetype" onclick="searchDataGrid()" value="0" />
							<span style="font-size:15px;font-family:微软雅黑">&nbsp;其他文档</span>&nbsp;&nbsp;
					</td>
					<!-- 填充 -->
					<td width="365px">	
					</td>
					<!-- 查询小窗口 -->
					<!-- <td align="right" style="margin-right:0px;margin-top: 10px">&nbsp;&nbsp;
						<input class="easyui-textbox" id="searchname" name="filename" data-options="prompt:'搜索我的文件'" style="width:160px;height:30px;border:false">
						<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:30px" data-options="iconCls:'icon-search'"
						   onclick="queryInput()">查询</a>
					</td> -->
				</tr>
				<div style="width:100%;float:right;margin-top: 8px;margin-bottom: 8px">
					<tr>
						<td>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-fanhui',plain:true" id="backBtn" onclick="backFun()">返回</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-upload',plain:true" id="buttons" onclick="uploadFileFun()">上传</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-download',plain:true" onclick="downloadFileFun()">下载</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-share',plain:true" id="buttons" onclick="shareFileFun()">分享</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:100px;height:35px" data-options="iconCls:'icon-addfiles',plain:true" id="buttons" onclick="addFolderFun()">新建文件夹</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:60px;height:35px" data-options="iconCls:'icon-delete',plain:true" id="buttons" onclick="deleteFileFun()">删除</a>&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" style="width:80px;height:35px" data-options="iconCls:'icon-rename',plain:true" id="buttons" onclick="updateNameFun()">重命名</a>&nbsp;
						</td>
					</tr>
				</div>	
			</form>	
		</div>
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%" id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'pid',width:30,align:'left',hidden:true"></th>
						<th data-options="field:'fileid',width:30,align:'left',hidden:true"></th>
						<th data-options="field:'filetype',width:30,align:'left',hidden:true"></th>
						<th data-options="field:'unitid',width:30,align:'left',hidden:true"></th>
						<th data-options="field:'unitname',width:30,align:'left',hidden:true"></th>
						<th data-options="field:'filename',width:100,align:'left',formatter:nameformater">名称</th>
						<th data-options="field:'size',width:22,align:'left'">大小</th>
						<th data-options="field:'ctime',width:40,align:'left'">修改时间</th>
						<th data-options="field:'type',width:40,align:'left',formatter:typeformater,hidden:true">类型</th>
						<th data-options="field:'size',width:40,align:'left',hidden:true">大小</th>
						<th data-options="field:'fileurl',width:40,align:'left',hidden:true"></th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<!-- 新建文件夹或重命名 弹出框 -->
	<div id="window" class="easyui-window" title="文件详情" data-options="closed:true,iconCls:'icon-save',inline:true,modal:true"
		style="width:500px;height:200px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;">
				<form id="folderForm" method="post" enctype="multipart/form-data">
					<input id="fileid" name="fileid" type="hidden" />
					<input id="filenames" name="filenames" type="hidden" />
					<input id="type" name="type" type="hidden" />
					<table align="center" style="width:100%">
						<div>
							<div class="detail-line" style="margin: 10px 20px">
								<span>文件名称 ：
									<input class="easyui-textbox" id="filename" name="filename"  style="width: 200px ;height: 30px;">
								</span> 	  
							</div>
						</div>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="saveBtn" href="javascript:void(0)" 
					onclick="submitSave();" style="width:80px">确定</a> 
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
					onclick="$('#window').window('close');" style="width:80px">取消</a>
			</div>
		</div>
	</div>
	<!-- 上传文件 弹出框 -->
	<div id="uploadwindow" class="easyui-window" title="上传文件" data-options="closed:true,modal:true,iconCls:'icon-save',inline:true,modal:true"
		style="width:600px;height:400px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;">
				<form id="uploadForm" method="post" enctype="multipart/form-data">	
					<table align="center" style="width:100%">
						<tr>
							<div class="detail-line"  style="margin: 15px 20px">
								<input id="uploadfiles" name="uploadfiles" type="hidden" />
								<span>上传文件：
								    <input type="file" style="width:250px;height: 26px"  id="fileurl" name="filepath" />
								</span>
							    <!-- <span>
									<input id="file_upload" name="filepath" type="file">
							    </span>	 -->	
							    <font color="red">选择一个附件*</font></td>
							</div>
							<!-- <div id="fileQueue"></div> -->
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="confirmBtn" href="javascript:void(0)" 
					onclick="confirmUpload();" style="width:80px">确定</a>
				<!-- <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:$('#file_upload').uploadify('upload', '*')" style="width:80px">开始上传</a>&nbsp; -->   
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
					onclick="$('#uploadwindow').window('close');" style="width:80px">关闭</a>
			</div>
		</div>
	</div>
	<!-- 分享文件 弹出框 -->
	<div id="sharewindow" class="easyui-window" title="分享文件" data-options="closed:true,iconCls:'icon-save',inline:true,modal:true"
		style="width:600px;height:400px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;">
				<form id="shareForm" method="post">
					<input id="shareFileid" name="fileid" type="hidden" />
					<table align="center" style="width:100%">
						<tr>
							<!-- <div class="detail-line" style="margin: 10px 20px">
								<a id="tipshow" data-options="plain:true" href="javascript:void(0)">分享小贴士</a>
							</div>
							<br> -->
							<div class="detail-line" style="margin: 15px 20px">
								<span>
									分享对象：&nbsp;<input class="easyui-textbox" style="width: 200px;height: 30px" id="windowunitnameshow" />
				   					<input type="hidden"  id="windowunitid" name="unitid"/>
				   						<input type="hidden"  id="windowunitname" name="unitname"/>
				   					<a href="#" id="searchbtn" onClick="javascript:showSelectWin();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
								</span>
							</div>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="shareBtn" href="javascript:void(0)" 
					onclick="confirmShare();" style="width:80px">确定</a> 
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
					onclick="$('#sharewindow').window('close');" style="width:80px">取消</a>
			</div>
		</div>
	</div>
	<!-- 选择分享对象 弹窗 -->
	<div id="w" class="easyui-window" title="选择部门" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:320px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'" style="padding:10px;">
					<!-- <table class="">
							<tr>
								<td>
									<input id ="condiSearch" class="easyui-textbox" data-options="buttonIcon:'icon-search'" style="width:150px"> 
								</td>
							</tr>
					</table> -->
					<table id="condiSearchTable" title="" style="width:95%;" data-options="">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'unitId',width:30,align:'center'">公司编码</th>
							<th data-options="field:'unitName',width:30,align:'center'">公司名称</th>
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

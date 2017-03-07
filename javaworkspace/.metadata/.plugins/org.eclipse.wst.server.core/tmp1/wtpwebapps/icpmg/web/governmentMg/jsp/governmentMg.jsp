<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>组织结构管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="组织结构管理">

  </head>
  
  <body>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/web/governmentMg/css/governmentMg.css" />
  <script type="text/javascript" charset="UTF-8">
	//获取一级组织结构url
	 var getFirstGovernmenturl = '${pageContext.request.contextPath}/gov/getFirstGovernment.do';
	//获取二级组织结构url
	var getSecondGovernmenturl = '${pageContext.request.contextPath}/gov/getSecondGovernment.do';
 	 //增加一级组织结构url
 	 var addFirstGovernmenturl = '${pageContext.request.contextPath}/gov/addFirstGovernment.do';
  	//增加二级组织结构url
	var addSecondGovernmenturl = '${pageContext.request.contextPath}/gov/addSecondGovernment.do';
	//删除一级组织结构url
	var delFirstGovernmenturl = '${pageContext.request.contextPath}/gov/delFirstGovernment.do';
	//删除二级组织结构url
	var delSecondGovernmenturl = '${pageContext.request.contextPath}/gov/delSecondGovernment.do';
	//修改一级组织结构url
	var updateFirstGovernmenturl = '${pageContext.request.contextPath}/gov/updateFirstGovernment.do';
	//修改二级组织结构url
	var updateSecondGovernmenturl = '${pageContext.request.contextPath}/gov/updateSecondGovernment.do'; 
	//获取归属地区url
	var getGovernmentRegionurl = '${pageContext.request.contextPath}/gov/getGovernmentRegion.do'; 
	
	var onclicktype = 0;//1是点查询 0 不是点查询
	var  unitnums = 0;//后台查询的个数
  var govtoolbar = [
{
	    id:'addgov',
	    disabled:false,
		text : '增加',
		iconCls : 'icon-add',
		handler : function() { 
			$('#govwindow2').window('open');
			$('#govtwoform').form('clear');
			$('#g2punitname').textbox('setValue',$('#govtest').val());
			$('#g2punitid').val($('#govid').val());
			$("#updatetype").val("2");
		}
},
{
		id:'updategov',
	    disabled:false,
		text : '修改',
		iconCls : 'icon-edit',
		handler : function() {
			var rows = $("#gov_dg").datagrid('getSelections');
			if(rows.length!=1){
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
			}
			var pids = "";
			$.each(rows,function(index,object){
		 		pids= object.unitid;
			 });
			$('#govwindow2').window('open');
			$('#govtwoform').form('clear');
			$("#updatetype").val("1");
			$('#govtwoform').form(
					'load',
					"${pageContext.request.contextPath}/gov/getSecondGovernment.do?unitid="+pids
			);
			$("#gov_dg").datagrid('clearChecked');
		}
},
{
			id:'delgov',
		    disabled:false,
			text : '删除',
			iconCls : 'icon-remove',
			handler : function() {
				var rows = $("#gov_dg").datagrid('getChecked');
				//if(rows.length!=1){
				//	$.messager.alert('消息','请选择一条记录！'); 
				//	return; 
				//}
				if(rows.length<1){
					$.messager.alert('消息','请选择要删除的记录！'); 
					return; 
				}
				var pids = "";
				var levels = "";
				var ids = "";
				$.each(rows,function(index,object){
			 		pids+=(","+ object.unitid);
			 		ids = object.punitid;
			 		levels = object.unitlevel;
				 });
				 $.messager.confirm('提示','您确认要删除选中的单位么？',function(r){ 
					 if (r){ 
						 $.ajax({
							 type : 'post',
		   				  		url:delSecondGovernmenturl,
		   				  		data:{
		   				  			level:'2',
		   				  			pids:pids,
		   				  			},
		   				  		success:function(retr){
			   				  		var data =  JSON.parse(retr); 
		   				  			$.messager.alert('消息',data.msg); 
		   				  			$("#gov_dg").datagrid('clearChecked');
		   				  			if(data.obj==1){
			   				  			var textlevel = $("#govlevel").val();
			   				  		    var textid = $("#govid").val();
			   				  		    var textvaue = "";
			   				  		    if(onclicktype==1){
			   				  		   		textvaue =  $("#govunitname").textbox("getValue");
			   				  		    }
			   				  		    if(textlevel==levels){
			   				  		    	if(textid!=ids){
			   				  		    		textid = ids;
			   				  		    	}
			   				  		    }
			   				  			 $('#gov_dg').datagrid('load',{
				   				  			level: textlevel,
				   				  			govid: textid,
				   				  			unitname:textvaue
			   				  			});
		   				  			}
		   				  		}
						 });
					 }
				 });
			}
},
];
  $(document).ready(function() {
	  var dg_width =$("#centerTab").width()*0.69;
	  //addGovTree();
	  govTreeReload();
	  loadDatagrid(dg_width);
	  $("#addgov").hide();
  });
  //获取一二级下子个数，unitnums如果为0 就可以删除
  function getSecondNum(level,id){
	  $.ajax({
			type : 'post',
			async: false,
			url:'${pageContext.request.contextPath}/gov/getSecondGovernmentNum.do',
			data:{
				level:level,
				unitid:id},
			success : function(data) {
				var myJson = eval('(' + data + ')');
				unitnums =  myJson.obj;
			}
	  });
  }
  
  function loadDatagrid(dg_width){
	  $('#gov_dg').datagrid({
		  rownumbers: false,
	      checkOnSelect: true,
	      selectOnCheck: true,
	      scrollbarSize: 0,
	      width:dg_width,
	      border: false,
	      striped: true,
	      sortName: 'unitid',
	      sortOrder: 'asc',
	      nowarp: false,
	      singleSelect: false,
	      method: 'post',
	      loadMsg: '数据装载中......',
	      fitColumns: true,
	      idField: 'unitid',
	      pagination: true,
	      pageSize: 10,
	      pageList: [10, 20, 30, 40, 50],
	      toolbar : govtoolbar,
	      url: '${pageContext.request.contextPath}/gov/queryUnit.do',
	  });
  }
  function govdetailformater(value, row, index) {
		if(value==1){
			return "信息化主管单位";
		}else{
			return "信息化非主管单位";
		}
}
  //增加
  function append(){
	  var node = $('#ttgov').tree('getSelected');
	  	var textlevel = node.level;
	  	
	    if(textlevel=='1'){
	    	$('#govwindow1').window('open');
	    	$('#govoneform').form('clear');
			$('#g1groupname').textbox('setValue',$('#govtest').val());
			$('#g1groupid').val($('#govid').val());
			$("#updatetype").val("3");
	    }
	    if(textlevel=='2'){
	    	$('#govwindow2').window('open');
			$('#govtwoform').form('clear');
			$('#g2punitname').textbox('setValue',$('#govtest').val());
			$('#g2punitid').val($('#govid').val());
			$("#updatetype").val("2");
	    }
	  
  }
  //删除
  function removes(){
	  var node = $('#ttgov').tree('getSelected');
	  var pids = node.id;
	  $.messager.confirm('提示','您确认要删除选择的单位么？',function(r){ 
			 if (r){ 
				 $.ajax({
					 type : 'post',
				  		url:delSecondGovernmenturl,
				  		data:{
				  			level:node.level-1,
				  			pids:pids,
				  			},
				  		success:function(retr){
	   				  		var data =  JSON.parse(retr); 
				  			$.messager.alert('消息',data.msg); 
				  			
				  			if(data.obj==1){
				  				$('#ttgov').tree('remove',node.target);
				  			}
				  		}
				 });
			 }
		 });
  }
 function searchGovDataGrid(){
	 onclicktype = 1;
	 var textlevel = $("#govlevel").val();
	 var textid = $("#govid").val();
	 var textvaue =  $("#govunitname").textbox("getValue");
	 $('#gov_dg').datagrid('load',{
			level: textlevel,
			govid: textid,
			unitname:textvaue
		});
 }
 
 function  govaddHide(){
	  $('#govwindow1').window('close');
	  $('#govwindow2').window('close');
 }
 
 
 function  gov2add(){
	 var url ="";
	 var ids="";
	 var type = $("#updatetype").val();//1为二级修改 2 二级增加 3一级增加 4一级修改
	 if (!type && typeof(type)!="undefined" && type!=0){
		 
	 }else{
	     if(type==1){
	    	 url =  updateSecondGovernmenturl;
	    	 ids="#govtwoform";
	     }
	     if(type==2){
	    	 url = addSecondGovernmenturl;
	    	 ids="#govtwoform";
	     }
		 if(type==3){
			 if(!$('#g1groupname').val() && typeof($('#g1groupname').val())!="undefined"){
			 
			 } else{
				 $('#g1groupname').textbox('setValue',$('#govtest').val());
			 }
	    	 url =  addFirstGovernmenturl;
	    	 ids="#govoneform";
	     }
	     if(type==4){
	    	 url = updateFirstGovernmenturl;
	    	 ids="#govoneform";
	     }
	 }
	 
	 $(ids).form('submit',{
		    url:url,
		    onSubmit: function(){
		    	var flag = $(this).form('validate');
		          
		           if(!flag){
		            return flag; 
		           }
		    },
		    success:function(retr){
		    	var _data =  JSON.parse(retr); 
		    	$.messager.alert('消息',_data.msg);
		    	if(_data.obj==1){
		    			govaddHide();
		    			$('#ttgov').tree('reload');
			  			var textlevel = $("#govlevel").val();
			  		    var textid = $("#govid").val();
			  		    var textvaue = "";
			  		    if(onclicktype==1){
			  		   		textvaue =  $("#govunitname").textbox("getValue");
			  		    }
			  		    if(textlevel==2){
			  		    	$('#gov_dg').datagrid('load',{
					  			level: textlevel,
					  			govid: textid,
					  			unitname:textvaue
				  			});
			  		    }
		  			}
		    }
	 });
 }
 
 function govTreeReload(){
	 $('#ttgov').tree({  
		 url:'${pageContext.request.contextPath}/gov/queryGovernment.do',
		 lines : true,
		 animate : true,
		 onClick : function(node) {
				onclicktype = 0;
				$("#govlevel").val(node.level);
				$("#govid").val(node.id);
				$("#govtest").val(node.text);
				$('#gov_dg').datagrid('load',{
					level: node.level,
					govid: node.id
				});
				if(node.level==2){
					$("#addgov").show();
				}else{
					$("#addgov").hide();
					$(this).tree(node.state === 'closed' ? 'expand': 'collapse',node.target);
					node.state = node.state === 'closed' ? 'open': 'closed';
				}
			},
			onContextMenu : function(e,node) {
				e.preventDefault();
				// 查找节点
				$('#ttgov').tree('select',node.target);
				$("#govlevel").val(node.level);
				$("#govid").val(node.id);
				$("#govtest").val(node.text);
				if (node.level == 0) {
				}else{
					// 显示快捷菜单
					getSecondNum(node.level,node.id);
					if(unitnums==0 && node.level == 2){
						$('#govmf').menu('show', {
							left : e.pageX,
							top : e.pageY
						});
					}else{
						$('#govmr').menu('show', {
							left : e.pageX,
							top : e.pageY
						});
					}
					if(node.level==2){
						$("#addgov").hide();
					}else{
						$("#addgov").hide();
					}
				}
			}
		}); 
 }
  </script>
  <!-- updatetype 1为二级修改 2 二级增加 3一级增加 4一级修改 -->
  <input type="hidden" id="updatetype" ></input>
  <input type="hidden" id="govlevel" ></input>
  <input type="hidden" id="govid" ></input>
  <input type="hidden" id="govtest" ></input>
  
  	<div class="b">
  		<div class="b-l">
  			<div class="easyui-panel" style="padding:5px;">
  				<ul id="ttgov" class="easyui-tree"></ul>  
  			</div>
		</div>
		<div class="b-r">
				<div class="b-r-top"  >
					<form id="gov_searchform">
						<table class="gov-table1">
							<tr>
								<td>二级单位：
                                    <input class="easyui-textbox" name="unitname" id="govunitname" style="width:150px">
                                </td>
                                 <td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"  onclick="searchGovDataGrid()">查询</a>
	    								&nbsp; &nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true"  onclick="$('#gov_searchform').form('clear');$('#govlevel').val('');$('#govid').val('');$('#gov_dg').datagrid('load',{});addGovTree()">重置</a>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="b-r-bot"  >
						<table id="gov_dg"  style="height: 425px;">
								<thead >
		                            <tr>
		                                <th data-options="field:'ck',width:10,checkbox:true"></th>
		                                <th data-options="field:'unitname',width:20,align:'center'">二级单位</th>
		                                <th data-options="field:'punitname',width:20,align:'center'">一级单位</th>
		                                <th data-options="field:'groupname',width:20,align:'center'">单位类别</th>
		                                <th data-options="field:'ismanage',width:20,align:'center',formatter:govdetailformater">角色</th>
		                            </tr>
		                        </thead>
							</table>
				</div>
		</div>
  	</div>
  	<div id="govmr" class="easyui-menu" style="width:120px;">
			<div onclick="append()" data-options="iconCls:'icon-add'">追加</div>
		</div>
		<div id="govmf" class="easyui-menu" style="width:120px;">
			<div onclick="append()" data-options="iconCls:'icon-add'">追加</div>
			<div onclick="removes()" data-options="iconCls:'icon-remove'">移除</div>
		</div>
		<div id="govms" class="easyui-menu" style="width:120px;">
			<div onclick="removes()" data-options="iconCls:'icon-remove'">移除</div>
		</div>
		
		<div id="govwindow2" class="easyui-window" title="二级部门添加" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:400px;height:260px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false" style="padding:5px;">
					<form id="govtwoform" method="post" enctype="multipart/form-data" >
						<div class="level-1">
								<p>一级部门名称</p>
								<div class="infor-left">
										<input name="punitname" id="g2punitname" class="easyui-textbox"   editable=false  style="width:200px;height:30px;margin-left:8px;background: #ccc" />
										<input type="hidden" name="punitid"  id="g2punitid" ></input>
								</div>
						</div>
						<div class="level-1">
								<p>二级部门名称</p>
								<div class="infor-left">
										<input name="unitname" id="g2unitname" class="easyui-textbox"  data-options="required:true,missingMessage:'请输入二级部门名称',validType:['nameInput','maxLength[128]'],prompt:'不得超过128字'"  style="width:200px;height:30px;margin-left:8px;"/>
										<input type="hidden" name="unitid"  id="g2unitid" ></input>
								</div>
						</div>
						<div class="level-1">
								<p>部门简称（英文字母）</p>
								<div class="infor-left">
										<input name="unitshort" id="g2unitshort" class="easyui-textbox"  data-options="required:true,missingMessage:'请输入部门简称（英文字母）',validType:['english','maxLength[32]'],prompt:'不得超过32英文字符'"  style="width:200px;height:30px;margin-left:8px;"/>
								</div>
						</div>
						<div class="level-1">
								<p>角色</p>
								<div class="infor-left">
										<select name="ismanage" id="g2ismanage" class="easyui-combobox"  data-options="required:true,missingMessage:'请选择角色',prompt:'请选择'"  style="width:200px;height:30px;margin-left:8px;">
									    <option value="0" >信息化非主管单位</option>
									    <option value="1">信息化主管单位</option>
								  </select>  
								</div>
						</div>
					</form>
					<div id="govaddmsg" style="margin-left:225px;color:red;"></div>
							<div class="bottom">
								<div class="gov-button" >
										<a id="g2savebtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="gov2add()">   保存   </a> 
										<a id="g2btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="govaddHide()">   取消   </a> 
								</div>
							</div>
				</div>
			</div>
		</div>
		
		<div id="govwindow1" class="easyui-window" title="一级部门添加" data-options="closed:true,cache : false,iconCls:'icon-save',modal: true" style="width:400px;height:300px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false" style="padding:5px;">
					<form id="govoneform" method="post" enctype="multipart/form-data" >
						<div class="level-1">
								<p>组织机构类别</p>
								<div class="infor-left">
										<input name="groupname" id="g1groupname" class="easyui-textbox" editable=false   style="width:200px;height:30px;margin-left:8px;background: #ccc" />
										<input type="hidden" name="groupid"  id="g1groupid" ></input>
										<input type="hidden" name="unitlevel"  id="g1unitlevel"  value="1"></input>
								</div>
						</div>
						<div class="level-1">
								<p>一级部门名称</p>
								<div class="infor-left">
										<input name="punitname" id="g1punitname" class="easyui-textbox" style="width:200px;height:30px;margin-left:8px;" data-options="required:true,missingMessage:'请输入一级部门名称',validType:['nameInput','maxLength[128]'],prompt:'不得超过128字'"/>
										<input type="hidden" name=punitid  id="g1punitid" ></input>
								</div>
						</div>
						<div class="level-1">
								<p>部门简称（英文字母）</p>
								<div class="infor-left">
										<input name="unitshort" id="g1unitshort" class="easyui-textbox" style="width:200px;height:30px;margin-left:8px;" data-options="required:true,missingMessage:'请输入部门简称（英文字母）',validType:['english','maxLength[32]'],prompt:'不得超过32英文字符'"/>
								</div>
						</div>
						<div class="level-1">
								<p>归属地区</p>
								<div class="infor-left">
										<input name="cityid " id="g1cityid" class="easyui-combobox"  style="width:200px;height:30px;margin-left:8px;" data-options="required:true,missingMessage:'请选择归属地',prompt:'请选择',
											url: getGovernmentRegionurl,
																valueField: 'id', 
																textField: 'name', 
																filter: function(q, row){
																	var opts = $(this).combobox('options');
																	return row[opts.textField].indexOf(q) == 0; 
																},
																onSelect: function(rec){ 
																		$('#g1cityname').val(rec.name);
																}
										"/>
										<input type="hidden" name="cityname"  id="g1cityname" ></input>
								</div>
						</div>
						<div class="level-1">
										<p>分组排序</p>
										<div class="infor-left">
												<input name="groupsort" id="g1groupsort" class="easyui-textbox"   style="width:200px;height:30px;margin-left:8px;" data-options="required:true,validType:['integ','range[1,127]'],prompt:'请输入1到127的整数',missingMessage:'请输入分组排序号(最小为1的整数)'" />
										</div>
								</div>
					</form>
					<div id="govaddmsg" style="margin-left:225px;color:red;"></div>
						<div class="bottom">
							<div class="gov-button" >
									<a id="g1savebtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="gov2add()">   保存   </a> 
									<a id="g1btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="govaddHide()">   取消   </a> 
							</div>
						</div>
				</div>
			</div>
		</div>
  </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/icp/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>

<body>
	<%-- <jsp:include page="resourceForm.jsp"></jsp:include> --%>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:40px;overflow:hidden;border:false">
			<form id="vm_searchform">
				<table>
					<tr style="margin: 10px 20px 10px 20px;padding: 10px;" >
						<td style="margin: 10px 20px 10px 20px;padding: 10px;">单位：
							<input name="resourceUnit" id="resourceUnit" style="width:200px">
						</td>
						<td style="margin: 10px 20px 10px 20px;padding: 10px;">项目：
							<input name="projectName" id="projectName" style="width:200px">
						</td>
						<td align="center" colspan="3">
							<a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<div data-options="region:'center',border:false" id="addid">
				<table title="" style="width:100%;" id="dg">
					<thead>
						<tr>
							<%--n_gc_project_object  projectid, projectname, unittype, unitid, unitname, objectid, severtypeidlevelfirst,--%>
							<%--servertypenamelevelfirst, servertypeidlevelsecond, servertypenamesecond, appname, bussinessstat, extension1, extension2, extension3, snote--%>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'neid',width:20,align:'center',sortable:true,hidden:true"></th>
							<th data-options="field:'projectid',width:20,align:'center',sortable:true,hidden:true">项目编号</th>
							<th data-options="field:'projectname',width:50,align:'center',sortable:true">项目名称</th>
							<th data-options="field:'unitname',width:20,align:'center',sortable:true">所属单位</th>
							<!-- <th data-options="field:'displayname',width:20,align:'center',sortable:true">实例名称</th> -->
							<th data-options="field:'servertypenamesecond',width:20,align:'center',sortable:true,">服务名称</th>
							<th data-options="field:'servertypenamelevelfirst',width:100,align:'center',hidden:true">类型</th>
							<th data-options="field:'severtypeidlevelfirst',width:100,align:'center',hidden:true">一级分类id</th>
							<th data-options="field:'servertypeidlevelsecond',width:100,align:'center',hidden:true">二级分类id</th>
							<th data-options="field:'appname',width:40,align:'center'" >应用</th>
							<th data-options="field:'testtime',width:30,align:'center',sortable:true">试运行时间</th>
							<th data-options="field:'usetime',width:30,align:'center',sortable:true">开始计费时间</th>
							<th data-options="field:'curstat',width:20,align:'center'" formatter="statusFormatter">状态</th>
							
							<!-- n_gc_network  objectid ,networktype ,domainname,interaip,interaport,interipunincom,interiptelecom,interipgov,interport,bandwidth-->
							<th data-options="field:'objectid',hidden:true"></th>
							<th data-options="field:'networktype',hidden:true"></th>
							<th data-options="field:'domainname',hidden:true"></th>
							<th data-options="field:'interaip',hidden:true"></th>
							<th data-options="field:'interaport',hidden:true"></th>
							<th data-options="field:'interipunincom',hidden:true"></th>
							<th data-options="field:'interiptelecom',hidden:true"></th>
							<th data-options="field:'interiptelecom',hidden:true"></th>
							<th data-options="field:'interipgov',hidden:true"></th>
							<th data-options="field:'interport',hidden:true"></th>
							<th data-options="field:'bandwidth',hidden:true"></th>
							
							<!-- rmd_vm  serverid,cpunum,memnum,disknum,osname,hostid -->
							<th data-options="field:'serverid',hidden:true"></th>
							<th data-options="field:'cpunum',hidden:true"></th>
							<th data-options="field:'memnum',hidden:true"></th>
							<th data-options="field:'disknum',hidden:true"></th>
							<th data-options="field:'osname',hidden:true"></th>
							<th data-options="field:'hostid',hidden:true"></th>											
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
<script type="text/javascript" src="../gov2.js"></script>
<script type="text/javascript">
	var flagck = 0;  //  初始化为0
	$(document).ready(function () {
		var _toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{
	                $('<div></div>').dialog({
	                    id : 'windowVM',
	                    title : '云服务器信息',
	                    width : 600,
	                    height : 590,
	                    closed : false,
	                    cache : false,
	                    href : '${ctx}/web/gov2/resourcemanage/resourceForm.jsp',
	                    modal : true,
	                    onLoad : function() {
	                        //初始化表单数据
	                    	$("#unitname").textbox('setValue','');
	            			$("#projectname").textbox('setValue','');
	            			$("#servertypenamelevelfirst").textbox('setValue','计算');
	            			$("#servertypenamesecond").textbox('setValue','云服务器');
	            			$("#severtypeidlevelfirst").val('100001');
	            			$("#servertypeidlevelsecond").val('200001');
	            			$("#nename").textbox('setValue','');
	            			//$("#displayname").textbox('setValue','');
	            			$("#appname").textbox('setValue','');
	            	
            				$("#cpunum").textbox('setValue','');
            				$("#memnum").textbox('setValue','');
            				$("#disknum1").textbox('setValue','');
            				$("#disknum2").textbox('setValue','');
            				$("#osname").combobox('setValue','');
            				$("#hostid").textbox('setValue','');
            	
            				$("#networktype").combobox('setValue','');
            				$("#domainname").textbox('setValue','');
            				$("#interaip").textbox('setValue','');
            				$("#interaport").textbox('setValue','');
            				$("#interipunincom").textbox('setValue','');
            				$("#interiptelecom").textbox('setValue','');
            				$("#interipgov").textbox('setValue','');
            				$("#interport").textbox('setValue','');
            				$("#bandwidth").textbox('setValue','');
            				$('#waiIP').hide();
            				$('#IP').show();
            				url='${ctx}/resourceinfo/addResourceVM.do';
	                    },
	                    onClose : function() {
	                        $(this).dialog('destroy');
	                    },
	                    buttons : [ {
	                        text : '确定',
	                        iconCls : 'icon-ok',
	                        handler : function() {
	                            //提交表单
	                            confirmBtn();
	                        }
	                    }, {
	                        text : '取消',
	                        iconCls : 'icon-cancel',
	                        handler : function() {
	                            $("#windowVM").dialog('destroy');
	                        }
	                    } ]

	                });
		        }

		},{
			text:'删除',
			iconCls:'icon-delete',
			handler:function()
			{
				var rows = $('#dg').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！');
					return;
				}
				var objectids = "";
				$.each(rows,function(index,object){
					objectids+=object.objectid+",";
				});
				$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){
					if (r){
						$.ajax({
							type : 'post',
							url:'${ctx}/resourceinfo/deleteProject.do',
							data:{objectids:objectids},
							success:function(retr){
								var data = JSON.parse(retr);
								$.messager.alert('消息',data.msg);
								if(data.success)
								{
									$('#dg').datagrid('unselectAll');
									$('#dg').datagrid('reload');
								}
							}
						});
					}
				});
			}
		},{
			text:'修改',
			iconCls:'icon-modify',
			handler:function()
			{	
				var rows = $('#dg').datagrid('getChecked');
				if (rows.length != 1) {
					$.messager.alert('消息', '请选择一条记录！');
					return;
				}
	            if (rows) {
	                $('<div></div>').dialog({
	                    id : 'windowVM',
	                    title : '云服务器信息',
	                    width : 600,
	                    height : 590,
	                    closed : false,
	                    cache : false,
	                    href : '${ctx}/web/gov2/resourcemanage/resourceForm.jsp',
	                    modal : true,
	                    onLoad : function() {
	                    	var disknum = rows[0].disknum;
	                    	//1,20;2,40
	                    	var a = disknum.indexOf(",");
	                    	var b = disknum.indexOf(";");
	                    	var c = disknum.lastIndexOf(",");
	                    	var disknum1 = disknum.substring(a+1,b);
	        				var disknum2 = disknum.substring(c+1);
	                        //初始化表单数据
	        				$("#neid").val(rows[0].neid);
	        				$("#unitname").textbox('setValue',rows[0].unitname);
	        				$("#projectname").textbox('setValue',rows[0].projectname);
	        				$("#servertypenamelevelfirst").textbox('setValue','计算');
	        				$("#servertypenamesecond").textbox('setValue','云服务器');
	        				$("#severtypeidlevelfirst").val('100001');
	        				$("#servertypeidlevelsecond").val('200001');
	        				$("#nename").textbox('setValue',rows[0].nename);
	        				//$("#displayname").textbox('setValue',rows[0].displayname);
	        				$("#appname").textbox('setValue',rows[0].appname);
	        	
	        				$("#cpunum").textbox('setValue',rows[0].cpunum);
	        				$("#memnum").textbox('setValue',rows[0].memnum);
	        				$("#disknum1").textbox('setValue',disknum1);
	        				$("#disknum2").textbox('setValue',disknum2);
	        				$("#osname").textbox('setValue',rows[0].osname);
	        				$("#hostid").textbox('setValue',rows[0].hostid);
	        				if("1"==rows[0].networktype){
	        					$("#networktype").textbox('setValue',"政务外网");
	        					$('#IP').hide();
	        					$('#waiIP').show();
	        					$("#interport").textbox('setValue',rows[0].interport);
	        				}else{
	        					$("#networktype").textbox('setValue',"互联网");
	        					$('#IP').show();
	        					$('#waiIP').hide();
	        					$("#interports").textbox('setValue',rows[0].interport);
	        				}
	        				$("#domainname").textbox('setValue',rows[0].domainname);
	        				$("#interaip").textbox('setValue',rows[0].interaip);
	        				$("#interaport").textbox('setValue',rows[0].interaport);
	        				$("#interipunincom").textbox('setValue',rows[0].interipunincom);
	        				$("#interiptelecom").textbox('setValue',rows[0].interiptelecom);
	        				$("#interipgov").textbox('setValue',rows[0].interipgov);
	        				$("#bandwidth").textbox('setValue',rows[0].bandwidth);
	        				url='${ctx}/resourceinfo/updateResourceVM.do';
	                    },
	                    onClose : function() {
	                        $(this).dialog('destroy');
	                    },
	                    buttons : [ {
	                        text : '确定',
	                        iconCls : 'icon-ok',
	                        handler : function() {
	                            //提交表单
	                            confirmBtn();
	                        }
	                    }, {
	                        text : '取消',
	                        iconCls : 'icon-cancel',
	                        handler : function() {
	                            $("#windowVM").dialog('destroy');
	                        }
	                    } ]

	                });
	              }	
			}
		}];
		
		loadDataGrid();
			//项目下拉框
		$('#projectName').combobox({
			width:140,
			panelHeight: '100'
		}); 
		
		//单位下拉框
		$('#resourceUnit').combobox({
			url:'${ctx}/infopublish/getDepartsTJ.do',
			valueField: 'unitId',
			textField: 'unitName',
			width:100,
			panelHeight: '100',
			onSelect:function (record){
				var _unitId = record.unitId;
				$('#projectName').combobox({
					url:'${ctx}/project/getprojectsAll.do?unitId='+_unitId,
					valueField: 'proid',
					textField: 'proname',
					loadFilter:function(data){
						data.unshift({proid:"",proname:"请选择"});
						return data;
					}
				});
			}
		});
		//查询
		$("#search").click(function () {
			searchDataGrid();
		});
		//重置
		$("#formReset").click(function () {
			$("#vm_searchform").form("reset");
			searchDataGrid();
		});
	
		function loadDataGrid() {
			$('#dg').datagrid({
				rownumbers: false,
				scrollbarSize:0,
				checkOnSelect: true,
				selectOnCheck: true,
				border: false,
				striped: true,
				sortName: 'projectid',
				sortOrder: 'asc',
				nowarp: false,
				singleSelect: true,
				method: 'post',
				loadMsg: '数据装载中......',
				fitColumns: true,
				idField: 'neid',
				pagination: true,
				toolbar: _toolbar,
				pageSize:10,
				pageNumber:1,
				pageList: [5,10,20,30],
				url: '${ctx}/resourceinfo/resourceinfoListVM.do',
				   onLoadSuccess: function (data) {
					      var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
					      var  _pageSize = pageopt.pageSize;
					      var  _rows = $('#dg').datagrid("getRows").length;
					      var total = pageopt.total; //显示的查询的总数
					      if (_pageSize >= 10) {
					         for(i=10;i>_rows;i--){
					            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					            $(this).datagrid('appendRow', {objectid:''  })
					         }
					         $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
						    	total: total,
						     });
					         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
					      }else{
					         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
					         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					      }
					    //设置不显示复选框
					      var rows = data.rows;
					      if (rows.length) {
								 $.each(rows, function (idx, val) {
									if(val.objectid==''){ 
										//addid为datagrid上一层的div id
										$('#addid  input:checkbox').eq(idx+1).css("display","none");
										 
									}
								}); 
					      }
					 } ,
					 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
							if(rowData.objectid==''){
								 $(this).datagrid('unselectRow', rowIndex);
							}else{
								//点击有数据的行  标志位变为0
								flagck=0;
							}
							//判断时候已经有全部选择
							if(flagck ==1){
								$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
							}
					}, 
					 //点击全选
					onCheckAll: function(rows) {
							//全选时，标志位变为1
							flagck = 1;
							$.each(rows, function (idx, val) {
								if(val.objectid==''){
									//如果是空行，不能被选中
									$("#dg").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");	
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
	
		function searchDataGrid() {
			$('#dg').datagrid('load', $('#vm_searchform').form('serialize'));
		}
		$.extend($.fn.form.methods, {
			serialize: function (jq) {
				var arrayValue = $(jq[0]).serializeArray();
				var json = {};
				$.each(arrayValue, function () {
					var item = this;
					if (json[item["name"]]) {
						json[item["name"]] = json[item["name"]] + "," + item["value"];
					} else {
						json[item["name"]] = item["value"];
					}
				});
				return json;
			},
			getValue: function (jq, name) {
				var jsonValue = $(jq[0]).form("serialize");
				return jsonValue[name];
			},
			setValue: function (jq, name, value) {
				return jq.each(function () {
					_b(this, _29);
					var data = {};
					data[name] = value;
					$(this).form("load", data);
				});
			}
		});
	});
	
	//增加$修改 确定按钮
	function confirmBtn(){
		$('#formVM').form('submit',{
			url:url,
	        onSubmit:function(){ 
	        	var reg=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;//IP格式 正则表达式
	        	//表单验证
	        	var unitname =  $("#unitname").textbox('getValue');
	        	if(""==unitname || null==unitname){ 
	                $.messager.alert('提示',"请选择单位！"); 
	                return false;
	            }
	        	var projectname =  $("#projectname").textbox('getValue');
	        	if(""==projectname || null==projectname){ 
	                $.messager.alert('提示',"请选择项目！"); 
	                return false;
	            }
	        	/* var displayname =  $("#displayname").textbox('getValue');
	        	if(displayname=="" || displayname==null){ 
	                $.messager.alert('提示',"名称不能为空！"); 
	                return false;
	            } */
	        	var appname =  $("#appname").textbox('getValue');
	        	if(appname=="" || appname==null){ 
	                $.messager.alert('提示',"应用不能为空！"); 
	                return false;
	            }
	        	var objectname =  $("#objectname").textbox('getValue');
	        	if(objectname=="" || objectname==null){ 
	                $.messager.alert('提示',"uuid名称不能为空！"); 
	                return false;
	            }
	        	var cpunum =  $("#cpunum").textbox('getValue');
	        	if(""==cpunum || null==cpunum){ 
	                $.messager.alert('提示',"CPU不能为空！"); 
	                return false;
	            }else{
	            	if(!/^\+?[1-9][0-9]*$/.test(cpunum)){
	            		$.messager.alert('提示',"CPU格式有误,请输入非0正整数!");
	                    return false;
	                }
	            }
	        	var memnum =  $("#memnum").textbox('getValue');
	        	if(""==memnum || null==memnum){ 
	                $.messager.alert('提示',"内存不能为空！"); 
	                return false;
	            }else{
	            	if(!/^\+?[1-9][0-9]*$/.test(memnum)){
	            		$.messager.alert('提示',"内存格式有误,请输入非0正整数!");
	                    return false;
	                }
	            }
	        	//^(0|[1-9]\d*)$  非负整数
	        	var disknum1 =  $("#disknum1").textbox('getValue');
	        	var disknum2 =  $("#disknum2").textbox('getValue');
	        	if(disknum1=="" || disknum1==null){ 
	                $.messager.alert('提示',"数据盘1不能为空！"); 
	                return false;
	            }else if(!(disknum2=="" || disknum2==null)){
	            	if(!/^(0|[1-9]\d*)$/.test(disknum1)||!/^(0|[1-9]\d*)$$/.test(disknum2)){
	            		$.messager.alert('提示',"数据盘格式有误,请输入非0正整数!");
	                    return false;
	                }
	            }
	        	var osname =  $("#osname").textbox('getValue');
	        	if(osname=="" || osname==null){ 
	                $.messager.alert('提示',"请选择系统！"); 
	                return false;
	            }
	        	var hostid =  $("#hostid").textbox('getValue');
	        	if(hostid=="" || hostid==null){ 
	                $.messager.alert('提示',"主机IP不能为空！"); 
	                return false;
	            }else if(reg.test(hostid)){    
					if(!(RegExp.$1<256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256)){
						$.messager.alert('提示',"请输入正确的主机IP范围！");
						return false;     
					}   
	            }else{    
	            	$.messager.alert('提示',"主机IP格式有误！");     
	            	return false;
	            }
	        	//return $(this).form('validate');
	        	var networktype =  $("#networktype").textbox('getValue');
	        	if(""==networktype || null==networktype){ 
	                $.messager.alert('提示',"请选择网络类型！"); 
	                return false;
	            }
	        	var domainname =  $("#domainname").textbox('getValue');
	        	if(domainname=="" || domainname==null){ 
	                $.messager.alert('提示',"域名不能为空！"); 
	                return false;
	            }
	        	var interaip =  $("#interaip").textbox('getValue');
	        	if(interaip=="" || interaip==null){ 
	                $.messager.alert('提示',"内网IP不能为空！"); 
	                return false;
	            }else if(reg.test(interaip)){    
					if(!(RegExp.$1<256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256)){
						$.messager.alert('提示',"请输入正确的内网IP范围！");
						return false;     
					}   
	            }else{    
	            	$.messager.alert('提示',"内网IP格式有误！");     
	            	return false;
	            }
	        	var interaport =  $("#interaport").textbox('getValue');
	        	if(interaport=="" || interaport==null){ 
	                $.messager.alert('提示',"内网端口不能为空！"); 
	                return false;
	            }else{
	            	if(!/^[0-9]*$/.test(interaport)){
	            		$.messager.alert('提示',"内网端口格式有误,请输入数字!");
	                    return false;
	                }
	            }
	        	if('1'==networktype){//网络类型：政务外网
	        		var interipgov =  $("#interipgov").textbox('getValue');
		        	if(interipgov=="" || interipgov==null){ 
		                $.messager.alert('提示',"外网IP不能为空！"); 
		                return false;
		            }else if(reg.test(interipgov)){    
						if(!(RegExp.$1<256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256)){
							$.messager.alert('提示',"请输入正确的外网IP范围！");
							return false;     
						}   
		            }else{    
		            	$.messager.alert('提示',"外网IP格式有误！");     
		            	return false;
		            }
		        	var interport =  $("#interport").textbox('getValue');
		        	if(interport=="" || interport==null){ 
		                $.messager.alert('提示',"外网端口不能为空！"); 
		                return false;
		            }else{
		            	if(!/^[0-9]*$/.test(interport)){
		            		$.messager.alert('提示',"外网端口格式有误,请输入数字!");
		                    return false;
		                }
		            }
	        	}else if('2'==networktype){//网络类型：互联网
		        	var interipunincom =  $("#interipunincom").textbox('getValue');
		        	if(interipunincom=="" || interipunincom==null){ 
		                $.messager.alert('提示',"联通IP不能为空！"); 
		                return false;
		            }else if(reg.test(interipunincom)){    
						if(!(RegExp.$1<256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256)){
							$.messager.alert('提示',"请输入正确的联通IP范围！");
							return false;     
						}   
		            }else{    
		            	$.messager.alert('提示',"联通IP格式有误！");     
		            	return false;
		            }
		        	var interiptelecom =  $("#interiptelecom").textbox('getValue');
		        	if(interiptelecom=="" || interiptelecom==null){ 
		                $.messager.alert('提示',"电信IP不能为空！"); 
		                return false;
		            }else if(reg.test(interiptelecom)){    
						if(!(RegExp.$1<256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256)){
							$.messager.alert('提示',"请输入正确的电信IP范围！");
							return false;     
						}   
		            }else{    
		            	$.messager.alert('提示',"电信IP格式有误！");     
		            	return false;
		            }
		        	var interports =  $("#interports").textbox('getValue');
		        	if(interports=="" || interports==null){ 
		                $.messager.alert('提示',"外网端口不能为空！"); 
		                return false;
		            }else{
		            	if(!/^[0-9]*$/.test(interports)){
		            		$.messager.alert('提示',"外网端口格式有误,请输入数字!");
		                    return false;
		                }
		            }  	
		        	var bandwidth =  $("#bandwidth").textbox('getValue');
		        	if(bandwidth=="" || bandwidth==null){ 
		                $.messager.alert('提示',"带宽不能为空！"); 
		                return false;
		            }else{
		            	if(!/^[0-9]*$/.test(bandwidth)){
		            		$.messager.alert('提示',"带宽格式有误,请输入数字!");
		                    return false;
		                }
		            }
	        	}	            
	        },
	        success:function(data){
	        	var _data = JSON.parse(data);
	        	$('#windowVM').window('close');
	  			$.messager.alert('消息',_data.msg);
	        	if(_data.success){
	        		$('#dg').datagrid('unselectAll');
		    		$('#dg').datagrid('reload');
	        	}
	        }        
		})
	}
	//状态
	function statusFormatter(val,rows,index){
		switch (rows.bussinessstat) {
			case "0":
				return "开通"
			case "1":
				return "试运行";
			case "2":
				return "计费开始";
			case "3":
				return "计费结束"; 
		}
	}
</script>
</body>
</html>
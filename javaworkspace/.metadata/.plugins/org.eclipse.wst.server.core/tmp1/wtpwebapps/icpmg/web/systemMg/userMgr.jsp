<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<script type="text/javascript" charset="utf-8">
var flagck = 0;  //  初始化为0
$(function(){
	//重置密码
   passwdSet =  function(){
    var rows = datagrid.datagrid('getSelections');
		if(rows.length > 0){
			$.messager.confirm('请确认','您确定要重置当前所有选择的用户密码吗?',function(b){
					if(b){
						var ids = [];
						for(var i =0;i<rows.length;i++){
							if(rows[i].status !=3){
								$.messager.alert('提示','非正常状态的用户无法完成密码重置,请重新选择.');
								return ;
							}else{
								ids.push(rows[i].email);
							}
							
					}
					/* console.info(ids.join(',')); */
					$.ajax({
						url:'${pageContext.request.contextPath}/authMgr/resetUser.do',
						data:{
							emailids: ids.join(',')
						},
						cache:false,
						dataType:"json",
						success:function(r){
							if(r && r.success){
								datagrid.datagrid('acceptChanges');
								$.messager.show({
									msg:r.msg,
									title:'成功'
								});
							}else{
								datagrid.datagrid('rejectChanges');
								$.messager.alert('错误',r.msg,'error');
							}
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('load');
						}
					});
				}
			});
		}else{
			$.messager.alert('提示','请选择要重置的用户！','error');
		}
     
   }
	
	searchForm = $('#usermgr_searchform').form();
	
	var userlevel_data = [{"value":"1","text":"父帐号"},{"value":"2","text":"子帐号"}];
	var usertype_data = [{"value":"1","text":"政府客户"},{"value":"2","text":"企业客户"},{"value":"3","text":"公众客户"},{"value":"4","text":"管理员"}];
	var status_data = [{"value":"1","text":"待验证"},{"value":"2","text":"待审核"},{"value":"3","text":"正常"},{"value":"0","text":"驳回"},{"value":"4","text":"注销"}];
	
	datagrid = $('#datagrid_user').datagrid({
		url:'${pageContext.request.contextPath}/authMgr/getUsers.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		/* fit:true, */		
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'email',
		sortName:'utime',
		sortOrder:'desc',
		toolbar:'#user_tb',
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'电子邮箱',
			field:'email',
			width:100,
			sortable:true
		},{
			title:'密码',
			field:'passwd',
			width:100,
			hidden:true,
			formatter: function(value,rowData,rowIndex){
				return '<span title="密码">******</span>';
			}
		},{
			title:'时间',
			field:'validtime',
			hidden:true,
		},{
			title:'手机号码',
			field:'mobile',
			width:100
		},{
			title:'用户名称',
			field:'uname',
			width:100
		},{
			title:'帐号类型',
			field:'userlevel',
			width:100,
			formatter:function(value,row,index){
			    for(var i = 0; i < userlevel_data.length; i++){
			        if (userlevel_data[i].value == value){
			            return userlevel_data[i].text;
			        }
			    }
			},
			editor:{
				type:'combobox',
				options:{
					data:userlevel_data,
					valueField:"value",
					textField:"text"
				}
			} 
		},{
			title:'父帐号邮箱',
			field:'pemail',
			width:100
		},{
			title:'用户类型',
			field:'usertype',
			width:100,
			formatter:function(value,row,index){
			    for(var i = 0; i < usertype_data.length; i++){
			        if (usertype_data[i].value == value){
			            return usertype_data[i].text;
			        }
			    }
			},
			editor:{
				type:'combobox',
				options:{
					data:usertype_data,
					valueField:"value",
					textField:"text"
				}
			}
		},{
			title:'状态',
			field:'status',
			width:100,
			formatter:function(value,row,index){
			    for(var i = 0; i < status_data.length; i++){
			        if (status_data[i].value == value){
			            return status_data[i].text;
			        }
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
		},{
			title:'别名',
			field:'alias',
			width:100,
			hidden:true
		},{
			title:'密保问题',
			field:'pwdpp',
			width:100,
			hidden:true
		},{
			title:'密保答案',
			field:'pwdppanswer',
			width:100,
			hidden:true
		},{
			title:'付费方式',
			field:'biway',
			width:100,
			hidden:true
		},{
			title:'操作',
			field:'ops',
			width:100,
			formatter: function(value,rowData,rowIndex){
				if(rowData.email){
					var str='';
					str += '<a onclick="showOperaLogFun(\''+rowData.email+'\');">日志</a>|';
					str += '<a onclick="grantRoleFun(\''+rowData.email+'\',\''+rowData.status+'\');">角色</a>';
					return str;
				}
			}
		}]],
		onLoadSuccess: function (data) {
		      var pageopt = $('#datagrid_user').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#datagrid_user').datagrid("getRows").length;
		      var total = pageopt.total; //显示的查询的总数
		      if (_pageSize >= 10) {
		         for(i=10;i>_rows;i--){
		            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
		            $(this).datagrid('appendRow', {email:''  });
		         }
		         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
		         $('#datagrid_user').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    	total: total,
			     });
		      }else{
		         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		    //设置不显示复选框
	        var rows = data.rows;
	        if (rows.length) {
				 $.each(rows, function (idx, val) {
					if(val.email==''){ 
						//addid为datagrid上一层的div id
						$('#addid  input:checkbox').eq(idx+1).css("display","none");
						 
					}
				}); 
	        }
		 },
		//没数据的行不能被点击选中
		onClickRow: function (rowIndex, rowData) {
			if(rowData.email==''){
				 $('#datagrid_user').datagrid('unselectRow', rowIndex);
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
					if(val.email==''){
						//如果是空行，不能被选中
						$("#datagrid_user").datagrid('uncheckRow', idx);
						//增加全选复选框被选中
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");	
					}
				});
		},
		 //取消全选
		onUncheckAll: function(rows) {
			//取消全选时，标志位变为0
			flagck = 0;
		}
	});
	searchFun=function(){
		datagrid.datagrid('load',icp.serializeObject(searchForm));
	};
	cleanSearchFun=function(){
		searchForm.find('input').val('');
		datagrid.datagrid('load',{});
	};
	
	addUserFun=function(){
		$('#user_add_addForm .easyui-textbox').each(function(index){
			$(this).textbox('setText','');
			$(this).textbox('setValue','');
		});
		/*
		$('#auserlevel').attr('checked',true);
		$('#apemaildiv').show();
		$('#abiwaydiv').show();
		$('#ausertype').val(4);
		$('#acorpinfodiv').hide();
		$('#agovmtinfodiv').hide();
		$('#aauserlevel').val('2');//默认为子帐号 
		*/
		//默认处理为默认展示父账号 2016-07-19
		$('#auserlevel').attr('checked',false);
		$('#aauserlevel').val('1');//默认为父账号
		$('#ausertype').val(1);//政府客户
		$('#apemaildiv').hide();
		$('#abiwaydiv').hide();
		$('#agovmtinfodiv').show();
		$('#acorpinfodiv').hide();
		clearAddAllMsg(); 
		$('#user_add_dialog').dialog('open');
		
		comboxselect();
		/* window.open('${pageContext.request.contextPath}/web/systemMg/userMgrAddUserBasicInfo.jsp','_blank'); */
	};
	
	delUserFun=function(){
		var rows = datagrid.datagrid('getSelections');
		if(rows.length > 0){
			if(rows[0].email){
				var isDelete = true;
				for(var i=0; i<rows.length; i++){
					if(rows[i].status != 4){
						isDelete = false;
						break;
					}
				}
				if(isDelete){
					$.messager.alert('提示','所选择的用户已被删除！');
					return;
				}
				$.messager.confirm('请确认','您确定要删除当前所有选择的记录吗?',function(b){
					if(b){
						var ids = [];
						for(var i =0;i<rows.length;i++){
							ids.push(rows[i].email);
						}
						/* console.info(ids.join(',')); */
						$.ajax({
							url:'${pageContext.request.contextPath}/authMgr/deleteUser.do',
							data:{
								emailids: ids.join(',')
							},
							cache:false,
							dataType:"json",
							success:function(r){
								if(r && r.success){
									datagrid.datagrid('acceptChanges');
									$.messager.show({
										msg:r.msg,
										title:'成功'
									});
								}else{
									datagrid.datagrid('rejectChanges');
									$.messager.alert('错误',r.msg,'error');
								}
								datagrid.datagrid('unselectAll');
								datagrid.datagrid('load');
							}
						});
					}
				});
			}
		}else{
			$.messager.alert('提示','请选择要删除的记录！','error');
		}
	};
	
	updateUserFun=function(){
		var rows = datagrid.datagrid('getSelections');
		if(rows.length == 1){	//选择一行
			if(rows[0].email){
				if(4 == rows[0].status){	//判断用户状态
					$.messager.alert('提示','所选择的用户已被注销！');
					return;
				}
				//设置基本信息		
				$("#email").val(rows[0].email);
				//$("#passwd").val(rows[0].passwd);
				$("#alias").val(rows[0].alias);
				$("#mobile").val(rows[0].mobile);
				$("#uname").val(rows[0].uname);
				$("#pwdpp").val(rows[0].pwdpp);
				var pwdppanswer = rows[0].pwdppanswer;
				if(pwdppanswer !=null && pwdppanswer != "null"){
					$("#pwdppanswer").val(rows[0].pwdppanswer);
				}
				
				$("#usertype").val(rows[0].usertype);//设置值为rows[0].usertype项为选中项 
				
				var ul = rows[0].userlevel;		//用户等级，子帐号父帐号
				var ut = rows[0].usertype;		//用户类型
				var bw = rows[0].biway;			//付费方式 
				
	 			if(ul == 2){
					$("#uuserlevel").attr("checked",true);
					$("#uuuserlevel").val("2");
					$("#upemail").val(rows[0].pemail);
					if(bw == 0){
		 				$("#bw1").attr("checked",true);
					}
					if(bw == 1){
						$("#bw2").attr("checked",true);
					}
					$("#ubiway").val(bw);
					$('#upemaildiv').show();
					$('#ubiwaydiv').show();
				}else{
					$("#uuserlevel").attr("checked",false);
					$("#uuuserlevel").val("1");
					$("#upemail").val("");
					$('#upemaildiv').hide();
					$('#ubiwaydiv').hide();				
				}
				
				if(ut == 4){
					$('#ucorpinfodiv').hide();
					$('#ugovmtinfodiv').hide();
				}
				//设置隐藏div
				if(ul == 2){	//子帐号
					$('#ugovmtinfodiv input').val('');
					$('#ucorpinfodiv input').val('');
					$('#ucorpinfodiv').hide();
					$('#ugovmtinfodiv').hide();
				}else{	//父帐号
					$.ajax({
						url:"${pageContext.request.contextPath}/userMgr/getCorpGovmntVo.do",
						cache: false,
						data:{email:rows[0].email,usertype:ut},
						success: function(data){
							var arr = jsonParse(data);
							if(arr != null && arr.length > 0){
								if(ut == 1){	//政府客户
									$("#ucontactpart").val(arr[0].unitcontactpart);
									$("#ucontacttel").val(arr[0].unitcontacttel);
									$("#ucontact_person").val(arr[0].unitcontactperson);
									//$("#uunitname").val(arr[0].unitname);
									$("#uofficeloc").val(arr[0].officeloc);
									$('#ugovmtinfodiv').show();
									$('#ucorpinfodiv').hide();
									//$("#punitname").val(arr[0].punitname);//一级部门
									
									$('#oneunitidUpdate').combobox({    
								   		valueField: 'unitId',    
								        textField: 'unitName',
								        editable:true,
								        loadFilter:function(data){
											    	data.unshift({unitId:'',unitName:'请选择'});
											        return data;
									    },
								        url: '${pageContext.request.contextPath}/project/getUnitsForRegist.do',
								        onLoadSuccess: function () { //加载完成后,选中
								        	$("#oneunitidUpdate").combobox("setValue",arr[0].punitid);//一级单位
									    }  
									});
									
									
									//处理二级单位
									var urlson = '${pageContext.request.contextPath}/project/getUnitsForRegistNext.do?unitid='+arr[0].punitid;    
					            	$('#twounitidUpdate').combobox({    
						                   url:urlson,    
						                   valueField:'unitId',    
						                   textField:'unitName',  
						                   editable:true,
						             	   onLoadSuccess: function () { //加载完成后,选中
						             		  $('#twounitidUpdate').combobox('setValue', arr[0].unitid);
									       }   
				         			   }).combobox('clear');
								}else if(ut == 2){	//企业客户
									$("#ucmpyname").val(arr[0].cmpyname);
									$("#ucmpycode").val(arr[0].cmpycode);
									$("#ucmpytel").val(arr[0].cmpytel);
									$("#ucontactperson").val(arr[0].contactperson);
									$("#ucontactmobile").val(arr[0].contactmobile);
									$("#uprovid").val(arr[0].provid);
									$("#ucityid").val(arr[0].cityid);
									$("#uprovname").val(arr[0].provname);
									$("#ucityname").val(arr[0].cityname);
									$("#ucmpyaddr").val(arr[0].cmpyaddr);
									$("#uzipcode").val(arr[0].zipcode);
									$("#uoneid").val(arr[0].oneid);
									$("#utwoid").val(arr[0].twoid);
									$("#uthreeid").val(arr[0].threeid);
									$("#uoneidname").val(arr[0].oneidname);
									$("#utwoidname").val(arr[0].twoidname);
									$("#uthreeidname").val(arr[0].threeidname);
									$("#uchannel").val(arr[0].channel);
									$('#ucorpinfodiv').show();
									$('#ugovmtinfodiv').hide();
								}
							}else{
								if(ut == 1){	//政府客户
									$('#ugovmtinfodiv').show();
									$('#ucorpinfodiv').hide();
								}else if(ut == 2){	//企业客户
									$('#ucorpinfodiv').show();
									$('#ugovmtinfodiv').hide();
								}
							}					
						}
					});
				}
				clearAllMsg();
				$('#user_update_dialog').dialog('open');
	//			$("#userMgr_update_window").window('open');
			}	
		}else{
			$.messager.alert('提示','请选择一条记录修改！','error');
		}
		datagrid.datagrid('unselectAll');	//取消所有的选中状态
	};
	
	showOperaLogFun=function(user_email){
		var dialog = parent.icp.modalDialog({
			title : '用户的所有操作日志',
			url : '${pageContext.request.contextPath}/web/systemMg/userAllOperaLog.jsp?id=' + user_email
		});
	};
	
	grantRoleFun=function(id,status){
		if(status != 3){
			$.messager.show({
				title:'提示',
				msg:"该用户不是正常用户，无法分配角色！"
			});
			// $.messager.alert('错误','此用户不是正常用户！','error');
			return;
		}
		$('#user_email_id').val(id);
		//parent.$.messager.progress({
			//text : '数据加载中....'
		//});
		$('#fact_role_tree').tree({
			url : '${pageContext.request.contextPath}/authMgr/getAllRoles.do?rt=1',
			checkbox : true,
			formatter : function(node) {
				return node.text;
			},
			onLoadSuccess : function(node, data){
				
				/* console.info(data); */
				$.post('${pageContext.request.contextPath}/authMgr/getRolesByUser.do', {
					id : $('#user_email_id').val()
				}, function(result) {
					
					if (result) {
						var arr = result.split(',');
						
						for (var i = 0; i < arr.length; i++) {
							var node = $('#fact_role_tree').tree('find', arr[i]);
							if (node) {
								//var isLeaf = $('#fact_role_tree').tree('isLeaf', node.target);
								// if (isLeaf) {
									//$('#fact_role_tree').tree('check', node.target);
								//} 
								$('#fact_role_tree').tree('check', node.target);
							}
						}
					}
					//parent.$.messager.progress('close');
				}, 'text');
			}
		});
		
		$('#hollow_role_tree').tree({
			url : '${pageContext.request.contextPath}/authMgr/getAllRoles.do?rt=0',
			checkbox : true,
			formatter : function(node) {
				return node.text;
			},
			onLoadSuccess : function(node, data){
				
				/* console.info(data); */
				$.post('${pageContext.request.contextPath}/authMgr/getRolesByUser.do', {
					id : $('#user_email_id').val()
				}, function(result) {
					if (result) {
						var arr = result.split(',');
						for (var i = 0; i < arr.length; i++) {
							var node = $('#hollow_role_tree').tree('find', arr[i]);
							if (node) {
								//var isLeaf = $('#hollow_role_tree').tree('isLeaf', node.target);
								 //if (isLeaf) {
								//	$('#hollow_role_tree').tree('check', node.target);
							//	}
								$('#hollow_role_tree').tree('check', node.target);
							}
						}
					}
					//parent.$.messager.progress('close');
				}, 'text');
			}
		});
		$('#user_roleGrantDialog').dialog('open');
	};
});

</script>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="usermgr_searchform">
			<table>
				<tr>
					<td>用户：<input class="easyui-textbox" name="username" style="width:110px;height:28px;border:false"></td>
					<td>&nbsp;状态：<select class="easyui-combobox" name="status" data-options="panelHeight:'auto',required:true,editable:false" style="width:100px;height:28px;border:false">
						<option value="5">全部</option>
						<option value="0">驳回</option>
						<option value="1">待验证</option>
						<option value="2">待审核</option>
						<option value="3">正常</option>
						<option value="4">注销</option>
						</select>
					</td>
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="background:#eee;" id="addid">
		<table id="datagrid_user" style="background:#eee;width:100%;"></table>
	</div>
</div>
<div id="user_tb" style="background:#f4f4f4;width:100%;float:left">
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="addUserFun()">增加</a>&nbsp;&nbsp;
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="delUserFun()">删除</a>&nbsp;&nbsp;
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="updateUserFun()">修改</a>&nbsp;&nbsp;
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="passwdSet()">密码重置</a>&nbsp;&nbsp;
</div>

<jsp:include page="userMgrAddDialog.jsp"></jsp:include>
<jsp:include page="userMgrUpdateDialog.jsp"></jsp:include>
<jsp:include page="userRoleGrant.jsp"></jsp:include>
<!-- <script type="text/javascript" charset="utf-8">
	setSelect('1','aprovid');
	setTradeSelect('1', 'aoneid');
</script> -->
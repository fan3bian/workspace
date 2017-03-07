<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
	<style type="text/css">
.FieldInput2 {
	width: 30%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
}

.FieldLabel2 {
	width: 20%;
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

#data_table input {
	margin-left: 0px !important
}

#data_table1 input {
	margin-left: 0px !important
}

#data_table3 input {
	margin-left: 0px !important
}
/* #data_table4 input{margin-left:0px !important} */
</style>
	<script type="text/javascript">
var grid;
var connParam;
var connPlattype;
var serveridArray = new Array();
var statusTimeout;

$(document).ready(function() {
	loadDataGrid();
	setTimeout(initServerIdArray,10*1000);
	statusTimeout = setTimeout(checkStatusChange,30*1000);
});

function initServerIdArray(){
	  //首先加载状态为5的serverid到serveridArray中
	   $.ajax({  
       url:'${pageContext.request.contextPath}/lb/lblist.do?flowid=' + '<%=request.getParameter("transferid")%>',
    type:'post',  
    async: false,
    dataType:'json',  
    success:function(data){      	
    	if(data.rows){
              for(var idx = 0 ;idx < data.rows.length; idx ++){
              	  var rowdata = data.rows[idx];
              	  if(rowdata.status == '5'){
              	       if(serveridArray.indexOf(rowdata.lbid)<0){
              	  	   serveridArray.push(rowdata.id);
              	  	   }
              	  }
              }
    	}
    	 
    }  
});
}
function checkStatusChange(){
   var serverIds ;	
   if(serveridArray.length == 0){
     statusTimeout = setTimeout(arguments.callee,30*1000);
      return;
   }
   if(serveridArray.length == 1){
   	   if(serveridArray[0] == ""){
   	   	   statusTimeout = setTimeout(arguments.callee,30*1000);
   	   	    return;
   	   }else{
   	   	  serverIds = serveridArray[0];
   	   }
   }else{
   	      serverIds = serveridArray.join(",");
   }
   
   if(!serverIds){
   	  statusTimeout = setTimeout(arguments.callee,30*1000);
   	   return;
   }
   
//   window.alert("timeInterval:" + serverIds);
   
   $.ajax({  
    url:'${pageContext.request.contextPath}/lb/checklbstatus.do',
    type:'post',  
    async: false,
    data: {param1: serverIds},  
    dataType:'json',  
    success:function(data){      	
    	if(data.success){
    	   //首先清空数组
          serveridArray.length = 0;
           //data.obj是返回的当前未创建成功的Server 
    	  var unExistServerids = data.obj;
    	  if(unExistServerids == ""){
    	  	  //如果没有数据返回，说明全部创建成功	
    	  }else{ 
    	  	  //如果有数据返回，说明还存在没有创建成功的server, 需要更新数组 
    	  	  if(unExistServerids.indexOf(",") >= 0 ){
    	  	     serveridArray = unExistServerids.split(",");
    	  	  }else{
    	  	  	 serveridArray.push(unExistServerids);
    	  	  }
    	  }
    	  
    	  if(serverIds != unExistServerids){
    	  // 如果请求的数据和返回的数据不一样，说明已经有server创建成功了，需要重新加载表格里的数据
    	   $('#lblist_grid').datagrid('load',{});
    	  
    	  }
    	}
    	 
     statusTimeout =  setTimeout(checkStatusChange,30*1000);
    }  
});
}

//查询结果
function loadDataGrid(){
	grid = $('#lblist_grid').datagrid({
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		toolbar:[],    
	    url:'${pageContext.request.contextPath}/lb/lblist.do?flowid=' + '<%=request.getParameter("transferid")%>',
	    onLoadSuccess : function(data) {
			var pageopt = $('#lblist_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#lblist_grid').datagrid("getRows").length
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {operation : ''})
				}
			} else {
				$(this).closest('div.datagrid-wrap').find(
						'div.datagrid-pager').show();
			}
		}

							});
		}
		function optionformater(value, row, index) {
			if (null == value || "" == value) {
				return "<a href=\"javascript:void(0);\" onclick=\"createDialog(\'"
						+ row.cpunum
						+ "\', \'"
						+ row.memnum
						+ "\', \'"
						+ row.disknum
						+ "\', \'"
						+ row.detailid
						+ "\', \'"
						+ row.cuserid
						+ "\', \'"
						+ row.networktype
						+ "\', \'"
						+ row.connnum
						+ "\', \'"
						+ row.instatype
						+ "\', \'"
						+ row.regionname
						+ "\', \'"
						+ row.displayname + "\');\">创建</a>";
			} else if ('2' == value) {
				return "<a href=\"javascript:void(0);\" onclick=\"createDialog3(\'"
						+ row.lbid
						+ "\', \'"
						+ row.detailid
						+ "\', \'"
						+ row.cuserid + "\');\">修改</a>";
			} else if ('3' == value) {
				return "<a href=\"javascript:void(0);\" onclick=\"createDialog2(\'"
						+ row.lbid + "\', \'" + row.detailid + "\');\">销毁</a>";
			} else if ('4' == value) {
				return "<a href=\"javascript:void(0);\" onclick=\"createDialog1(\'"
						+ row.lbid
						+ "\', \'"
						+ row.detailid
						+ "\');\">网络配置</a>";
			} else if ('5' == value) {
				return "请稍候";
			} else if ('-1' == value) {
				return "<a href=\"javascript:void(0);\" onclick=\"createDialog(\'"
						+ row.cpunum
						+ "\', \'"
						+ row.memnum
						+ "\', \'"
						+ row.disknum
						+ "\', \'"
						+ row.detailid
						+ "\', \'"
						+ row.cuserid
						+ "\', \'"
						+ row.networktype
						+ "\', \'"
						+ row.connnum
						+ "\', \'"
						+ row.instatype
						+ "\', \'"
						+ row.regionname
						+ "\', \'"
						+ row.displayname + "\');\">创建失败</a>";
			} else if ('-2' == value) {
				return "<a href=\"javascript:void(0);\" onclick=\"startDialog(\'"
						+ row.lbid + "\');\">启动失败</a>";
			} else if ('1' == value) {
				return "创建完成";
			} else if ('0' == value) {
				return "销毁完成";
			}
		}
		function startDialog(serverid) {
			jQuery.ajax({
				url : "${pageContext.request.contextPath}/vm/operate.do",
				data : {
					'type' : 'start',
					'neid' : serverid,
					'nename' : serverid
				},
				type : "post",
				cache : false,
				dataType : "json",
				success : function() {
					$.messager.alert('提示', '启动请求已发送，请稍候。。。。。。', 'info');
				}
			});

		}
		function createDialog3(serverid, detailid, serveruserid) {
			$('#vmCreateForm3').form('clear');
			jQuery
					.ajax({
						url : "${pageContext.request.contextPath}/jsonvm/getVmChanges.do",
						data : {
							'serverid' : serverid
						},
						type : "post",
						cache : false,
						dataType : "json",
						success : function(result) {

							var change = result.change;
							var current = result.current;
							if (change.cpunum != current.cpunum) {
								document.getElementById("cpu_tr").style.display = "";
								$('#change_cpu').textbox('setValue',
										change.cpunum);
								$('#current_cpu').textbox('setValue',
										current.cpunum);
							}
							if (change.memnum != current.memnum) {
								document.getElementById("mem_tr").style.display = "";
								$('#change_mem').textbox('setValue',
										change.memnum);
								$('#current_mem').textbox('setValue',
										current.memnum);
							}
							if (change.disknum != current.disknum) {
								document.getElementById("disk_tr").style.display = "";
								$('#change_disk').textbox('setValue',
										change.disknum).textbox('setText',
										change.disknum);
								$('#current_disk').textbox('setValue',
										current.disknum).textbox('setText',
										current.disknum);
							}
							if (change.interbw != current.interbw) {
								document.getElementById("interbw_tr").style.display = "";
								$('#change_interbw').textbox('setValue',
										change.interbw);
								$('#current_interbw').textbox('setValue',
										current.interbw);
							}
							if (change.interport != current.interport) {
								document.getElementById("interport_tr").style.display = "";
								$('#change_interport').textbox('setValue',
										change.interport);
								$('#current_interport').textbox('setValue',
										current.interport);
							}
							if (change.imode != current.imode) {
								document.getElementById("imode_utr").style.display = "";
								document.getElementById("imode_mtr").style.display = "";
								document.getElementById("imode_ttr").style.display = "";
							}

							$('#serverid3_').val(serverid);
							$('#detailid3_').val(detailid);
							$('#w3').window('open');
						}
					});

		}
		function createDialog2(lbid, detailid) {
			$.messager.confirm('确认', '请确认该负载均衡需要销毁吗？？', function(r) {
				if (r) {
					$.ajax({
						type : "post",
						async : false, // 同步请求
						data : {
							lbid : lbid,
							flowid : $('#flowid').val(),
							detailid : detailid
						},
						url : '${pageContext.request.contextPath}/lb/delLb.do',
						dataType : "json",
						success : function(data) {

							if (data.success) {
								$.messager.alert('提示', data.msg, 'info');
							} else {
								$.messager.alert('提示', data.msg, 'error');
							}
							$('#lblist_grid').datagrid('reload');
						},
						error : function() {
						}
					});
				}
				;
			});
		}
		function createDialog1(serverid, detailid) {
			$('#vmCreateForm1').form('clear');
			jQuery.ajax({
						url : "${pageContext.request.contextPath}/lb/getLbIntraip.do",
						data : {
							'serverid' : serverid
						},
						type : "post",
						cache : false,
						dataType : "json",
						success : function(result) {
							$("#mannetwork_").textbox('setValue',result.obj["mannetwork"]).textbox('setText', result.obj["mannetwork"]);
							$("#manip").textbox('setValue', result.obj["manip"]).textbox('setText', result.obj["manip"]);
							$("#funnetwork_").textbox('setValue',result.obj["funnetwork"]).textbox('setText', result.obj["funnetwork"]);
							$("#funip").textbox('setValue', result.obj["funip"]).textbox('setText', result.obj["funip"]);
							$('#serverid1_').val(serverid);
							$('#detailid1_').val(detailid);
							$('#w1').window('open');
						}
					});
		}
		function createDialog(cpunum, memnum, disknum, detailid, serveruserid,
				networktype, connnum, instatype, regionname , displayname) {
			$('#vmCreateForm').form('clear');
			$('#cpunum').textbox('setValue', cpunum).textbox('setText', cpunum);
			$('#memnum').textbox('setValue', memnum).textbox('setText', memnum);
			$('#displayname').textbox('setValue', displayname);
			$('#disknum').textbox('setValue', '0,0,0,0').textbox('setText',
					'0,0,0,0');
			$('#detailid_').val(detailid);
			$('#serveruserid_').val(serveruserid);
			$('#networktype_').val(networktype);
			$('#connnum_').val(connnum);
			$('#instatype_').val(instatype);
			$('#regionname_').val(regionname);
			platformCombobox();
			$('#w').window('open');
		}
		//虚拟平台下拉框
		function platformCombobox() {
			var serveruserid = $('#serveruserid_').val();
			$('#platform').combobox({
								url : '${pageContext.request.contextPath}/vm/getRmcVmPlatformVos.do?serveruserid='
										+ serveruserid,
								valueField : 'value',
								textField : 'platformname',
								onSelect : function(rec) {
									$.blockUI({
										message : "<h2>请求已发送,请稍后......</h2>",
										css : {
											zIndex : '10001',
											color : '#fff',
											border : '3px solid #aaa',
											backgroundColor : '#CCCCCC'
										},
										overlayCSS : {
											opacity : '0.0'
										}
									});

									connParam = rec.value;
									connPlattype = rec.plattype;
									$('#platform_').val(rec.platformid);
									datacenterCombobox(rec.value, rec.plattype);

									if ('vmware' == rec.plattype) {
										var as = document.getElementsByName('vmdis');
										for ( var i = 0; i < as.length; i++) {
											as[i].style.display = '';
										}
										$('#clusterField').children().remove();
										$('#hostField').children().remove();
										$('#storageField').children().remove();

										$('#clusterField')
												.append(
														"<input id=\"cluster\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
										$('#hostField')
												.append(
														"<input id=\"host\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
										$('#storageField')
												.append(
														"<input id=\"storage\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:true,editable:false,panelHeight:'auto'\"/>");
									} else if ('cloudstack' == rec.plattype) {
										var as = document
												.getElementsByName('vmdis');
										for ( var i = 0; i < as.length; i++) {
											as[i].style.display = 'none';
										}
										$('#clusterField').children().remove();
										$('#hostField').children().remove();
										$('#storageField').children().remove();

										$('#clusterField')
												.append(
														"<input id=\"cluster\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
										$('#hostField')
												.append(
														"<input id=\"host\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
										$('#storageField')
												.append(
														"<input id=\"storage\" class=\"easyui-combobox\" style=\"height:30px;\" data-options=\"required:false,editable:false,panelHeight:'auto'\"/>");
									}

									$.parser.parse($('#clusterField'));
									$.parser.parse($('#hostField'));
									$.parser.parse($('#storageField'));
								}
							});
		}
		//数据中心下拉框
		function datacenterCombobox(data, plattype) {
			var serveruserid = $('#serveruserid_').val();
			var platformid = $('#platform_').val();
			$('#datacenter').combobox({
				url : '${pageContext.request.contextPath}/vm/getdatacenter.do',
				valueField : 'id',
				textField : 'id',
				onBeforeLoad : function(param) {
					param.data = data;
					param.plattype = plattype;
					param.serveruserid = serveruserid;
					param.platformid = platformid;
				},
				onLoadSuccess : function() {
					$.unblockUI();
				},
				onSelect : function(rec) {
					templateCombobox(rec.id);

					if ('cloudstack' == plattype) {
						networkCombobox(rec.id);
					} else if ('vmware' == plattype) {
						clusterCombobox(rec.id);
					}
				}
			});
		}
		//集群下拉框
		function clusterCombobox(data) {
			var serveruserid = $('#serveruserid_').val();
			var platformid = $('#platform_').val();
			$('#cluster').combobox({
				url : '${pageContext.request.contextPath}/vm/getcluster.do',
				valueField : 'id',
				textField : 'id',
				onBeforeLoad : function(param) {
					param.datacenter = data;
					param.connParam = connParam;
					param.plattype = connPlattype;
					param.serveruserid = serveruserid;
					param.platformid = platformid;
				},
				onSelect : function(rec) {
					hostCombobox(rec.id);
				}
			});
		}
		//模板下拉框
		function templateCombobox(data) {
			debugger;
			var serveruserid = $('#serveruserid_').val();
			var platformid = $('#platform_').val();
			$('#template').combobox({
				url : '${pageContext.request.contextPath}/vm/gettemplate.do',
				valueField : 'id',
				textField : 'id',
				onBeforeLoad : function(param) {
					param.datacenter = data;
					param.connParam = connParam;
					param.plattype = connPlattype;
					param.serveruserid = serveruserid;
					param.platformid = platformid;
				},
				onSelect : function(rec) {
					nicCombobox(rec.id);
				}
			});
		}
		//宿主机下拉框
		function hostCombobox(data) {
			var serveruserid = $('#serveruserid_').val();
			var platformid = $('#platform_').val();
			$('#host').combobox({
				url : '${pageContext.request.contextPath}/vm/gethost.do',
				valueField : 'id',
				textField : 'id',
				onBeforeLoad : function(param) {
					param.cluster = data;
					param.datacenter = $('#datacenter').combobox('getValue');
					param.connParam = connParam;
					param.plattype = connPlattype;
					param.serveruserid = serveruserid;
					param.platformid = platformid;
				},
				onSelect : function(rec) {
					storageCombobox(rec.id);
					networkCombobox(rec.id);
				}
			});
		}
		//存储下拉框
		function storageCombobox(data) {
			var serveruserid = $('#serveruserid_').val();
			var platformid = $('#platform_').val();
			$('#storage').combobox({
				url : '${pageContext.request.contextPath}/vm/getstorage.do',
				valueField : 'id',
				textField : 'id',
				onBeforeLoad : function(param) {
					param.host = data;
					param.connParam = connParam;
					param.plattype = connPlattype;
					param.serveruserid = serveruserid;
					param.platformid = platformid;
				}
			});
		}
		//网络下拉框
		function networkCombobox(data) {
			var serveruserid = $('#serveruserid_').val();
			var platformid = $('#platform_').val();
			$.ajax({
				type : "post",
				async : false,
				dataType : "json",
				url :"${pageContext.request.contextPath}/vm/getnetwork.do",
				data : {
					'host' : data,
					'connParam' :connParam,
					'plattype':connPlattype,
					'serveruserid':serveruserid,
					'platformid':platformid
				},
				success : function(data) {
					$('#mannetwork').combobox({
						data:data,
						valueField : 'id',
						textField : 'id',
						onSelect : function(rec) {
						}
					});
					$('#funnetwork').combobox({
						data:data,
						valueField : 'id',
						textField : 'id',
						onSelect : function(rec) {
						}
					});
				}
			});
		}
		function nicCombobox(data) {
			var serveruserid = $('#serveruserid_').val();
			var platformid = $('#platform_').val();
			$.ajax({
				type : "post",
				async : false,
				dataType : "json",
				url :"${pageContext.request.contextPath}/vm/getNicDevicesName.do",
				data : {
					'template' : data,
					'connParam' :connParam,
					'plattype':connPlattype,
					'serveruserid':serveruserid,
					'platformid':platformid
				},
				success : function(data) {
					$('#mannic').combobox({
						data:data,
						valueField : 'nic',
						textField : 'nic',
						onSelect : function(rec) {
						}
					});
					$('#funnic').combobox({
						data:data,
						valueField : 'nic',
						textField : 'nic',
						onSelect : function(rec) {
						}
					});
				}
			});
		}
		//提交按钮
		function ok() {
			var mannic = $("#mannic").combobox('getValue');
			var funnic = $("#funnic").combobox('getValue');
			var mannetwork = $("#mannetwork").combobox('getValue');
			var funnetwork = $("#funnetwork").combobox('getValue');
			if(funnic==mannic){
				$.messager.alert("提示", "请选择不同的网络适配器","info");
				return ;
			}
			if(mannetwork==funnetwork){
				$.messager.alert("提示", "请选择不同的网络", "info");
				return ;
			}
			if ($('#vmCreateForm').form('validate')) {
						$('#vmCreateForm').form('submit',{
									url : '${pageContext.request.contextPath}/lb/saveLbFirst.do',
									onSubmit : function(param) {
										param.datacenter = $('#datacenter')
												.combobox('getValue');
										param.cluster = $('#cluster').combobox(
												'getValue');
										param.host = $('#host').combobox(
												'getValue');
										param.storage = $('#storage').combobox(
												'getValue');
										param.mannetwork = mannetwork;
										param.funnetwork = funnetwork;
										param.mannic = mannic;
										param.funnic = funnic;
										param.template = $('#template')
												.combobox('getValue');
										param.cpunum = $('#cpunum').textbox(
												'getValue');
										param.memnum = $('#memnum').textbox(
												'getValue');
										//param.disknum = $('#disknum').textbox('getValue');
										param.displayname = $('#displayname')
												.textbox('getValue');
										param.description = $('#description')
												.textbox('getValue');
										param.flowid = $('#flowid').val();
										param.detailid = $('#detailid_').val();
										param.platform = $('#platform_').val();
										param.connparam = connParam;
										param.connplattype = connPlattype;
										param.serveruserid = $('#serveruserid_')
												.val();
										param.instatype = $('#instatype_')
												.val();
										param.regionname = $('#regionname_')
												.val();
										param.networktype = $('#networktype_')
												.val();
										param.connnum = $('#connnum_').val();
									},
									success : function(retr) {
										var _data = $.parseJSON(retr);
										if (_data.success) {
											$.messager.alert('提示', _data.msg,'info');
											serveridArray.push(_data.obj);
											/* $("#mannic1_").val(mannic);
											$("#funnic1_").val(funnic); */
											//$("#mannetwork1_").val(mannetwork);
											//$("#funnetwork1_").val(funnetwork);
										} else {
											$.messager.alert('提示', _data.msg,
													'error');
										}
										$('#w').window('close');
										$('#lblist_grid').datagrid('reload');
										
									}
								});
			}
		}
		//网络配置提交按钮
		function ok1() {
			if ($('#vmCreateForm1').form('validate')) {
				$('#vmCreateForm1').form('submit',{
					url : '${pageContext.request.contextPath}/lb/saveLbSecond.do',
					onSubmit : function(param) {
						debugger;
						param.manip = $('#manip').textbox('getValue');
						param.mannetwork = $('#mannetwork_').textbox('getValue');
						param.funip = $('#funip').textbox('getValue');
						param.funnetwork = $('#funnetwork_').textbox('getValue');
						param.serverid = $('#serverid1_').val();
						param.flowid = $('#flowid').val();
						param.detailid = $('#detailid1_').val();
					},
					success : function(retr) {
						var _data = $.parseJSON(retr);
						if (_data.success) {
							$.messager.alert('提示', _data.msg,'info');
						} else {
							$.messager.alert('提示', _data.msg,'error');
						}
						$('#w1').window('close');
						$('#lblist_grid').datagrid('reload');
					}
				});
			}
		}

		//提交按钮
		function ok4() {
			var returnparam = false;
			jQuery.ajax({
						url : "${pageContext.request.contextPath}/lb/confirmflow.do",
						data : {
							'flowid' : $('#flowid').val(),
							'stepno' : $('#stepno').val(),
						},
						type : "post",
						cache : false,
						dataType : "json",
						beforeSend : function() {
							//20150902guoqiaozhi
							//根据资源创建情况展示工单提交按钮
							$.ajax({url : '${pageContext.request.contextPath}/lb/lblist.do?flowid='	+ '<%=request.getParameter("transferid")%>',
						type:'post',  
						async: false,
						dataType:'json',  
						success:function(data){   
					  		if(data.rows){
					  			var flag = data.rows.length;
					            for(var idx = 0 ;idx < data.rows.length; idx ++){
					            	  var rowdata = data.rows[idx];
					            	  if(rowdata.status == '1' || rowdata.status == '0'){
					            		  flag --;
					            	  }
					            }
					            
					            if(flag == 0){
					            	returnparam = true;
						    	}else{
						    		//资源没有处理完成,不能提交工单
						    		returnparam = false;
						    		$.messager.alert('提示', '资源未处理完成，请稍候提交工单！', 'info');
						    	}
					            
					  		}
					  	}  
					});	
					
					return returnparam;
				},
				success : function(retr) {
					if (retr.success) {
						$.messager.alert('提示', retr.msg, 'info');
					} else {
						$.messager.alert('提示', retr.msg, 'error');
					}
					$('#dd').dialog('close');
				}
			});
		}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<input type="hidden" id="flowid" name="flowid"
			value="<%=request.getParameter("transferid")%>" /> 
		<input type="hidden" id="stepno" name="stepno"
			value="<%=request.getParameter("stepno")%>" />
		<div data-options="region:'center',border:false">
			<table title="" style="width:100%;" id="lblist_grid">
				<thead>
					<tr>
						<th
							data-options="field:'lbid',width:30,align:'center',hidden:'true'">序号</th>
						<th
							data-options="field:'displayname',width:30,align:'center',hidden:'true'"></th>
						<th data-options="field:'detailid',width:30,align:'center'">序号</th>
						<th data-options="field:'cpunum',width:40,align:'center'">CPU(核)</th>
						<th data-options="field:'memnum',width:40,align:'center'">内存(G)</th>
						<th data-options="field:'disknum',width:90,align:'center'">系统盘(G)</th>
						<th data-options="field:'osname',width:100,align:'center'">操作系统</th>
						<th data-options="field:'instatype',width:60,align:'center',hidden:'true'">实例类型</th>
						<th data-options="field:'regionname',width:60,align:'center'">区域</th>
						<th data-options="field:'connnum',width:110,align:'center',hidden:'true'">最大连接数</th>
						<th
							data-options="field:'status',width:60,align:'center',formatter:optionformater">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'south',border:false"
			style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
				href="javascript:void(0)" onclick="ok4();" style="width:80px;">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				href="javascript:void(0)" onclick="$('#dd').dialog('close');"
				style="width:80px">取消</a>
		</div>
	</div>
	<div id="w1" class="easyui-window" title="负载均衡网络配置"
		data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',inline:true"
		style="width:900px;height:400px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center'" style="padding:10px;">
				<form id="vmCreateForm1" method="post">
					<input type="hidden" id="serverid1_" />
					<input type="hidden" id="detailid1_" />
					<table id="data_table1"  style="width:100%">
						<tr>
							<td class="FieldLabel2" style="width:15%;">管理网络：</td>
							<td class="FieldInput2" style="width:25%;"><input id="mannetwork_"
								class="easyui-textbox" data-options="height:30,prompt:'管理网络'" readonly/></td>
							<td class="FieldLabel2" style="width:15%;">管理IP：</td>
							<td class="FieldInput2" style="width:25%;"><input id="manip"
								class="easyui-textbox" data-options="height:30,prompt:'管理IP'" readonly/></td>
						</tr>
						<tr>
							<td class="FieldLabel2" style="width:15%;">业务网络：</td>
							<td class="FieldInput2" style="width:25%;"><input id="funnetwork_"
								class="easyui-textbox" data-options="height:30,prompt:'业务网络'" readonly/></td>
							<td class="FieldLabel2" style="width:15%;">业务IP：</td>
							<td class="FieldInput2" style="width:25%;"><input id="funip"
								class="easyui-textbox" data-options="height:30,prompt:'业务IP'" readonly/></td>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
					href="javascript:void(0)" onclick="ok1();" style="width:80px">提交</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					href="javascript:void(0)" onclick="$('#w1').window('close');"
					style="width:80px">取消</a>
			</div>
		</div>
	</div>
	<div id="w" class="easyui-window" title="创建负载均衡"
		data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',inline:true"
		style="width:900px;height:400px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center'" style="padding:10px;">
				<form id="vmCreateForm" method="post" data-options="novalidate:true">
					<input type="hidden" id="instatype_" /><input type="hidden"
						id="regionname_" /> <input type="hidden" id="networktype_" /> <input
						type="hidden" id="connnum_" /> <input type="hidden"
						id="platform_" /> <input type="hidden" id="detailid_" /> <input
						type="hidden" id="serveruserid_" />
					<table id="data_table" style="width:100%">
						<tr>
							<td class="FieldLabel2">虚拟平台：</td>
							<td class="FieldInput2"><input id="platform"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
							<td class="FieldLabel2">数据中心：</td>
							<td class="FieldInput2"><input id="datacenter"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
						</tr>
						<tr name="vmdis">
							<td class="FieldLabel2" style="">集&emsp;&emsp;群：</td>
							<td class="FieldInput2" id="clusterField"><input
								id="cluster" class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
							<td class="FieldLabel2">宿主机：</td>
							<td class="FieldInput2" id="hostField"><input id="host"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
						</tr>
						<tr>
							<td class="FieldLabel2" name="vmdis">存&emsp;&emsp;储：</td>
							<td class="FieldInput2" name="vmdis" id="storageField"><input
								id="storage" class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
							<td class="FieldLabel2">模&emsp;&emsp;板：</td>
							<td class="FieldInput2"><input id="template"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
						</tr>
						<tr>
							<td class="FieldLabel2">管理网卡：</td>
							<td class="FieldInput2"><input id="mannic"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
							<td class="FieldLabel2">管理网络：</td>
							<td class="FieldInput2"><input id="mannetwork"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
						</tr>
						<tr>
							<td class="FieldLabel2">业务网卡：</td>
							<td class="FieldInput2"><input id="funnic"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
							<td class="FieldLabel2">业务网络：</td>
							<td class="FieldInput2"><input id="funnetwork"
								class="easyui-combobox" style="height:30px;"
								data-options="required:true,editable:false,panelHeight:'auto'" /></td>
						</tr>
						<tr>
							<td class="FieldLabel2">CPU：</td>
							<td class="FieldInput2"><input id="cpunum"
								class="easyui-textbox" style="height:30px;"
								data-options="editable:false" /></td>
							<td class="FieldLabel2">内存：</td>
							<td class="FieldInput2"><input id="memnum"
								class="easyui-textbox" style="height:30px"
								data-options="editable:false" /></td>
						</tr>
						<tr>
							<td class="FieldLabel2">实例名称：</td>
							<td class="FieldInput2"><input id="displayname"
								class="easyui-textbox" style="height:30px;"
								data-options="required:true" /></td>
							<td class="FieldLabel2">实例描述：</td>
							<td class="FieldInput2"><input id="description"
								style="height:53px;" class="easyui-textbox"
								data-options="multiline:true" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
					href="javascript:void(0)" onclick="ok();" style="width:80px">提交</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					href="javascript:void(0)" onclick="$('#w').window('close');"
					style="width:80px">取消</a>
			</div>
		</div>
	</div>
</body>

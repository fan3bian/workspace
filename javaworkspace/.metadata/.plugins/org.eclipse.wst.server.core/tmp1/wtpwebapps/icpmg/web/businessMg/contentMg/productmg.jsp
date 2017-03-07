<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
<style type="text/css">
.customer-product-close {
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
	
	var flagck = 0;	
	
				var codiv= "<div class=\"panel\" style=\"float:left;width:390px;margin:5px 5px 5px 5px;\">                                                                             "
		+"<input name=\"haveimage\" type=\"hidden\" value=\"0\"     /> "                                                                                                    
	+"		<div class=\"panel-header\" style=\"width:378px;\">                                                                                                              "
	+"			<div class=\"panel-title\"></div>                                                                                                                              "
	+"			<div class=\"panel-tool\"><a class=\"panel-tool-close\" href=\"javascript:void(0)\" onclick=\"closeContentSubPanel(this)\"></a></div>                                 "
	+"			</div>                                                                                                                                                         "
	+"			<div name=\"fsub\" class=\"panel-body\" title=\"\" style=\"width: 388px; height: 230px; background: rgb(250, 250, 250);\" data-options=\"closable:true\">      "
 	+"            			<table align=\"center\" style=\"width:100%\">                                                                                                      "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\" style=\"border-top:!important;\">                                                                                            "
	+"								内容标题：</td>                                                                                                                                      "
	+"							<td class=\"FieldInput2\"><input                                                                                                     "                  
	+"								style=\"height:25px\" name=\"coname\" class=\"easyui-validatebox\"                                                                                   "
	+"								data-options=\"required:true\" /><font color=\"red\">*</font></td>                                                                                   "
	+"						</tr>                                                                                                                                                    "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\" style=\"border-top:!important;\">                                                                                            "
	+"								副标题：</td>                                                                                                                                        "
	+"							<td class=\"FieldInput2\"><input                                                                                                            "           
	+"								style=\"height:25px\" name=\"cotip\" class=\"easyui-validatebox\"                                                                                 "   
	+"								data-options=\"required:true\" /</td>                                                                                   "                             
	+"						</tr>                                                                                                                                                    "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\" style=\"border-top:!important;\">                                                                                            "
	+"								内容类型：</td> <td class=\"FieldInput2\">                                                                                                                                   "
	+"							<select class=\"easyui-combobox\" name=\"cotype\" style=\"border-top:!important;\">                                                                  "              
	+"														<option value=\"1\">文字描述</option>                                                                                                                                                                 "   
	+"														<option value=\"2\">超链接</option>  </td>                                                                                                                                      "                            											                                                                                                                                                                                                          
	+" </select>"
	+"</tr><tr> "                                                                                                                                               
	+"							<td class=\"FieldLabel2\">图片/文件：</td>                                                                                                              "
	+"							<td class=\"FieldInput2\"><input  id=\"\" name =\"coimagefile\" type=\"file\"                                                                "          
	+"								style=\"height:25px\"                                                                                                                                "
	+"								name=\"imagefile\" /></td>                                                                                                              "
	+"						</tr>                                                                                                                                                    "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\">图片文件路径：</td>                                                                                                          "
	+"							<td class=\"FieldInput2\"><input  style=\"height:25px\" name=\"coimage\" readonly/></td>                                                 "              
	+"						</tr>                                                                                                                                                    "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\" style=\"border-top:!important;\">                                                                                            "
	+"								内容描述：</td>                                                                                                                                      "
	+"							<td class=\"FieldInput2\"><input                                                                                                 "                      
	+"								style=\"height:60px;width: 260px\" name=\"codiscription\"                                                                                            "
	+"								class=\"easyui-textbox\"                                                                                                          "
	+"								data-options=\"required:true,multiline:true\" />                                                                                              "
	+"								</td>                                                                                                                          "
	+"						</tr>                                                                                                                                                    "
	+"					</table>"                                                                                                                                                   
  	+"         		 </div>"                                                                                                                                                
	+"		</div>";                                                                                                                                                          
		var fediv= "<div class=\"panel\" style=\"float:left;width:390px;margin:5px 5px 5px 5px;\">                                                                             "
		+"<input name=\"ishaveimage\" type=\"hidden\" value=\"0\"     /> "
	+"		<div class=\"panel-header\" style=\"width:378px;\">                                                                                                              "
	+"			<div class=\"panel-title\"></div>                                                                                                                              "
	+"			<div class=\"panel-tool\"><a class=\"panel-tool-close\" href=\"javascript:void(0)\" onclick=\"closeSubPanel(this)\"></a></div>                                 "
	+"			</div>                                                                                                                                                         "
	+"			<div name=\"fsub\" class=\"panel-body\" title=\"\" style=\"width: 388px; height: 230px; background: rgb(250, 250, 250);\" data-options=\"closable:true\">      "
 	+"            			<table align=\"center\" style=\"width:100%\">                                                                                                      "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\" style=\"border-top:!important;\">                                                                                            "
	+"								特性标题：</td>                                                                                                                                      "
	+"							<td class=\"FieldInput2\"><input                                                                                                     "
	+"								style=\"height:25px\" name=\"fename\" class=\"easyui-validatebox\"                                                                                   "
	+"								data-options=\"required:true\" /><font color=\"red\">*</font></td>                                                                                   "
	+"						</tr>                                                                                                                                                    "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\" style=\"border-top:!important;\">                                                                                            "
	+"								副标题：</td>                                                                                                                                        "
	+"							<td class=\"FieldInput2\"><input                                                                                                            "
	+"								style=\"height:25px\" name=\"fetip\" class=\"easyui-validatebox\"                                                                                 "
	+"								data-options=\"required:true\" /</td>                                                                                   "
	+"						</tr>                                                                                                                                                    "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\" style=\"border-top:!important;\">                                                                                            "
	+"								副标题链接：</td>                                                                                                                                    "
	+"							<td class=\"FieldInput2\"><input                                                                                                         "
	+"								style=\"height:25px\" name=\"feturl\" class=\"easyui-validatebox\"                                                                                "
	+"								data-options=\"required:true\" /></td>                                                                                   "
	+"						</tr>"
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\">背景图片：</td>                                                                                                              "
	+"							<td class=\"FieldInput2\"><input  id=\"\" name =\"feimagefile\" type=\"file\"                                                                "
	+"								style=\"height:25px\"                                                                                                                                "
	+"								name=\"imagefile\" /><font                                                                                                                           "
	+"								color=\"red\">选择一张图片*</font></td>                                                                                                              "
	+"						</tr>                                                                                                                                                    "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\">背景图片路径：</td>                                                                                                          "
	+"							<td class=\"FieldInput2\"><input  style=\"height:25px\" name=\"feimage\" readonly/></td>                                                 "
	+"						</tr>                                                                                                                                                    "
	+"						<tr>                                                                                                                                                     "
	+"							<td class=\"FieldLabel2\" style=\"border-top:!important;\">                                                                                            "
	+"								特性描述：</td>                                                                                                                                      "
	+"							<td class=\"FieldInput2\"><input                                                                                                 "
	+"								style=\"height:60px;width: 260px\" name=\"fediscription\"                                                                                            "
	+"								class=\"easyui-validatebox easyui-textbox\"                                                                                                          "
	+"								data-options=\"required:true,multiline:true\" /><font                                                                                                "
	+"								color=\"red\">*</font></td>                                                                                                                          "
	+"						</tr>                                                                                                                                                    "
	+"					</table>"
  	+"         		 </div>"
	+"		</div>";
		var toolbar = [
				{
					text : '增加',
					iconCls : 'icon-add',
					handler : function() {
						$("#pname").val('');
						$("#pid").val('');
						$("#productimg").val('');
						$("#discription").textbox('setValue', "");
						//$("#applyurl").val('');
						//$("#configurl").val('');
						//清空文件框
						var file = document.getElementById("imagefile");
						 if (file.outerHTML) {
				             file.outerHTML = file.outerHTML;
				         } else { // FF(包括3.5)
				             file.value = "";
				         }
						$('#window').window('open');
					}
				},
				{
					text : '删除',
					iconCls : 'icon-delete',
					handler : function() {
						var rows = $('#dg').datagrid('getChecked');
						if (rows.length < 1) {
							$.messager.alert('消息', '请至少选择一条记录！');
							return;
						}
						var pids = "";
						$.each(rows, function(index, object) {
							pids += object.pid + ",";
						});
						$.messager
								.confirm(
										'确认',
										'您确认想要删除选中记录吗？',
										function(r) {
											if (r) {
												$
														.ajax({
															type : 'post',
															url : '${pageContext.request.contextPath}/content/delProduct.do',
															data : {
																pids : pids
															},
															success : function(
																	retr) {
																var data = JSON
																		.parse(retr);
																$.messager
																		.alert(
																				'消息',
																				data.msg);
																if (data.success) {
																	$('#dg')
																			.datagrid(
																					'unselectAll');
																	$('#dg')
																			.datagrid(
																					'reload',
																					icp
																							.serializeObject($('#ordercofig_searchform')));

																}
															}
														});
											}
										});
					}
				},
				{
					text : '修改',
					iconCls : 'icon-modify',
					handler : function() {
						var rows = $('#dg').datagrid('getChecked');
						if (rows.length != 1) {
							$.messager.alert('消息', '请选择一条记录！');
							return;
						}
						$('#pno').combobox('select',rows[0].pno);
						$("#pname").val(rows[0].pname);
						$("#pid").val(rows[0].pid);
						$("#productimg").val(rows[0].image);
						$("#discription").textbox('setValue', rows[0].discription);
						//$("#applyurl").val(rows[0].applyurl);
						//$("#configurl").val(rows[0].configurl);
						//清空文件框
						var file = document.getElementById("imagefile");
						 if (file.outerHTML) {
				             file.outerHTML = file.outerHTML;
				         } else { // FF(包括3.5)
				             file.value = "";
				         }
						$('#window').window('open');

					}
				},
				{
					text : '生成HTML',
					iconCls : 'icon-html',
					handler : function() {
						$.messager
								.confirm(
										'确认',
										'您确认想要生成HTML？原来文件将被覆盖',
										function(r) {
											if (r) {
												$
														.ajax({
															type : 'post',
															url : '${pageContext.request.contextPath}/content/toProductHtml.do',
															success : function(
																	retr) {
																var data = JSON
																		.parse(retr);
																$.messager
																		.alert(
																				'消息',
																				data.msg);
																if (data.success) {
																	//$('#dg')
																	//		.datagrid(
																	//				'unselectAll');
																	//$('#dg')
																	//		.datagrid(
																	//				'reload',
																	//				icp
																	//						.serializeObject($('#ordercofig_searchform')));

																}
															}
														});
											}
										});

					}
				},
				{
					text : '生成HTML并预览',
					iconCls : 'icon-html',
					handler : function() {
						$.messager
								.confirm(
										'确认',
										'您确认想要生成HTML？原来文件将被覆盖',
										function(r) {
											if (r) {
												$
														.ajax({
															type : 'post',
															url : '${pageContext.request.contextPath}/content/toProductHtml.do',
															success : function(
																	retr) {
																var data = JSON
																		.parse(retr);
																$.messager
																		.alert('消息', data.msg);
																if (data.success) {
																	window.open('${pageContext.request.contextPath}/'+data.obj , '_blank') ;
																}
															}
														});
											}
										});

					}
				}  ];
		$(document).ready(function() {

			loadDataGrid();

		});
		function loadDataGrid() {
			$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'pid',
								sortOrder : 'asc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/content/productList.do',
								onLoadSuccess: function (data) {
				      var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#dg').datagrid("getRows").length;
				       var total = pageopt.total; //显示的查询的总数
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {config:''});
				         }
				          $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
									    		total: total,
									    	});
				         
				         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
				      }else{
				         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
				         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				      }
				      
				        var rows = data.rows;
									      if (rows.length) {
												 $.each(rows, function (idx, val) {
													if   (val.config==''&&val.config!='0'){  
														$('#proid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
				      
				      
				 },
				 
				 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.config==''&&rowData.config!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#proid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.config==''&&val.config!='0'){
									$("#dg").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
				 
				 
				 
				 
							});

		}

		function searchDataGrid() {
			$('#dg').datagrid('load',
					icp.serializeObject($('#ordercofig_searchform')));
		};

		function submitSave() {
			if ($('#productform').form('validate')) {
				$('#saveBtn').linkbutton('disable');
				$('#productform')
						.form(
								'submit',
								{
									url : '${pageContext.request.contextPath}/content/saveOrUpdteProduct.do',
									onSubmit : function() {
										//alert($("productimg").val());
									},
									success : function(retr) {
										//$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
										var _data = JSON.parse(retr);
										//alert("success: "+_data.success);
										$.messager.alert('消息', _data.msg);
										if (_data.success) {
											$('#dg')
													.datagrid(
															'reload',
															icp
																	.serializeObject($('#ordercofig_searchform')));
											$('#window').window('close');
										}
										$('#saveBtn').linkbutton('enable');
									}
								});
			}
		}

		function configformater(value, row, index) {
		    if(row.pid){	
			var str = '';
			str += '<a style="color:green;cursor:pointer" onclick="featureopen('
					+ row.pid + ');">特点</a>|';
			str += '<a style="color:green;cursor:pointer" onclick="contentopen('
					+ row.pid + ');">内容</a>';
			return str;
			}
		}
		function featureopen(pid) {
			$.ajax({  
			    url: '${pageContext.request.contextPath}/content/productFList.do',   
			    type:'post',  
			    async: false,  
			    dataType:'json',  
			    data:{"productid":pid,"sort":"position","order":"asc","rows":"10"},
			    success:function(data){
			    	$("#feproductid").val(pid);
			        showFeature(data);
			    }  
			});
	/*		$('#dg')
					.datagrid(
							{
								rownumbers : false,
								border : false,
								striped : true,
								scrollbarSize : 0,
								sortName : 'pid',
								sortOrder : 'asc',
								singleSelect : false,
								method : 'post',
								loadMsg : '数据装载中......',
								fitColumns : true,
								idField : 'pid',
								pagination : true,
								pageSize : 10,
								pageList : [ 5, 10, 20, 30, 40, 50 ],
								toolbar : toolbar,
								url : '${pageContext.request.contextPath}/content/productList.do',
								queryParams:{
										productid: 'easyui',
										subject: 'datagrid'
									}
								
							});
							*/
		}
		function showFeature(data)
		{
			$("#fehome").html('');
			for(var i=0;i<data.total;i++)
			{
				$("#fehome").append(fediv);
			}
			for(var j=0;j<data.total;j++)
			{
				$("#fehome input[name='feimagefile']")[j].id=("feimagefile"+(j+1));
				if(data.rows[j].ftip)
				{
					$("#fehome input[name='fetip']")[j].value=data.rows[j].ftip;
				}
				if(data.rows[j].fturl)
				{
					$("#fehome input[name='feturl']")[j].value=data.rows[j].fturl;
				}
				$("#fehome input[name='fename']")[j].value=data.rows[j].name;
			//	$("#fehome input[name='fetip']")[j].value=data.rows[j].ftip;
			//	$("#fehome input[name='feturl']")[j].value=data.rows[j].fturl;
				$("#fehome input[name='feimage']")[j].value=data.rows[j].image;
				$("#fehome input[name='fediscription']")[j].value=data.rows[j].discription;
			}
			$('#featurewindow').window('open');
		}
		function closeSubPanel(panel)
		{
			
			$(panel).parent().parent().parent().remove();
		}
		function addSubPanel()
		{
			
			$("#fehome").append(fediv);
		}
		function saveFeature()
		{
			//准备提交数据
			//var feature = {"productid":fproductid,"rows":[]};
			//var files = new Array();
			
			 //上传文件-保存数据
		   	/*$.ajaxFileUpload({
			        url:urlrootpath+'/content/saveOrUpdteProductF.do',  
			        secureuri :false,
			        data:{list:jsonToString(feature)},
			        dataType : 'json',
			        fileElementId : files,//file控件id
			        success : function (data){
			        
			        },
			        error: function(data){
			        }
		    });*/
			$('#featureForm')
						.form(
								'submit',
								{
									url :  '${pageContext.request.contextPath}/content/saveOrUpdteProductF.do',  
									onSubmit : function() {
										//alert($("productimg").val());
										for(var i=0;i<$("#fehome input[name='fediscription']").length;i++)
											{
												
												if(!$("#fehome input[name='fename']")[i].value)
												{
													$.messager.alert('消息', "第"+(i+1)+"个：特性标题不能为空！");
													return false;
												}
												if($("#fehome input[name='feimagefile']")[i].value)
												{
													var bizlic = $("#fehome input[name='feimagefile']")[i].value;
													var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
													if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
														$.messager.alert('消息', "第"+(i+1)+"个：请选择一张图片【jpg/jpeg/png/gif】！");
														return false;
													}
													$("#fehome input[name='ishaveimage']")[i].value = "1";
												}
												else 
												{
													$("#fehome input[name='ishaveimage']")[i].value = "0";
												}
												if(!$("#fehome input[name='feimage']")[i].value&&!$("#fehome input[name='feimagefile']")[i].value)
												{
													$.messager.alert('消息', "第"+(i+1)+"个：背景图片不能为空！");
													return false;
												}
												if(!$("#fehome input[name='fediscription']")[i].value)
												{
													$.messager.alert('消息', "第"+(i+1)+"个：特性描述不能为空！");
													return false;
												}
												//files[i] = "feimage"+(i+1); 
												/*feature.rows[i]={"fname":$("#fehome input[name='fename']")[i].value,
															     "ftip":$("#fehome input[name='fetip']")[i].value,
															     "furl":$("#fehome input[name='feturl']")[i].value,
															     "image":(!$("#fehome input[name='feimagefile']")[i].value)?$("#fehome input[name='feimage']")[i].value:"haveImage:"+$("#fehome input[name='feimage']")[i].value,
															     "discription":$("#fehome input[name='fediscription']")[i].value,
															     "position":i+1,
												};*/
											}
										$("#feproductid").val();
									//	$("#dataALL").attr("value" , jsonToString(feature));
									},
									success : function(retr) {
										var _data = JSON.parse(retr);
										//alert("success: "+_data.success);
										if (_data.success) {
											$('#featurewindow').window('close');
										}
										$.messager.alert('消息', _data.msg);
										
									}
								});    
		}
   
		function contentopen(pid) {
			$.ajax({  
			    url: '${pageContext.request.contextPath}/content/productCList.do',   
			    type:'post',  
			    async: false,  
			    dataType:'json',  
			    data:{"productid":pid,"sort":"position","order":"asc","rows":"10"},
			    success:function(data){
			    	$("#coproductid").val(pid);
			        showcontent(data);
			    }  
			});
		}
		function showcontent(data)
		{
			$("#cohome").html('');
			for(var i=0;i<data.total;i++)
			{
				$("#cohome").append(codiv);
			}
			for(var j=0;j<data.total;j++)
			{
				$("#cohome input[name='coimagefile']")[j].id=("coimagefile"+(j+1));
				if(data.rows[j].ftip)
				{
					$("#cohome input[name='cotip']")[j].value=data.rows[j].ftip;
				}
				$("#cohome select[name='cotype']")[j].value=data.rows[j].type;
				$("#cohome input[name='coname']")[j].value=data.rows[j].name;
				if(data.rows[j].image)
				{
					$("#cohome input[name='coimage']")[j].value=data.rows[j].image;
				}
				$("#cohome input[name='codiscription']")[j].value=data.rows[j].discription;
			}
			$('#contentwindow').window('open');
		}
		function saveConent()
		{
			//准备提交数据
			//var feature = {"productid":fproductid,"rows":[]};
			//var files = new Array();
			
			 //上传文件-保存数据
		   	/*$.ajaxFileUpload({
			        url:urlrootpath+'/content/saveOrUpdteProductF.do',  
			        secureuri :false,
			        data:{list:jsonToString(feature)},
			        dataType : 'json',
			        fileElementId : files,//file控件id
			        success : function (data){
			        
			        },
			        error: function(data){
			        }
		    });*/
			$('#contentForm')
						.form(
								'submit',
								{
									url :  '${pageContext.request.contextPath}/content/saveOrUpdteProductC.do',  
									onSubmit : function() {
										//alert($("productimg").val());
										for(var i=0;i<$("#cohome input[name='coname']").length;i++)
											{
												
												if(!$("#cohome input[name='coname']")[i].value)
												{
													$.messager.alert('消息', "第"+(i+1)+"个：内容标题不能为空！");
													return false;
												}
												if($("#cohome input[name='coimagefile']")[i].value)
												{
													if("1"==$("#cohome select[name='cotype']")[i].value){
													var bizlic = $("#cohome input[name='coimagefile']")[i].value;
													var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
													if(!/\.jpg$|\.jpeg$|\.png$|\.gif$/i.test(format)){
														$.messager.alert('消息', "第"+(i+1)+"个：请选择一张图片【jpg/jpeg/png/gif】！");
														return false;
													}
													}
													$("#cohome input[name='haveimage']")[i].value = "1";
												}else 
												{
													$("#cohome input[name='haveimage']")[i].value = "0";
												}
												//if(!$("#cohome input[name='coimage']")[i].value&&!$("#cohome input[name='coimagefile']")[i].value)
												//{
												//	$.messager.alert('消息', "第"+(i+1)+"个：背景图片不能为空！");
												//	return false;
											    //}
												//if(!$("#cohome input[name='codiscription']")[i].value)
												//{
												//	$.messager.alert('消息', "第"+(i+1)+"个：特性描述不能为空！");
												//	return false;
												//}
												//files[i] = "feimage"+(i+1); 
												/*feature.rows[i]={"fname":$("#fehome input[name='fename']")[i].value,
															     "ftip":$("#fehome input[name='fetip']")[i].value,
															     "furl":$("#fehome input[name='feturl']")[i].value,
															     "image":(!$("#fehome input[name='feimagefile']")[i].value)?$("#fehome input[name='feimage']")[i].value:"haveImage:"+$("#fehome input[name='feimage']")[i].value,
															     "discription":$("#fehome input[name='fediscription']")[i].value,
															     "position":i+1,
												};*/
											}
										
										$("#coproductid").val();
									//	$("#dataALL").attr("value" , jsonToString(feature));
									},
									success : function(retr) {
										var _data = JSON.parse(retr);
										//alert("success: "+_data.success);
										if (_data.success) {
											$('#contentwindow').window('close');
										}
										$.messager.alert('消息', _data.msg);
										
									}
								});    
		}
		function addConentSubPanel()
		{
		
			$("#cohome").append(codiv);
		}
		function closeContentSubPanel(panel)
		{
			$(panel).parent().parent().parent().remove();
		}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	
		<div data-options="region:'north',border:false"
			style="background:#eee;height:30px;overflow:hidden;">
			<form id="ordercofig_searchform">
				<table>
					<tr>
						<td>产品名称：<input class="easyui-textbox" name="pname"
							id="searchpname" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);"
							class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"
							onclick="searchDataGrid()">查询</a>&nbsp;&nbsp; <a
							href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo',plain:true"
							onclick="$('#ordercofig_searchform input').val('');$('#searchpname').textbox('clear');$('#dg').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="proid">
			<table title="" style="width:100%;" id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th
							data-options="field:'pid',width:60,align:'center',sortable:true">编码</th>
						<th data-options="field:'ptype',width:60,align:'center'">产品类别</th>
						<th data-options="field:'pno',width:60,align:'center',hidden:true">类别ID</th>
						<th data-options="field:'pname',width:60,halign:'center'">产品名称</th>
						<th data-options="field:'discription',width:250,halign:'center'">产品描述</th>
						<th data-options="field:'image',width:180,halign:'center'">背景图片</th>
						<th data-options="field:'applyurl',width:130,halign:'center',hidden:true">申请URL</th>
						<th data-options="field:'configurl',width:130,halign:'center',hidden:true">配置预览URL</th>
						
						<th data-options="field:'config',width:80,align:'center',formatter:configformater">配置</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="window" class="easyui-window" title="产品配置" data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:500px;height:360px;padding:5px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center',border:false"
					style="padding:10px;">
					<form id="productform" method="post" enctype="multipart/form-data">
						<input id="pid" name="pid" type="hidden" />
						<table align="center" style="width:100%">

							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									产品类别：</td>
								<td class="FieldInput2"><select class="easyui-combobox" id="pno" name="pno" data-options="panelHeight:'auto',editable:false" style="height:25px;width:130px;">
							    <option value="1">计算</option>
							    <option value="2">存储</option>
							    <option value="3">容灾</option>
							    <option value="4">IDC</option>
							    <option value="5">应用</option>
							    <option value="6">数据库</option>
					            </select></td>
					           </tr>
					           <tr>
								<td class="FieldLabel2" style="border-top:!important;">
									产品名称：</td>
								<td class="FieldInput2"><input id="pname"
									style="height:25px" name="pname" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2">背景图片：</td>
								<td class="FieldInput2"><input id="imagefile" type="file"
									style="height:25px;width: 260px !important" 
									name="imagefile" /><font
									color="red">选择一张图片*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel2">背景图片路径：</td>
								<td class="FieldInput2"><input id="productimg" style="height:25px;width: 257px !important" name="productimg" readonly/></td>
							</tr>
							<tr>
								<td class="FieldLabel2" style="border-top:!important;">
									产品描述：</td>
								<td class="FieldInput2"><input id="discription"
									style="height:150px;width: 260px" name="discription"
									class="easyui-validatebox easyui-textbox"
									data-options="multiline:true" /></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="display:none;">
									立即申请URL：</td>
								<td class="FieldInput2" style="display:none;"><input id="applyurl" type="hidden"
									style="height:25px" name="applyurl" value="#" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
							<tr>
								<td class="FieldLabel2" style="display:none;">
									配置浏览URL：</td>
								<td class="FieldInput2" style="display:none;"><input id="configurl" type="hidden"
									style="height:25px" name="configurl" value="#" class="easyui-validatebox"
									data-options="required:true" /><font color="red">*</font></td>

							</tr>
						</table>
					</form>
				</div>
				<div data-options="region:'south',border:false"
					style="text-align:right;padding:5px 0 0;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
						id="saveBtn" href="javascript:void(0)" onclick="submitSave();"
						style="width:80px">确定</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
						onclick="$('#window').window('close');" style="width:80px">取消</a>
				</div>
			</div>
		</div>
	<div id="contentwindow" class="easyui-window" title="产品内容配置"
			data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:860px;height:560px;padding:5px;">
			<div style="display:block;height:30px" >
			<a class="easyui-linkbutton"
						data-options="iconCls:'icon-add'" href="javascript:void(0)"
						onclick="addConentSubPanel();" style="width:80px">增加</a>
			 <a class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" href="javascript:void(0)"
						onclick="saveConent();" style="width:80px">保存</a>
			</div>
			<form id="contentForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="coproductid" name="coproductid" value="">
				<div id="cohome">
					
					
				</div>
			</form>
	</div>
		<div id="featurewindow" class="easyui-window" title="产品特点配置"
			data-options="closed:true,iconCls:'icon-save',inline:true"
			style="width:860px;height:560px;padding:5px;">
			<div style="display:block;height:30px" >
			<a class="easyui-linkbutton"
						data-options="iconCls:'icon-add'" href="javascript:void(0)"
						onclick="addSubPanel();" style="width:80px">增加</a>
			 <a class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" href="javascript:void(0)"
						onclick="saveFeature();" style="width:80px">保存</a>
			</div>
			<form id="featureForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="feproductid" name="feproductid" value="">
				<div id="fehome">
					
					
				</div>
			</form>
		</div>
</body>


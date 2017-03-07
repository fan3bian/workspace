<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>

	<%@ include file="/icp/include/taglib.jsp"%>
	<!-- CSS样式 -->
	<style type="text/css">
.cards {
	text-align: justify;
	text-justify: inter-ideograph;
	padding: 0 15px 15px;
	margin-top: -10px;
	font-size: 0;
}

.cards .card {
	display: inline-block;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	-webkit-box-shadow: 1px 2px 5px rgba(180, 180, 180, .75);
	box-shadow: 1px 2px 5px rgba(180, 180, 180, .75);
	width: 31%;
	height: 100%;
	position: relative;
	margin: 25px 1% 25px 1%;
	overflow: hidden;
	background-color: #fff;
	border: 1px solid #c9ccd0;
	vertical-align: top;
	font-size: 12px;
}

.card:hover {
	color: #97c9e5;
	border: 1px solid rgba(12, 148, 222, .8);
	box-shadow: 0 0 4px rgba(12, 148, 222, .8);
}

.setting-box {
	border-left: 1px solid #ebebeb;
	border-right: 1px solid #ebebeb;
	border-bottom: 1px solid #ebebeb;
	overflow: hidden;
	background-color: #fafafa;
	margin-bottom: 10px;
}

.setting-box-head {
	font-size: 16px;
	padding: 4px 15px 4px;
	background-color: #f5f5f5;
	border-top: 1px solid #ebebeb;
	border-bottom: 1px solid #ebebeb;
}

.setting-box-body {
	width: 86%;
	padding: 10px;
	float: left;
}

.setting-btn {
	min-width: 100px;
	padding: 6px 0;
	margin-top: 10px;
	float: left;
	line-height: 14px;
	margin-left: 50px;
}

.progressBody {
	width: 100%;
	text-align: center;
}

.loading {
	text-align: left;
	width: 300px;
	height: 48px;
	background: #97c9e5;
	text-align: center;
	font-family: Tahoma;
	font-size: 18px;
	line-height: 48px;
}

.chainurl {
	word-break: break-word;
	height: 80px;
}
</style>
<!-- script -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sockjs-0.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/web/obsMgr/js/ZeroClipboard.js"></script>
<script type="text/javascript">
		var ws = null;
		var url = null;
		var transports = [];
		/********** sheet1: 桶空间运用情况展示  START **********/
		//文件存储
		$(function() {
			
			$('#space-card').highcharts({
				chart : {
					type : 'areaspline'
				},
				title : {
					text : '文件存储',
					x : -10
				},
				xAxis : {
				categories : function() {
					var data = [];
					$.ajax({
						type : 'post',
						url : urlrootpath+ '/obsMgr/lstDate.do?daycoun=7&starttime=&endtime=',
						async : false,
						dataType : "json",
						success : function(value) {
							data = value;
						}
					});
					return data;
				}()
				},
				yAxis : {
					title : {
						text : 'MB'
					},
					min : 0,
					minTickInterval : 2,
					plotLines : [ {
						value : 0,
						width : 1,
						color : '#808080'
					} ]
				},
				tooltip : {
					valueSuffix : 'MB'
				},
				series : [ {
					name : '近一周',
					data : function() {
						var data = [];
						$.ajax({
								type : 'post',
								url : urlrootpath
										+ '/obsMgr/lstStatisticsByDay.do?statisticstype=storage&daycoun=7&bucketName=${vo.bucketname}&starttime=&endtime=',
								async : false,
								dataType : "json",
								success : function(value) {
									data = value;
								}
						});
						return data;
					}()
				} ],
				credits : {
					enabled : false
				}
			});
		});

		//流量统计
		$(function() {
			$('#flow-card').highcharts(
							{
								chart : {
									type : 'areaspline'
								},
								title : {
									text : '流量统计',
									x : -10
								},
								xAxis : {
									categories : function() {
										var data = [];
										$.ajax({
											type : 'post',
											url : urlrootpath+ '/obsMgr/lstDate.do?daycoun=7&starttime=&endtime=',
											async : false,
											dataType : "json",
											success : function(value) {
												data = value;
											}
										});
										return data;
									}()
								},
								yAxis : {
									title : {
										text : 'MB'
									},
									min : 0,
									minTickInterval : 0.25,
									plotLines : [ {
										value : 0,
										width : 1,
										color : '#808080'
									} ]
								},
								tooltip : {
									valueSuffix : 'MB'
								},
								series : [ {
									name : '近一周',
									data : function() {
										var data = [];
										$.ajax({
											type : 'post',
											url : urlrootpath
													+ '/obsMgr/lstStatisticsByDay.do?statisticstype=flow&daycoun=7&bucketName=${vo.bucketname}&starttime=&endtime=',
											async : false,
											dataType : "json",
											success : function(value) {
												data = value;
											}
										});
										return data;
									}()
								} ],
								credits : {
									enabled : false
								}
							});
		});

		//上传下载次数
		$(function() {
			$('#getput-card').highcharts(
							{
								chart : {
									type : 'areaspline'
								},
								title : {
									text : '上传下载次数',
									x : -10
								},
								xAxis : {
									categories : function() {
										var data = [];
										$.ajax({
											type : 'post',
											url : urlrootpath
													+ '/obsMgr/lstDate.do?daycoun=7&starttime=&endtime=',
											async : false,
											dataType : "json",
											success : function(value) {
												data = value;
											}
										});
										return data;
									}()
								},
								yAxis : {
									title : {
										text : '次'
									},
									min : 0,
									minTickInterval : 0.25,
									plotLines : [ {
										value : 0,
										width : 1,
										color : '#808080'
									} ]
								},
								tooltip : {
									valueSuffix : '次'
								},
								series : [{
											name : '近一周上传',
											data : function() {
												var data = [];
												$.ajax({
													type : 'post',
													url : urlrootpath
															+ '/obsMgr/lstStatisticsByDay.do?statisticstype=put&daycoun=7&bucketName=${vo.bucketname}&starttime=&endtime=',
													async : false,
													dataType : "json",
													success : function(value) {
														data = value;
													}
												});
												return data;
											}()
										},
										{
											name : '近一周下载',
											data : function() {
												var data = [];
												$.ajax({
													type : 'post',
													url : urlrootpath
															+ '/obsMgr/lstStatisticsByDay.do?statisticstype=get&daycoun=7&bucketName=${vo.bucketname}&starttime=&endtime=',
													async : false,
													dataType : "json",
													success : function(value) {
														data = value;
													}
												});
												return data;
											}()
										} ],
								credits : {
									enabled : false
								}
							});
		});
		/********** sheet1: 桶空间运用情况展示  END **********/

		/********** sheet2: 上传、下载、重命名、删除文件 START **********/

		//listBucketFile
		$(document).ready(function() {
			loadDataGrid();
			updateUrl('${pageContext.request.contextPath}/sockjs/echo');
		//	updateUrl('icpmg/sockjs/echo');

			connect();
			var clip = new ZeroClipboard(document.getElementById("d_clip_button"),{
						moviePath : "${pageContext.request.contextPath}/web/obsMgr/js/ZeroClipboard.swf"
					});
			clip.on('complete', function(client, args) {
				$.messager.show({
					title : '系统消息',
					msg : '成功复制到剪贴板',
					timeout : 1000,
					showType : 'slide',
				});
			});
		});
		function updateUrl(urlPath) {
			if (urlPath.indexOf('sockjs') != -1) {
				url = urlPath;
			} else {
				if (window.location.protocol == 'http:') {
					url = 'ws://' + window.location.host + urlPath;
				} else {
					url = 'wss://' + window.location.host + urlPath;
				}
			}
		}

		//list Bucket File Core
		function loadDataGrid() {
			var fileNameSlice = $("#fileNameSlice").val();
			$('#dg').datagrid({
				//表格格式
				striped : true,//条纹
				scrollbarSize : 0,//滚动条
				rownumbers : false,
				border : false,
				//单元格内格式
				nowarp : false,
				fitColumns : true,
				//选中
				singleSelect : true,
				checkOnSelect : true,
				selectOnCheck : false,
				//分页
				pagination : true,
				pageList : [ 5, 10, 20, 30 ],
				//分类
				sortName : 'updatetime',
				sortOrder : 'desc',
				//数据来源
				url : urlrootpath
						+ '/obsMgr/lstBucketFile.do?bucketName=${vo.bucketname}&fileNameSlice='
						+ fileNameSlice,
				method : 'post',
	
				//等待消息
				loadMsg : '数据装载中......',
				onLoadSuccess : function(data) {
					if(data!=null){
						$("#fileListNum").val(data.total);
					}
					$('.obs_file_download').linkbutton({
						iconCls : 'icon-download',
						plain : true
					});
					$('.obs_file_rename').linkbutton({
						iconCls : 'icon-update',
						plain : true
					});
					$('.obs_file_share').linkbutton({
						iconCls: 'icon-share',
						plain : true
					});
		    		var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;//分页条数
					var  _rows = $('#dg').datagrid("getRows").length;//每页实际条数
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for( var i=10;i>_rows;i--){
							//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
							$(this).datagrid('appendRow', {fileid:''  });
						}
						$('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
							if(val.fileid==''){ 
								//addid为datagrid上一层的div id
								$('#addid input:checkbox').eq(idx+1).css("display","none");
							}
						}); 
			        }
			    },
				 onClickRow: function (rowIndex, rowData) {
					if   (rowData.operation ==''){
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
						if(val.operation ==''){
							//如果是空行，不能被选中
							$("#dg").datagrid('uncheckRow', idx);
							//增加全选复选框被选中
							$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
						}
					});
				} 
		});
	}

		//select file:重置 
		$("#reset").click(function() {
			$("#file_searchform").form("reset");
			loadDataGrid();
		});

		//select file:查询
		$("#search").click(function() {
			loadDataGrid();
		});

		//打开上传对话框
		var progress = 0;
		function uploadFileWindowOpen() {
			//进度条初始化
			$('#uploadForm').form('clear');
			$("#loading").css("width", "0%");
			$("#message").html("");
			progress = 0;//先给一个进度，避免长期在0%等待
			$('#uploadwindow').window('open');
		};

		//进度条
		function SetProgress(progress) {
			$("#loading").css("width", String(progress) + "%"); //控制#loading div宽度 
			$("#message").html(String(progress) + "%"); //显示百分比 
		}

		//接收后台传参
		function connect() {
			
			if (!url) {
				alert('Select whether to use W3C WebSocket or SockJS');
				return;
			}
			ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
				protocols_whitelist : transports
			}) : new WebSocket(url);

			ws.onopen = function() {
				//setConnected(true);
			};

			ws.onmessage = function(event) {
				
				var json = JSON.parse(event.data);
				SetProgress(json);
				/* alert("大小"+json);
				if (progress > 100){
					SetProgress(100);
					//$("#message").text("上传完毕！");//上传完毕提示 
					
				}
				if (progress <= 100){
					progress = json;
				}  */
			};

			ws.onclose = function(event) {
				//setConnected(false);
			};
		}
		//data-options="iconCls:'icon-download',plain:true"
		function iconformatter(value, row, index) {
			return "<a href=\"javascript:void(0);\" class=\"obs_file_download\" title =\"下载\" style=\"width:36px;height:32px\"  onclick=\"downloadFun(\'"
				+ row.filename
				+ "\')\"></a>"
				+ "<a href=\"javascript:void(0);\" class=\"obs_file_rename\" title =\"重命名\" style=\"width:36px;height:32px\"  onclick=\"showeditwin(\'"
				+ row.fileid
				+ "\',\'"
				+ row.filename
				+ "\')\"></a>&nbsp"
				+ "<a href=\"javascript:void(0);\" class=\"obs_file_share\" title =\"分享\" style=\"width:36px;height:32px\" onclick=\"showsharewin(\'"
				+ row.filename + "\')\"/>";
		}
	function fileChange(target){
		var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
		 var fileSize = 0;
         if (isIE && !target.files) {
             var filePath = target.value;
             var fileSystem = new ActiveXObject("Scripting.FileSystemObject");   
             var file = fileSystem.GetFile (filePath);
             fileSize = file.Size;
         } else {
             fileSize = target.files[0].size;
         }
         if(fileSize>314572800){
        	 $.messager.alert('错误', "文件大于300M，请用工具上传","warning");
        	 $('#uploadbtn').linkbutton('disable');
         }else{
        	 debugger;
        	 $('#uploadbtn').linkbutton('enable');
        	 var pos=target.value.lastIndexOf("\\");
        	 var filename= target.value.substring(pos+1);  
	         	$.ajax({
             		type:'POST',
	              	url:'${pageContext.request.contextPath}/obsMgr/checkfilename.do',
	              	dataType:'json',
	              	data:{
	              		filename:filename,
	              		bucketname:'${vo.bucketname}'
	              	},
	               	async:false,
	              	success:function(data){
	              		if(data.success){
              			 	$.messager.alert('警告', "文件名已存在，继续上传将覆盖","warning");
	              		}
            		}
            	 });
         }
       
	}
		//上传文件
	function uploadFun() {
			
		var filetype = $("input[name='filepath']");
		if (!filetype.val()) {
			$.messager.alert('错误', "请选择要上传的文件！","warning");
			return false;
		}
		/* if(Sys.ie &&Sys.ie<10){
		//ie 9待处理
			 var filePath = target.value;
             var fileSystem = new ActiveXObject("Scripting.FileSystemObject");   
             var file = fileSystem.GetFile (filePath);
             fileSize = file.Size;
		}else{
			if (filetype[0].files[0].size > 314572800)//300M
			{
				$.messager.alert('错误', "文件大于300M，请用工具上传","warning");
				return false;
			}
		} */
		var permission = $('#permission').val();
		$('#uploadForm').form('submit',
			{
				url : urlrootpath
						+ '/obsMgr/uploadBucketFile.do?bucketName=${vo.bucketname}&permission='
						+ permission,
				onSubmit : function() {
					SetProgress(0);
					$('#uploadbtn').linkbutton('disable');
				},
				success : function(retr) {
					$('#uploadbtn').linkbutton('enable');
					var _data = JSON.parse(retr);
					$.messager.alert('消息', _data.msg);
					if (_data.success) {
						loadDataGrid();
						// 						$('#uploadwindow').window('close');
					}
				}
			});
		}

	//下载文件 
	function downloadFun(filename) {

		$.ajax({
			type : 'post',
			url : urlrootpath + '/obsMgr/downloadBucketFile.do?filename='
					+ encodeURI(filename) + '&bucketName=${vo.bucketname}',
			dataType : 'text',
			async : false,
			success : function(url) {
				// 					var temp = url.split(".");
				// 					var str = temp[temp.length - 1];
				// 					if (str == "doc" || str == "docx" || str == "xls"
				// 							|| str == "xlsx") {
				// 						window.open(url);
				// 					} else {
				window.location.href = url;
				// 					}
			}
		});
	};

	//删除文件
	function deleteFun() {
		var rows = $('#dg').datagrid('getChecked');
		if (rows.length < 1) {
			$.messager.alert('消息', '请选择文件');
			return;
		}
		var filenames = "";
		for (var index = 0; index < rows.length; index++) {
			filenames = filenames + rows[index].filename + ",";
		}
		$.messager.confirm('确认', '您确认想要删除文件吗？', function(r) {
			$.ajax({
				type : "POST",
				url : urlrootpath
						+ '/obsMgr/deleteBucketFile.do?filename='
						+ encodeURI(filenames)
						+ '&bucketName=${vo.bucketname}',
				dataType : "json",
				success : function(data) {
					$.messager.alert('消息', data.msg);
					if (data.success) {
						loadDataGrid();
					}
				}
			});
		});
	}
	//打开重命名窗口
	function showeditwin(fileid, filename) {
		$('#fileid').val(fileid);
		$('#oldfilename').val(filename);
		$('#newfilename').textbox("setValue", filename).textbox("setText",
				filename);
		$('#file_edit_win').window('open');
	}
	//重命名文件
	function renamefile() {
		var fileid = $('#fileid').val();
		var oldfilename = $('#oldfilename').val();
		var newfilename = $('#newfilename').textbox("getValue");
		var permission = $('#permission').val();
		$.ajax({
			type : "POST",
			url : urlrootpath + '/obsMgr/renamefile.do?',
			dataType : "json",
			data : {
				bucketname : '${vo.bucketname}',
				fileid : fileid,
				permission : permission,
				oldfilename : oldfilename,
				newfilename : newfilename
			},
			success : function(data) {
				//	SetProgress(100);
				$.messager.alert('消息', data.msg);
				if (data.success) {
					loadDataGrid();
				}
				$('#file_edit_win').window('close');
			}
		});
	}
	//显示外链地址窗口
	function showsharewin(filename) {
		$.ajax({
			type : "POST",
			url : urlrootpath + '/obsMgr/generateUrl.do?',
			dataType : "json",
			data : {
				bucketname : '${vo.bucketname}',
				filename : filename,
				permission : $("#permission").val(),
			},
			async : false,
			success : function(data) {
				$('#chainaddr').text(data.obj);
			}
		});
		$('#file_share_win').window('open');
	}

	/********** sheet2: 上传、下载、重命名、删除文件 END **********/

	/********** sheet3: 变更空间属性、重命名空间、删除空间   START **********/
	//deleteBucket
	function deleteBucket() {
		$.messager.confirm('确认', '您确认想要删除空间吗？', function(r) {
			if (r) {
				
				var filenum = $("#fileListNum").val();
				if (Number(filenum) > 0) {
					$.messager.alert('错误', '空间中仍有文件，请先删除文件', 'warning');
					return;
				}
				$.ajax({
					type : "GET",
					url : urlrootpath + '/obsMgr/deleteBucket.do',
					data : {
						bucketName : "${vo.bucketname}"
					},
					dataType : "json",
					success : function(retr) {
						//delete bucket result
						if (retr.success) {
							$.messager.alert('提示', retr.msg, 'info');
							//页面跳转
							var topWindow = window.parent;
							topWindow.$('#centerTab').panel({
								href : '/icpmg/web/obsMgr/SpaceMgr.jsp'
							});
							//坐标变更
							var titletd = document.getElementById("titletd");
							var titletd_bucketName = document
									.getElementById("titletd_bucketName");
							titletd.removeChild(titletd_bucketName);
						} else {
							$.messager.alert('提示', retr.msg, 'error');
						}
					}
				});
			} else {
				return;
			}
		});
	}
	//更改访问权限
	function togglepermission() {

		var permission = $('#permission').val();
		if (permission == '1') {//0:private 1:public
			permission = '0';
		} else {
			permission = '1';
		}
		$.ajax({
			type : "POST",
			url : urlrootpath + '/obsMgr/togglepermission.do?',
			dataType : "json",
			data : {
				bucketname : '${vo.bucketname}',
				bucketid : '${vo.bucketid}',
				permission : permission
			},
			success : function(data) {
				if (data.success) {
					$.messager.alert('提示信息', data.msg, 'info');
					$('#permission').val(permission);
					if (permission == '1') {
						$('.per_space').text("私有空间");
						$('.per_space1').text("私有空间需要拥有者的授权链接才可访问");
						$('#togglebtn').linkbutton({
							text : "改为公开",
							plain : true
						});
					} else {
						$('.per_space').text("公有空间");
						$('.per_space1').text("公开空间的文件可通过外链地址直接访问");
						$('#togglebtn').linkbutton({
							text : "改为私有",
							plain : true
						});
					}
				} else {
					$.messager.alert('错误', data.msg, 'error');
				}
			}
		});
	}

	/********** sheet3: 变更空间属性、重命名空间、删除空间   END **********/
</script>

	<div id="div_BucketMgr" class="easyui-tabs"
		style="width:98%; height:100%;">

		<!--------------- 桶空间运用情况展示  START --------------->
		<div title="空间" style="padding:20px">
			<div class="cards">

				<div class="card" id="space-card" style="height:280px">
					<!-- 存储空间变化图生成 -->
				</div>

				<div class="card" id="flow-card" style="height:280px">
					<!-- 流量变化图生成 -->
				</div>

				<div class="card" id="getput-card" style="height:280px">
					<!-- 上传下载次数变化图生成 -->	
				</div>

			</div>
		</div>
		<!---------------- 桶空间运用情况展示  END ---------------->

		<!------------ 上传、下载、重命名、删除文件  START ------------>
		<div title="空间管理" style="padding:20px">

			<!-- 上侧 ：查询、上传、下载、删除  -->
			<div data-options="region:'north',border:false" style="height:50px;overflow:hidden;">
				<form id="file_searchform">
					<table style="width:96%">
						<tr style="margin: 10px 10px 10px 0px;padding: 0px;">
							<td style="margin: 10px 10px 10px 0px;padding: 0px;">文件名称：<input
								class="easyui-textbox" name="fileNameSlice" id="fileNameSlice"
								style="width:200px"> <a href="javascript:void(0);"
								id="search" class="easyui-linkbutton"
								data-options="iconCls:'icon-search',plain:true,border:false">查询</a>&nbsp;&nbsp; <a
								href="javascript:void(0);" id="reset" class="easyui-linkbutton"
								data-options="iconCls:'icon-redo',plain:true,border:false">重置</a>
							</td>

							<td style="float:right">&nbsp; <a href="javascript:void(0);"
								class="easyui-linkbutton" style="width:60px;height:35px"
								data-options="iconCls:'icon-upload',plain:true"
								onclick="uploadFileWindowOpen()">上传</a>&nbsp; <a
								href="javascript:void(0);" class="easyui-linkbutton"
								style="width:60px;height:35px"
								data-options="iconCls:'icon-delete',plain:true"
								onclick="deleteFun()">删除</a>&nbsp;
							</td>
						</tr>
					</table>
				</form>
			</div>

			<!-- 下侧：文件列表   -->
			<div data-options="region:'center',border:false,fit:false" style="min-height:420px" id="addid">
				<table style="width:100%; "id="dg" data-options="border:false,fit:false">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'filename',width:100,align:'left',sortable:true">文件名</th>
							<th data-options="field:'fileformat',width:140,align:'center',sortable:true">文件格式</th>
							<th data-options="field:'filesize',width:80,align:'center',sortable:true">文件大小(单位:B)</th>
							<th data-options="field:'updatetime',width:100,align:'center',sortable:true">最近更新时间</th>
							<th data-options="field:'fileid',width:100,align:'center',sortable:true,formatter:iconformatter">操作</th>
						</tr>
					</thead>
				</table>
			</div>

		</div>
		<!------------- 上传、下载、重命名、删除文件  END ------------->
		<!---------- 变更空间属性、重命名空间、删除空间  START ---------->
		<div title="空间设置" style="padding:20px">
			<!-- 变更空间属性 -->
			<div class="setting-box">
				<div class="setting-box-head">访问控制</div>
				<div class="setting-box-body">
					<table style="width:90%">
						<tr>
							<td><input type="hidden" id="permission"
								value="${vo.permission}" />
								<p>当前访问空间为<span class="per_space"><c:if test="${vo.permission eq '0'}">公开空间</c:if>
										<c:if test="${vo.permission eq '1'}">私有空间</c:if></span>。 <span
										class="per_space1"><c:if test="${vo.permission eq '0'}">公开空间的文件可通过外链地址直接访问</c:if>
										<c:if test="${vo.permission eq '1'}">私有空间需要拥有者的授权链接才可访问</c:if></span>。
								</p>
								<p>
									改变访问控制可能使当前正在运行的程序无法正常使用。
									<!-- <a class="link" target="_blank" href="http://kb.qiniu.com/53a4iwi2">公开和私有的区别？</a> -->
								</p> <!-- <p><b>如果您配置了自定义域名，切换会导致自定义域名失效，请谨慎操作，并在切换后重新配置自定义域名。</b></p>
              <p>切换生效需 24小时。</p> --></td>
						</tr>
					</table>

					<div class="setting-btn">
						<a id="togglebtn" class="easyui-linkbutton"
							data-options="plain:true" href="javascript:void(0)"
							onclick="togglepermission();"> 
							<c:if test="${vo.permission eq '0'}">改为私有</c:if>
							<c:if test="${vo.permission eq '1'}">改为公开</c:if>
						</a>
					</div>
				</div>
			</div>

			<!-- 删除空间 -->
			<div class="setting-box">
				<div class="setting-box-head">删除空间</div>
				<div class="setting-box-body">
					<input type="hidden" id="fileListNum">
					<table style="width:90%">
						<tr>
							<td>
								<p>
									一旦删除空间，就永远无法再恢复回来，请确认是否有必要删除！<br />此操作会影响到和这个空间相关程序的运行。
								</p>
							</td>
						</tr>
					</table>

					<div class="setting-btn">
						<a class="easyui-linkbutton" href="javascript:void(0)"
							data-options="plain:true" onclick="deleteBucket();">删除空间</a>
					</div>
				</div>
			</div>
		</div>
		<!----------- 变更空间属性、重命名空间、删除空间  END ----------->

	</div>

	<!-- 上传文件 弹出框   -->
	<div id="uploadwindow" class="easyui-window" title="上传文件"
		data-options="closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
		style="width:600px;height:400px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;">
				<form id="uploadForm" method="post" enctype="multipart/form-data">
					<div class="detail-line" style="margin: 15px 20px;">
						<input id="uploadfiles" name="uploadfiles" type="hidden" /> <span>上传文件：</span>
							<input type="file" style="width:250px;height: 26px" id="fileurl" name="filepath" onchange="fileChange(this);"/>
						 <span style="color:red">选择一个附件*</span>
					</div>
				</form>
				<!-- 进度条 -->
				<div class="progressBody">
					<div id="loading" class="loading">
						<div id="message"></div>
					</div>
				</div>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="uploadbtn"
					href="javascript:void(0)" onclick="uploadFun();" style="width:80px">上传</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					href="javascript:void(0)"
					onclick="$('#uploadwindow').window('close');" style="width:80px">关闭</a>
			</div>
		</div>
	</div>
	<!-- 重命名 弹出框   -->
	<div id="file_edit_win" class="easyui-window" title="重命名"
		data-options="closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
		style="width:380px;height:200px;padding:10px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false"
				style="padding:10px;">
				<input class="easyui-textbox" id="newfilename"
					style="margin-left:40px;" data-options="width:200,height:30" /> <input
					type="hidden" id="fileid" /> <input type="hidden" id="oldfilename" />
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
					href="javascript:void(0)" onclick="renamefile();"
					style="width:72px">确定</a> <a class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
					onclick="$('#file_edit_win').window('close');" style="width:72px">关闭</a>
			</div>
		</div>
	</div>
	<!-- 分享链接窗口 -->
	<div id="file_share_win" class="easyui-window" title="外链地址"
		data-options="closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
		style="width:380px;height:200px;padding:10px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;">
				<div id="chainaddr" class="chainurl"></div>
			</div>
			<div data-options="region:'south',border:false"	style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-copy'"
					href="javascript:void(0)" style="width:72px" id="d_clip_button"
					data-clipboard-target="chainaddr">复制</a> 
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					href="javascript:void(0)" onclick="$('#file_share_win').window('close');"
					style="width:72px;margin-left:3px;">关闭</a>
			</div>
		</div>
	</div>


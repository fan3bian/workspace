<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<style type="text/css">
  .detail-line{
    margin: 10px 25px;
  }
</style>
<script type="text/javascript" charset="utf-8">
	var flagck = 0;  //  初始化为0
	var toolbar = [
       		{
       			text:'上架',
       			iconCls:'icon-add',
       			handler:function()
       			{
       				$('<div></div>').dialog({
       					id:'editWindow',
       					title : '设备上架',
	                    width : 680,
	                    height : 430,
	                    closed : false,
	                    cache : false,
	                    href : '${ctx}/web/gov2/resourcemanage/trustDeviceEdit.jsp',
	                    modal : true,
	                    onLoad : function() {
	                    	$('.j-required').validatebox({
	        	                required: true
	        	            });
	                    	//初始化表单数据
	                    	/* $('#unitnameEdit').val('');
	                    	$('#appnameEdit').val('');
	                    	$('#sbmcEdit').val('');
	                    	$('#ppxhEdit').val('');
	                    	$('#leixingEdit').val('');
	                    	$('#xlhEdit').val('');
	                    	$('#edglEdit').val('');
	                    	$('#sbgdEdit').val('');
	                    	$('#sjjghEdit').val('');
	                    	$('#sjywEdit').val('');
	                    	$('#nwipEdit').val('');
	                    	$('#quyuEdit').val('');
	                    	$('#flowidEdit').val('');
	                    	$('#ggcsEdit').val(''); */
	                    	url = '${ctx}/trust/addEquip.do';
	                    },
	                    onClose : function() {
	                        $(this).dialog('destroy');
	                    },
	                    buttons:[
		                    {
		                    	text:'确定',
		                    	iconCls:'icon-ok',
		                    	handler:function(){
			                    	confirmBtn();
		                    	}
		                    },{
		                    	text:'取消',
		                    	iconCls:'icon-cancel',
		                    	handler:function(){
		                    		$("#editWindow").dialog('destroy');
		                    	}
		                    }
	                    ]
       				});
       			}
       		},
       		{
       			text:'变更',
       			iconCls:'icon-modify',
       			handler:function()
       			{
       				var row = $('#datagrid_trust').datagrid('getChecked');
       				if(row.length!=1){
       					$.messager.alert('消息','请选择一条记录！','info');
       					return;
       				}
       				$('<div></div>').dialog({
       					id:'editWindow',
       					title : '设备变更',
	                    width : 680,
	                    height : 430,
	                    closed : false,
	                    cache : false,
	                    href : '${ctx}/web/gov2/resourcemanage/trustDeviceEdit.jsp',
	                    modal : true,
	                    onLoad : function() {
	                    	//console.log(row[0]);
	                    	$("#unitnameEdit").textbox('setValue',row[0].unitname);
	                    	//$('#unitnameEdit').textbox('readonly',true);
	                    	$("#appnameEdit").textbox('setValue',row[0].appname);
	                    	//$('#appnameEdit').textbox('readonly',true);
	                    	$("#sbmcEdit").val(row[0].equipmentname);
	                    	$("#ppxhEdit").val(row[0].equipmentpro);
	                    	$("#leixingEdit").combobox('setValue',row[0].equipmentstyle);
	                    	//$('#leixingEdit').textbox('readonly',true);
	                    	$("#xlhEdit").val(row[0].equipmentcode);
	                    	$("#edglEdit").val(row[0].equipmentpower);
	                    	$("#sbgdEdit").val(row[0].equipmentheight);
	                    	$("#sjjghEdit").val(row[0].cabinetnumber);
	                    	$("#sjywEdit").val(row[0].unumber);
	                    	$("#nwipEdit").val(row[0].interip);
	                    	$("#quyuEdit").combobox('setValue',row[0].equipmentregion);
	                    	//$('#quyuEdit').textbox('readonly',true);
	                    	$("#flowidEdit").textbox('setValue',row[0].flowid);
	                    	//$('#flowidEdit').textbox('readonly',true);
	                    	$("#ggcsEdit").val(row[0].snote);
	                    	$("#objectidEdit").val(row[0].objectid);
	                    	$("#equipnumEdit").val(row[0].equipmentnum);
	                    	$('.j-required').validatebox({
	        	                required: true
	        	            });
	                    	url = '${ctx}/trust/updateEquip.do';
	                    	
	                    	
	                    },
	                    onClose : function() {
	                        $(this).dialog('destroy');
	                    },
	                    buttons:[
		                    {
		                    	text:'确定',
		                    	iconCls:'icon-ok',
		                    	handler:function(){
		                    		
		                    		confirmBtn();
		                    	}
		                    },{
		                    	text:'取消',
		                    	iconCls:'icon-cancel',
		                    	handler:function(){
		                    		$("#editWindow").dialog('destroy');
		                    	}
		                    }
	                    ]
       				});
       				
       			}
       		},
       		{
       			text:'下架',
       			iconCls:'icon-delete',
       			handler:function()
       			{
       				var rows = $('#datagrid_trust').datagrid('getChecked');
       				if(rows.length<1){
       					$.messager.alert('消息','请至少选择一条记录！','info');
       					return;
       				}
       				var objectid = rows[0].objectid;
       				var equipmentnum = rows[0].equipmentnum;
       				/* var objectids = '';
       				$.each(rows,function(index,object){
       					objectids += "'"+object.objectid+"',";
       				});
       				objectids = objectids.substring(0,objectids.length-1); */
       				$.messager.confirm('确认','您确认要将所选记录下架吗？',function(r){
       					if(r){
       						$.ajax({
       							type:'post',
       							url:'${ctx}/trust/dropEquip.do',
       							data:{objectid:objectid,equipmentnum:equipmentnum},
       							success:function(data){
       								var retr = JSON.parse(data);
       								$.messager.alert('消息',retr.msg);
       								if(retr.success){
       									$('#datagrid_trust').datagrid('unselectAll');
							    		$('#datagrid_trust').datagrid('load',
												icp.serializeObject($('#trust_searchform')));
       								}
       							}
       							
       						});
       					}
       				});
       			}
       		}
      ];
	  $(function(){
			searchForm = $('#trust_searchform').form();
			datagrid = $('#datagrid_trust').datagrid({
				url:'${ctx}/trust/getDeviceLists.do',
				pagination:true,
				pageSize:10,
				pageList:[5,10,20,30,40,50],
				fitColumns:true,
				nowarp:false,
				border:false,
				scrollbarSize:0,
				idField:'neid',
				sortName:'ctime',
				sortOrder:'desc',
		        singleSelect:true,
		        toolbar:toolbar,
				frozenColumns:[[ 
					{field:'ck',checkbox:true} 
				]],
				onLoadSuccess:function(data){
					var pageopt = $('#datagrid_trust').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = $('#datagrid_trust').datagrid("getRows").length;
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
							//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
							$(this).datagrid('appendRow', {feestat:''  })
						}
						$('#datagrid_trust').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
							if(val.feestat==''){ 
								//addid为datagrid上一层的div id
								$('#addid  input:checkbox').eq(idx+1).css("display","none");
								 
							}
						}); 
			        }
				},
				//没数据的行不能被点击选中
				onClickRow: function (rowIndex, rowData) {
					if(rowData.neid==''){
						 $('#datagrid_trust').datagrid('unselectRow', rowIndex);
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
						if(val.neid==''){
							//如果是空行，不能被选中
							$("#datagrid_trust").datagrid('uncheckRow', idx);
							//增加全选复选框被选中
							$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");	
						}
					});
				},
				 //取消全选
				onUncheckAll: function(rows) {
					//取消全选时，标志位变为0
					flagck = 0;
				},
				columns:[[ 
				{
				   title:'单位id',
				   field:'unitid',
				   width:100,
				   align:'center',
				   hidden:true,
				},
				{
				   title:'部门',
				   field:'unitname',
				   width:100,
				   align:'center'
				},
				{
					title:'',
					field:'objectid',
					width:100,
				    align:'center',
				    hidden:true
				},
				{
					title:'设备名称',
					field:'equipmentname',
					width:100,
				    align:'center',
				},
				{
					title:'品牌',
					field:'equipmentpro',
					width:100,
				    align:'center',
				},{
					title:'类型',
					field:'equipmentstyle',
					width:100,
					align:'center',
					formatter:function(value,row,index){
						if("10001"==value){
							return "服务器";
						}else if("10002"==value){
							return "存储";
						}else if("10003"==value){
							return "网络设备";
						}else if("10004"==value){
							return "安全设备";
						}else if("10005"==value){
							return "SAN交换机";
						}else if("10006"==value){
							return "其他";
						}else{
							return value;
						}
					}
				},{
					title:'设备高度（U）',
					field:'equipmentheight',
					width:100,
					align:'center',
				},{
					title:'区域',
					field:'equipmentregion',
					width:100,
					align:'center',
					formatter:function(value,row,index){
						if("0001"==value){
							return "政务外网";
						}else if("0002"==value){
							return "互联网区";
						}else{
							return value;
						}
					}
				
				},{
					title:'状态',
					field:'usestatus',
					width:100,
					align:'center',
					formatter:function(value,row,index){
						if("1"==value){
							return "上架";
						}else if("0"==value){
							return "下架";
						}
					}
				},{
					title:'操作',
					field:'status',
					width:100,
					align:'center',
					formatter:function(value,row,index){
						var rows = $('#datagrid_trust').datagrid('getChecked');
					
						var _objectid = row['objectid'];
						var _equipnum = row['equipmentnum'];
						if(_objectid){
							var atag = '<a href="javascript:void(0)" onclick="showDetail(\''+_objectid+"','"+_equipnum+"','"+index+'\')">详情<\/a>';
						}
						return atag;
					}
				},{
					title:'序列号',
					field:'equipmentcode',
					width:100,
				    align:'center',
				    hidden:true
				},{
					title:'功率',
					field:'equipmentpower',
					width:100,
					align:'center',
					hidden:true
				},{
					title:'上架机柜号',
					field:'cabinetnumber',
					width:100,
					align:'center',
					hidden:true
				},{
					title:'上架U位',
					field:'unumber',
					width:100,
				    align:'center',
				    hidden:true
				},{
					title:'内网ip',
					field:'interip',
					width:100,
					align:'center',
					hidden:true
				},{
					title:'规格',
					field:'snote',
					width:100,
					align:'center',
					hidden:true
				}]]
			});
		});
	    
</script>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="trust_searchform">
			<table>
				<tr>
					<td>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：
                        <input class="easyui-textbox" name="unitname" id="unitnameTrust" style="width:200px;height: 25px;">
                    </td>
					<td style="margin-left: 10px">
					&nbsp;&nbsp;设备名称：<input class="easyui-textbox" id="equipname" style="width: 150px;height: 25px; "  name="equipmentname">
					</td>
					<td>&nbsp;&nbsp;状&nbsp;&nbsp;态：
                        <select class="easyui-combobox" name="usestatus" id="usestatusTrust" style="width:100px;height: 25px;">
	                        <option value=""></option>
	                        <option value="1">上架</option>
	                        <option value="0">下架</option>
	                    </select>
                    </td>
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFunc()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div data-options="region:'center',border:false" style="background:#eee;margin-top: 15px" id="addid">
		<table id="datagrid_trust" style="background:#eee;width:100%;"></table>
	</div>
	
	 
</div>
<script type="text/javascript" charset="utf-8">
	//所属单位
	$('#unitnameTrust').combobox({
		url:'${pageContext.request.contextPath}/project/getUnitsData.do',
		valueField: 'unitId',
		textField: 'unitName',
		width:200,
		panelHeight: '100',
		loadFilter:function(data){
			data.unshift({unitId:"",unitName:"请选择"});
			return data;
		}
	});
	//查询
	function searchFunc(){
	    $('#datagrid_trust').datagrid('load',icp.serializeObject($('#trust_searchform')));
	}
	//重置
	function cleanSearchFun(){
		$('#trust_searchform input').val('');
		$('#unitnameTrust').textbox('clear');
		$('#equipname').textbox('clear');
		$('#usestatusTrust').textbox('clear');
		$('#datagrid_trust').datagrid('load',{});
	}
	//上架&变更 确认
	function confirmBtn(){
		$('#deviceEdit').form('submit',{
			url:url,
	        onSubmit:function(){
	        	return $(this).form('validate');
	        },
	        success:function(data){
	        	var _data = JSON.parse(data);
	        	$('#editWindow').window('close');
	  			$.messager.alert('消息',_data.msg);
	        	if(_data.success){
	        		$('#datagrid_trust').datagrid('unselectAll');
		    		$('#datagrid_trust').datagrid('reload');
	        	}
	        } 
		});
    }
	//详情
	function showDetail(objectid,equipmentnum,index) {
		$('<div></div>').dialog({
			id: 'equipInfo',
			title: '设备信息',
			width: 680,
			height: 530,
			closed: false,
			cache: false,
			href: '${ctx}/web/gov2/resourcemanage/trustDeviceInfo.jsp?equipmentnum='+equipmentnum+'&objectid='+objectid,
			modal: true,
			onLoad: function () {
				$('#bbbbm').textbox('readonly',true);
            	$('#ywyyxt').textbox('readonly',true);
            	$('#sbmc').textbox('readonly',true);
            	$('#ppxh').textbox('readonly',true);
            	$('#xlh').textbox('readonly',true);
            	$('#edgl').textbox('readonly',true);
            	$('#sbgd').textbox('readonly',true);
            	$('#sjjgh').textbox('readonly',true);
            	$('#sjyw').textbox('readonly',true);
            	$('#nwip').textbox('readonly',true);
            	$('#ggcs').textbox('readonly',true);
            	$('#leixing').textbox('readonly',true);
            	$('#quyu').textbox('readonly',true);
			},
			onClose: function () {
				$(this).dialog('destroy');
			}
		});
	}
</script>
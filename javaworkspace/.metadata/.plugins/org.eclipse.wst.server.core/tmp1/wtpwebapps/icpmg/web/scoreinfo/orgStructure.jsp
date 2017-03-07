<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>

<script type="text/javascript" charset="utf-8">

$(function(){
	var toolbar = [{
			text:'增加',
			iconCls:'icon-newadd',
			handler:function()
			{
			    $("#windowflag").val('1');				
				$("#unitid").textbox('setValue','');
				$("#unitname").textbox('setValue','');
				$("#punitid").textbox('setValue','');
				$("#punitname").textbox('setValue','');
				$("#unittype").combobox('setValue','');
				$("#unitlevel").combobox('setValue','');
				$("#ismanage").combobox('setValue','');
				
			    $("#provname").textbox('setValue','');
			    $("#groupname").textbox('setValue','');
			    $("#cityname").textbox('setValue','');
			    $("#unitshort").textbox('setValue','');
			    			 	
				$('#unitedit').window('open');
			}
		},{
			text:'删除',
			iconCls:'icon-del',
			handler:function()
			{
				var rows = $('#datagrid_promg').datagrid('getSelections');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				var ids = "";
				 $.each(rows,function(index,object){
				 	ids+=object.unitid+",";
   				 });
   			 
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/scoreinfoMg/orgStructureDel.do',
   				  		data:{ids:ids},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg,"info");  
				  			if(data.success)
					    	{
					    		$('#datagrid_promg').datagrid('unselectAll');
					    		$('#datagrid_promg').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
					    		
					    	} 
   				  		}
   				  	});
   				  }
   				 });
			}
		},{
			text:'修改',
			iconCls:'icon-update',
			handler:function()
			{
				var rows = $('#datagrid_promg').datagrid('getSelections');
				
				if(rows.length!=1)
				{
					$.messager.alert('消息','请选择一条记录！'); 
					return; 
				}
			   	$("#windowflag").val('2');
			   	$("#unitid").textbox('setValue',rows[0].unitid);
				$("#unitname").textbox('setValue',rows[0].unitname);
				$("#punitid").textbox('setValue',rows[0].punitid);
				$("#punitname").textbox('setValue',rows[0].punitname);
				$("#unittype").combobox('setValue',rows[0].unittype);
				$("#unitlevel").combobox('setValue',rows[0].unitlevel);
				
				var ismanageTemp = rows[0].ismanage;
				if("0"==ismanageTemp){
					$("#ismanage").combobox('setValue',"否");
				}else if("1"==ismanageTemp){
					$("#ismanage").combobox('setValue',"是");
				}
				//$("#provid").textbox('setValue',rows[0].provid);
			    $("#provname").textbox('setValue',rows[0].provid).textbox('setText',rows[0].provname);
			    $("#cityname").textbox('setValue',rows[0].cityid).textbox('setText',rows[0].cityname);
			    $("#groupname").textbox('setValue',rows[0].groupid).textbox('setText',rows[0].groupname);
			    //$("#cityid").textbox('setValue',rows[0].cityid);
			    $("#unitshort").textbox('setValue',rows[0].unitshort);
			    		
				$('#unitedit').window('open');
				
			}
		}]; 
	
	searchForm = $('#promgr_searchform').form();
 	
	datagrid = $('#datagrid_promg').datagrid({
		url:'${ctx}/scoreinfoMg/orgStructureQuery.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],		
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'unitid',
		sortName:'unitid',
		sortOrder:'desc',
		toolbar:toolbar,
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'单位编号',
			field:'unitid',
			width:30,
			hidden:true,
			sortable:true
		},
		{
			title:'单位名称',
			field:'unitname',
			width:30,
			align:'center'
		},{
			title:'父单位编号',
			field:'punitid',
			width:30,
			hidden:true,
			align:'center'
		},
		{
		   title:'父单位名称',
		   field:'punitname',
		   width:30,
		   align:'center'
		},
		{
			title:'单位类型',
			field:'unittype',
			width:30,
			hidden:true,
		    align:'center'
		},{
			title:'单位级别',
			field:'unitlevel',
			width:30,
			hidden:true,
			align:'center'
		},{
			title:'是否主管单位',
			field:'ismanage',
			width:30,
			hidden:true,
			align:'center'
			
		},{
			title:'所属省编码',
			field:'provid',
			width:30,
			hidden:true,
			align:'center' 
		},{
			title:'所属省名称',
			field:'provname',
			width:30,
			hidden:true,
			align:'center' 
		},{
			title:'机关分类',
			field:'groupname',
			width:30,
			align:'center' 
		},{
			title:'所属市编码',
			field:'cityid',
			width:30,
			hidden:true,
			align:'center' 
		},{
			title:'所属市名称',
			field:'cityname',
			width:30,
			align:'center' 
		},{
			title:'单位简称',
			field:'unitshort',
			width:30,
		    align:'center'
		}]],
		onLoadSuccess: function (data) {
					      var pageopt = $('#datagrid_promg').datagrid('getPager').data("pagination").options;
					      var  _pageSize = pageopt.pageSize;
					      var  _rows = $('#datagrid_promg').datagrid("getRows").length;
					      var total = pageopt.total; //显示的查询的总数 
					      if (_pageSize >= 10) {
					         for(i=10;i>_rows;i--){
					            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					            $(this).datagrid('appendRow', {operation:''  })
					         }
					          $('#datagrid_promg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
													if   (val.operation==''){  
														$('#scoreid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
					      					    					      
					},
					 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.operation==''){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#scoreid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.operation==''){
									$("#datagrid_promg").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#scoreid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
	});
	
	searchFun=function(){
	    datagrid.datagrid('load',icp.serializeObject($('#promgr_searchform')));

	};
	cleanSearchFun=function(){
		//searchForm.find('input').val('');
		$('#promgr_searchform input').val('');
		$('#unitsearchname').textbox('clear');
		datagrid.datagrid('load',{});
	};

});

  
</script>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="promgr_searchform">
			<table>
				<tr>
						<td>
					  单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：<input id="unitsearchname" style="width:200px;height: 30px; "  name="unitname" class="easyui-textbox" /> 
				 
          
					</td>
					
					 
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;

					</td>
				</tr>
			</table>
		</form>
	</div>

	<div data-options="region:'center',border:false" style="background:#eee;">
		<table id="datagrid_promg" style="background:#eee;width:100%;"></table>
	</div>
	
	<div id="unitedit" class="easyui-window" title="单位录入" data-options="iconCls:'icon-update',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:650px;height:330px;">
        <form action="" method="post" id="unitform">
        <input id="windowflag" name="flag" type="hidden" value="0" />
        <div data-options="region:'center'" style="padding:10px;">        
        <fieldset>
			<legend>单位信息</legend>					
			<div style="margin: 10px 25px;width:550px;" >
				&nbsp;&nbsp;&nbsp;<span>单位编码：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="unitid" id="unitid" style="width: 170px ;height: 25px;" >
				</span>&nbsp;&nbsp;&nbsp; 
				<span>&nbsp;&nbsp;&nbsp;单位名称：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="unitname" id="unitname" style="width: 170px ;height: 25px;" >
				</span>	  
		    </div>
		    
		    <div style="margin: 10px 25px;width:550px;" >
				<span>父单位编码：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="punitid" id="punitid" style="width: 170px ;height: 25px;"  >
				</span>&nbsp;&nbsp;&nbsp; 
				<span>父单位名称：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="punitname" id="punitname" style="width: 170px ;height: 25px;"  >
				</span>	  
		    </div>
		    				    
			<div style="margin: 10px 25px;width:550px;" >
				&nbsp;&nbsp;&nbsp;<span>单位类型：
					<select class="easyui-combobox" name="unittype" id="unittype" data-options="prompt:'---请选择单位类型---'" style="width: 170px;height: 25px;">
						<option value=""></option>
						<option value="1">市</option>
						<option value="2">区县</option>
					</select>
				</span>&nbsp;&nbsp;&nbsp;
				<span>&nbsp;&nbsp;&nbsp;单位级别：
					<select class="easyui-combobox" name="unitlevel" id="unitlevel" data-options="prompt:'---请选择单位级别---'" style="width: 170px;height: 25px;">
						<option value=""></option>
						<option value="1">一级</option>
						<option value="2">二级</option>
					</select>
				</span>  
		    </div>
		    				    
		    <div style="margin: 10px 25px;width:550px;" >
				&nbsp;&nbsp;&nbsp;<span>主管单位：
					<select class="easyui-combobox" name="ismanage" id="ismanage" data-options="prompt:'---请选择是否主管单位---'" style="width: 170px;height: 25px;">
						<option value=""></option>
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
				</span>&nbsp;&nbsp;&nbsp;
				<span>&nbsp;&nbsp;&nbsp;单位简称：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="unitshort" id="unitshort" style="width: 170px ;height: 25px;"  >
				</span>	  
				
		    </div>
		     	
		    <div style="margin: 10px 25px;width:550px;">
		    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>省名称：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="provname" id="provname" style="width: 170px ;height: 25px;"  >
				</span>&nbsp;&nbsp;&nbsp; 
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市名称：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="cityname" id="cityname" style="width: 170px ;height: 25px;"  >
				</span>
				
			</div>
			<div style="margin: 10px 25px;width:550px;">
		    	&nbsp;&nbsp;&nbsp;<span>机关分类：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="groupname" id="groupname" style="width: 170px ;height: 25px;"  >
				</span>&nbsp;&nbsp;&nbsp; 
				
			</div>
		  				    	    					    				    
		</fieldset>
		</div>        	
		   					  
	 	<div data-options="region:'south',border:false" style="text-align:center;padding:10px 0 0;">
           <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="unitedit()" style="width:80px">确定</a>&nbsp;&nbsp;&nbsp;
           <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#unitedit').dialog('close')" style="width:80px">取消</a>
        </div>
		</form>
	  </div>
</div>
<script type="text/javascript" charset="utf-8">

//增加 弹窗，单位-项目级联
		$('#cityname').combobox({
			width:170,
			panelHeight: '100'
		});
		
		$('#provname').combobox({
			url:'${ctx}/scoreinfoMg/getProvname.do',
			valueField: 'REGION_ID',
			textField: 'REGION_NAME',
			width:170,
			panelHeight: '100',
			onSelect:function (record){
				var _REGION_ID = record.REGION_ID;
				$('#cityname').combobox({
					url:'${ctx}/scoreinfoMg/getCityname.do?REGION_ID='+_REGION_ID,
					valueField: 'REGION_ID',
					textField: 'REGION_NAME',
				});
			}
		});
		$('#groupname').combobox({
			url:'${ctx}/scoreinfoMg/getGroupname.do',
			valueField: 'groupid',
			textField: 'groupname',
			width:170,
			panelHeight: '100',
		});

function unitedit(){
 
      $('#unitform').form('submit',{
      
         url:'${ctx}/scoreinfoMg/orgStructureedit.do',
         
         onSubmit:function(){
        
         },
         success:function(data){
           $('#unitedit').window('close');
           var data = JSON.parse(data);
           if(data.success){
            datagrid.datagrid('load');
            datagrid.datagrid('unselectAll');
            
            $.messager.alert('提示',data.msg,"info");
    
           }else{
            $.messager.alert('提示',data.msg,"info");
           }
         }
      });
   }
 </script>
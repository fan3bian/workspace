<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<style type="text/css">
  .detail-line{
    margin: 10px 25px;
  }
</style>
<script type="text/javascript" charset="utf-8">

$(function(){
	var toolbar = [{
			text:'增加',
			iconCls:'icon-newadd',
			handler:function()
			{
			    var myDate = new Date();
				$("#getpid").val('');
				$("#unitname").textbox('setValue','');
				$("#hosting").textbox('setValue','');
				$("#hostingother").textbox('setValue','');
				$("#phost").textbox('setValue','');
				$("#phostother").textbox('setValue','');
			    $("#virtualserver").textbox('setValue','');
			 	$('#ctime').datebox('setValue', myDate.toLocaleDateString());
				$('#reportedit').window('open');
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
				 	ids+=object.migrid+",";
   				 });
   			 
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/scoreinfoMg/reportDel.do',
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
			   
			   	$("#getpid").val(rows[0].migrid);
			    $("#unitname").textbox('setValue',rows[0].unitname);
				$("#hosting").textbox('setValue',rows[0].hosting);
				$("#hostingother").textbox('setValue',rows[0].hostingother);
				$("#phost").textbox('setValue',rows[0].phost);
				$("#phostother").textbox('setValue',rows[0].phostother);
			    $("#virtualserver").textbox('setValue',rows[0].virtualserver);
			 	$('#ctime').datebox('setValue', rows[0].ctime);				
				$('#reportedit').window('open');
				
			}
		}]; 
	
	searchForm = $('#promgr_searchform').form();
 	
	datagrid = $('#datagrid_promg').datagrid({
		url:'${ctx}/scoreinfoMg/reportQuery.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],		
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'migrid',
		sortName:'ctime',
		sortOrder:'desc',
		toolbar:toolbar,
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'ID',
			field:'migrid',
			width:100,
			hidden:true,
			sortable:true
		},
		{
			title:'单位',
			field:'unitname',
			width:100,
			align:'center'
		},{
			title:'托管服务器',
			field:'hosting',
			width:100,
			align:'center'
		},
		{
		   title:'托管网络和安全设备',
		   field:'hostingother',
		   width:100,
		   align:'center'
		},
		{
			title:'租用物理服务器',
			field:'phost',
			width:100,
		    align:'center'
		},{
			title:'租用其他设备',
			field:'phostother',
			width:100,
			align:'center'
		},{
			title:'租用虚拟机',
			field:'virtualserver',
			width:100,
			align:'center'
			
		},{
			title:'创建时间',
			field:'ctime',
			width:100,
			align:'center' 
		},{
			title:'是否可用',
			field:'delflg',
			width:100,
		    hidden:true,
		}]],
		onLoadSuccess: function (data) {
		      var pageopt = $('#datagrid_promg').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#datagrid_promg').datagrid("getRows").length
		      if (_pageSize >= 10) {
		         for(i=10;i>_rows;i--){
		            //添加一个新数据行，其中{} 中的delflg 为最后一列 的列名 如下图说明
		            $(this).datagrid('appendRow', {delflg:''  })
		         }
		         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
		      }else{
		         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
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
	
		<div id="reportedit" class="easyui-window" title="数据录入" data-options="iconCls:'icon-update',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:500px;height:400px;">
        <form action="" method="post" id="proform">
        <div data-options="region:'center'" style="padding:10px;">
        	
        	<div class="detail-line" >
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;单位名称：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-textbox" data-options="validType:'isBlank'"  id="unitname" style="width: 250px ;height: 30px;"  name="unitname">
				</span> 	  
		    </div>
		    
		    <div class="detail-line" >
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;托管服务器：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-textbox" data-options="validType:'isBlank'"  id="hosting" style="width: 250px ;height: 30px;"  name="hosting">
				</span> 	  
		    </div>
		    
		    <div class="detail-line" >
				<span>托管网络和安全设备：<input class="easyui-textbox" data-options="validType:'isBlank'"  id="hostingother" style="width: 250px ;height: 30px;"  name="hostingother">
				</span> 	  
		    </div>
		    
		    <div class="detail-line" >
				<span>&nbsp;&nbsp;&nbsp;&nbsp;租用物理服务器：&nbsp;&nbsp;&nbsp;<input class="easyui-textbox" data-options="validType:'isBlank'"  id="phost" style="width: 250px ;height: 30px;"  name="phost">
				</span> 	  
		    </div>
		    
		    <div class="detail-line" >
				<span>&nbsp;&nbsp;&nbsp;&nbsp;租用其他设备：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-textbox" data-options="validType:'isBlank'"  id="phostother" style="width: 250px ;height: 30px;"  name="phostother">
				</span> 	  
		    </div>
		    
		     <div class="detail-line" >
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;租用虚拟机：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-textbox" data-options="validType:'isBlank'"  id="virtualserver" style="width: 250px ;height: 30px;"  name="virtualserver">
				</span> 	  
		    </div>
		    
		    
		    <div class="detail-line" >
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;时间：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-datebox" data-options="required:'ture',validType:'isBlank',showSeconds:false"  id="ctime" style="width: 250px ;height: 30px;"  name="ctime">
				</span> 	  
		    </div>
		   <input type="hidden" name="migrid" id="getpid"> 
			  
			 <div data-options="region:'south',border:false" style="text-align:center;padding:10px 0 0;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="projectedit()" style="width:80px">确定</a>&nbsp;&nbsp;&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#reportedit').dialog('close')" style="width:80px">取消</a>
            </div>
		</form>
	  </div>
</div>
<script type="text/javascript" charset="utf-8">
function projectedit(){
 
      $('#proform').form('submit',{
      
         url:'${ctx}/scoreinfoMg/reportedit.do',
         onSubmit:function(){
        
         },
         success:function(data){
           $('#reportedit').window('close');
           var data = JSON.parse(data);
           if(data.success){
            datagrid.datagrid('load');
            datagrid.datagrid('unselectAll');
            $('#proid').combobox('reload');
            $.messager.alert('提示',data.msg,"info");
    
           }else{
            $.messager.alert('提示',data.msg,"info");
           }
         }
      })
   }
 </script>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>

<script type="text/javascript" charset="utf-8">

$(function(){
	var toolbar = [{
			text:'增加',
			iconCls:'icon-newadd',
			handler:function()
			{
			    $("#windowflagflag").val('1');				
				$("#servertypeid").textbox('setValue','');
				$("#servertypename").textbox('setValue','');
				$("#serverlevel").combobox('setValue','');
				$("#unit").textbox('setValue','');				
			    $("#pid").textbox('setValue','');			   
			    $("#snote").textbox('setValue','');			    
			    			 	
				$('#appproductedit').window('open');
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
				 	ids+=object.servertypeid+",";
   				 });
   			 
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/product/appProductDel.do',
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
			   	$("#windowflagflag").val('2');
			   	$("#servertypeid").textbox('setValue',rows[0].servertypeid);
				$("#servertypename").textbox('setValue',rows[0].servertypename);
				$("#serverlevel").combobox('setValue',rows[0].serverlevel);
				$("#unit").textbox('setValue',rows[0].unit);				
			    $("#pid").textbox('setValue',rows[0].pid);			   
			    $("#snote").textbox('setValue',rows[0].snote);	
			    		
				$('#appproductedit').window('open');
				
			}
		}]; 
	
	searchForm = $('#promgr_searchform').form();
 	
	datagrid = $('#datagrid_promg').datagrid({
		url:'${ctx}/product/appProductQuery.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],		
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'servertypeid',
		sortName:'servertypeid',
		sortOrder:'asc',
		toolbar:toolbar,
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'服务类型编码',
			field:'servertypeid',
			width:30,
			sortable:true
		},
		{
			title:'服务类型名称',
			field:'servertypename',
			width:30,
			align:'center'
		},{
			title:'服务等级',
			field:'serverlevel',
			width:30,
			hidden:true,
			align:'center'
		},
		{
		   title:'计量单位',
		   field:'unit',
		   width:30,
		   align:'center'
		},
		{
			title:'父等级编码',
			field:'pid',
			width:30,
		    align:'center'
		},{
			title:'备注',
			field:'snote',
			width:30,
			align:'center'
		}]],
		onLoadSuccess: function (data) {
		      var pageopt = $('#datagrid_promg').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#datagrid_promg').datagrid("getRows").length;
		      if (_pageSize >= 10) {
		         for(i=10;i>_rows;i--){
		            //添加一个新数据行，其中{} 中的delflg 为最后一列 的列名 如下图说明
		            $(this).datagrid('appendRow', {delflg:''  });
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
					  服务名称：<input id="unitsearchname" style="width:200px;height: 30px; "  name="servertypename" class="easyui-textbox" /> 
				 
          
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
	
	<div id="appproductedit" class="easyui-window" title="服务产品" data-options="iconCls:'icon-update',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:650px;height:250px;">
        <form action="" method="post" id="unitform">
         <input id="windowflagflag" name="flag" type="hidden" value="0" />
        <div data-options="region:'center'" style="padding:10px;">        
        <fieldset>
			<legend>服务产品信息</legend>					
			<div style="margin: 10px 25px;width:550px;" >
				<span>服务类型编码：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="servertypeid" id="servertypeid" style="width: 170px ;height: 25px;" >
				</span>&nbsp;&nbsp;&nbsp; 
				<span>服务类型名称：
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="servertypename" id="servertypename" style="width: 170px ;height: 25px;" >
				</span>	  
		    </div>
		    
		    <div style="margin: 10px 25px;width:550px;" >
				&nbsp;&nbsp;&nbsp;<span>服务等级：&nbsp;&nbsp;&nbsp;
					<select class="easyui-combobox" name="serverlevel" id="serverlevel" data-options="prompt:'---请选择服务等级---'" style="width: 170px;height: 25px;">
						<option value=""></option>
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
					</select>					
				</span>&nbsp;&nbsp;&nbsp; 
				&nbsp;&nbsp;&nbsp;<span>计量单位：&nbsp;&nbsp;&nbsp;
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="unit" id="unit" style="width: 170px ;height: 25px;"  >
				</span>	  
		    </div>
		    				    					     	
		    <div style="margin: 10px 25px;width:550px;">
		    	<span>父等级编码：&nbsp;&nbsp;&nbsp;
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="pid" id="pid" style="width: 170px ;height: 25px;"  >
				</span>&nbsp;&nbsp;&nbsp; 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>备注：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="easyui-textbox" data-options="validType:'isBlank'" name="snote" id="snote" style="width: 170px ;height: 25px;"  >
				</span>
				
			</div>
		  				    	    					    				    
		</fieldset>
		</div>        	
		   					  
	 	<div data-options="region:'south',border:false" style="text-align:center;padding:10px 0 0;">
           <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="unitedit()" style="width:80px">确定</a>&nbsp;&nbsp;&nbsp;
           <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#appproductedit').dialog('close')" style="width:80px">取消</a>
        </div>
		</form>
	  </div>
</div>
<script type="text/javascript" charset="utf-8">

function unitedit(){
 
      $('#unitform').form('submit',{
      
         url:'${ctx}/product/appProductEdit.do',
         
         onSubmit:function(){
        
         },
         success:function(data){
           $('#appproductedit').window('close');
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
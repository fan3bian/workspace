<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<style type="text/css">
  .detail-line{
    margin: 10px 25px;
  }
</style>
<script type="text/javascript" charset="utf-8">
var flagck = 0;  //  初始化为0
$(function(){
	var toolbar = [{
			text:'增加',
			iconCls:'icon-newadd',
			handler:function()
			{
			    var myDate = new Date();
			 
			     
				    $("#n_getpid").val('');
					$("#n_proname").textbox('setValue','');
					 
					$("#n_contactmail").textbox('setValue','');
				     
					$("#n_contacttel").textbox('setValue','');
					$("#n_contacters").textbox('setValue','');
				    $("#n_snote").textbox('setValue','');
			 	    $('#n_prodate').datebox('setValue', myDate.toLocaleDateString());
			        $('#n_proedit').window('open');
			    
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
				if(rows[0].proid){					
					var ids = "";
					 $.each(rows,function(index,object){
					 	ids+=object.proid+",";
	   				 });
	   			    if(!canBeCancel(ids)){
				     
				     $.messager.alert('警告',"该项目已使用，不可删除！","warning");
				     return;
				   }
	   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
	   				  if (r){ 
	   				  	$.ajax({
	   				  		type : 'post',
	   				  		url:'${ctx}/project/projectDel.do',
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
				if(rows[0].proid){		
				   if(!canBeCancel(rows[0].proid)){
				         $.messager.alert('警告',"该项目已使用，不可再修改！","warning");
				     return;
				   }
				
				    $("#n_getpid").val(rows[0].proid);
					$("#n_proname").textbox('setValue',rows[0].proname);
					$('#n_prodate').datebox('setValue', rows[0].prodate);
				 
					$("#n_unitid").combobox('select',rows[0].unitid);
					
					$("#n_contactmail").textbox('setValue',rows[0].contactmail);
					$("#n_contacttel").textbox('setValue',rows[0].contacttel);
					$("#n_contacters").textbox('setValue',rows[0].contacters);
				    $("#n_snote").textbox('setValue',rows[0].snote);
				      $('#n_proedit').window('open');
				   }
				 
				
			}
		}]; 
		
	canBeCancel = function(proid){
	  var flag;
	    $.ajax({
		  		type : 'post',
		  		url:'${ctx}/project/canBeCancel.do',
		  		data:{
		  		  proid:proid
		  		},
		  		async: false,
		  		success:function(data){
		  		   var data = JSON.parse(data);
		  		   flag = data.success;
		  		}
		  	}); 
   		return flag;
	}
	searchForm = $('#promgr_searchform').form();
 	
	datagrid = $('#datagrid_promg').datagrid({
		url:'${ctx}/project/projectQuery.do',
		pagination:true,
		pageSize:10,
		pageList:[10,20,30,40,50],
		/* fit:true, */		
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'proid',
		sortName:'ctime',
		sortOrder:'desc',
		toolbar:toolbar,
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'ID',
			field:'proid',
			width:100,
			hidden:true,
			sortable:true
		},
		{
			title:'项目代码',
			field:'procode',
			width:100,
			align:'center',
			hidden:true
		},{
			title:'项目名称',
			field:'proname',
			width:100,
			align:'center'
		},
		{
			title:'联系人',
			field:'contacters',
			width:100,
			align:'center'
		},
		{
		   title:'单位',
		   field:'unitid',
		  	hidden:true,
		   width:100,
		   align:'center'
		},
		{
		   title:'单位',
		   field:'unitname',
		  	hidden:true,
		   width:100,
		   align:'center'
		},
		{
			title:'立项时间',
			field:'prodate',
			width:100,
		    align:'center'
		},{
			title:'创建时间',
			field:'ctime',
			width:100,
			align:'center',
			sortable:true
		},
		
		{
			title:'联系人电话',
			field:'contacttel',
			width:100,
			align:'center'
		},
		{
			title:'联系邮箱',
			field:'contactmail',
			width:100,
			align:'center'
		},{
			title:'备注',
			field:'snote',
			width:100,
			hidden:true,
		},{
			title:'创建人',
			field:'cusername',
			width:100,
			hidden:true,
			align:'center' 
		},
		{
			title:'ishelp',
			field:'ishelp',
			width:100,
			hidden:true,
			align:'center' 
		},{
			title:'是否可用',
			field:'isvalid',
			width:100,
		    hidden:true,
		}]],
		onLoadSuccess: function (data) {
		      var pageopt = $('#datagrid_promg').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#datagrid_promg').datagrid("getRows").length;
		      var total = pageopt.total; //显示的查询的总数
		      if (_pageSize >= 10) {
					for(i=10;i>_rows;i--){
						//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
						$(this).datagrid('appendRow', {procode:''  })
					}
					$('#datagrid_promg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
						if(val.procode==''){ 
							//addid为datagrid上一层的div id
							$('#addid  input:checkbox').eq(idx+1).css("display","none");
							 
						}
					}); 
		        }
		        
		 },
		//没数据的行不能被点击选中
			onClickRow: function (rowIndex, rowData) {
				if(rowData.procode==''){
					 $('#datagrid_promg').datagrid('unselectRow', rowIndex);
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
						if(val.procode==''){
							//如果是空行，不能被选中
							$("#datagrid_promg").datagrid('uncheckRow', idx);
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

});

  
</script>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
		<form id="promgr_searchform">
			<table>
				<tr>
						<td>
					  单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：<input id="unitid" style="width:200px;height: 30px; "  name="unitid" class="easyui-combobox" data-options=" 
				 valueField: 'unitId',    
                 textField: 'unitName',  
        
                 url: '${ctx}/project/getUnits.do',    
                 onSelect: function(rec){    
                 var url = '${ctx}/project/getProjects.do?unitid='+rec.unitId;    
                 
                 $('#proid').combobox({    
                    url:url,    
                    valueField:'proid',    
                    textField:'proname',  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项
                    var data = $('#proid').combobox('getData');
                  if (data.length > 0) {
                 $('#proid').combobox('select', data[0].proid);
             } 
           }   
   });
              },
               onLoadSuccess: function () { //加载完成后,设置选中第一项
              var data = $('#unitid').combobox('getData');
             if (data.length > 0) {
                 $('#unitid').combobox('select', data[0].unitId);
             } 
            } 
        ">
					</td>
					<td style="margin-left: 10px">
					&nbsp;&nbsp; 项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目：<input class="easyui-combobox" data-options="valueField:'proid',textField:'proname'"   id="proid" style="width: 200px;height: 30px; "  name="proid">
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
		<table id="datagrid_promg" style="background:#eee;width:100%;"></table>
	</div>
	
	  <!-- 项目 -->
	  	<div id="n_proedit" class="easyui-window" title="项目编辑" data-options="iconCls:'icon-update',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:430px;height:480px;">
        <form action="" method="post" id="n_proform">
        <div data-options="region:'center'" style="padding:10px;">
		     
			<div class="detail-line" >
				<span>项目名称：<input class="easyui-textbox" data-options="required:'ture',validType:['nameInput','maxLength[256]'],prompt:'项目名称',missingMessage:'项目名称必填'"  id="n_proname" style="width: 250px ;height: 30px;"  name="proname">
				</span> 	  
		    </div>
		  
       	   <div class="detail-line" >
		     <span id="n_unitidname"> 单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：<input id="n_unitid" style="width:250px;height: 30px; "  name="unitid" class="easyui-combobox" data-options=" 
				 valueField: 'unitId',    
                 textField: 'unitName',      
                 url: '${ctx}/project/getUnits.do',    
                 loadFilter:function(data){
						return data;
				},
               onLoadSuccess: function () { //加载完成后,设置选中第一项
              var data = $('#n_unitid').combobox('getData');
                 
               if (data.length > 0) {
                 $('#n_unitid').combobox('select', data[0].unitId);
             } 
            } 
        "></span>
         </div>
		    <div class="detail-line" >
				<span>立项时间：<input class="easyui-datebox" data-options="required:'ture',validType:'isBlank',showSeconds:false,panelWidth:250"  id="n_prodate" style="width: 250px ;height: 30px;"  name="prodate">
				</span> 	  
		    </div>
		     <div class="detail-line" >
				<span>联&nbsp;系&nbsp;人&nbsp;：<input class="easyui-textbox" data-options="required:'ture',validType:['nameInput','maxLength[32]'],showSeconds:false,panelWidth:250,missingMessage:'联系人必填'"  id="n_contacters" style="width: 250px ;height: 30px;"  name="contacters">
				</span> 	  
		    </div>
		     <div class="detail-line" >
				<span>联系电话：<input class="easyui-textbox" data-options="required:'ture',validType:'mobileAndTel',showSeconds:false,panelWidth:250,missingMessage:'联系人电话必填'"  id="n_contacttel" style="width: 250px ;height: 30px;"  name="contacttel">
				</span> 	  
		    </div>
		     <div class="detail-line" >
				<span>联系邮箱：<input class="easyui-textbox" data-options="validType:'email'"  id="n_contactmail" style="width: 250px ;height: 30px;"  name="contactmail">
				</span> 	  
		    </div>
		    <div class="detail-line" >
				<span>项目备注：<input class="easyui-textbox" data-options="validType:'maxLength[200]',prompt:'不得超过200字',multiline:true"  id="n_snote" style="width: 250px ;height: 90px;"  name="snote">
				</span> 	  
		    </div>
			<input type="hidden" name="proid" id="n_getpid"> 
			  
			 <div data-options="region:'south',border:false" style="text-align:center;padding:10px 0 0;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="projecteditNew()" style="width:80px">确定</a>&nbsp;&nbsp;&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#n_proedit').dialog('close')" style="width:80px">取消</a>
            </div>
		</form>
	  </div>
</div>
<script type="text/javascript" charset="utf-8">
   hasSameName = function(){
      var valueName = '';
      var proid ='';
      var unitid='';
      
      valueName = $("#n_proname").textbox('getValue');
      proid = $("#n_getpid").val();
      unitid = $("#n_unitid").combobox('getValue');
       
       
       var flag;
          $.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/project/isSame.do',
   				  		data:{
   				  		  value:valueName,
   				  		  proid:proid,
   				  		  unitid:unitid
   				  		},
   				  		async: false,
   				  		success:function(data){
   				  		   var data = JSON.parse(data);
   				  		   flag = data.success;
   				  		}
   				  	}); 
        return flag;
      }  
      

       hasSameCode = function(){
       var valueCode = '';
       var proid = '';
       var unitid ='';
       if('0'==${sessionUser.ismanage}){
	       valueCode = $("#procode").textbox('getValue');
           proid = $("#getpid").val();
          
       }
       if('1'==${sessionUser.ismanage}){
           valueCode =$("#n_procode").textbox('getValue');
           proid = $("#n_getpid").val();
           if ($('#n_ishelp').attr('checked')){
           unitid =$("#n_unitid").combobox('getValue');
           }
       }
    
       var flag;
          $.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/project/isSame.do',
   				  		data:{
   				  		  value:valueCode,
   				  		  proid:proid,
   				  		  unitid:unitid
   				  		},
   				  		async: false,
   				  		success:function(data){
   				  		   var data = JSON.parse(data);
   				  		   flag = data.success;
   				  		}
   				  	}); 
        return flag;
      }  
 
   function projecteditNew(){
     
    $('#n_proform').form('submit',{
      
         url:'${ctx}/project/projectedit.do',
         onSubmit:function(){
           var flag = $(this).form('validate');
          
           if(!flag){
            return flag;  
           }
         /*  if(!hasSameCode()){
              $.messager.alert('提示',"项目代码不能重复","info"); 
              return hasSameCode();
           } */
           if(!hasSameName()){
            $.messager.alert('提示',"项目名称不能重复","info"); 
             return hasSameName();
           }  
           return true;
         },
         queryParams:{n_unitid:$("#n_unitid").combobox('getValue'),n_unitname:$("#n_unitid").combobox('getText')},
         success:function(data){
           $('#n_proedit').window('close');
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
      });
   }
 </script>
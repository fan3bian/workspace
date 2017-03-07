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
	  
	searchForm = $('#promgr_searchform').form();
 	
	datagrid = $('#datagrid_promg').datagrid({
		url:'${ctx}/resourceinfo/getOperateResource.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		/* fit:true, */		
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'neid',
		sortName:'testtime',
		sortOrder:'desc',
        singleSelect:true,
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		onLoadSuccess:function(data){
			var pageopt = $('#datagrid_promg').datagrid('getPager').data("pagination").options;
			var  _pageSize = pageopt.pageSize;
			var  _rows = $('#datagrid_promg').datagrid("getRows").length;
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for(i=10;i>_rows;i--){
					//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
					$(this).datagrid('appendRow', {feestat:''  })
				}
				$('#datagrid_promg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
					if(val.neid==''){
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
		},
		columns:[[ 
		{
			title:'项目代码',
			field:'projectid',
			width:100,
			align:'center',
			 hidden:true,
		},{
			title:'项目名称',
			field:'projectname',
			width:100,
			align:'center'
		},
		{
		   title:'单位id',
		   field:'unitid',
		   width:100,
		   align:'center',
		   hidden:true,
		},
		{
		   title:'单位',
		   field:'unitname',
		   width:100,
		   align:'center'
		},
		{
			title:'实例名称',
			field:'neid',
			width:100,
		    align:'center',
		    
		},
		{
			title:'',
			field:'nename',
			width:100,
		    align:'center',
		    hidden:true,
		},{
			title:'服务名称',
			field:'typename',
			width:100,
			align:'center',
			/* formatter:function(value,row,index){            
			   	if (value=="VM"){
			    	return '云服务器';
			    }
			}  */
		},{
			title:'应用',
			field:'appname',
			width:100,
		    align:'center',
		},{
			title:'开通时间',
			field:'testtime',
			width:100,
			align:'center',
			sortable:true
		},{
			title:'计费时间',
			field:'usetime',
			width:100,
		     
		},{
			title:'操作',
			field:'feestat',
			width:100,
		    formatter:function(value,row,index){
		      var id = row.neid;
		      var temp ="resouceOperate"+index;
		      var  select ;
		      if(value==1){
		         select = '<select id="'+temp+'" name="resouceOperate" style="width:80px;"><option value="1" selected>试运行</option><option value="2">计费开始</option><option value="3">计费结束</option></select>'
		      }
		      if(value==2){
		        select = '<select id="'+temp+'" name="resouceOperate" style="width:80px;"><option value="1" >试运行</option><option value="2" selected>计费开始</option><option value="3">计费结束</option></select>'
		      }
		      if(value==3){
		        select = '<select id="'+temp+'" name="resouceOperate" style="width:80px;"><option value="1" >试运行</option><option value="2">计费开始</option><option value="3" selected>计费结束</option></select>'
		      }
		      var  button = "<img src='${ctx}/images/queding.png' style='position:relative;margin-left:5px;top:7px' onclick=modifyStatus("
		      +index
		      +","+"'"
		      +id
		      +"')>"; 
		      
		      if (value!=''){ 
			       return select+button;     
			   }	        
			} 
		}]]
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
                 url: '${ctx}/project/getUnitsData.do',    
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
					&nbsp;&nbsp; 项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目：<input class="easyui-combobox" data-options="valueField:'procode',textField:'proname'"   id="proid" style="width: 200px;height: 30px; "  name="proid">
					</td>
					 
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;

					</td>
				</tr>
			</table>
		</form>
	</div>

	<div data-options="region:'center',border:false" style="background:#eee;margin-top: 15px" id="addid">
		<table id="datagrid_promg" style="background:#eee;width:100%;"></table>
	</div>
	
	 
</div>
<script type="text/javascript" charset="utf-8">
 var befoStatus;
 $(function(){
 
    modifyStatus = function(index,neid){
     var resouceOperate  = "resouceOperate"+index;
   
     var nodeOfOper = document.getElementById(resouceOperate);
     var b = $(nodeOfOper).val();
     getStatus(neid);
     /* if(b==0 || befoStatus==b || b<befoStatus ){
        $.messager.alert('提示',"不可逆向操作！","info");
       $('#datagrid_promg').datagrid('reload');
       return;
     } */
      $.ajax({
   				  type : 'post',
   				  url:'${ctx}/resourceinfo/changeStatus.do',
   				  data:{
   				  	 neid:neid,
   				  	 status:b
   				  	},
   				  async: false,
   				  success:function(result){
   				  	 var data = JSON.parse(result);	 
   				     $.messager.alert('提示',data.msg,"info");
   				     $('#datagrid_promg').datagrid('reload');
   				     
   				  }
   			}); 
    }
    //获取之前的状态
    getStatus = function(obid){
      
        $.ajax({
   				  type : 'post',
   				  url:'${ctx}/resourceinfo/getbefoStatus.do',
   				  data:{
   				  	 neid:obid
   				  	},
   				  async: false,
   				  success:function(result){
   				  	 var data = JSON.parse(result);	 
   				     befoStatus = data.msg; 
   				  }
   			});
    }
 
 })
 
 </script>
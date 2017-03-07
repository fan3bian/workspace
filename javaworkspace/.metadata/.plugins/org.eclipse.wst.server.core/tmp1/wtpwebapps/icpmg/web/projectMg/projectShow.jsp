<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<script type="text/javascript" charset="utf-8">
$(function(){
	searchForm = $('#promgr_searchform').form();
	
	var status_data = [{"value":"0","text":"首次提交"},{"value":"1","text":"未处理"},{"value":"2","text":"已审批"},{"value":"3","text":"生产中"},{"value":"4","text":"试运行"},{"value":"5","text":"运行中"},{"value":"6","text":"停止服务"}];
	
	datagrid = $('#datagrid_pro').datagrid({
		url:'${ctx}/project/projectsearch.do',
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		/* fit:true, */		
		fitColumns:true,
		nowarp:false,
		border:false,
		scrollbarSize:0,
		idField:'orderid',
		sortName:'otime',
		sortOrder:'asc',
		frozenColumns:[[ 
			{field:'ck',checkbox:true} 
		]],
		columns:[[{
			title:'订单',
			field:'orderid',
			width:100,
			hidden:true,
			sortable:true
		},
		{
			title:'项目名',
			field:'proname',
			width:100,
			align:'center'
		},{
			title:'标题',
			field:'protitle',
			width:100,
		},
		{
		   title:'单位',
		   field:'department',
		   width:100,
		   align:'center'
		},
		{
			title:'提交时间',
			field:'otime',
			width:100,
		 
		},{
			title:'正式申请',
			field:'ptime',
			width:100
		},{
			title:'开通时间',
			field:'rstime',
			width:100
		},{
			title:'计费时间',
			field:'stime',
			width:100,
			 
		},{
			title:'结束时间',
			field:'etime',
			width:100,
		 
		},{
			title:'状态',
			field:'ostatus',
			width:100,
			align:'center',
			formatter:function(value,row,index){
			    for(var i = 0; i < status_data.length; i++){
			        if (status_data[i].value == value){
			            return status_data[i].text;
			        }
			    }
			},
            styler: function(value, row, index){
                if (value == "1") {
                 return 'background-color:#999;color:#fff';
               }
                 if (value == "2") {
                 return 'background-color:#66CC00;color:#fff';
               }
                 if (value == "3") {
                 return 'background-color:#FF9900;color:#fff';
               }
                 if (value == "0") {
                 return 'background-color:#CCC; color:#fff';
               }
                 if (value == "4") {
                 return 'background-color:#FFFF00;color:#666';
               }
                 if (value == "5") {
                 return 'background-color:#00BB00;color:#fff';
               }
                 if (value == "6") {
                 return 'background-color:#FF2D2D;color:#fff';
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
			 
		}]],
		onLoadSuccess: function (data) {
		      var pageopt = $('#datagrid_pro').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#datagrid_pro').datagrid("getRows").length
		      if (_pageSize >= 10) {
		         for(i=10;i>_rows;i--){
		            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
		            $(this).datagrid('appendRow', {operation:''  })
		         }
		         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
		      }else{
		         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
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
	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false;margin-bottom: 10px;">
		<form id="promgr_searchform">
			<table>
				<tr>
					<td>项目名：<input class="easyui-textbox" name="proname" style="width:110px;height:28px;border:false"></td>
					<td>&nbsp;状态：<select class="easyui-combobox" name="ostatus" data-options="panelHeight:'auto',required:true,editable:false" style="width:100px;height:28px;border:false">
						<option value="7">全部</option>
						<option value="0">首次提交</option>
						<option value="1">未处理</option>
						<option value="2">已审批</option>
						<option value="3">生产中</option>
						<option value="4">试运行</option>
						<option value="5">运行中</option>
						<option value="6">停止服务</option>
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
	
	<div data-options="region:'center',border:false" style="background:#eee;">
		<table id="datagrid_pro" style="background:#eee;width:100%;"></table>
	</div>
</div>

 
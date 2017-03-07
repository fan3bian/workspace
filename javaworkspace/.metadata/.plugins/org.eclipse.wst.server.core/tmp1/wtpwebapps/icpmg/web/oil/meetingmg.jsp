<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>	
<body >
  	<script type="text/javascript">
  		/**  
 * 扩展两个方法  
 */  
$.extend($.fn.datagrid.methods, {   
    /**
     * 开打提示功能  
     * @param {} jq  
     * @param {} params 提示消息框的样式  
     * @return {}  
     */  
    doCellTip : function(jq, params) {   
        function showTip(data, td, e) {   
            if ($(td).text() == "")   
                return;   
            data.tooltip.text($(td).text()).css({   
                        top : (e.pageY + 10) + 'px',   
                        left : (e.pageX + 20) + 'px',   
                        'z-index' : $.fn.window.defaults.zIndex,   
                        display : 'block'   
                    });   
        };   
        return jq.each(function() {   
            var grid = $(this);   
            var options = $(this).data('datagrid');   
            if (!options.tooltip) {   
                var panel = grid.datagrid('getPanel').panel('panel');   
                var defaultCls = {   
                    'border' : '1px solid #333',   
                    'padding' : '1px',   
                    'color' : '#333',   
                    'background' : '#f7f5d1',   
                    'position' : 'absolute',   
                    'max-width' : '200px',   
                    'border-radius' : '4px',   
                    '-moz-border-radius' : '4px',   
                    '-webkit-border-radius' : '4px',   
                    'display' : 'none'   
                }   
                var tooltip = $("<div id='celltip'></div>").appendTo('body');   
                tooltip.css($.extend({}, defaultCls, params.cls));   
                options.tooltip = tooltip;   
                panel.find('.datagrid-body').each(function() {   
                    var delegateEle = $(this).find('> div.datagrid-body-inner').length   
                            ? $(this).find('> div.datagrid-body-inner')[0]   
                            : this;   
                    $(delegateEle).undelegate('td', 'mouseover').undelegate(   
                            'td', 'mouseout').undelegate('td', 'mousemove')   
                            .delegate('td', {   
                                'mouseover' : function(e) {   
                                    if (params.delay) {   
                                        if (options.tipDelayTime)   
                                            clearTimeout(options.tipDelayTime);   
                                        var that = this;   
                                        options.tipDelayTime = setTimeout(   
                                                function() {   
                                                    showTip(options, that, e);   
                                                }, params.delay);   
                                    } else {   
                                        showTip(options, this, e);   
                                    }   
  
                                },   
                                'mouseout' : function(e) {   
                                    if (options.tipDelayTime)   
                                        clearTimeout(options.tipDelayTime);   
                                    options.tooltip.css({   
                                                'display' : 'none'   
                                            });   
                                },   
                                'mousemove' : function(e) {   
                                    var that = this;   
                                    if (options.tipDelayTime) {   
                                        clearTimeout(options.tipDelayTime);   
                                        options.tipDelayTime = setTimeout(   
                                                function() {   
                                                    showTip(options, that, e);   
                                                }, params.delay);   
                                    } else {   
                                        showTip(options, that, e);   
                                    }   
                                }   
                            });   
                });   
  
            }   
  
        });   
    },   
     /**
     * 关闭消息提示功能  
     * @param {} jq  
     * @return {}  
     */  
    cancelCellTip : function(jq) {   
        return jq.each(function() {   
                    var data = $(this).data('datagrid');   
                    if (data.tooltip) {   
                        data.tooltip.remove();   
                        data.tooltip = null;   
                        var panel = $(this).datagrid('getPanel').panel('panel');   
                        panel.find('.datagrid-body').undelegate('td',   
                                'mouseover').undelegate('td', 'mouseout')   
                                .undelegate('td', 'mousemove')   
                    }   
                    if (data.tipDelayTime) {   
                        clearTimeout(data.tipDelayTime);   
                        data.tipDelayTime = null;   
                    }   
                });   
    }   
});  
  		var editor;
  		var grid;
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
			{ 	
			var dialog = parent.icp.modalDialog({
			title : '添加会议纪要',
			url : '${pageContext.request.contextPath}/'+'web/oil/meetingForm.jsp',
			buttons : [{
			text : '添加',
			iconCls:'icon-ok',
			handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
				dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
			}
			},{
			text : '取消',
			iconCls:'icon-cancel',
			handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
				dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
			}
			} ]
			});
			
			}
		},{
			text:'删除',
			iconCls:'icon-remove',
			handler:function()
			{
				var rows = $('#grid').datagrid('getChecked');
				if(rows.length<1)
				{
					$.messager.alert('消息','请至少选择一条记录！'); 
					return; 
				}
				var meetingid = "";
				 $.each(rows,function(index,object){
				 	meetingid+=object.meetingid+",";
   				 });
   				 $.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/oil/meetingsDel.do',
   				  		data:{lessionids:meetingid},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#grid').datagrid('unselectAll');
					    		$('#grid').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
					    		
					    	} 
   				  		}
   				  	});
   				  }
   				 });
			}
		},{
			text:'修改',
			iconCls:'icon-modify',
			handler:function()
			{
				var rows = $('#grid').datagrid('getSelections');
				if(rows.length==1)
				{
				var dialog = parent.icp.modalDialog({
				title : '修改会议纪要',
				url : '${pageContext.request.contextPath}/'+'web/oil/meetingForm.jsp?meetingid=' + rows[0].meetingid,
				buttons : [{
					text : '修改',
					iconCls:'icon-ok',
					handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
					},{
					text : '取消',
					iconCls:'icon-cancel',
					handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
						dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
					}
					} ]
				});
					//add(rows[0].newsid);
				}else {
					$.messager.alert('提示', '请选择一条记录！', 'error');
					return; 
				}
				
			}
		}];
		
		$(document).ready(function() {
			
			loadDataGrid();
			
		});
		function loadDataGrid()
			{
				grid = $('#grid').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					scrollbarSize:0,
					sortName:'mtimg',
					sortOrder:'desc',
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					nowarp:true,
					idField:'meetingid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/oil/meetingsList.do',
				    onLoadSuccess:function(data){   
    $(this).datagrid('doCellTip',{delay:500});      
}   
					}); 
				
			}
			
		function searchDataGrid(){
			$('#grid').datagrid('load',icp.serializeObject($('#ordercofig_searchform')));
		};
		 
		function fileformater(value,row,index)
		 {
		 
			return "<a target='_blank' href=\""+'${pageContext.request.contextPath}' + row.url + "\" >下载</a>";
		 }
		 function validformater(value,row,index)
		 {
		 
			switch (value) {
							case 1:
								return "<span style=\"color:green\">有效</span>";
							 
							case 0:
								return "<span style=\"color:red\">无效</span>";
							}
		 }
		
</script>
 <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
 	<div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
			<form id="ordercofig_searchform">
				<table >
					<tr>
						<td>会议主题：<input class="easyui-textbox" name="meetingnames"  id="meetingnames" style="width:160px;height:30px;border:false"></td>
						<td>&nbsp;&nbsp;会议时间：<input class="easyui-datebox" editable="false" name="mtimgs" id="mtimgs" style="width:130px;height:30px;border:false">
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#ordercofig_searchform input').val('');$('#mtimgs').datebox('setValue', '');$('#meetingnames').textbox('clear');$('#grid').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
		<table title="" style="width:100%;"  id="grid">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'meetingid',width:100,hidden:true,halign:'center'">编码</th>
				<th data-options="field:'meetingname',width:130,halign:'center'">会议主题</th>
				<th data-options="field:'mtimg',width:100,halign:'center',sortable:true">会议时间</th>
				<th data-options="field:'persons',width:210,halign:'center'">参加人员</th>
				<th data-options="field:'content',width:210,halign:'center'">会议内容</th>
				<th data-options="field:'iprojects',width:130,halign:'center'">备注</th>
				<th data-options="field:'ctime',width:80,hidden:true,halign:'center'">创建时间</th>
			    <th data-options="field:'userid',width:70,hidden:true,halign:'center'">创建人id</th>
				<th data-options="field:'username',width:80,hidden:true,halign:'center'">创建人</th>
				<th data-options="field:'delflg',width:80,align:'center',formatter:validformater">是否有效</th>
				<th data-options="field:'url',width:50,align:'center',formatter:fileformater">附件</th>
			</tr>
		 </thead>
  	 </table>
 	 </div>  
	</div>
</body>


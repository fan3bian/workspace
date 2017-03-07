<%@ page contentType="text/html; charset=utf-8" import="java.util.*"
	language="java"%>
<body>
	<div id="tabs" class="easyui-tabs" style="width:100%;background:#eee" data-options="tabWidth:112, border:false,fit:true" >
	<div id="tabs-1" title="公告信息" data-options="selected:true,fit:true" style="padding:10px;background:#eee" >
		<script type="text/javascript">
		
		var flagck = 0;
		
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
  		var gridLession;
		var toolbar = [{
		    text:'生成HTML',
		    iconCls:'icon-html',
			handler:function()
			{
			   $.messager.confirm('确认','您确认想要生成HTML？如果有原文件将被覆盖',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/toNoticeHtml.do',
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg').datagrid('unselectAll');
					    		$('#dg').datagrid('reload',icp.serializeObject($('#ordercofig_searchform')));
					    		
					    	} 
   				  		}
   				  	});
   				  }
   				 });
			
			}
		}];
		
		$(document).ready(function() {
			
			loadDataGrid();
			
		});
		function loadDataGrid()
			{
			   gridLession=$('#dg').datagrid({
					rownumbers:false,
					border:false,
				    autoRowHeight:false,
					striped:true,
					scrollbarSize:0,
					sortName:'titleid',
					sortOrder:'desc',
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'titleid',
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/content/noticeList.do',
				      onLoadSuccess:function(data){   
    $(this).datagrid('doCellTip',{delay:500}); 
    var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#dg').datagrid("getRows").length;
				       var total = pageopt.total; //显示的查询的总数
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {htmlflg:''  });
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
													if   (val.htmlflg==''&&val.htmlflg!='0'){  
														$('#noteid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
				      
				      
				 },
				 
				 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.htmlflg==''&&rowData.htmlflg!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#noteid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.htmlflg==''&&val.htmlflg!='0'){
									$("#dg").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#noteid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
					
					}); 
				
			}
			
		function searchLessionDataGrid(){
			$('#dg').datagrid('load',icp.serializeObject($('#ordercofig_searchform')));
		};
		var viewDetail = function(id) {//生成单页公告跳转
		
		$('#centerTab').panel({
		href:"${pageContext.request.contextPath}/content/noticeMake.do?transferid=" + id
		});
	};
		 	//弹框查看
		function operformater(value, row, index) {
			switch (value) {
							case 1:
								return "<span style=\"color:blue\">已生成</span>";
							 
							case 0:
								return icp.formatString('<a style=\"color:red;cursor:pointer\" onclick=\"viewDetail(\'{0}\');\">生成公告</a>', row.titleid);
							}
				
		}
		
		
	</script>
 <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
 	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;">
			<form id="ordercofig_searchform">
				<table >
					<tr>
						<td>标题：<input class="easyui-textbox" name="searchtitle"  id="searchtitle" style="width:160px;height:30px;border:false"></td>
							<td>&nbsp;&nbsp;状态：<select class="easyui-combobox" name="lesstatus" id="lesstatus" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px;height:30px;">
								<option value="3" selected>全部</option>
								<option value="0">待生成</option>
								<option value="1">已生成</option>
								</select>
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchLessionDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#ordercofig_searchform input').val('');$('#searchtitle').textbox('clear');$('#lesstatus').combobox('select','3');$('#dg').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="noteid">
		<table title="" style="width:100%;"  id="dg">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'titleid',width:60,align:'center',sortable:true">公告编码</th>
				<th data-options="field:'title',width:120,halign:'center'">公告标题</th>
				<th data-options="field:'content',width:180,halign:'center'">内容</th>
				<th data-options="field:'cuser',width:40,align:'center'">发布人</th>
				<th data-options="field:'sendrole',width:80,halign:'center',hidden:true">发布单位</th>
				<th data-options="field:'ctime',width:60,align:'center',sortable:true">发布时间</th>
				<th data-options="field:'filepath',width:100,halign:'center',hidden:true">附件地址</th>
				<th data-options="field:'isvalid',width:60,align:'center',hidden:true">删除位</th>
			    <th data-options="field:'htmlflg',width:60,align:'center',formatter:operformater">操作</th>
			</tr>
	 </thead>
  </table>
 </div>  
</div>
		
	</div>
	<div id="tabs-2" title="标准规范"  style="padding:10px;background:#eee">
      <script type="text/javascript">
      	
      	var flagck = 0;  //  初始化为0
      	
  	    var editor;
  		var gridqa;
		var toolbar = [{
		    text:'生成HTML',
		    iconCls:'icon-html',
			handler:function()
			{
			   $.messager.confirm('确认','您确认想要生成HTML？如果有原文件将被覆盖',function(r){   
   				  if (r){ 
   				  	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/content/toDocsHtml.do',
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			$.messager.alert('消息',data.msg);  
				  			if(data.success)
					    	{
					    		$('#dg_qa').datagrid('unselectAll');
					    		$('#dg_qa').datagrid('reload',icp.serializeObject($('#qacofig_searchform')));
					    		
					    	} 
   				  		}
   				  	});
   				  }
   				 });
			
			}
		}];
		
		$(document).ready(function() {
			
			loadQaDataGrid();
			
		});
		function loadQaDataGrid()
			{
			 gridqa=$('#dg_qa').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					scrollbarSize:0,
					sortName:'ctime',
					sortOrder:'desc',
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					idField:'fileid',
					autoRowHeight:false,
					nowrap:true,
					pagination:true,
					pageSize:10,
					pageList:[5,10,20,30,40,50],
					toolbar:toolbar,    
				    url:'${pageContext.request.contextPath}/content/docsList.do',
				    onLoadSuccess: function (data) {
				      var pageopt = $('#dg_qa').datagrid('getPager').data("pagination").options;
				      var  _pageSize = pageopt.pageSize;
				      var  _rows = $('#dg_qa').datagrid("getRows").length;
				       var total = pageopt.total; //显示的查询的总数				      
				      if (_pageSize >= 10) {
				         for(i=10;i>_rows;i--){
				            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
				            $(this).datagrid('appendRow', {status:''  });
				         }
				         $('#dg_qa').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
													if   (val.status==''&&val.status!='0'){  
														$('#filewordid  input:checkbox').eq(idx+1).css("display","none");
														 
													}
												}); 
									      }
				      
				      
				 },
				 
				 //没数据的行不能被点击选中
					 onClickRow: function (rowIndex, rowData) {
					if(rowData.status==''&&rowData.status!='0'){
					 $(this).datagrid('unselectRow', rowIndex);
					}else{
					//点击有数据的行  标志位变为0
					flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
					$('#filewordid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
					}, 
					//全选问题
					onCheckAll: function(rows) {
						flagck = 1;
							$.each(rows, function (idx, val) {
								if (val.status==''&&val.status!='0'){
									$("#dg_qa").datagrid('uncheckRow', idx);
									//增加全选复选框被选中
									$('#filewordid div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
								}
							});
					},
									
					onUncheckAll: function(rows) {
						flagck = 0;
					}  
				    
					}); 
				
			}
			
		function searchQaDataGrid(){
			$('#dg_qa').datagrid('load',icp.serializeObject($('#qacofig_searchform')));
		};

		 	function statusqaformater(value,row,index)
		 {
		 
			switch (value) {
							case 1:
								return "<span style=\"color:blue\">已生成</span>";
							case 0:
								return "<span style=\"color:red\">待生成</span>";
							}
		 }
		  
 
   
</script>
 <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
 	<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;">
			<form id="qacofig_searchform">
				<table >
					<tr>
						<td>标题：<input class="easyui-textbox" name="doctitle"  id="doctitle" style="width:160px;height:30px;border:false"></td>
							<td>&nbsp;&nbsp;状态：<select class="easyui-combobox" name="docstatus" id="docstatus" data-options="panelHeight:'auto',required:true,editable:false" style="width:120px;height:30px;">
								<option value="3" selected>全部</option>
								<option value="0">待生成</option>
								<option value="1">已生成</option>
								</select>
						</td>
						<td>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchQaDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="$('#qacofig_searchform input').val('');$('#doctitle').textbox('clear');$('#docstatus').combobox('select','3');$('#dg_qa').datagrid('load',{});">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false" id="filewordid">
		<table title="" style="width:100%;" id="dg_qa">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'fileid',width:100,align:'center',sortable:true">文件编码</th>
				<th data-options="field:'filename',width:210,halign:'center'">文件标题</th>
				<th data-options="field:'fileurl',width:300,halign:'center'">标准文档</th>
				<th data-options="field:'ctime',width:130,halign:'center',sortable:true">创建时间</th>
				<th data-options="field:'htmlflg',width:80,align:'center',formatter:statusqaformater">状态</th>
				<th data-options="field:'status',width:80,align:'center',hidden:true">删除位</th>				
			</tr>
	 </thead>
  </table>
 </div>  
</div>
	
	</div>
</div>
		
</body>
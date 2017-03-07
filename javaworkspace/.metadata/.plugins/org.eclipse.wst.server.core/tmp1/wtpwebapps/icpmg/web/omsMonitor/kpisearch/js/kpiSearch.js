	var transNe = {};
	var transInd = {};
   $(document).ready(function() {
		var listTypeName_url_action_path = context_path+'/pingconfig/listNeTypeName.do?';
		var listNeName_url_action_path = context_path+'/pingconfig/listNeName.do';
		var listIndName_url_action_path = context_path+'/kpisearch/getIndListByNetype.do';
		
	
		
		/**
		 * 设备类型选择,选择后从rmd_object读取对应类型的设备名称
		 */
		$('#kpisearch_netype').combobox({    
		    url:listTypeName_url_action_path,    
		    valueField:'typeid',    
		    textField:'typename',
		    onSelect:function(rec){    
		        var neurl = listNeName_url_action_path + '?typeid=' + rec.typeid;
		        var kpiurl = listIndName_url_action_path + '?typeid=' + rec.typeid;
		        
		        //生成翻译值
		        var netypeObj = $("#kpisearch_netype").combobox("getData");
		        for(var i = 0; i < netypeObj.length; i++){
		        	var netypeId = netypeObj[i].typeid;
		        	var netypeValue = netypeObj[i].typename;
		        	transNe[netypeId] = netypeValue;
		        }
		        $('#kpisearch_ne').combobox('clear');
		        $('#kpisearch_ind').combobox('clear');
		        
		        $('#kpisearch_ne').combobox('reload', encodeURI(neurl)); 
		        $('#kpisearch_ind').combobox('reload', encodeURI(kpiurl)); 
		        
		    }
		});  
		
		
		    loadDataGrid();
			$('#kpisearch_ind').combobox({onSelect:function(){
				   var indNameObj = $("#kpisearch_ind").combobox("getData");
				   for(var j = 0; j < indNameObj.length; j++){
			        	var kpiname = indNameObj[j].kpiname;
			        	var text = indNameObj[j].text;
			        	transInd[kpiname] = text;
			        }
				
			}});
		});
		function loadDataGrid()
		{
			$('#kpisearch_dg').datagrid({
				rownumbers:false,
				border:true,
				striped:true,
				sortName:'starttime',
				sortOrder:'desc',
				nowarp:false,
				singleSelect:false,
				method:'post',
				loadMsg:'数据装载中......',
				fitColumns:true,
				idField:'serverid',
				pagination:true,
				pageSize:10,
				pageList:[5,10,20,30,40,50],
				onLoadSuccess:function(data){
					 var pageopt = $('#kpisearch_dg').datagrid('getPager').data("pagination").options;
					  var  _pageSize = pageopt.pageSize;
					  var  _rows = $('#kpisearch_dg').datagrid("getRows").length;
					  if (_pageSize >= 10) {
						  for(var i=10;i>_rows;i--){
							  $(this).datagrid('appendRow', {});					  
						  }
					  }else{
						  $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					  }
				}
				
			   
				}); 
			
		}
		
		
		
		
			
		function searchDataGrid(){
			//做一些非空校验
			   if(!$("#kpisearch_searchform").form('validate')){
			    	 return false;
			     }
			   
			   
			   var typeidText = $("#kpisearch_ne").combo("getText");
			   if(!typeidText){
				   $("#kpisearch_ne").combo('reset'); 
			   }
			   
			   
			$('#kpisearch_dg').datagrid('options').url = context_path+'/kpisearch/getIndValueByCondition.do';
			$('#kpisearch_dg').datagrid('load',icp.serializeObject($('#kpisearch_searchform')));
		};
		
		
		function resetCondition(){
			$("#kpisearch_netype").combobox('clear');
			$("#kpisearch_netype").combobox('reload');
			$("#kpisearch_ne").combobox('clear');
			$("#kpisearch_ind").combobox('clear');
			$("#kpisearch_starttime_from").textbox('clear');
			$("#kpisearch_starttime_to").textbox('clear');
			  var val = $("#kpisearch_timeperiod").combobox("getData");
			$("#kpisearch_timeperiod").combobox('select',val[0].periodId);
		}
		
		
		function neTypeformater(value, row, index) {
			 return transNe[value];
						
		} 
		
		function indformater(value, row, index) {
			 return transInd[value];
						
		} 
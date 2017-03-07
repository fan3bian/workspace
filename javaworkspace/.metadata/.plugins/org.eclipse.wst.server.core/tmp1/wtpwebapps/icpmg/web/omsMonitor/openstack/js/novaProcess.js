$(function(){
	
	var platformid = 'lord';
	var os_nova_process_action = context_path + "/os_ploverview/getOSComHealth.do";
	
	
	
/****************************************************************************************************/
/**
 * 获取Nova关键进程
 */	
		
	$('#nova-process-datagrid').datagrid({
		striped:true,
		title:'Nova关键进程监控',
		url:os_nova_process_action,
		queryParams: 
			{
				platformid:platformid
			},
			showHeader:true,
			height:300,
        columns:
        	[	
        	 	[    
		            {field:'processName',title:'',width:120,align:'center'},    
		            {field:'processHealth',title:'上行包数',width:70,align:'center'},
		            {field:'txpkts',title:'下行包数',width:70,align:'center'}
	            ]
        	],
    	fitColumns:true
    	
    });  
/****************************************************************************************************/
		
	
	
});
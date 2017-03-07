(function($){

	
//	var nename = '7b363fee-4045-4371-8318-be59bdfd8520';
	var nename = osinserver_nename ;

	var osinserver_network_action = context_path + "/os_inserver_runoverview/getOSInserverNetworkIndex.do";
	
	
/****************************************************************************************************/
/**
 * 获取虚拟机网络其他关键性指标
 */	
		
	$('#osinserver-network-datagrid').datagrid({
		striped:true,
		title:'虚拟机网络指标监控',
		url:osinserver_network_action,
		pagination:true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		queryParams: 
			{
				nename:nename									
			},
			showHeader:true,
			height:400,
        columns:
        	[	
        	 	[    
		            {field:'starttime',title:'时间',width:120,align:'center'},    
		            {field:'rxerrs',title:'上行错误包数',width:85,align:'center'},
		            {field:'txerrs',title:'下行错误包数',width:85,align:'center'},
		            {field:'rxdrop',title:'上行丢包数',width:80,align:'center'},
		            {field:'txdrop',title:'下行丢包数',width:80,align:'center'},
		            {field:'rxbytes',title:'上行字节数',width:80,align:'center'},
		            {field:'txbytes',title:'下行字节数',width:80,align:'center'},
		            {field:'rxpkts',title:'上行包数',width:70,align:'center'},
		            {field:'txpkts',title:'下行包数',width:70,align:'center'}
	            ]
        	],
    	fitColumns:true
    	
    });  
/****************************************************************************************************/
	
	
})(jQuery);
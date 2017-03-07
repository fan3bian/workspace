/**
 * @auther zhangsy
 */
$(function(){
	$('#new_card').on('click',function(){
		$('#new_host_form').form('clear');
		$('#new_environ_win').window("open");
		$('#networkType').combobox({
			valueField:'value',
			textField:'text',
			url:content+'/web/osdeploy/js/networkType.json',
			panelHeight:'auto',
			editable:false
		});
	});
//	newEnviron=function(){
//		$('#centerTab').panel({
//			//href:'/icpmg/web/obsMgr/BucketMgr.jsp?bucketName=' + bucketName
//			href:'${pageContext.request.contextPath}/osdeploy/newEnviron.do'
//		});
//	};	
});
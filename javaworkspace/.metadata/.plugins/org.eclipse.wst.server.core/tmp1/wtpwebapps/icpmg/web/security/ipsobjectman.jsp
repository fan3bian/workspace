<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<body>	
<div id="ips_tabs" class="easyui-tabs" style="width:100%;" data-options="tabWidth:112,fit:true,border:false" >
	<input type="hidden" id="tabs_service_id" value="${rmdSecurityVo.serviceid}"/>
	<input type="hidden" id="tabs_security_id" value="${rmdSecurityVo.securityid}"/>
	<input type="hidden" id="tabs_displayname" value="${rmdSecurityVo.displayname}"/>
	<input type="hidden" id="tabs_manip" value="${rmdSecurityVo.manip}"/>
	<div id="tabs0" title="协议配置" data-options="fit:true,selected:true" style="padding:10px;background:#eee" >
		<jsp:include page="ips.jsp" />
	</div>
	<!-- <div id="tabs1" title="运行监控" data-options="fit:true" style="padding:10px;background:#eee;overflow:hidden;" >
		<div id="ips_alarm" style="overflow:hidden;"></div>
	</div> -->
	<div id="tabs2" title="高级配置" data-options="fit:true" style="padding:10px;background:#eee;overflow:hidden;" >
		<div id="ips_mm" style="overflow:hidden;"></div>
	</div>
</div>
<div id="mm">
	<div id="domain">安全域</div>
	<div id="netparam">全局网络参数</div>
	<div id="dnat">防护资源配置</div>
</div>	
<script type="text/javascript">
//高级配置增加下拉菜单
$(function(){
	var p = $('#ips_tabs').tabs().tabs('tabs')[1];
	var mb = p.panel('options').tab.find('a.tabs-inner');
	mb.menubutton({
		menu:'#mm'
	}).click(function(){
		$('#ips_tabs').tabs('select',1);
	});
});

$(document).ready(function() {
	$('#ips_tabs').tabs({
		border : false,
		onSelect : function(title, index) {
			/* if (index == 1) {//运行监控
				$("#ips_alarm").panel({
					href : '${pageContext.request.contextPath}/web/security/arpdomain.jsp'
				});
			} */
		}
	});
	
	//下拉菜单对应页面
	$('#mm').menu({    
	    onClick:function(item){  
	    	$("#ips_mm").panel('clear');//先清空
	        if(item.id == 'domain'){
	        	$("#ips_mm").panel({
					href : '${pageContext.request.contextPath}/web/security/domain.jsp'
				});
	        }else if(item.id == 'netparam'){
	        	$("#ips_mm").panel({
					href : '${pageContext.request.contextPath}/web/security/netparam.jsp'
				});
	        }else if(item.id == 'dnat'){
	        	$("#ips_mm").panel({
					href : '${pageContext.request.contextPath}/web/security/dnat.jsp'
				});
	        }    
	    }    
	});
}); 
</script>
</body>

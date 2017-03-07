<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<body>	
<div id="waf_tabs" class="easyui-tabs" style="width:100%;" data-options="tabWidth:112,fit:true,border:false" >
	<input type="hidden" id="tabs_security_ipsid" value="${rmdSecurityIpsVo.ipsid}"/> 
	<input type="hidden" id="tabs_security_id" value="${rmdSecurityIpsVo.securityid}"/>
	<div id="tabs0" title="防护配置" data-options="fit:true,selected:true" style="padding:10px;background:#eee" >
		<jsp:include page="waf.jsp" />
	</div>
</div>	
<!-- <div id="mm">
	<div id="domain">安全域</div>
	<div id="netparam">全局网络参数</div>
	<div id="dnat">目的NAT</div>
</div> -->
<script type="text/javascript">
//高级配置增加下拉菜单
$(function(){
	/* var p = $('#waf_tabs').tabs().tabs('tabs')[2];
	var mb = p.panel('options').tab.find('a.tabs-inner');
	mb.menubutton({
		menu:'#mm'
	}).click(function(){
		$('#waf_tabs').tabs('select',2);
	}); */
}); 


$(document).ready(function() {
	/* $('#waf_tabs').tabs({
		border : false,
		onSelect : function(title, index) {
			if (index == 1) {//攻击防护
				$("#waf_arp").panel({
					href : '${pageContext.request.contextPath}/web/security/arpdomain.jsp'
				});
			}
		}
	}); */
	
	//下拉菜单对应页面
/* 	$('#mm').menu({    
	    onClick:function(item){  
	    	$("#waf_mm").panel('clear');//先清空
	        if(item.id == 'domain'){
	        	$("#waf_mm").panel({
					href : '${pageContext.request.contextPath}/web/security/domain.jsp'
				});
	        }else if(item.id == 'netparam'){
	        	$("#waf_mm").panel({
					href : '${pageContext.request.contextPath}/web/security/netparam.jsp'
				});
	        } else if(item.id == 'dnat'){
	        	$("#waf_mm").panel({
					href : '${pageContext.request.contextPath}/web/security/dnat.jsp'
				});
	        }
	    }    
	}); */
}); 
</script>
</body>

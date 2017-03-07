<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<a href="javascript:void(0)" class="close"></a>
<div align="center">【${cuser}】的消息</div>
<div class="suggest-wrap">
	<div class="line cf">
		<p class="title">标题：</p>
		<div>${title}</div>
	</div>
	<div class="line cf">
		<p class="title">内容：</p>
		<div>${content}</div>
	</div>
	<div class="button"><input type="reset" onclick="cancle()" value='关闭' ></div>
</div>
<script type="text/javascript">
function cancle(){
	$('.popup').hide();
	$('.popup .xq').hide();
}
</script>

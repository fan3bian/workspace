<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/icp/include/taglib.jsp"%>
<head></head>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>

<form id="userInfo" method="post">
    <div>
        <label for="usernamelogin">系统登录用户名：</label>
        <input class="easyui-validatebox" type="text" name="usernamelogin" data-options="required:true"/>
    </div>
    <div>
        <label for="username">备份系统用户名：:</label>
        <input class="easyui-validatebox" type="text" name="username" data-options="required:true"/>
    </div>
    <div>
        <label for="boughtmb">购买容量：:</label>
        <input class="easyui-validatebox" type="text" name="boughtmb" data-options="validType:'email'"
               data-options="required:true"/>
    </div>
    <div>
        <label for="tel">联系方式：:</label>
        <input type="text" name="tel"/>
    </div>
    <div>
        <label for="address">联系方式：:</label>
        <input type="text" name="address"/>
    </div>
</form>
</body>
</html>
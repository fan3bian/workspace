<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<%
	  String folderPath = request.getParameter("folerPath");
	
	%>	
	<base target="_self"/> 	
	</head>
	<body>
		<form action="uploadfile.jsp?folerPath=<%=folderPath%>" method="post"
			enctype="multipart/form-data">
			<table width="380" border="0" align="center" cellpadding="0"
				cellspacing="0" style="font-size: 12px;">
				
				<tr>
					<td height="40" align="right" valign="middle">
						选择图片：
					</td>
					<td>
						<input type="file" name="upfile" id="file">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="提交"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

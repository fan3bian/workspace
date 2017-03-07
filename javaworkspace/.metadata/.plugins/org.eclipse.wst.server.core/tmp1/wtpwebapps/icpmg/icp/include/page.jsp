<%@ page language="java" import="java.util.*,java.lang.*"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
int pageNum=Integer.parseInt(String.valueOf(request.getAttribute("pageNum")));
int totalPage=Integer.parseInt(String.valueOf(request.getAttribute("totalPage")));
int totalNum=Integer.parseInt(String.valueOf(request.getAttribute("totalNum")));
if(totalPage==0)
{
	pageNum=0;
}
%>
<script type="text/javascript">
	
    function ifDigit(obj){
        slen=obj.length;
        for (i=0; i<slen; i++){
            cc = obj.charAt(i);
            if (cc <"0" || cc >"9"){
                return false;
            }
        }
        return true;
    }
    function checkPage(pageno,totalPage){
        if(!ifDigit(pageno)){
            return false;
        }
        if(pageno == "" || pageno > totalPage*1 || pageno < 1){
            return false;
        }
        return true;
    }
    function goPage(pageno){ 
    	
     	if(!checkPage(pageno,<%=totalPage%>)){
            alert("注意：请输入合法页码数！");
            $('#pageNO').focus();
            return false;
        }
		$('#pageNo').val(pageno);
        document.getElementById("conditionForm").submit();
      
    }
</script>

<div style="float:left;">
&nbsp;&nbsp;<a <%if(pageNum > 1){%>href="javascript:goPage(1);"><font color="Black"><%}else{%>><font color="#6e6d59"><%}%>首页</font></a>&nbsp;
<a <%if(pageNum > 1){%>href="javascript:goPage(<%=pageNum-1%>);"><font color="Black"><%}else{%>><font color="#6e6d59"><%}%>上一页</font></a>&nbsp;
<a <%if(pageNum < totalPage){%>href="javascript:goPage(<%=pageNum+1%>);"><font color="Black"><%}else{%>><font color="#6e6d59"><%}%>下一页</font></a>&nbsp;
<a <%if(pageNum < totalPage){%>href="javascript:goPage(<%=totalPage%>);"><font color="Black"><%}else{%>><font color="#6e6d59"><%}%>末页</font></a>&nbsp;&nbsp;
至<input size="3" id="pageNO" name="pageNO" style="BACKGROUND:#ffffff; position: relative; width:20px;">页
<input type="button" value="GO" onclick="goPage($('#pageNO').val());">
</div>

<div style="float:right;">
共<%=totalNum%>条记录&nbsp;
共<%=totalPage%>页&nbsp;
第<%=pageNum%>页&nbsp;&nbsp;
</div>
  

 

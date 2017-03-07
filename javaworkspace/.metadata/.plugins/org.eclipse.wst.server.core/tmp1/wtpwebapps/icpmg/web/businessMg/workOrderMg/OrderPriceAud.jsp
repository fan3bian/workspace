<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.* " %>
	<%
	List<OraderDetailVo> list = new ArrayList<OraderDetailVo>();
	list = (ArrayList<OraderDetailVo>)request.getAttribute("list");
	String flowid = (String)request.getAttribute("flowid");
	String path = request.getContextPath();	
	System.out.println("list.size="+list.size());
	System.out.println("flowid="+flowid);
	 %>
		
		
	<body>
	<script >
	function save(){
			if ($('#tableform').form('validate')) {
				$('#submitBtn').linkbutton('disable');
			$('#tableform').form('submit',{
		    url:'<%=path%>/workorder/saveOrderDetailServer.do',
		    onSubmit: function(){
		    },
		    success:function(data){
				
				alert("保存成功！！！");
		    }
		});
		}
		//$('#editForm').submit();	
		$("#details").parent().dialog('close');
	}	
	
	function redo(){
		$("#details").parent().dialog('close');
	}
	</script >
		<div id="details"
				style="padding:5px 5px 5px 5px;margin:10px 5px 10px 40px; ">

				<a href="#" onClick="javascript:save();" class="easyui-linkbutton"
					data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;&nbsp; <a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
				<div style="height:10px"></div>
				<div id="tablepanel" class="easyui-panel" title="">
					
						<form id="tableform" method="post">
						<input type="hidden" name="size"  id="size" value="<%=list.size() %>" />
						<input type="hidden" name="flowid"  id="flowid" value="<%=flowid %>" />
							<table align="center" name="parentid"   table-layout:fixed >
								<tr>
									
                              
     <td style="width:10%;align:center" class="FieldLabel2" style="border-top:!important;">编号</td>
     <td style="width:60%;align:center" class="FieldLabel2" style="border-top:!important;">配置信息</td><!--
      <td class="FieldLabel2" style="border-top:!important;">数量(台)</td>
     <td class="FieldLabel2" style="border-top:!important;">时长(小时)</td>
     --><td style="width:6%;" class="FieldLabel2" style="border-top:!important;">按时价格</td>
     <td style="width:6%;" class="FieldLabel2" style="border-top:!important;">按项价格</td>
      <td style="width:6%;" class="FieldLabel2" style="border-top:!important;">优惠按时价格</td>
      <td style="width:6%;" class="FieldLabel2" style="border-top:!important;">优惠按项价格</td>
								</tr>
								
				<%
				 for(int i=0;i<list.size();i++){
				   OraderDetailVo vo = new OraderDetailVo();
			       vo = (OraderDetailVo)list.get(i);
			       //String detailid = vo.getOrderDetailid();
			       String detail = vo.getDetail();
			       String tnumber = vo.getTnumber();
			       String tlong = vo.getTlong();
			       String tprice = vo.getTprice();
			       String atprice = vo.getAtprice();
			       String oprice = vo.getOprice();
			       String aotprice = vo.getAoprice();
			       String detailid = String.valueOf(Integer.parseInt(vo.getOrderDetailid())+1);
			    %>	   
			    <tr>  
			     <td class="FieldInput3"><strong><%=detailid %></strong></td>
				<td class="FieldInput3"><strong><%=detail %></strong></td>
				<!--<td><%=tnumber %></td>	
				<td><%=tlong %></td>	
				--><td class="FieldInput3"><strong><%=tprice %></strong></td>	
				<td class="FieldInput3"><strong><%=oprice %></strong></td>
				<td class="FieldInput3"><strong><input style="width: 100px ! important;height:20px" type="text" name="price<%=i+1%>" id="price<%=i+1%>"  value="<%=atprice %>"></strong></td>	
				<td class="FieldInput3"><strong><input style="width: 100px ! important;height:20px" type="text" name="aoprice<%=i+1%>" id="aoprice<%=i+1%>"  value="<%=aotprice %>"></strong></td>				
			      </tr>     
			    <%   
				 }
				 %>			
								
								
								
							</table>
						</form>
				</div>
			</div>
</body>
<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.* " %>
	<%
	List<RmdObjectVo> list = new ArrayList<RmdObjectVo>();
	list = (ArrayList<RmdObjectVo>)request.getAttribute("list");
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
		    url:'<%=path%>/workorder/saveNeDetailListServer.do',
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
					data-options="iconCls:'icon-save'">设备注销</a>&nbsp;&nbsp;&nbsp; <a
					href="#" onClick="javascript:redo();" class="easyui-linkbutton"
					data-options="iconCls:'icon-redo'">关闭</a>
				<div style="height:10px"></div>
				<div id="tablepanel" class="easyui-panel" title="">
					
						<form id="tableform" method="post">
					
						<input type="hidden" name="flowid"  id="flowid" value="<%=flowid %>" />
							<table align="center" name="parentid"   table-layout:fixed >
								<tr>
									
      <td style="width:5%;align:center" class="FieldLabel2" style="border-top:!important;">设备序号</td>                         
     <td style="width:30%;align:center" class="FieldLabel2" style="border-top:!important;">设备编号</td>
     <td style="width:10%;align:center" class="FieldLabel2" style="border-top:!important;">设备名称</td><!--
      <td class="FieldLabel2" style="border-top:!important;">数量(台)</td>
     <td class="FieldLabel2" style="border-top:!important;">时长(小时)</td>
     --><td style="width:15%;" class="FieldLabel2" style="border-top:!important;">设备IP</td>
     <td style="width:15%;" class="FieldLabel2" style="border-top:!important;">设备IP地址</td>
      <td style="width:10%;" class="FieldLabel2" style="border-top:!important;">设备类型</td>
      <td style="width:15%;" class="FieldLabel2" style="border-top:!important;">用户账号</td>
								</tr>
								
				<%
				 for(int i=0;i<list.size();i++){
				   RmdObjectVo vo = new RmdObjectVo();
			       vo = (RmdObjectVo)list.get(i);
			       //String detailid = vo.getOrderDetailid();
			       String neid = vo.getNeid();
			       String nename = vo.getNename();
			       String ipname = vo.getIpname();
			       String ipaddr = vo.getIpaddr();
			       String type = vo.getType();
			       String suserid = vo.getSuserid();
			       			    %>	   
			    <tr>  
			     <td class="FieldInput3"><strong><%=i+1 %></strong></td>
			     <td class="FieldInput3"><strong><%=neid %></strong></td>
				<td class="FieldInput3"><strong><%=nename %></strong></td>
				<td class="FieldInput3"><strong><%=ipname %></strong></td>	
				<td class="FieldInput3"><strong><%=ipaddr %></strong></td>
				<td class="FieldInput3"><strong><%=type %></strong></td>	
				<td class="FieldInput3"><strong><%=suserid %></strong></td>
							      </tr>     
			    <%   
				 }
				 %>			
								
								
								
							</table>
						</form>
				</div>
			</div>
</body>
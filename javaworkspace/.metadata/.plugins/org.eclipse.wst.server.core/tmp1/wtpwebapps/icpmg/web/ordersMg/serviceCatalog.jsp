<%@page import="com.inspur.icpmg.gov2.vo.up.Resourceservertype"%>
<%@page import="com.inspur.icpmg.productMg.appserviceMg.vo.ProductPriceVo"%>
<%@page import="com.inspur.icpmg.ordersMg.service.ServiceTypeService"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

ServiceTypeService serviceTypeService = new ServiceTypeService();

List<Resourceservertype> resourceservertypes = serviceTypeService.getServiceTypeTop(0,null);

Map<String,List<Resourceservertype>> resourceservertypeTop = new HashMap<String, List<Resourceservertype>>();

List<Resourceservertype>  resourceservertypes2 = new ArrayList<Resourceservertype>();

List<Resourceservertype>  resourceservertypes4 = new ArrayList<Resourceservertype>();

List<ProductPriceVo> productprice = new ArrayList<ProductPriceVo>();
						
%>
<%@ include file="/icp/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>服务列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  <body>
   <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" />
    <div class="easyui-layout lcy-body" data-options="fit:true,border:false">
        
        <div data-options="region:'center',border:false">
            <div class="lcy-fqdd">
                
                <!-- 表格 -->
                <div class="lcy-fqdd-t" style="top:0 ;position:relative; margin-bottom:20px;">
                    <div class="header">政务云服务目录</div>
                    <div class="t-wrap-iaas">
					<style>
					.sever-table{border-top:1px solid #e5e5e5; border-right:1px solid #e5e5e5;}
					.sever-table td{border-bottom:1px solid #e5e5e5; border-left:1px solid #e5e5e5; padding:3px 5px; font-size:12px;}
					.sever-title{ font-size:14px; line-height:3; color:#00b7ee;border-left:1px solid #e5e5e5; border-right:1px solid #e5e5e5;padding-left:10px;}
					.sever-table th{border-bottom:1px solid #e5e5e5; border-left:1px solid #e5e5e5; padding:3px 5px; font-size:14px; background:#eee;}
					</style>
                      <table width="100%" class="sever-table"> 
                      <tr>
	                      <th  width="15%" style="text-align: center;">二级分类</th>
	                      <th  width="20%"  style="text-align: center;">服务名称</th>
	                      <th  width="15%"  style="text-align: center;">规格</th>
	                      <th  width="20%"  style="text-align: center;">年价格（万元）</th>
	                      <th style="text-align: center;">服务说明</th></tr></table>
                        	
                    <%
 
                       for(int x=0,lenType=resourceservertypes.size();x<lenType;x++){
                     %>
                    
                     <p class="sever-title"><%=resourceservertypes.get(x).getServertypename()%></p>
                        <table id="fuwu" width="100%" class="sever-table">                   
                     <%                 
                
	                resourceservertypes2 = serviceTypeService.getServiceTypeTop(1, resourceservertypes.get(x).getServertypeid());    	
	                     	
					for(int y=0,typesLength2=resourceservertypes2.size();y<typesLength2;y++){				
					
					resourceservertypes4 = serviceTypeService.getServiceTypeTop(2, resourceservertypes2.get(y).getServertypeid());
							int a=0;
							int s=0;	
					for(int z=0,lenLists2=resourceservertypes4.size();z<lenLists2;z++){
					
						productprice = serviceTypeService.getProductPrice(resourceservertypes4.get(z).getServertypeid(), resourceservertypes4.get(z).getServertypename());
						
						for(int l=0,lenLists4=productprice.size();l<lenLists4;l++){
						s++;
						}
					}
															
					for(int z=0,lenLists2=resourceservertypes4.size();z<lenLists2;z++){
					
					productprice = serviceTypeService.getProductPrice(resourceservertypes4.get(z).getServertypeid(), resourceservertypes4.get(z).getServertypename());
					
					for(int l=0,lenLists4=productprice.size();l<lenLists4;l++){
					
					
					%>
					<tr >
					<% if(a==0) {%>
					
	                    <td rowspan=<%=s %>  width="15%" align="center"><%=resourceservertypes2.get(y).getServertypename()%></td>
	                   <%} if(l==0) { %> 
						<td  rowspan=<%=productprice.size() %> width="20%" align="center"><%=resourceservertypes4.get(z).getServertypename()%></td>
						<%} %>
						<%if(productprice.get(l).getSpec()!=null){%>
						<td width="15%" align="center"><%=productprice.get(l).getSpec()%></td>
						  <%}else {%><td width="15%" align="center"></td><%}%>
						  <%if(productprice.get(l).getYprice()!=null){%>
						<td width="20%" align="center"><%=productprice.get(l).getYprice()%></td>
						  <%}else {%><td width="20%" align="center"></td><%}%>					  
						<%if(productprice.get(l).getServicedesc()!=null){%><td><%=productprice.get(l).getServicedesc()%></td> 
							<%}else {%><td align="center"></td><%}%>
						</tr>	      	              
                 <% 
                 a++;
                 }
                  	   }
                  		 }%>                 		                          
                        </table>
                     <%   } %>
                    </div>     
                    
                </div>
            </div>
        </div>
    </div>
            
      
  </body>
</html>

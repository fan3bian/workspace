<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<html lang="en">
<body>
    
    <div id="deviceInfo" class="pop" >
       <!--  <div class="item3" style="padding:0"> -->
            <div class="item-wrap">
            	<div class="item2">
            		<div class="item-title">基础信息</div>
            		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
                      <tbody>
                        <tr>
                            <td align="right" width="18%"><span class="must-star">*</span> 部门：</td>
                            <td align="left" width="32%">
                                <select name="unitname" id="bbbbm" class="j-combobox" style="width: 182px; height: 25px">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td align="right" width="18%"><span class="must-star">*</span> 业务应用系统：</td>
                            <td align="left" width="32%">
                                <select name="appname" id="ywyyxt" class="j-combobox" style="width: 182px; height: 25px">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><span class="must-star">*</span> 设备名称：</td>
                            <td align="left">
                                <input id="sbmc" name="equipmentname" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            </td>
                            <td align="right">品牌型号：</td>
                            <td align="left">
                                <input id="ppxh" name="equipmentpro" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><span class="must-star">*</span> 类型：</td>
                            <td align="left">
                                <select name="equipmentstyle" id="leixing" class="j-combobox" style="width: 182px; height: 25px">
                                    <option value="">请选择</option>
                                    <option value="10001">服务器</option>
                                    <option value="10002">存储</option>
                                    <option value="10003">网络设备</option>
                                    <option value="10004">安全设备</option>
                                    <option value="10005">SAN交换机</option>
                                    <option value="10006">其他</option>
                                </select>
                            </td>
                            <td align="right">序列号：</td>
                            <td align="left">
                                <input id="xlh" name="equipmentcode" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            </td>
                        </tr>
                        <tr>
                            <td align="right">额定功率（W）：</td>
                            <td align="left">
                                <input id="edgl" name="equipmentpower" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            </td>
                            <td align="right"> 设备高度（U）：</td>
                            <td align="left">
                                <input id="sbgd" name="equipmentheight" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><span class="must-star">*</span> 上架机柜号：</td>
                            <td align="left">
                                <input id="sjjgh" name="cabinetnumber" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            </td>
                            <td align="right"><span class="must-star">*</span> 上架U位：</td>
                            <td align="left">
                                <input id="sjyw" name="unumber" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            </td>
                        </tr>
                        <tr>
                        	<td align="right"><span class="must-star">*</span> 区域：</td>
                            <td align="left">
                                <select name="equipmentregion" id="quyu" class="j-combobox" style="width: 182px; height: 25px">
                                    <option value="">请选择</option>
                                    <option value="0001">政务外网</option>
                                    <option value="0002">互联网</option>
                                    <option value="0003">行业专网</option>
                                </select>
                            </td>
                            <td align="right"><span class="must-star">*</span> 规格参数：</td>
                            <td align="left" colspan="3">
                            	<input id="ggcs" name="snote" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            </td>
                        </tr>
                    </tbody>
                </table>
            	</div>
                <div class="item2">
            		<div class="item-title">网络信息</div>
            		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
                        <tbody>
                        	
                        	<tr>
	                            <td align="right" width="18%"> 内网IP：</td>
                            	<td align="left" width="32%">
                                	<input id="nwip" name="interip" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
                            	</td>
	                            <td align="right" width="18%"> 内网端口：</td>
	                            <td align="left" width="32%">
	                                <input id="nwdk" name="interaport" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                        </tr>
	                        
	                        <tr id="hulian" style="display:none;">
	                            <td align="right">联通IP：</td>
	                            <td align="left">
	                                <input id="ltip" name="interipunincom" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                            <td align="right">电信IP：</td>
	                            <td align="left">
	                                <input id="dxip" name="interiptelecom" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                        </tr>
	                        <tr id='waiwang'>
	                            <td align="right"> 外网IP：</td>
	                            <td align="left">
	                                <input id="" name="" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                            <td align="right"> 外网端口：</td>
	                            <td align="left">
	                                <input id="wwdk" name="interport" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                        </tr>
	                        <tr id='band' style="display:none;">
	                        	<td align="right"> 外网端口：</td>
	                            <td align="left">
	                                <input id="wwdk" name="interport" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                            <td align="right">带宽：</td>
	                            <td align="left">
	                                <input id="daikuan" name="bandwidth" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                        </tr>
                        </tbody>
                    </table>
	            </div>
            </div>
        <!-- </div> -->
    </div>
    <script type="text/javascript">
	    $('.j-combobox').combobox();  
	    //初始化用户数据
	    $.ajax({
	          type:'post',
			  url:'${ctx}/trust/getEquipInfo.do?objectid=<%=request.getParameter("objectid")%>'+'&equipmentnum=<%=request.getParameter("equipmentnum")%>',
			  async: false,//使用同步的方式,true为异步方式
			  dataType:'json',
			  success:function(retr){
				  $('#bbbbm').combobox('setValue',retr.unitname);
				  $('#ywyyxt').combobox('setValue',retr.appname);
				  $('#leixing').combobox('setValue',retr.equipmentstyle);
				  $('#quyu').combobox('setValue',retr.equipmentregion);
				  if('0001'==retr.equipmentregion){
					  $('#hulian').hide();
					  $('#band').hide();
				  }else if('0002'==retr.equipmentregion){
					  
					  $('#hulian').show();
					  $('#band').show();
					  $('#waiwang').hide();
				  }
			  	  $('#sbmc').val(retr.equipmentname);
			  	  $('#ppxh').val(retr.equipmentpro);
			  	  $('#xlh').val(retr.equipmentcode);
			  	  $('#edgl').val(retr.equipmentpower);
			  	  $('#sbgd').val(retr.equipmentheight);
			  	  $('#sjjgh').val(retr.cabinetnumber);
			  	  $('#sjyw').val(retr.unumber);
			  	  $('#nwip').val(retr.interip);
			  	  $('#ggcs').val(retr.snote);
			  	  
			  	  $('#ltip').val(retr.interipunincom);
			  	  $('#dxip').val(retr.interiptelecom);
			  	  $('#wwdk').val(retr.interport);
			  	  $('#nwdk').val(retr.interaport);
			  	  $('#daikuan').val(retr.bandwidth);
			  }
	      
	    });
   
    </script>
</body>

</html>

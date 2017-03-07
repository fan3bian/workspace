<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<style type="text/css">
    .detail-line{
      margin: 10px 25px;
    }
    .tc-table {
       
        margin-bottom: 10px;
    }
    
    .tc-table td {
        padding: 5px 0;
        line-height: 26px;
    }
    
    .input-normol {
        height: 26px;
        line-height: 26px;
        border: 1px solid #ccc;
        border-radius: 3px;
        padding: 0 5px;
    }
    
    .input-normol:focus {
        border-color: #f0a73b
    }
    
    .gxwl li {
        height: 26px;
        line-height: 26px;
        border: 1px solid #ccc;
        border-radius: 3px;
        text-align: center;
        width: 110px;
        display: inline-block;
        cursor: pointer;
    }
    
    .gxwl li.active {
        background: #f8b551;
        color: #fff;
        border-color: #f0a73b;
    }
    
    .c-must {
        color: #f0a73b;
    }
</style>
<html lang="en">

<body>
	<form method="post" id="deviceEdit">
	    <div class="pop" >
	        <div class="item3" style="padding:0">
	            <div class="tc-table">
	                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
	                    <tbody>
	                        <tr>
	                        	<input name="objectid" id="objectidEdit" type='hidden'>
	                        	<input name="equipmentnum" id="equipnumEdit" type='hidden'>
	                            <td align="right" width="18%"><span class="must-star">*</span> 部门：</td>
	                            <td align="left" width="32%">
	                            	<input name="unitname" id="unitnameEdit" style="width:182px;height: 25px;">
	                            </td>
	                            <td align="right" width="18%"><span class="must-star">*</span> 业务应用系统：</td>
	                            <td align="left" width="32%">
	                                <input name="appname" id="appnameEdit" style="width:182px;height: 25px;">
	                            </td>
	                        </tr>
	                        <tr>
	                            <td align="right"><span class="must-star">*</span> 设备名称：</td>
	                            <td align="left">
	                                <input data-options="required:'ture' " id="sbmcEdit" name="equipmentname" class="shadow-input easyui-validatebox" style="width: 170px; " placeholder="" value="">
	                            </td>
	                            <td align="right">品牌型号：</td>
	                            <td align="left">
	                                <input id="ppxhEdit" name="equipmentpro" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                        </tr>
	                        <tr>
	                            <td align="right"><span class="must-star">*</span> 类型：</td>
	                            <td align="left">
	                                <select  data-options="required:'ture' " name="equipmentstyle" id="leixingEdit" class="j-combobox easyui-combobox" style="width: 182px; height: 25px">
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
	                                <input id="xlhEdit" name="equipmentcode" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                        </tr>
	                        <tr>
	                            <td align="right">额定功率（W）：</td>
	                            <td align="left">
	                                <input id="edglEdit" name="equipmentpower" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                            <td align="right">设备高度（U）：</td>
	                            <td align="left">
	                                <input id="sbgdEdit" name="equipmentheight" type="text" class="shadow-input" style="width: 170px; " placeholder="" value="">
	                            </td>
	                        </tr>
	                        <tr>
	                            <td align="right"><span class="must-star">*</span> 上架机柜号：</td>
	                            <td align="left">
	                                <input data-options="required:'ture' " id="sjjghEdit" name="cabinetnumber" type="text" class="shadow-input easyui-validatebox" style="width: 170px; " placeholder="" value="">
	                            </td>
	                            <td align="right"><span class="must-star">*</span> 上架U位：</td>
	                            <td align="left">
	                                <input data-options="required:'ture' " id="sjywEdit" name="unumber" type="text" class="shadow-input easyui-validatebox" style="width: 170px; " placeholder="" value="">
	                            </td>
	                        </tr>
	                        <tr>
	                            <td align="right"> 内网IP：</td>
	                            <td align="left">
	                                <input data-options="validType:'ip'" id="nwipEdit" name="interip" class="shadow-input easyui-validatebox" style="width: 170px; " placeholder="" value="">
	                            </td>
	                            <td align="right"><span class="must-star">*</span> 区域：</td>
	                            <td align="left">
	                                <select data-options="required:'ture' " name="equipmentregion" id="quyuEdit" class="j-combobox easyui-combobox" style="width: 182px; height: 25px">
	                                    <option value="">请选择</option>
	                                    <option value="0001">政务外网</option>
	                                    <option value="0002">互联网</option>
	                                    <option value="0003">行业专网</option>
	                                </select>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td align="right"> 工单：</td>
	                            <td align="left" colspan="3">
	                                <input name="flowid" id="flowidEdit" style="width:182px;height: 25px;">
	                            </td>
	                        </tr>
	                        <tr>
	                            <td align="right"> 规格参数：<br><span style='color:#f00'>(少于100字)</span></td>
	                            <td align="left" colspan="3">
	                                <textarea data-options="validType:'maxLength[100]'" id="ggcsEdit" name="snote" style="width: 95%; height: 90px" class="shadow-input textarea easyui-validatebox"></textarea>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
    </form>
    <script type="text/javascript">
    	$('.j-combobox').combobox();
    	$('#appnameEdit').combobox({
            valueField: 'appid',
            textField: 'appname',
            required: true
    	});
    	$('#flowidEdit').combobox({
            valueField: 'orderid',
            textField: 'flowid',
            //required: true
    	});
    	//所属单位
		$('#unitnameEdit').combobox({
			url:'${pageContext.request.contextPath}/project/getUnitsData.do',
			valueField: 'unitId',
			textField: 'unitName',
			required: true,
			panelHeight: '100',
			/* loadFilter:function(data){
				data.unshift({unitId:"",unitName:"请选择"});
				return data;
			}, */
			onSelect:function (record){
				var unitid = record.unitId;
				$('#appnameEdit').combobox({
	                url: '${ctx}/trust/getSomeInfo.do?unitid='+unitid,
	                valueField: 'appid',
	                textField: 'appname',
	                required: true
            	});
				$('#flowidEdit').combobox({
	                url: '${ctx}/trust/getFlowid.do?unitid='+unitid,
	                valueField: 'orderid',
	                textField: 'flowid',
	                required: true
            	});
			}
		});
		
    </script>
</body>

</html>

<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',border:false">
			<a onclick="createDisk();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">云硬盘创建</a>
			<a onclick="attachDataDisk();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">云硬盘挂载</a>
			<a onclick="detachDataDisk();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">云硬盘卸载</a>
			<a onclick="deleteDataDisk();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">云硬盘删除</a>
			<a onclick="volumeUploadImage();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">上传镜像</a>
			<a onclick="extendVolume();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">扩展云硬盘</a>
			<a onclick="createSnapshot();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">创建云硬盘快照</a>
			<a onclick="deleteSnapshot();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">删除云硬盘快照</a>
			<a onclick="createVolumeType();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">创建云硬盘类型</a>
			<a onclick="getVolumeType();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">获取云硬盘类型</a>
			<a onclick="deleteVolumeType();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">删除云硬盘类型</a>
			<a onclick="createQosSpec();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">获取Qos规格</a>
			<a onclick="getQosSpec();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">创建Qos规格</a>
			<a onclick="deleteQosSpec();" href="javascript:void(0);" style="margin: 10px;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">删除Qos规格</a>
		</div>
	</div>
	<script type="text/javascript">
		function createDisk(){
		    $.ajax({
				type : 'post',
				async: false,
				url:'${pageContext.request.contextPath}/indisk/createDisk.do',
				data:{},
				success : function(data) {
					var json = eval('(' + data + ')');
					alert(json);
				}
		    });
		}
	</script>
</body>
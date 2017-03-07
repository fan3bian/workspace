<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

 <script>
   	$(function(){
   		$('.down-bt').click(function(){
   			var category= $(this).parents("table").attr("id");
   			var filename= $(this).text().toLowerCase();
   			  $.ajax({
   				url:'${pageContext.request.contextPath}/obsMgr/downloadSdkTool.do',
   				type:'POST',
   				dataType:'json',
   				data:{
   					filename:filename,
   					category:category
   				},
   				success:function(data){
   					window.open('${pageContext.request.contextPath}'+data.url);
   				}
   				
   			}); 
   		});
   	});
   	</script>
   <style type="text/css">
    .client_mg_tool{
  	  width:1400px;
  	  height:750px;
  	  padding:20px;
    }
    .td_left{
    	width:60%;
    }
    .td_right{
    	width:60%;
    }
    .sdk-head{
    	margin:10px;
    	width:960px;
	    font-size: 18px;
		color: #333333;
		padding: 16px;	
		box-shadow: 0 1px 2px -1px #565656;
    }
    .sdk-body{
 		width:960px;
	    font-size: 18px;
		color: #333333;
		padding: 10px 20px;	
/* 		box-shadow: 0 1px 2px -1px #565656; */
    }
     .sdk-foot{
 		width:960px;
	    font-size: 18px;
		color: #333333;
		padding: 10px 20px;	
		box-shadow: 0 1px 2px -1px #565656;
    }
 	a:hover{text-decoration:none; cursor:pointer}  
 	
    table {
    	width:980px;
    }
    table thead{
    	background-color: #f5f5f5;
    }
    table thead tr {
    	height:30px;
    }  
    table thead tr th{
    	font-size:16px;
    }
   	table tbody{
   		margin:20px 0;
   	}
   	table tbody tr{
   		height:22px;
   	}
   	
    </style>
    
	<div class="easyui-panel" class="client_mg_tool">
	<div class="sdk-head">SDK及工具 </div>
	<div class="sdk-body">
		<table id="spacemg">
			<thead>
				<tr><th>管理工具</th><th></th></tr>
			</thead>
			<tbody>
				<tr>
					<td class="td_left"></td>
					<td class="td_right">工具下载</td>
				</tr>
				<tr>
					<td class="td_left">Inspur-Cloud管理工具提供了针对空间与文件的管理操作，用户可以依据工具进行：</td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">WIN32</a></td>
				</tr>
				<tr>
					<td class="td_left">创建空间、删除空间、空间信息查看与修改、空间文件列表查询的操作</td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">WIN64</a></td>
				</tr>
				<tr>
					<td class="td_left">同样也可以帮助您管理空间内文件操作，进行上传文件，支持：</td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">LINUX64</a></td>
				</tr>
				<tr>
					<td class="td_left">普通上传(PUT)，秒传（UPLOAD-HIT），分片上传（MPUT），表单方式上传；下载文件；删除文件；</td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">MAC</a></td>
				</tr>
			</tbody>
		</table>
<!-- 		<table id="contentmg"> -->
<!-- 			<thead> -->
<!-- 				<tr><th>内容管理</th><th></th></tr> -->
<!-- 			</thead> -->
<!-- 			<tbody> -->
<!-- 				<tr> -->
<!-- 					<td class="td_left">内容管理工具可帮助您进行空间内文件的管理操作，包括：</td> -->
<!-- 					<td class="td_right">工具下载</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="td_left">1.上传单个文件：普通上传(PUT)，秒传（UPLOAD-HIT），分片上传（MPUT），表单方式上传；</td> -->
<!-- 					<td class="td_right"><a class="down-bt" href="javascript:void(0);">WIN32</a></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="td_left">2.上传文件夹：普通上传(PUT)，分片上传(MPUT)，增量上传(SYNC)；</td> -->
<!-- 					<td class="td_right"><a class="down-bt" href="javascript:void(0);">WIN64</a></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="td_left">3.下载文件/文件夹</td> -->
<!-- 					<td class="td_right"><a class="down-bt" href="javascript:void(0);">LINUX64</a></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="td_left">4.删除文件/文件夹</td> -->
<!-- 					<td class="td_right"><a class="down-bt" href="javascript:void(0);">MAC</a></td> -->
<!-- 				</tr> -->

<!-- 			</tbody> -->
<!-- 		</table> -->
		</div>
		<div class="sdk-foot">
		<table id="sdk">
			<thead>
				<tr><th>API/SDK</th><td></td></tr>
			</thead>
			<tbody>
				<tr>
					<td class="td_left"></td>
					<td class="td_right">工具下载</td>
				</tr>
				<tr>
					<td class="td_left">我们为您提供了丰富的API，可进行空间与文件的管理。同时,</td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">PHP SDK</a></td>
				</tr>
				<tr>
					<td class="td_left">你还可以通过API进行CDN文件预取、刷新等操作</td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">Python SDK</a></td>
				</tr>
				<tr>
					<td class="td_left">具体API/SDK使用方法，参考SDK下载包中的Demo。</td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">C# SDK</a></td>
				</tr>
				<tr>
					<td class="td_left"></td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">NodeJS SDK</a></td>
				</tr>
				<tr>
					<td class="td_left"></td>
					<td class="td_right"><a class="down-bt" href="javascript:void(0);">Java SDK</a></td>
				</tr>

			</tbody>
		</table>
		</div>
	</div>

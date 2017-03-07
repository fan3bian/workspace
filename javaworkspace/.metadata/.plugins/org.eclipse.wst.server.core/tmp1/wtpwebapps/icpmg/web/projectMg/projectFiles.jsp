<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<style type="text/css">
   
 .datagrid-header td,
.datagrid-body td,
.datagrid-footer td {
  border-width: 0 0px 1px 0;
  border-style: dotted;
  margin: 0;
  padding: 0;
}
.datagrid-row-selected {
  background: #fff;
  color: #000000;
}
.datagrid-row-over,
.datagrid-header td.datagrid-header-over {
  background: #fff;
  color: #000000;
  cursor: default;
}
 .operate{
  padding-left: 20px;
  margin-left: 20px;
}
</style>

<script type="text/javascript" charset="utf-8">
 
$(function(){
   
	cleanSearchFun=function(){
		searchForm.find('input').val('');
		datagrid.datagrid('load',{});
	};
		var datagrid = $('#tt').datagrid({
				
				showHeader:true, 
				remoteSort:false,
				singleSelect:true,
				rownumbers:true,
				nowrap:false,
				striped:false,
				fitColumns:true,
				url:'${ctx}/project/projectQueryNoPage.do',
				columns:[[
					{field:'procode',title:'项目代码',width:80,height:84,align:'center'},
					{field:'proname',title:'项目名称',width:100,align:'center'},
					{field:'prodate',title:'立项时间',width:80,align:'center',sortable:true},
					{field:'proid',title:'项目ID',width:80,align:'center',hidden:true},
					{field:'unitname',title:'创建单位',width:80,align:'center'},
					{field:'unitid',title:'创建单位',width:80,align:'center',hidden:true},
				    {field:'cusernam',title:'操作',width:80,align:'center', formatter:function(value,row,index){
			             
			            if (value==null){
			              var proid = row.proid;
			             
			              var link = "<a href='javascript:void(0)'><img onclick='uploadfile("+("1"+proid)+")' style='padding-top:5px;' src='${ctx}/images/upload.png'/></a>";
			              return  link;
			            }
			         
			        
			          }		    
				    
				    },
				]],
				view: detailview,
				onExpandRow: function(index,row){ 
				 $('#ddv-'+index).datagrid({  
                    url:'${ctx}/project/getFileOfPro.do?proid='+row.proid, 
                    striped:false, 
                    fitColumns:true,  
                    singleSelect:true, 
                    showHeader:false, 
                    height:'auto',  
                    columns:[[  
                        {field:'ctime',width:17,
                          
                        formatter:function(value,row,index){
			            var times = row.ctime.split(" ");
			            if (value!=null){
			            
			             var time = "<span style='font-size:12px;color:#0068b7'>"+times[0]+"</span>";
			             return  time;
			            }
			         
			        
			          }
                        },
                      {
                         
			            field:'fileul',
			            width:13,
		                align:'center',
		                formatter:function(value,row,index){
			             
			            if (value==null){
			            
			             var link = "<a href='javascript:void(0)' ><img style='padding:0px;' src='${ctx}/images/narrow.png'/></a>";
			             return  link;
			            }
			         
			        
			          } 
                      },
                        {field:'filename',width:70,align:'center',formatter:function(value, row, index){
                            var filename = row.filename.substring(13);  
                            if(value!=null){
                             return  filename;
                            }
                        }},  
                        {field:'filetype',width:30,align:'center',formatter:function(value, row, index){  
                            if (value) {  
                                switch (value) {  
                                    case '0':  
                                        return '任务创建';  
                                        break;  
                                    case '1':  
                                        return '项目调研';  
                                        break;  
                                    case '2':  
                                        return '项目需求';  
                                        break;  
                                    case '3':  
                                        return '项目招标';  
                                        break;  
                                    case '4':  
                                        return '项目合同';  
                                        break;  
                                    case '5':  
                                        return '专家评审';  
                                        break;  
                                    case '6' :  
                                        return '其他类别';  
                                        break;  
                                          case '7' :  
                                        return '项目申请资料';  
                                        break; 
                                          case '8' :  
                                        return '项目终止资料';  
                                        break; 
                                }  
                            }  
                        }},  
                         {field:'fileid',width:50,align:'center',hidden:true},  
                    /*   {           
			            field:'checkstatus',
			            width:30,
		                align:'center',
		                formatter:function(value,row,index){
                          
                           if(value=="0"){
                            return "待审阅";
                           }
                            if(value=="1"){
                            return "审阅通过";
                           }
                            if(value=="2"){
                            return "审阅未通过";
                           }
                            if(value=="3"){
                            return "实施完成";
                           }
			           } 
                      }, */
                      {
                        title:'操作',
			            field:'fileurl',
			            width:80,
		                align:'center',
		                formatter:function(value,row,index){
			             var fileid = row.fileid.toString();
			             var filename = row.filename;
			       
			             var link = "<a href='javascript:void(0)' class='operate' ><img onclick='downfile("+("1"+fileid)+")' style='padding-top:10px;padding-right:15px' src='${ctx}/images/download.png'/></a>"+"<a class='operate' href='javascript:void(0)'><img onclick='delfile("+("1"+fileid)+")' style='padding-top:10px;padding-right:15px' src='${ctx}/images/cancel.png'/></a>  ";
			             return link;
			          } 
                      }
                    ]], 
                    
                    onResize:function(){  
                        $('#tt').datagrid('fixDetailRowHeight',index);  
                    },  
                    onLoadSuccess:function(){  
                        setTimeout(function(){  
                            $('#tt').datagrid('fixDetailRowHeight',index);  
                        },50);  
                    }  
                });  
				  $('#tt').datagrid('fixDetailRowHeight',index);
	 	        },
				detailFormatter: function(rowIndex, rowData){
				   return '<div style="padding:2px"><table id="ddv-' + rowIndex + '"></table></div>';
				}
	});
	
});

  
</script>


<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;height: auto">
	<div data-options="fit:true,region:'north',border:false" style="background:#eee;height:auto;border:none">
		<div  style="background:#eee;height:30px;overflow:hidden;border:none;padding: 10px">
		<form id="promgr_searchform">
			<table>
				<tr>
					<td>
					  单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：<input id="unitid" style="width:200px;height: 30px; "  name="unitid" class="easyui-combobox" data-options=" 
				 valueField: 'unitId',    
                 textField: 'unitName',   
                 
                 url: '${ctx}/project/getUnits.do',    
                 onSelect: function(rec){    
                 var url = '${ctx}/project/getProjects.do?unitid='+rec.unitId;    
                 
                 $('#proid').combobox({    
                    url:url,    
                    valueField:'proid',    
                    textField:'proname',  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项
                    var data = $('#proid').combobox('getData');
                  if (data.length > 0) {
                 $('#proid').combobox('select', data[0].proid);
             } 
           }   
   });
              },
               onLoadSuccess: function () { //加载完成后,设置选中第一项
              var data = $('#unitid').combobox('getData');
             if (data.length > 0) {
                 $('#unitid').combobox('select', data[0].unitId);
             } 
            }
        ">
					</td>
					<td style="margin-left: 10px">
					&nbsp;&nbsp; 项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目：<input class="easyui-combobox" data-options="valueField:'proid',textField:'proname'"   id="proid" style="width: 200px;height: 30px; "  name="proid">
					</td>
					<td style="float:right">&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun()">查询</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;

					</td>
				</tr>
			</table>
		</form>
	</div>
		 <table id="tt">
		   
		 </table>
	  </div>
</div>

<div id="procheck" class="easyui-window" title="审阅意见" data-options="iconCls:'icon-shenpi',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:400px;height:250px;">
        <form action="" method="post" id="checkform">
        <div data-options="region:'center'" style="padding:10px;">
			<div class="detail-line" >
			  <p  style="padding: 10px;font: bold 14px"; align="center"> 是否通过 <span id="checkFileName"></span>?</p>	  
		    </div>
		    <div class="detail-line"style="padding: 10px;margin-left:45px;" >
			   <span><input class="easyui-textbox" data-options="validType:'isBlank',multiline:true,prompt:'审阅意见'"  id="snote" style="width: 250px ;height: 90px;"  name="checknote">
			   </span> 
		    </div>
		    <div class="detail-line" style="padding-top: 10px;margin-left: 115px">
		    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="checkfile2('1')">通过</a>&nbsp;&nbsp;
	        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="checkfile2('2')">拒绝</a>&nbsp;&nbsp;
	        </div>
	  </div>
		</form>
</div>

<div id="fileloadwin" class="easyui-window" title="文档上传" data-options="iconCls:'icon-file',closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false" style="width:400px;height:220px;">
        <form action="" method="post" id="fileloadform" enctype="multipart/form-data">
        <div data-options="region:'center'" style="padding:10px;">
			 <div class="load-line" style="margin-top: 20px;margin-left: 20px">
				<span>文档类别：<select class="easyui-combobox" data-options="validType:'isBlank',"  id="filetype" style="width: 230px;height: 30px; "  name="filetype">
				   <option value="1">项目调研</option>   
                   <option value="2">项目需求</option>   
                   <option value="3">项目招标</option>   
                   <option value="4">项目方案</option>   
                   <option value="5">项目合同</option> 
                   <option value="5">专家评审</option>
                   <option value="6">其他类别</option>
		      	</select>
				</span> 	  
		       </div>
		       <div class="load-line" style="margin-top: 20px;margin-left: 20px">
				<span>文档上传：<input class="easyui-filebox" data-options="validType:'isBlank', buttonText:'浏    览'"  id="fileload" style="width: 230px;height: 30px; "  name="fileload">
				</span> 
		       </div>
		   
		    <div class="load-line" style="padding-top: 10px;margin-left: 120px">
		    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="uploadfile2()">上传</a>&nbsp;&nbsp;
	        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick=" javascript:$('#fileloadwin').dialog('close')">取消</a>&nbsp;&nbsp;
	        </div>
	  </div>
	</form>
</div>
<script type="text/javascript" charset="utf-8">
   var fileid;
   var filename;
    
  $(function(){
  //审阅权限控制
     hasRightCheck = function(){
      var  canCheck = false;
  /*     var roleids = ${sessionUser.roleid};
      var role = roleids.split(",");
      for(var i=0;i<role.length;i++){
        if(role[i]=="1000000048"){
          canCheck = true;
        }
     } */
     return canCheck;
   };
   //上传权限控制
    hasRightUpload = function(){
      var  canload = true;
    /*   var roleids = ${sessionUser.roleid}+",";
      var role = roleids.split(",");
      for(var i=0;i<role.length;i++){
        if(role[i]=="1000000047"||role[i]=="1000000048"){
          canload = true;
        }
     } */
     return canload;
   };
 
   //审批
     checkfile = function(checkid){
      var status;
     if(hasRightCheck()){

      fileid = checkid.toString().substring(1);
       $.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/project/getFile.do',
   				  		data:{fileid:fileid},
   				  		async: false, 
   				  		dataType:'json',
   				  		success:function(data){
   				  		 
   				  		   filename = data.filename;
   				  		   status = data.checkstatus;
   				  		  }
   				  		});
         if(status!="0"){
          $.messager.alert('提示',"您已经审阅过了！","info");
         }else{
         $("#checkFileName").html("【"+filename.substring(13)+"】");
          $("#procheck").window('open');
         } 
   			   	  		
   	   }else {
	 
		  $.messager.alert('警告',"您没有权限审阅！","warning");
	  }
   	};
    
    checkfile2 = function(status){
 
         $('#checkform').form('submit',{
      
         url:'${ctx}/project/checkFile.do',
         queryParams:{checkstatus:status,fileid:fileid},
         onSubmit:function(){
           return $(this).form('validate');  
         },
         success:function(data){
           $('#procheck').window('close');
           var data = JSON.parse(data);
           if(data.success){
           $('#tt').datagrid('unselectAll');
		   $('#tt').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
            $.messager.alert('提示',data.msg);
    
           }else{
            $.messager.alert('提示',data.msg);
           }
         }
      })
    };
    
    uploadfile = function(proid){
    if(hasRightUpload()){
     var proid = proid.toString().substring(1);
     $("#fileload").textbox("setValue",'');
     $("#filetype").combobox('select','1');
      $("#fileloadwin").window('open');
      }else {
		 
		  $.messager.alert('警告',"您没有权限上传文件！","warning");
	}
    };
    searchForm = $('#promgr_searchform').form();
    searchFun=function(){
     
		$('#tt').datagrid('load',{
		  proid:$("#proid").combobox('getValue'),
		  unitid:$("#unitid").combobox('getValue')
		});
	};
    uploadfile2 = function(){
      var row = $('#tt').datagrid('getSelected');
      var proid = row.proid;
     
      var proname = row.proname;
       
      var unitid = row.unitid;
       
      var unitname = row.unitname;
       
       $("#fileloadform").form('submit',{
        url:'${ctx}/project/proFileLoad.do',
        queryParams:{proid:proid,proname:proname,unitid:unitid,unitname:unitname},
        onSubmit:function(){
            var fileTypeName =  $("#fileload").textbox('getValue');
            
           if(fileTypeName=="" || fileTypeName==null){
             
             $.messager.alert('提示',"文档不能为空！"); 
              return false;
           } 
        
          
        },
        success:function(data){
          $('#fileloadwin').window('close');
          var data = JSON.parse(data);
            if(data.success){
           $('#tt').datagrid('unselectAll');
		   $('#tt').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
            $.messager.alert('提示',data.msg);
    
           }else{
            $.messager.alert('提示',data.msg);
           } 
       }
     })
    };
    
    downfile = function(downid,filename){
      var fileid = downid.toString().substring(1);
      
      var url;
      $.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/project/downFile.do',
   				  		data:{
   				  		  fileid:fileid
   				  		},
   				  		async: false,
   				  		dataType:'text',
   				  		success:function(result){
   				  		 
   				  		  url = '${ctx}/'+result;
   				  		  var temp = url.split(".");
   				  		  var str = temp[temp.length-1];
   				  		 
   				  		  if(str=="doc"||str=="docx"||str=="xls"||str=="xlsx"){
   				  		   window.location.href = url;
   				  		  }else{
   				  		   window.open(url);
   				  		  }
   				  		}
   				  	}); 
  
    };
    delfile = function(delid){
     
     var fileid = delid.toString().substring(1);
      $.messager.confirm("操作提示", "您确定要执行删除操作吗？", function (data) {  
            if (data) {  
                	$.ajax({
   				  		type : 'post',
   				  		url:'${ctx}/project/delFile.do',
   				  		data:{fileid:fileid},
   				  		success:function(retr){
   				  			var data =  JSON.parse(retr); 
   				  			 
   				  			$.messager.alert('警告',data.msg,"warning"); 
				  			if(data.success)
					    	{
					    		$('#tt').datagrid('unselectAll');
					    		$('#tt').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
					    		
					    	} 
   				  		}
   				  	});    
          
            }  
            else {  
            }  
        });   
    }
  })
  
 </script>
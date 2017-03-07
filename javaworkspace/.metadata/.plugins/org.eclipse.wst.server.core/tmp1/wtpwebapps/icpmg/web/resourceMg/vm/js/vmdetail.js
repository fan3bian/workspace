var str_status = "状态：";
var str_running = "运行中";
var str_starting = "启动中";
var str_stopping = "正在停止";
var str_stopped  = "停止";

var val_running = "Running";
var val_starting = "Starting";
var val_stopping = "Stopping";
var val_stopped = "Stopped";
//停止，重启，启动
function operate(neid,type,nename){
	$('#vm_operate').form('submit',
			{
				url : basePath +'/vm/operate.do',
				onSubmit : function(param) {
					param.type=type;
					param.neid=neid;
					param.nename=nename;
				   $.blockUI({
		            message: "<h2>请求已发送,请稍后......</h2>",
		            css: {color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
		            overlayCSS: {opacity:'0.0'}
		          });
				},
				success : function(retr) {

				   $.unblockUI();
					var _data = $.parseJSON(retr);
					if (_data.success) {
					     if(_data.obj){
				   //状态修改为启动中
				    if(_data.obj == val_running){
	
				       $("p.vmstatus").text(str_status + str_running);
				       if($("#vmdetail_shutdown_btn").length === 0){
				          $("#vmdetail_open_btn").after("<a id=\"vmdetail_shutdown_btn\" href=\"javascript:void(0);\" class=\"easyui-linkbutton\" style=\"float:right;margin-right:10px;\" onclick=\"operate('${rmdVmVo.serverid}', 'shutdown','${rmdVmVo.servername}')\">停      止</a>");
				       
				        }else{
				          $("#vmdetail_shutdown_btn").show();
				       }
				       if( $("#vmdetail_restart_btn").length === 0){
				           $("#vmdetail_open_btn").next().after("<a id=\"vmdetail_restart_btn\" href=\"javascript:void(0);\" class=\"easyui-linkbutton\" style=\"float:right;margin-right:10px;\" onclick=\"operate('${rmdVmVo.serverid}', 'restart','${rmdVmVo.servername}')\">重      启</a>");
				         
				        }else{
				           $("#vmdetail_restart_btn").show();
				       }
				       $("#vmdetail_start_btn").hide();
				       
				
				       
				    }else if (_data.obj == val_stopped){
				      // 状态修改为停止中
				        $("p.vmstatus").text(str_status + str_stopped);
				        $("#vmdetail_shutdown_btn").hide();
				        $("#vmdetail_restart_btn").hide();
				        if($("#vmdetail_start_btn").length === 0){
				          $("#vmdetail_open_btn").after("<a id=\"vmdetail_start_btn\" href=\"javascript:void(0);\" class=\"easyui-linkbutton\" style=\"float:right;margin-right:10px;\" onclick=\"operate('${rmdVmVo.serverid}', 'start','${rmdVmVo.servername}')\">启     动</a>");
	
				        }else {
				          $("#vmdetail_start_btn").show();
				        }
				    }else if(_data.obj == val_starting || _data.obj == val_stopping){
				    
                      //待补充：当状态是Starting或者Stopping时，启动定时任务, 获取数据库里的最新的状态，当状态变为running或者stopped时，停止定时任务 
                    }
                    //重新渲染组件
                           $.parser.parse();
				}
						$.messager.alert('提示', _data.msg, 'info');
					} else {
						$.messager.alert('提示', _data.msg, 'error');
					}
				}
			});
}


//虚机迁移
function migrate(neid,nename){
	 //window.alert("begin");
	  $.blockUI({
          message: "<h2>请求已发送,请稍后......</h2>",
          css: {color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
          overlayCSS: {opacity:'0.0'}
        });
	 // window.alert("end");
	  // debugger;
	   
	  $.ajax({  
			 url:   basePath +'/vm/operate.do?neid='+neid+'&type=powerstate&migoper=0',
		    type:'post',  
		    dataType:'json', 
		    success:function(data){      	
		    	  $.unblockUI();
		    	  var dialog = parent.icp.modalDialog({
						title : '虚机迁移',
						url :  basePath +'/vm/vmMigrate.do?serverid='+neid,
						buttons : [{
							text : '确认',
							iconCls:'icon-ok',
							handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
								dialog.find('iframe').get(0).contentWindow.submitForm(dialog,  parent.$ , neid,nename);
							}
						},{
							text : '取消',
							iconCls:'icon-cancel',
							handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
								dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
							}
						}]
					}); 
		    	 
		    }  
		});
   		
                			
               
		
  
}


function openConsole(serverid){
	  $.blockUI({
          message: "<h2>请求已发送,请稍后......</h2>",
          css: {color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
          overlayCSS: {opacity:'0.0'}
        });
	  
	  $.ajax({  
			 url:   basePath +'/vm/getConsoleURL.do?neid='+serverid,
		    type:'post',  
		    dataType:'json',  
		    success:function(data){      	
		    	  $.unblockUI();
		    	if(data.success){
		    				            		            				 
		    		var dataurl = data.obj;
		    		window.open(dataurl,serverid,'height=400,width=800,top=50,left=100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');//改为 弹出窗口而不是tab页
		              
		    	}else{
		    		$.messager.alert('提示', data.msg, 'error');
		    	}
		    	 
		    }  
		});
	
}
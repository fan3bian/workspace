$(function(){
	var listTypeName_url_action_path = context_path+'/pingconfig/listNeTypeName.do?type=url';
	var listNeName_url_action_path = context_path+'/pingconfig/listNeName.do';
	var listNeip_url_action_path = context_path +'/pingconfig/listNeip.do';
	var add_urlconfig_action_path = context_path+'/urlconfig/addURLConfig.do';


	var urlAppLengthLimit = 40; //URL应用长度限制

	/***************************************************************************************************/
	/**
	 * 用于添加告警配置
	 */
	var paramtype = 1;
	var neid;
	var nename;
	var netypeid;
	var netypename;
	var neipaddr;
	var nesuserid;

	var port;
	var urlApp;


	/***************************************************************************************************/

	/**
	 * 设备类型选择,选择后从rmd_object读取对应类型的设备名称
	 */
	$('#url-netypename-inputcombobox').combobox({    
	    url:listTypeName_url_action_path,    
	    valueField:'typeid',    
	    textField:'typename',
	    onSelect:function(rec){    
	        var url = listNeName_url_action_path + '?typeid=' + rec.typeid;
	        $('#url-nename-inputcombobox').combobox('setValue', '');
	        $('#url-neip-area').empty();
	        $('#url-alarm-urlstr-area').empty();
	        $('#url-nename-inputcombobox').combobox('reload', encodeURI(url)); 
	        
	    }
	});  

	/**
	 * 设备类型名称,选择后,以其neid从rmd_object读取告警配置所用参数
	 */
	$('#url-nename-inputcombobox').combobox({
	    valueField:'neid',
	    textField:'nename',
	    onSelect:function(rec){    
			
	    	neid = rec.neid;
	    	nename = rec.nename;
	    	netypeid = rec.typeid;
	    	netypename = rec.typename;
	    	
				$.ajax
					({
					 	type : 'post',
						async:false, 
						data:{neid:rec.neid,netype:rec.typeid},
						url:listNeip_url_action_path,
						dataType:'json',
						success:
							function(ret)
							{
								var vo = ret[0];
								neipaddr = vo.ipaddr;
								nesuserid = vo.suserid;
								$('#url-neip-area').empty();
								$('#url-neip-area').append(neipaddr);
								
								port = $('#url-alarm-port-input').val();
								urlApp = $('#url-alarm-app-input').val();
								$('#url-alarm-urlstr-area').empty();
								$('#url-alarm-urlstr-area').append('http://' + neipaddr + ':' + port + '/' + urlApp);
							}
					});
	        
	    }
	});

	/**
	 * 端口输入
	 */
	$('#url-alarm-port-input').numberbox({
		  onChange:function(newValue,oldValue){
				
			  if((neid == undefined) || (neid == null) || (neid == "clk"))
				{
					return;
				}
				
				port = newValue;
				urlApp = $('#url-alarm-app-input').val();
				$('#url-alarm-urlstr-area').empty();
				if((port == "") || (port == null) || (port == "clk") || (port == undefined)   )
				{
					$('#url-alarm-urlstr-area').append('http://' + neipaddr + '/' + urlApp);
				}
				else
				{
					$('#url-alarm-urlstr-area').append('http://' + neipaddr + ':' + port + '/' + urlApp);
				}
				
		  }
		});

	/**
	 * 应用名称
	 */
	$('#url-alarm-app-input').textbox({
		  onChange:function(newValue,oldValue){
				
			  if((neid == undefined) || (neid == null) || (neid == "clk"))
				{
					return;
				}
				
				port = $('#url-alarm-port-input').val();
				urlApp = newValue;
				if(urlApp.length > urlAppLengthLimit)
				{
					$.messager.alert("  警告  ","  URL过长，请重新输入 ","warning");
					newValue = "";
					urlApp="";
					$('#url-alarm-app-input').textbox('clear');
					$('#url-alarm-urlstr-area').empty();
					
				}
				
				$('#url-alarm-urlstr-area').empty();
				
				if((urlApp == "") || (urlApp == null) || (urlApp == "clk") || (urlApp == undefined)   )
				{
					if((port == "") || (port == null) || (port == "clk") || (port == undefined)   )
					{
						$('#url-alarm-urlstr-area').append('http://' + neipaddr);
					}
					else
					{
						$('#url-alarm-urlstr-area').append('http://' + neipaddr + ':' + port );
					}
				}
				else
				{
					if((port == "") || (port == null) || (port == "clk") || (port == undefined)   )
					{
						$('#url-alarm-urlstr-area').append('http://' + neipaddr + '/' + urlApp);
					}
					else
					{
						$('#url-alarm-urlstr-area').append('http://' + neipaddr + ':' + port + '/' + urlApp);
					}
				}
				
		  }
		});

	/***************************************************************************************************/
	/**
	 * 对所选告警配置进行添加
	 */
	$("#url-config-add-button").click(
			function(){
				
				if((neid == undefined) || (neid == null) || (neid == 'clk') || (neid == ''))
				{
					$.messager.alert("警告 ","添加失败！请选择对应设备后再进行添加 ","warning");
					return;
				}
				
				if((neipaddr == undefined) || (neipaddr == null) || (neipaddr == '') || (neipaddr == 0) || (neipaddr == 'clk'))
				{
					$.messager.alert("警告 ","添加失败！该设备IP信息有误 ","warning");
					return;
				}
				
				if((port == undefined) || (port == null) || (port == '') || (port == 'clk'))
				{
					port = '';
				}
				
				if((urlApp == undefined) || (urlApp == null) || (urlApp == '') || (urlApp == 'clk'))
				{
					urlApp = '';
				}
				
				var totalURL;
				
				if(urlApp == '')
				{
					if(port == "")
					{
						totalURL = 'http://' + neipaddr;
					}
					else
					{
						totalURL = 'http://' + neipaddr + ':' + port;
					}
				}
				else
				{
					if(port == '')
					{
						totalURL = 'http://' + neipaddr + '/' + urlApp;
					}
					else
					{
						totalURL = 'http://' + neipaddr + ':' + port + '/' + urlApp;
					}
				}
				
				
				var addFlag = false;
					$.ajax
	  				({
	  				 	type : 'post',
	  					async:false, 
	  					data:{paramtype:1, neid:neid,nename:nename,netypeid:netypeid,netypename:netypename,
	  						nesuserid:nesuserid,neipaddr:neipaddr,urlport:port,urlapp:urlApp,totalurl:totalURL},
	  					url:add_urlconfig_action_path ,
	  					dataType:'text',
	  					success:
	  						function(ret)
	  						{
	  							if(ret=="true")
	  							{
	  								addFlag = true;
	  							}
	  						}
	  				});
					
					if(addFlag==true)
					{
						$('#urlconfig-datagrid').datagrid('reload');
						$('#add-url-config-dialog').window('close'); 
						$.messager.alert("完成  ","  被选中的配置已添加成功!  ","info");
						
						//将变量复位
						var clk = "clk";
				    	neid = clk;
				    	nename = clk;
				    	netypeid = clk;
				    	netypename = clk;
						neipaddr = clk;
						nesuserid = clk;
						port = clk;
						urlApp = clk;
					}
					else
					{
						$.messager.alert("警告","添加失败！该设备的告警配置已存在，如设备信息已发生改变，需修改配置，请删除后重新添加 ","warning");
					}
					

					
			}
	);

	/***************************************************************************************************/
	/**
	 * 
	 */
	$("#url-config-cancel-button").click(
			function(){
				$('#add-url-config-dialog').window('close');
				//将变量复位
				var clk = "clk";
				neid = clk;
		    	nename = clk;
		    	netypeid = clk;
		    	netypename = clk;
				neipaddr = clk;
				nesuserid = clk;
				port = clk;
				urlApp = clk;
			}
	);




});

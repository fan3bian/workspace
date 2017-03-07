$(function(){
	var listTypeName_url_action_path = context_path+'/pingconfig/listNeTypeName.do';
	var listNeName_url_action_path = context_path+'/pingconfig/listNeName.do';
	var listNeip_url_action_path = context_path +'/pingconfig/listNeip.do';
	var add_pingconfig_action_path = context_path+'/pingconfig/addPingConfig.do';

	/***************************************************************************************************/
	/**
	 * 用于添加告警配置
	 */
	var paramtype = 0;
	var neid;
	var nename;
	var netypeid;
	var netypename;
	var neipaddr;
	var nesuserid;

	/***************************************************************************************************/

	/**
	 * 设备类型选择,选择后从rmd_object读取对应类型的设备名称
	 */
	$('#ping-netypename-inputcombobox').combobox({    
	    url:listTypeName_url_action_path,    
	    valueField:'typeid',    
	    textField:'typename',
	    onSelect:function(rec){    
	        var url = listNeName_url_action_path + '?typeid=' + rec.typeid;
	        
	        $('#ping-nename-inputcombobox').combobox('setValue', '');
	        $('#ping-neip-area').empty();
	        $('#ping-nename-inputcombobox').combobox('reload', encodeURI(url)); 
	        
	    }
	});  

	/**
	 * 设备类型名称,选择后,以其neid从rmd_object读取告警配置所用参数
	 */
	$('#ping-nename-inputcombobox').combobox({
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
								$('#ping-neip-area').empty();
								$('#ping-neip-area').append(neipaddr);
							}
					});
	        
	    }
	});

	/***************************************************************************************************/
	/**
	 * 对所选告警配置进行添加
	 */
	$("#ping-config-add-button").click(
			function(){
				if((neid == undefined) || (neid == null) || (neid == "clk"))
				{
					$.messager.alert("  警告  ","  添加失败！请选择对应设备后再进行添加 ","error");
					return;
				}
				
				if((neipaddr == undefined) || (neipaddr == null) || (neipaddr == "") || (neipaddr == "0") || (neipaddr == "clk"))
				{
					$.messager.alert(' 警告  ','  添加失败！该设备IP信息有误 ','error');
					return;
				}
				
				var addFlag = false;
					$.ajax
	  				({
	  				 	type : 'post',
	  					async:false, 
	  					data:{paramtype:0, neid:neid,nename:nename,netypeid:netypeid,netypename:netypename,
	  						nesuserid:nesuserid,neipaddr:neipaddr,totalurl:neipaddr},
	  					url:add_pingconfig_action_path,
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
						$('#pingconfig-datagrid').datagrid('reload');
						$('#add-ping-config-dialog').window('close'); 
						$.messager.alert("完成  ","  被选中的配置已添加成功!  ","info");
						//将变量复位
						var clk = "clk";
				    	neid = clk;
				    	nename = clk;
				    	netypeid = clk;
				    	netypename = clk;
						neipaddr = clk;
						nesuserid = clk;
						
					}
					else
					{
						$.messager.alert("  警告  ","  添加失败！该设备的告警配置已存在，如设备信息已发生改变，需修改配置，请删除后重新添加 ","warning");
					}
					


			}
	);

	/***************************************************************************************************/
	/**
	 * 取消按钮
	 */
	$("#ping-config-cancel-button").click(
			function(){
				$('#add-ping-config-dialog').window('close');
				//将变量复位
				var clk = "clk";
				neid = clk;
		    	nename = clk;
		    	netypeid = clk;
		    	netypename = clk;
				neipaddr = clk;
				nesuserid = clk;
			}
	);


});

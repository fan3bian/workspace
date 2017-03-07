/**
 * 
 */
<script type="text/javascript">
	
	$().ready(function (){
		
		var mems ={
				"1":["2","4"],
				"2":["2","4","8","16"],
				"4":["4","8","12","16","24","32"],
				"8":["8","16","24","32","64"],
				"16":["32","64"],
				"32":["64"],
				
		}
		var cpumem = [1,2,4,8,16,32]
		/**
		验证cpu离开时 内存和cpu的数量是否相匹配
		*/
	 	function blurcpu(cpunum){
		
		}
		var cputds = $("#baseinfo >tbody >tr >td[id^='cpunum']");
		cputds.each(function(i){
			var that = $(this);
		
		   $(this).bind("dblclick",function (){
				var detailid  = that.prev().children("input").val();
			   var selectStr = "<select id='cpuedit' name='cpuedit' >"+
			   " <option value='1'>1</option><option value='2'>2</option><option value='4'>4</option>"+
			   " <option value='8'>8</option><option value='16'>16</option><option value='32'>32</option>"+
			   " </select>";
		        $(this).html(selectStr); 
		        $("#cpuedit").die().live('blur',function (){
				 	var cpunum = $(this).val();
				 	var _obj =$(this).parent().next().text();
				 	 $(this).parent().text(cpunum);
					 var exist = $.inArray(parseInt(_obj) + '', mems[cpunum]);
					 if (exist != -1) {
						 that.css("background-color","");
						  that.next().css("background-color","");
					 } else {
					     alert("您改变了cpu的数量，和内存的设置不匹配，请修改内存参数或者cpu参数！");
					    that.css("background-color","red");
					    that.next().css("background-color","red");
					     return false;
					 }
					 
					 $.ajax({
						 url:'${pageContext.request.contextPath}/',
						 data:{
							 
							 flowid:$("#flowid").val(),
							 detailid:detailid
						 },
						 success:function (obj){
							 
							 
						 }
					 })
			   }); 
		   });
	 	});
		
		
		var memtds = $("#baseinfo >tbody >tr >td[id^='memnum']");
		memtds.each(function(i) {
		    $(this).bind("dblclick",
		    function() {
		        var cpunum = $(this).prev().html();
		        var arrmem = mems[cpunum];

		        var selectStr = "<select id='memedit' >";
		        for (i = 0; i < arrmem.length; i++) {
		            selectStr += "<option value='" + arrmem[i] + "'>" + arrmem[i] + "G</option>";
		        }
		        selectStr += "</select>";

		        $(this).html(selectStr);

		        $("#memedit").die().live('blur',
		        function() {
		            var memnum = $(this).val();
		            $(this).parent().text(memnum);
		        });
		    });
		});
		
		
		$("#listsave").click(function (){
			
			$("#listhandlerform").submit();
		});
	});
	
	function editdetil(orderid, detailid, vtable, pname, shopid){
		
		//$('#dd').dialog('close');
		debugger;
		//var _temp = $("#dd").parent();
		//console.log($(_temp).html());
		var tab = $('#tabs').tabs('getSelected');
		//var tab = $('#tab-user-right').tabs('getSelected');  
        var tbId = tab.attr("id");  
        //获取tab的iframe对象  
        tab.panel('refresh', "${pageContext.request.contextPath}/workorder/getOrderChangeMxPz.do");

       // tbIframe.attr("src",'www.baidu.com');
		//var index = $('#tabs').tabs('getTabIndex',tab);

		//$("#details").parent().dialog('close');
		/* jQuery.ajax( {
			url : "${pageContext.request.contextPath}/workorder/getOrderChangeMxPz.do",
			data : {'orderid' : orderid, 'detailid' : detailid, 'vtable' : vtable, 'pname' : pname},
			type : "post",
			cache : false,
			dataType : "html",
			success : function(result) {
				console.log($("#dd").dialog());
		//		$('.popup .bg .pz').html(result);
		//		var height = $('.popup .bg').outerHeight();
		//        $('.popup .bg').css('margin-top',-(height/2));
			}
		});	 */
	}
	
	</script>
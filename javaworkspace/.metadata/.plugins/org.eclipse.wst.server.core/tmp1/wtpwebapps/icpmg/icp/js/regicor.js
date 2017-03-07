$(function() {
	vEffectcor();
});

function vEffectcor() {
	$('.register select').each(function() {
		if (!$(this).parents().hasClass('register-link')) {
			$(this).select({
				endFun:function(param,text,dataPath,_this){
					/*console.log(param)
					console.log(text)
					console.log(dataPath)
					console.log(_this)*/
					
					if(_this.attr('id')=='provid')
					{
						onSelectChange(dataPath,'cityid');
						$("#psel").remove();
					}else if(_this.attr('id')=='oneid')
					{
						onTradeSelChange(dataPath,'twoid');
						$("#tsel").remove();
					}else if(_this.attr('id')=='twoid')
					{
						onTradeSelChange(dataPath,'threeid');
						$("#tsel").remove();
					}else
					{
						$("#csel").remove();
						
					}
				}
			}
					
					
			);
		}
	});
	$('.register .text')
			.on(
					{
						'focus' : function() {
							$(this).removeClass('errorActive');
							$(this).addClass('focusActive');
							$("#" + $(this).attr('id') + "_span").remove();
							// $(this).parent().remove($($(this).attr('id')+'_span'));
							// if($($(this).attr('id')+'_span')){
							// $($(this).attr('id')+'_span').remove();
							// }
						},
						'blur' : function() {
							$(this).removeClass("focusActive");
							var flag = isValid($(this).attr('id'), $(this)
									.val(), '');
							if (flag != 0) {
								$(this).addClass('errorActive');
								$(this)
										.parent()
										.append(
												'<span id="'
														+ $(this).attr('id')
														+ '_span" class="validatorfailure"><img src="'+path+'/icp/images/icon/error.png"/>'
														+ getAlertMsg(flag)
														+ '</span>');
							}

						}
					});

	$('.register .file-cell').each(function() {
		var mark = $(this).siblings('.file-mark');
		$(this).find('input[type="file"]').change(function() {
			mark.text($(this).val());
		});
	});

}
function isValid(id, value) {
	switch (id) {
	case 'cmpyname':
		return cmpyCheck(value);
//	case 'cmpycode':
//		//return cmpycodeCheck(value);
	case 'contactperson':
		return contpCheck(value);
//	case 'contactmobile':
//	//	return mobiCheck(value);
//	case 'cmpyaddr':
//		//return cmpyaCheck(value);
//	case 'cmpytel':
//	//	return contmCheck(value);
//	case 'zipcode':
//		//return zcCheck(value);
	default:
		return 0;
	}
}

function getAlertMsg(flag) {
	switch (flag) {
	case 1:
		return "不能为空";
	case 8:
		return "至少两个数字、字母、横线";
	case 9:
		return "必须纯数字";
	case 10:
		return "手机号码格式不正确";
	case 11:
		return "电话号码格式不正确";
	case 12:
		return "只能使用汉字或英文字母,长度大于2,小于20";
	case 13:
		return "邮编格式不正确";
	case 14:
		return "请选择所在地";
	case 15:
		return "请选择公司行业";
	case 16:
		return "请选择了解途径";
	case 17:
		return "请上传营业执照";
	case 18:
		return "只支持jpg/jpeg/gif格式";
	case 19:
		return "只支持png/jpg/jpeg格式";
	case 20:
		return "请上传LOGO";
	default:
		return "未知错误";
	}

}

function cmpyCheck(value)
{
	if ($.trim(value) == '') {
		return 1;
	}else if (!/^[\u4E00-\u9FA5a-zA-Z]{2,20}$/.test(value)) {
		return 12;
	}
	return 0;
}

function cmpycodeCheck(value)
{
	if ($.trim(value) == '') {
		return 1;
	}else if (!/^[a-zA-Z0-9-]{2,20}$/.test(value)) {
		return 8;
	}
	return 0;
}

function contpCheck(value)
{
	if ($.trim(value) == '') {
		return 1;
	}else if (!/^[\u4E00-\u9FA5a-zA-Z]{2,20}$/.test(value)) {
		return 12;
	}
	return 0;
}

function mobiCheck(value) {
	if ($.trim(value) == '') {
		return 1;
	} else if (!/^[0-9]*$/.test(value)) {
		return 9;
	} else if (!/^1[3|5|7|8|][0-9]{9}$/.test(value)) {
		return 10;
	}
	return 0;
}

function contmCheck(value)
{
	if ($.trim(value) == '') {
		return 1;
	}else if (!/^([0-9]{3,4}\-)?[0-9]{7,8}$/.test(value)) {
		return 11;
	}
	return 0;
	}
function cmpyaCheck(value)
{
	if ($.trim(value) == '') {
		return 1;
	}
	return 0;
	}
function zcCheck(value)
{
	if ($.trim(value) == '') {
		return 1;
	}else if (!/^[1-9][0-9]{5}$/.test(value)) {
		return 13;
	}
	return 0;
}
function check() {
	var isVa = true;
	
	$("#psel").remove();
	$("#tsel").remove();
	$("#csel").remove();
	$("#bizmsg").remove();
	$("#logomsg").remove();
	//$('#provid').find("option:selected").text();
//	if(!$('#provid').val() || !$('#cityid').val() || $('#cityid').val()=="" || $('#provid').val()=="")
//	{
//		$('#provid').parent().parent().parent().append('<div id="psel" class="msg"><img src="'+path+'/icp/images/icon/error.png"/>'+getAlertMsg(14)+'</div>');
//		isVa = false;
//	}
	
	if(!$('#oneid').val() || !$('#twoid').val() || $('#oneid').val()=="" || $('#twoid').val()=="" || !$('#threeid').val() || $('#threeid').val()=="" )
	{
		$('#threeid').parent().parent().parent().append('<div id="tsel" class="msg"><img src="'+path+'/icp/images/icon/error.png"/>'+getAlertMsg(15)+'</div>');
		isVa = false;
	}
//	if(!$('#channel').val() || $('#channel').val()=="" )
//	{
//		$('#channel').parent().parent().parent().append('<div id="csel" class="msg"><img src="'+path+'/icp/images/icon/error.png"/>'+getAlertMsg(16)+'</div>');
//		isVa = false;
//	}
	
	if($('#bizlic').val() == ""){
//		$('#bizlic').parent().parent().parent().parent().parent().append('<div id="bizmsg" class="msg"><img src="'+path+'/icp/images/icon/error.png"/>'+getAlertMsg(17)+'</div>');
//		isVa = false;
	}else
	{
		var bizlic = $('#bizlic').val();
		var format = bizlic.substring(bizlic.lastIndexOf("."),bizlic.length).toLowerCase();
		if(!/\.jpg$|\.jpeg$|\.gif$/i.test(format)){
			$('#bizlic').parent().parent().parent().parent().parent().append('<div id="bizmsg" class="msg"><img src="'+path+'/icp/images/icon/error.png"/>'+getAlertMsg(18)+'</div>');
			isVa = false;
		}
	}
	if($('#logofile').val() == ""){
//		$('#logofile').parent().parent().parent().parent().append('<div id="logomsg" class="msg"><img src="'+path+'/icp/images/icon/error.png"/>'+getAlertMsg(20)+'</div>');
//		isVa = false;
	}else
	{
		var logo = $('#logofile').val();
		var logofor = logo.substring(logo.lastIndexOf("."),logo.length).toLowerCase();
		if(!/\.jpg$|\.jpeg$|\.png$/i.test(logofor)){
			$('#logofile').parent().parent().parent().parent().append('<div id="logomsg" class="msg"><img src="'+path+'/icp/images/icon/error.png"/>'+getAlertMsg(19)+'</div>');
			isVa = false;
		}
	}
	
	$('.register .text')
			.each(
					function() {
						if ($(this).hasClass('errorActive')) {
							isVa = false;
						} else if (!$(this).is(":hidden")) {
							var flag = isValid($(this).attr('id'), $(this)
									.val(), '');
							if (flag != 0) {
								$(this).addClass('errorActive');
								$(this)
										.parent()
										.append(
												'<span id="'
														+ $(this).attr('id')
														+ '_span" class="validatorfailure"><img src="'+path+'/icp/images/icon/error.png"/> '
														+ getAlertMsg(flag)
														+ '</span>');
								isVa = false;
							}
						}
					});
	
	
	if(isVa)
	{
		$("#provname").val($('#provid').find("option:selected").text()); 
		$("#cityname").val($('#cityid').find("option:selected").text()); 
		$("#oneidname").val($('#oneid').find("option:selected").text()); 
		$("#twoidname").val($('#twoid').find("option:selected").text());
		$("#threeidname").val($('#threeid').find("option:selected").text());
	}
	return isVa;
}

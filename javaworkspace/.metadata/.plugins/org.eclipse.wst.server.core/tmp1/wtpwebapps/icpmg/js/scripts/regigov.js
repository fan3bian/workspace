$(function() {
	vEffectgov();
});

function vEffectgov() {
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
	case 'unitname':
		return unitCheck(value);
	case 'contactperson':
		return contpCheck(value);
	case 'contactpart':
		return offiCheck(value);
	case 'officeloc':
		return offiCheck(value);
	case 'contacttel':
		return contmCheck(value);
	default:
		return 0;
	}
}

function getAlertMsg(flag) {
	switch (flag) {
	case 1:
		return "不能为空";
	case 9:
		return "必须纯数字";
	case 11:
		return "电话号码格式不正确";
	case 12:
		return "只能使用汉字或英文字母,长度大于2";
	case 14:
		return "请选择所在地";
	case 19:
		return "只支持png格式";
	case 20:
		return "请上传LOGO";
	default:
		return "未知错误";
	}

}

function unitCheck(value)
{
	if ($.trim(value) == '') {
		return 1;
	}else if (!/^[\u4E00-\u9FA5a-zA-Z]{2,20}$/.test(value)) {
		return 12;
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
		return 11;
	}
	return 0;
}

function contmCheck(value)
{
	if ($.trim(value) == '') {
		return 1;
	}else if (!/^([0-9]{3,4}\-)?[0-9]{7,8}$/.test(value)&&(!/^1[3|5|7|8|][0-9]{9}$/.test(value))) {
		return 11;
	}
	return 0;
	}
function offiCheck(value)
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
	
	$("#logomsg").remove();
	if($('#logofile').val() == ""){
		$('#logofile').parent().parent().parent().parent().append('<div id="logomsg" class="msg"><img src="'+path+'/icp/images/icon/error.png"/>'+getAlertMsg(20)+'</div>');
		isVa = false;
	}else
	{
		var logo = $('#logofile').val();
		var logofor = logo.substring(logo.lastIndexOf("."),logo.length).toLowerCase();
		if(!/\.png$/i.test(logofor)){
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
	
	
	return isVa;
}

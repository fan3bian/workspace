// 滑块1初始
$('.j-silde').slider({
    width: 300,
    value: 10,
    showTip: true,
    min: 1,
    max: 2000,
    step: 10,
    rule: [1, 2000],
    tipFormatter: function(value) {
        return value + 'GB';
    },
    onChange: function(value) {
        $(this).parents(".j-xtp-item").find('.j-value').val(value);
    }
});

// 数据盘容量手动输入
$(document).on('blur', '.j-value', function() {
    if (value % 10 != 0) {
        var yu = 10 - parseInt(value % 10);
        value = parseInt(value) + parseInt(yu);
        $(this).val(value);
        $(this).parents(".j-xtp-item").find('.j-silde').slider(
            'setValue', value
        )
        return true;
    }
})
$(document).on('keyup', '.j-value', function() {
    this.value = this.value.replace(/\D/g, '')
    value = this.value;
    if (value > 2000) {
        value = 2000;
        $(this).val(value);
    }
    $(this).parents(".j-xtp-item").find('.j-silde').slider(
        'setValue', value
    )
    return true;
});
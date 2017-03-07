   
 function nTabs(thisObj, active) {

        if (thisObj.className == active) return;
        var tabList = $(thisObj).parent('ul').find('li');
        $(thisObj).addClass(active).siblings().removeClass(active);

    }
    // 加减
    $(document).on('click', '.j-subtn', function() {
        var subval = $(this).parent().find(".input-num");
        if (parseInt(subval.val()) > 1)
            subval.val(parseInt(subval.val()) - 1)
    });
    $(document).on('click', '.j-addbtn', function() {
        var subval = $(this).parent().find(".input-num");
        subval.val(parseInt(subval.val()) + 1)
    });
    function onlyNum() {
        if (!(event.keyCode == 46) && !(event.keyCode == 8) && !(event.keyCode == 37) && !(event.keyCode == 39))
            if (!((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105)))
                event.returnValue = false;
    }

// 数量加减
    $(document).on('click', '#subBtn', function() {
        var subval = $(this).parent().find(".input-num");
        if (parseInt(subval.val()) > 1)
            subval.val(parseInt(subval.val()) - 1)
    });
    $(document).on('click', '#addBtn', function() {
        var subval = $(this).parent().find(".input-num");
        subval.val(parseInt(subval.val()) + 1)
       
    });
    
    $(document).on('click', '#subBtn_other', function() {
        var subval = $(this).parent().find(".input-num");
        if (parseInt(subval.val()) > 1)
            subval.val(parseInt(subval.val()) - 1)
    });
    $(document).on('click', '#addBtn_other', function() {
        var subval = $(this).parent().find(".input-num");
        subval.val(parseInt(subval.val()) + 1)
    });
    

    $(document).on("click", "#serviceWindow2 .j-toadd", function() {
  
        var clonestr = '<div class="j-com">                 <p class="lcy-com">                        <label for="">类型</label><select name="" id="">                            <option value="">请选择</option> <option value="unicom">联通</option><option value="mobile">移动</option> <option value="telecom">电信</option>                         </select>                    </p>                    <p class="lcy-com">                        <label for="">数量</label>                        <a class="sub-btn" id="subBtn" href="javascript:void(0)">-</a>                        <input class="input-num" type="text" value="1">                        <a class="add-btn" id="addBtn" href="javascript:void(0)">+</a>                    </p>                    <p class="lcy-com">                        <label for="">宽带</label>                        <input class="j-numberbox" style="height: 21px; width: 82px;" />                    </p>                    <a href="javascript:void(0)" class="tosub j-tosub">-</a>                </div>'
        $('#serviceWindow2 .j-line').append(clonestr);
        
        $("#serviceWindow2 .j-tosub").css({
            display: 'inline-block'
        });
        $(' #serviceWindow2 .j-com:last').find('.j-tosub').hide();
        $('#serviceWindow2 .j-numberbox:last').numberbox({
            min: 0,
            max: 20,
            precision: 0
        });
        $('#serviceWindow2').css({
            height: 'auto'
        });

    });
   
    
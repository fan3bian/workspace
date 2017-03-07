/**
 * Created by sunjiyun on 2016/1/5.
 */
function gov2(){};
gov2.prototype={

    //js获取项目根路径，如： http://localhost:8083/uimcardprj
    getRootPath:function () {
        //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
        var curWwwPath = window.document.location.href;
        //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
        var pathName = window.document.location.pathname;
        var pos = curWwwPath.indexOf(pathName);
        //获取主机地址，如： http://localhost:8083
        var localhostPaht = curWwwPath.substring(0, pos);
        //获取带"/"的项目名，如：/uimcardprj
        var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
        return (localhostPaht + projectName+"/");
    },

    initSecondMenu:function(){
        var that = this;
        alert($("#parentid").val());
        $.ajax({
            url:'../usermenu/userMenu.do',
            type:'post',
            dataType:'json',
            data:{parentId:$("#parentid").val()},
            success:function(data){
                for(var i=0,l=data.length;i<l;i++){
                    li = $("<li></li>")
                    li.append($("<a>"+data[i]['fName']+"</a>").attr("href",that.getRootPath()+data[i]['hostName']))
                    $(".sub-menu-new").children("ul").append(li)
                }
            }
        })
    }
}

gov2 = new gov2();




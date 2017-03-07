<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.jspsmart.upload.*;"%>
<html>
<head>
  <base target="_self"/> 	
</head>
<body>

 <form action="uploadImage.jsp" method="post">
<%     SmartUpload mySmartUpload =new SmartUpload(); //上传文件的限制大小
long file_size_max=4000000; String fileName2="",ext="",testvar=""; //应保证在根目录中有此目录的存在（也就是说需要自己建立相应的文件夹） 
String url=request.getParameter("folerPath"); //初始化 
//String url="/upload/";
String filenamea="";

mySmartUpload.initialize(pageContext); //只允许上载此类文件
 try { mySmartUpload.setAllowedFilesList("bmp,jpg,png,gif,JPG,PNG");//此处的文件格式可以根据需要自己修改 
 
 //上载文件
  mySmartUpload.upload(); }
   catch (Exception e){ //上传类型出现异常%>
<SCRIPT language=javascript> alert("只允许上传图片"); 
document.forms[0].submit(); 
</script>
<% } try{ //得到上传的文件
com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0); 
//如果文件获得为空
if (myFile.isMissing()){%>
<SCRIPT language=javascript> alert("请先选择要上传的文件"); 
document.forms[0].submit(); 
</script>
<%}
 //得到了上传的文件
 else{ //
 String myFileName=myFile.getFileName(); 
 //取得上载的文件的文件名
  ext= myFile.getFileExt(); 
  //取得后缀名 
  int file_size=myFile.getSize(); 
  //取得文件的大小 
  String saveurl=""; 
  //如果文件没有超过限制上传的大小
  if(file_size<file_size_max){ 
  //更改文件名，取得当前上传时间的毫秒数值
   Calendar calendar = Calendar.getInstance(); 
   String filename = String.valueOf(calendar.getTimeInMillis());
    saveurl=url;
    filenamea="";
    //保存路径 
    saveurl+=filename+"."+ext; 
    filenamea+=filename+"."+ext; 
    //接受普通参数	
    Request req = mySmartUpload.getRequest(); 
    String bt=(String)req.getParameter("mcdb_content");
    String linkurl = (String)req.getParameter("linkUrl");
    myFile.saveAs(saveurl,SmartUpload.SAVE_PHYSICAL);
     out.print(filenamea+" 上传成功 !<br>"); 
     } 
     } 
     }catch (Exception e){
      out.print("上传失败  ! "+e.toString()); 
      } %>

  <input type="button" onclick="close1()" value="确 定">
   </form>
  </body>
</html>     
      
<SCRIPT language=javascript>
    function close1(){
      window.returnValue='<%=filenamea%>';
      window.close();
    }
</SCRIPT>
      
      
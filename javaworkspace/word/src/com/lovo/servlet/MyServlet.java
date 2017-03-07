package com.lovo.servlet;  
  
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import com.lovo.util.WordGenerator;  
  
/** 
 * Servlet implementation class MyServlet 
 */  
public class MyServlet  {  
    private static final long serialVersionUID = 1L;  
  
    protected void service () throws IOException {  
//        req.setCharacterEncoding("utf-8");  
        Map<String, Object> map = new HashMap<String, Object>();  
//        Enumeration<String> paramNames = req.getParameterNames();  
        // ͨ��ѭ���������������ֵ��ӳ����  
//        while(paramNames.hasMoreElements()) {  
//            String key = paramNames.nextElement();  
//            String value = req.getParameter(key);  
//            map.put(key, value);  
//        }  
      
        // ��ʾ���ڵ��ù���������Word�ĵ�֮ǰӦ����������ֶ��Ƿ�����  
        // ����Freemarker��ģ�������ڴ���ʱ���ܻ���Ϊ�Ҳ���ֵ������ ������ʱ�������������  
        File file = null;  
        InputStream fin = null;  
//        ServletOutputStream out = null;  
        try {  
            // ���ù�����WordGenerator��createDoc��������Word�ĵ�  
            file = WordGenerator.createDoc(map, "resume");  
            fin = new FileInputStream(file);  
              
//            resp.setCharacterEncoding("utf-8");  
//            resp.setContentType("application/msword");  
//            // ��������������صķ�ʽ������ļ�Ĭ����Ϊresume.doc  
//            resp.addHeader("Content-Disposition", "attachment;filename=resume.doc");  
              
//            out = resp.getOutputStream();  
            byte[] buffer = new byte[512];  // ������  
            int bytesToRead = -1;  
            // ͨ��ѭ���������Word�ļ�������������������  
            while((bytesToRead = fin.read(buffer)) != -1) {  
//                out.write(buffer, 0, bytesToRead);  
            }  
        } finally {  
            if(fin != null) fin.close();  
//            if(out != null) out.close();  
            if(file != null) file.delete(); // ɾ����ʱ�ļ�  
        }  
    }  
    public static void main(String[] args) {
		
	}
}  
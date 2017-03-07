package com.favccxx.secret.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

public class DocUtil {
	private Configuration configure = null;

	public DocUtil() {
		configure = new Configuration();
		configure.setDefaultEncoding("utf-8");
	}

	/**
	 * ����Docģ������word�ļ�
	 * 
	 * @param dataMap
	 *            Map ��Ҫ����ģ�������
	 * @param fileName
	 *            �ļ�����
	 * @param savePath
	 *            ����·��
	 */
	public void createDoc(Map<String, Object> dataMap, String downloadType, String savePath) {
		try {
			// ������Ҫװ���ģ��
			Template template = null;
			// ����ģ���ļ�
			configure.setClassForTemplateLoading(this.getClass(), "/com/favccxx/secret/util");
			// ���ö����װ��
			configure.setObjectWrapper(new DefaultObjectWrapper());
			// �����쳣������
			configure.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
			// ����Template����,ע��ģ������������downloadTypeҪһ��
			template = configure.getTemplate(downloadType + ".xml");
			// ����ĵ�
			File outFile = new File(savePath);
			Writer out = null;
			out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "utf-8"));
			template.process(dataMap, out);
			outFile.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		/**
		 * �����������ͻ�ȡ��Ҫ���ݵ�Map����
		 * @param oid ����Id
		 * @param downloadType ��������
		 */
	}
}
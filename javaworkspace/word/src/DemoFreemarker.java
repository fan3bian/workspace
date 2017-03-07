import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;

public class DemoFreemarker {

	public static void main(String[] args) {
		creatWord();
	}
	
	public static void creatWord() {
		try {
			Configuration cfg = new Configuration();
			cfg.setDefaultEncoding("utf-8");
			cfg.setDirectoryForTemplateLoading(new File(""));
			cfg.setObjectWrapper(new DefaultObjectWrapper());

			Template temp = cfg.getTemplate("zhang.ftl");
			temp.setEncoding("utf-8");
			
			Map root = new HashMap();
			root.put("zhang", "张淑一");
			root.put("user", "sb");
			List rows = new ArrayList();
			for (int j=1; j<5; j++) {
				List row = new ArrayList();
				for (int i=1; i<16; i++) {
					row.add(j+""+i);
				}
				rows.add(row);
			}
			root.put("rows", rows);
			String docName ="temp"+ (Math.random()*10000)+".doc";
			File docFile = new File(docName);
			Writer docout = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(docFile)));
			temp.process(root, docout);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
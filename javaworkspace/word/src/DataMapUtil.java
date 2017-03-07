import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class DataMapUtil {
       
    private static Map<String, Object> dataMap = new HashMap<String, Object>();
       
    /**
     * 将对象转换成Map
     * @param obj 对象类
     * @return
     */
    public static Map<String,Object> setObjToMap(Object obj){
        Class c;
        try {
            c = Class.forName(obj.getClass().getName());
            Method[] methods = c.getMethods();
            for(int i=0,l=methods.length;i<l;i++){
                String method = methods[i].getName();
                System.out.println("The method is:" + method);
                if(method.startsWith("get")){
                    Object value = methods[i].invoke(obj);
                    if(value != null){
                        if(value.getClass().getClassLoader() != null){  //处理自定义的对象类型
                            setObjToMap(value);
                        }
                        String key = method.substring(3);
                        key = key.substring(0, 1).toLowerCase() + key.substring(1);
                        if("java.util.Date".equals(value.getClass().getName())){
                            value = ((Date)value).toString();
                        }
                        dataMap.put(key, value);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataMap;
    }
    /**
     * 根据下载类型获取需要传递的Map参数
     * @param oid 对象Id
     * @param downloadType 下载类型
     */
    private Map<String, Object> getDataMap(String oid,String downloadType){
        Map<String, Object> dataMap = new HashMap<String, Object>();
//        if("Parameter1".equals(downloadType)){
//            dataMap = DataMapUtil.setObjToMap();
//        }else{
//            dataMap = DataMapUtil.setObjToMap(Object2);
//        }
        dataMap = DataMapUtil.setObjToMap(downloadType);
        return dataMap;
    }
    public static void main(String[] args) {
		
	}
}
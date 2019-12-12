public class CommonUtil {
    public static String fetchAllFields(String type){
        //Adding comments to the file in a branch
        Schema.sObjectType sObjectType = Schema.getGlobalDescribe().get(type);           
        Map<String,Schema.SObjectField> fieldsMap = sObjectType.getDescribe().fields.getMap();
        String fields = '';
        for(String key : fieldsMap.keySet()) {
            fields = fields + key + ',';
        }
        
        if(fields.endsWith(',')){
            fields = fields.substring(0, fields.length() -1);
        }    
        return fields;
    } 
}

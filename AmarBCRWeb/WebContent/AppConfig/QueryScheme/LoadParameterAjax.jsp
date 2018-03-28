<%@page import="com.amarsoft.app.awe.config.query.GenerateQuerySql"%>
<%@page import="com.amarsoft.are.util.json.*"%>
<%@page import="com.amarsoft.are.ARE"%>
<%@ page contentType="text/html; charset=GBK"%><%@
page import="java.util.*"%><%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

try{
	String sMajorObjClass = request.getParameter("MajorObjClass");
	String sJBOQL = request.getParameter("JBOQL");
	if (sMajorObjClass == null) sMajorObjClass = "";
	if (sJBOQL == null) sJBOQL = "";
	
	StringBuilder sb = new StringBuilder();
	JSONObject jos = JSONObject.createArray();
	
	GenerateQuerySql querySql = new GenerateQuerySql(sMajorObjClass, sJBOQL);
	//取查询语句的参数列表
	List list = querySql.getParameters();
	for(int i=0;i<list.size();i++){
		String sParameter = list.get(i).toString();
		JSONObject jo = JSONObject.createObject();
		jo.add(JSONElement.valueOf("Parameter", sParameter));
		jos.add(JSONElement.valueOf(jo));
	}
	//System.out.println(JSONEncoder.encode(jos));
	out.print(JSONEncoder.encode(jos));
}catch(Exception e){
    e.printStackTrace();
    ARE.getLog().error(e.getMessage(),e);
    throw e;
}%>
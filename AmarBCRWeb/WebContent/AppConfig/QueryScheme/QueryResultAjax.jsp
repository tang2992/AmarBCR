<%@page import="java.util.List"%>
<%@page import="com.amarsoft.are.ARE"%>
<%@page import="com.amarsoft.app.awe.config.query.ASHtmlTableHandler"%>
<%@page import="com.amarsoft.are.jbo.*"%>
<%@ page contentType="text/html; charset=GBK"%><%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

try{
	String sMajorObjClass = request.getParameter("MajorObjClass");
	String sJBOQL = request.getParameter("JBOQL");
	String sParameters = request.getParameter("Parameters");
	String sRowLimitChecked = request.getParameter("RowLimitChecked");
	String sRowLimit = request.getParameter("RowLimit");
	if(sMajorObjClass == null) sMajorObjClass = "";
	if(sJBOQL == null) sJBOQL = "";
	if(sParameters == null) sParameters = "";
	if(sRowLimit == null) sRowLimit = "0";
	int iRowLimit = Integer.valueOf(sRowLimit);
	
	//String sExportFields = "";
	//if(sExportFields == null) sExportFields = "*"; 
	
	//��JBO�б������׵�html�б�
	BizObjectQuery q = JBOFactory.getFactory().getManager(sMajorObjClass).createQuery(sJBOQL);
	//��query�Ĳ�����ֵ
	if (sParameters.indexOf("@") != -1) {
		sParameters = sParameters.substring(1);
		String [] as = sParameters.split(",");
		for (int i =0 ; i < as.length; i++) {
			String [] v = as[i].split("@");
			if (v.length > 1) {
				q.setParameter(v[0].trim(), v[1].trim());
			}
		}
	}
	
	//���趨�������Ƶģ�����query���������
	if(sRowLimitChecked.equals("true")){
		q.setMaxResults(iRowLimit);
	}
	//ȡ��JBO�б�
	List list = q.getResultList(false);
	//��Ⱦ��html
	ASHtmlTableHandler ht = new ASHtmlTableHandler(list);
	ht.setTableAttribute("class='mdftbl'");
	ht.setHeaderAttribute("class='alce'");
	//ht.setExportFields(sExportFields);
	ht.setIncludeRowNumber(true);
	out.println(ht.getHtmlText());
}catch(Exception e){
    e.printStackTrace();
    ARE.getLog().error(e.getMessage(),e);
    throw e;
}finally{
}%>
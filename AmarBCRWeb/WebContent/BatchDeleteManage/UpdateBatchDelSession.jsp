<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head> 
<!-- 更新批删状态为不再上报 -->
<title>更新批删状态主页面</title>
</head>
<body>
<% 
	String sSql = "";
	String sReturn = "";
	String sTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("tableName")); 
	if(sTableName==null) sTableName="";
	String report = CurPage.getParameter("report");//上报标志
	if(report == null) report = "";
	String keyValue = CurPage.getParameter("keyValue");//主键
	if(keyValue == null) keyValue = "";
	
	String keyStr = null;
	String valueStr = null;
	
	try{
		BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
		String jboWhere = "";
		String[] kv = keyValue.split("~");
		keyStr = kv[0];
		valueStr = kv[1];
		String[] kArr = keyStr.split("`");
		String[] vArr = valueStr.split("`");
		for(int ii=0; ii<kArr.length; ii++){
			String k = kArr[ii];
			String v = vArr[ii];
			jboWhere = jboWhere+" and "+k+"=:"+k;
		}
		jboWhere = jboWhere.substring(4);
		BizObjectQuery bizQuery = boManager.createQuery("update O set sessionid='"+(report.equals("0")?"0000000000":"1111111111")+"' where " + jboWhere);
		for(int i=0;i<kArr.length;i++){
			bizQuery.setParameter(kArr[i], vArr[i]);
		}
		bizQuery.executeUpdate();
		
		sReturn = "Success";
	}catch(Exception e){	
		sReturn = "Failure";
		throw e;
	}
	finally
	{
	}
%>
</body>
</html>
<script type="text/javascript">
	top.returnValue="<%=sReturn%>";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>
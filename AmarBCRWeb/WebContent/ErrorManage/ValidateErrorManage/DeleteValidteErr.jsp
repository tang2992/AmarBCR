<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	
	Object oo= session.getAttribute("errType");
		if(oo == null){return ;}
		String[] record = ((String)session.getAttribute("errType")).split(",");
		int myBusinessType = (Integer.valueOf(record[0])).intValue();
		String myMainBusinessNo = record[1];
		String mySql = "";
		String myErrMSG = "";
		System.out.print(myBusinessType);
		mySql = "delete from BCR_ERRHISTORY where recordtype in ('811') and mainbusinessno ='"+myMainBusinessNo+"'";
		Sqlca.executeSQL(mySql);
		session.removeAttribute("errType");
		String sReturnValue = "ok";
%>
<%/*~END~*/%>
<script type="text/javascript">

	top.returnValue =  "<%=sReturnValue%>";
	top.close();
</script>

<%@ include file="/IncludeEnd.jsp"%>
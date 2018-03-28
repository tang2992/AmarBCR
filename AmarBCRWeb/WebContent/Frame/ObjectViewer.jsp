<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%><%@
 page import="com.amarsoft.awe.res.AppBizObject"%><%@
 page import="com.amarsoft.awe.res.ErrMsgManager"%><%
	//��ȡҳ��������������͡������š���ͼ���
	String sObjectType  = CurPage.getParameter("ObjectType");
	String sObjectNo  = CurPage.getParameter("ObjectNo");
	String sViewID = CurPage.getParameter("ViewID");
	//����ֵת��Ϊ���ַ���
	if(sObjectType == null) sObjectType = "";
	if(sObjectNo == null) sObjectNo = "";
	if(sViewID == null) sViewID = "";
	
    AppBizObject bom = new AppBizObject(Sqlca,sObjectType,sObjectNo);

    String sRightType = bom.getRightType(Sqlca,CurUser.getUserID(),sViewID);
    if(sRightType == null) sRightType="None";
    
    String sViewToOpen = "";
    if (sViewID.equals("") || sViewID.equalsIgnoreCase("null"))
        sViewToOpen = bom.getType().getDefaultView();
    else
        sViewToOpen = sViewID;      

    String sViews = bom.getType().getViewType();
    
    String sOjbectTypeURL = (String)bom.getType().getPagePath();
    String sObjectTitle = bom.getType().getObjectName()+"-"+bom.getName()+"-����"+(sRightType.equalsIgnoreCase("ReadOnly")?"-ֻ��":(sRightType.equalsIgnoreCase("all")?"-���޸�":"-��Ȩ��"));

	//��Component�д洢����
	CurComp.setAttribute("CompObjectType",sObjectType);
	CurComp.setAttribute("CompObjectNo",sObjectNo);
	CurComp.setAttribute("RightType",sRightType);
%>
<html>
<head>
<title><%=sObjectTitle%></title>
<script type="text/javascript">
	setDialogTitle("&nbsp;&nbsp;<b><%=sObjectTitle%></b>");
</script>
</head> 
<body leftmargin="0" topmargin="0" class="pagebackground" style="overflow: auto;overflow-x:visible;overflow-y:visible">
   <table align='center' cellspacing=0 cellpadding=0 border=0 width=100% height="100%">
      <tr>
           <td>
                <%if (sRightType!=null && sRightType.equalsIgnoreCase("None")){%>
                	�Բ�����û�в鿴[<%if(bom.getName()!=null){%><%=bom.getName()%><%} %>]��ͼ["+sViewToOpen+"]��Ȩ��.
                <%}else{%>
					<iframe name="DeskTopInfo" src="<%=com.amarsoft.awe.util.Escape.getBlankJsp(sWebRootPath,"���ڴ�ҳ��,���Ժ�...")%>" width=100% height=100% frameborder=0 hspace=0 vspace=0 marginwidth=0 marginheight=0></iframe>
			    <%}%>
			</td>
      </tr>                         
   </table>
</body>
</html>
<script type="text/javascript">
	<%if (sRightType!=null && sRightType.equalsIgnoreCase("None")){%>
		alert("�Բ�����û�в鿴����["+bom.getName()+"]��ͼ["+sViewToOpen+"]��Ȩ��.");
	<%}else{%>
		OpenComp("<%=sViews%>","<%=sOjbectTypeURL%>","ObjectType=<%=sObjectType%>&ObjectNo=<%=sObjectNo%>&ViewID=<%=sViewToOpen%>&ToInheritObj=y","DeskTopInfo","");
	<%}%>
</script>
<%@ include file="/IncludeEnd.jsp"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
 	String sDoNo = CurPage.getParameter("DONO");
	if(sDoNo==null) sDoNo = "";
 	//����strip���飺
 	//������0.�Ƿ���ʾ, 1.���⣬2.�߶ȣ�3.���ID��4.URL��5����������6.�¼�
	String sStrips[][] = {
		{"true","ģ��Ŀ¼��Ϣ" ,"300","","/AppConfig/PageMode/DWConfig/DataObjectCatalogInfo.jsp","DONO="+sDoNo,""},
		{"true","ģ�嶨����Ϣ" ,"600","","/AppConfig/PageMode/DWConfig/DataObjectLibraryList.jsp","DONO="+sDoNo,""},
	};
 	String sButtons[][] = {};
%><%@include file="/Resources/CodeParts/Strip05.jsp"%>
<script type="text/javascript">	
	setDialogTitle("DataWindow��ʾģ������");
	setSelectedStrip(1); //Ĭ�ϴ���
</script>
<%@ include file="/IncludeEnd.jsp"%>
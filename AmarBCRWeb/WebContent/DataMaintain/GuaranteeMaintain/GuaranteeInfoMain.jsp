<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	/*
		ҳ��˵��:ʾ��ģ����ҳ��
	 */
	String sTitle=CurPage.getParameter("IsQuery");  
 	String PG_TITLE="";
 	String PG_CONTENT_TITLE="";
    if("true".equals(sTitle)){
    	PG_TITLE = "������Ϣ��ѯ"; // ��������ڱ��� <title> PG_TITLE </title>
    	PG_CONTENT_TITLE = "&nbsp;&nbsp;������Ϣ��ѯ&nbsp;&nbsp;"; //Ĭ�ϵ�����������
    }else{
    	PG_TITLE = "������Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
    	PG_CONTENT_TITLE = "&nbsp;&nbsp;������Ϣά��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
    }
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//���ҳ�����
    	String IsQuery=CurPage.getParameter("IsQuery");
       if(IsQuery==null) IsQuery="";

%><%@include file="/Resources/CodeParts/Main04.jsp"%>

<script type="text/javascript">
myleft.width=1;
AsControl.OpenView("/DataMaintain/GuaranteeMaintain/GuaranteeInfoList.jsp","IsQuery=<%=IsQuery%>","right");
</script>

<%@ include file="/IncludeEnd.jsp"%>
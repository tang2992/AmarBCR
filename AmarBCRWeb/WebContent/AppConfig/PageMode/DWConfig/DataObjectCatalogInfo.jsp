 <%@ page contentType="text/html; charset=GBK"%><%@
  include file="/Frame/resources/include/include_begin_info.jspf"%><%
	//��ò���	
	String sDoNo = CurPage.getParameter("DONO");
	if(sDoNo==null) sDoNo = "";
        
	ASObjectModel doTemp = new ASObjectModel("DataObjectCatalogInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sDoNo);   
    
    String sButtons[][] = {
        {"true","All","Button","����","���������޸�","as_save(0)","","","","btn_icon_save"},
    };
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
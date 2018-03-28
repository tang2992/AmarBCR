<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	 String sOrgCode = CurPage.getParameter("OrgCode");
	 if(sOrgCode == null) sOrgCode = "";

	 ASObjectModel doTemp = new ASObjectModel("CONTACT_INFO"); 
	 doTemp.setJboWhere("OrgCode=:OrgCode");
	 if(StringX.isEmpty(sOrgCode)){
		 doTemp.setReadOnly("OrgCode", false);
		 doTemp.setVisible("UpdateUserName,UpdateOrgName,UpdateDate,InputUserid,InputUserName,InputOrgName,InputDate", false);
	 }

	 ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	 dwTemp.Style = "2";//freeform
	 dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	 dwTemp.genHTMLObjectWindow(sOrgCode);
	 String sButtons[][] = {
			{"true","All","Button","����","����","save()","","","",""},
		};
%>

<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">

	function save(){
		setItemValue(0,0,"UpdateUserid","<%=CurUser.getUserID()%>");
    	setItemValue(0,0,"UpdateOrgid","<%=CurUser.getOrgID()%>");
    	setItemValue(0,0,"UpdateDate","<%=DateX.format(new java.util.Date())%>");
		as_save('myiframe0','');
	}
	
	function initRow()
	{
		if (getRowCount(0)==0) //���û���ҵ���Ӧ��¼��������һ�����������ֶ�Ĭ��ֵ
		{
			setItemValue(0,0,"OrgCode","<%=sOrgCode%>");
	    	setItemValue(0,0,"InputUserid","<%=CurUser.getUserID()%>");
	    	setItemValue(0,0,"InputOrgid","<%=CurUser.getOrgID()%>");
	    	setItemValue(0,0,"InputDate","<%=DateX.format(new java.util.Date())%>");
		}
	}
	
	initRow();
</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>

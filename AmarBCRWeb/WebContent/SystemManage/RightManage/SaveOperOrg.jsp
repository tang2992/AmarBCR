<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author:   qhhui
		Tester:
		Content: �û���ɫ�б�
		Input Param:
                  
		Output param:
		                
		History Log: 
            
	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<%

	//�������
	String sSql = "";
    ASResultSet  rs = null;
	String sUserID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("UserID"));
	if (sUserID == null) sUserID = "";
	String sOrgID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OrgID"));
	if (sOrgID == null) sOrgID = "";
	String sOrgSortNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("SortNo"));
	if (sOrgSortNo == null) sOrgSortNo = "";
	String sResult = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("Result"));
	if (sResult == null) sResult = "";
	String sBankID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("BankID"));
	if (sBankID == null) sBankID = "";
	  
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	
	
	SqlcaRepository.executeSQL(" delete from USER_ORG where UserID = '"+sUserID+"' AND ORGID IN (SELECT ORGID FROM ORG_INFO WHERE SORTNO LIKE '"+sOrgSortNo+"%')");
	if(sResult.equals("insert_no_relative")){
		SqlcaRepository.executeSQL(" insert into USER_ORG(UserID,OrgID,BankID,Grantor,InputUser,InputOrg,InputTime,Status) "+
	         " values('"+sUserID+"','"+sOrgID+"','"+sBankID+"','"+CurUser.getUserID()+"','" + CurUser.getUserID()+"','"+CurUser.getOrgID()+"','"+StringFunction.getToday()+" "+StringFunction.getNow()+"','1')");
	}
	if(sResult.equals("insert_relative")){
		 sSql = "select ORGID,BANKID from ORG_INFO where SORTNO like '"+sOrgSortNo+"%'";
    	 rs = Sqlca.getASResultSet(sSql);
       	 String sSubOrgID = "",sSubBankID="";
       	 while(rs.next()){
       		sSubOrgID = rs.getString(1);
       		sSubBankID = rs.getString(2);
       		if(sSubBankID!=null)
       	 		SqlcaRepository.executeSQL("insert into USER_ORG(UserID,OrgID,BankID,Grantor,InputUser,InputOrg,InputTime,Status)"
       	 		    + " values('"+sUserID+"','"+sSubOrgID+"','"+sSubBankID+"','"+CurUser.getUserID()+"','" + CurUser.getUserID()+"','"+CurUser.getOrgID()+"','"+StringFunction.getToday()+" "+StringFunction.getNow()+"','1')");
         }
	}
	if(rs!=null) rs.close();
%>
<%/*~END~*/%>
<<script type="text/javascript">
	self.close();
</script>

<%@ include file="/IncludeEnd.jsp"%>

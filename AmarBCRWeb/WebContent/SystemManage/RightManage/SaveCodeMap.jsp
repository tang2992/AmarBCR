<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author:   hywang
		Tester:
		Content: 保存新增的机构到codemap中
		Input Param:
                  
		Output param:
		                
		History Log: 
            
	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List02;Describe=定义变量，获取参数;]~*/%>
<%

	//定义变量
	String sSql = "";
    ASResultSet  rs = null;
	
	String sOrgID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OrgID"));
	if (sOrgID == null) sOrgID = "";
	
	String sBankID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("BankID"));
	if (sBankID == null) sBankID = "";
	
	String sOrgName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OrgName"));
	if (sOrgName == null) sOrgName = "";
	  
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	
	sSql = " select count(*) from ECR_CODEMAP where COLNAME='6501' and CTCODE='" +sOrgID +"'";
	rs = Sqlca.getASResultSet(sSql);
	int count = 0;
	if(rs.next()){
		count = rs.getInt(1);
	}
	if(count ==0){
		SqlcaRepository.executeSQL(" insert into ECR_CODEMAP values('6501','"+sOrgID+"','"+sBankID+"','"+sOrgName+"')");
	}else{
		SqlcaRepository.executeSQL(" update ECR_CODEMAP set pbcode ='"+sBankID+"' where colName ='6501' and ctcode='"+sOrgID+"'");
	}
	if(rs!=null) rs.close();
	
%>
<%/*~END~*/%>
<script type="text/javascript">

	self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>

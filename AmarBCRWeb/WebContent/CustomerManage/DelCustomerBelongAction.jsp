<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMD.jsp"%><%
	/*
		Content: 删除用户关联关系
		Input Param:
			CustomerID：客户编号					
		Output param:
			ReturnValue:返回值
				ExistApply:存在未终结的申请
				ExistApprove:存在未终结的最终审批意见
				ExistContract:存在未终结的合同
		History Log: 
				syang 2009/10/14 　删除用户关联关系，
				需要删除的不一定是当前用户的关系，
				因此，支持外部传入用户ID,如果没有传入用户ID,则默认使用当前用户，为了为原来的兼容
	 */
	//定义变量
	String sSql = "",sReturnValue = "";		
	int iCount = 0;
	ASResultSet rs = null;
	
	//获取页面参数：客户编号
	String sCustomerID   = CurPage.getParameter("CustomerID");
	String sUserID   = CurPage.getParameter("UserID");
	//将空值转化为空字符串
	if(sCustomerID == null) sCustomerID = "";
	if(sUserID == null || sUserID.length() == 0) sUserID = CurUser.getUserID();	//如果没有传入用户，则默认使用当前用户

	//计算未终结申请业务数
	/* sSql = " select count(SerialNo) from BUSINESS_APPLY "+
		   " where CustomerID = '"+sCustomerID+"' and PigeonholeDate is null and OperateUserID = '"+sUserID+"' " ;
	rs = Sqlca.getASResultSet(sSql);
	if(rs.next()) iCount = rs.getInt(1);
	rs.getStatement().close(); 		
	if (iCount == 0){	//申请业务全部终结
		//计算未终结最终审批意见业务数
		sSql = " select count(*) from BUSINESS_APPROVE "+
			   " where CustomerID = '"+sCustomerID+"' and PigeonholeDate is null and OperateUserID = '"+sUserID+"' " ;
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()) iCount = rs.getInt(1);
		rs.getStatement().close();
		if(iCount == 0){	//最终审批意见业务全部终结
			//计算未终结合同业务数
			sSql = " select count(*) from BUSINESS_CONTRACT "+
				   " where CustomerID = '"+sCustomerID+"' and FinishDate is null and ManageUserID = '"+sUserID+"' " ;
			rs = Sqlca.getASResultSet(sSql);
			if(rs.next()) iCount = rs.getInt(1);
			rs.getStatement().close();
			if (iCount == 0){	//合同业务全部终结 */
				//可以删除所属信息
				Sqlca.executeSQL("Delete from  CUSTOMER_BELONG where CustomerID='"+sCustomerID+"'"+" and UserID='"+sUserID+"'");					
				sReturnValue = "DelSuccess";//该客户所属信息已删除！		
/* 			}else{
				sReturnValue = "ExistContract";//该客户所属合同业务未终结，不能删除！
			}
		}else{
			sReturnValue = "ExistApprove";//该客户所属最终审批意见未终结，不能删除！
		}
	}else{
		sReturnValue = "ExistApply";//该客户所属申请业务未终结，不能删除！
	} */
%>
<script type="text/javascript">
	self.returnValue = "<%=sReturnValue%>";
	self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>
<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
/* 
 * Content: 交接用户动作 Ajax方式调用获取信息
   A3Web项目中只做底层相关表的操作
 */
	//获取参数：转移前用户编号、转移前机构代码、转移前机构名称、转移后机构代码、转移后机构名称
    String sFromUserID = CurPage.getParameter("UserID");
    String sFromOrgID = CurPage.getParameter("FromOrgID");
	String sFromOrgName = CurPage.getParameter("FromOrgName");	
	String sToOrgID = CurPage.getParameter("ToOrgID");
	String sToOrgName = CurPage.getParameter("ToOrgName");
	
	SqlObject so = null;
	//转移日志信息
	String sChangeReason = "用户转移操作人员代码:"+CurUser.getUserID()+"   姓名："+CurUser.getUserName()+"   机构代码："+CurOrg.getOrgID()+"   机构名称："+CurOrg.getOrgName();
	//SQL语句，是否成功标志
	String sSql = "";
	String sReturnValue = "";
	String sDate = DateX.format(new java.util.Date());
	try{
		sSql =  " update CLASS_CATALOG set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update CLASS_METHOD set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update CODE_CATALOG set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);	
		
		sSql =  " update CODE_LIBRARY set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);	
		
		sSql =  " update CUSTOMER_BELONG set OrgID = :OrgID where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update CUSTOMER_BELONG set InputOrgID = :InputOrgID,UpdateDate = :UpdateDate where InputUserID = :InputUserID ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrgID",sToOrgID).setParameter("UpdateDate",sDate).setParameter("InputUserID",sFromUserID);
		Sqlca.executeSQL(so);	
		
		/* sSql =  " update CUSTOMER_FSRECORD set OrgID = :OrgID where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update CUSTOMER_INFO set InputOrgID = :InputOrgID where InputUserID = :InputUserID ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrgID",sToOrgID).setParameter("InputUserID",sFromUserID);
		Sqlca.executeSQL(so); */
		
		sSql =  " update DOC_ATTACHMENT set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update DOC_LIBRARY set OrgID = :OrgID,OrgName = :OrgName where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("OrgName",sToOrgName).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update DOC_LIBRARY set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);
		
		/* sSql =  " update ENT_INFO set UpdateOrgID = :UpdateOrgID,UpdateDate = :UpdateDate where UpdateUserID = :UpdateUserID ";
		so = new SqlObject(sSql);
		so.setParameter("UpdateOrgID",sToOrgID).setParameter("UpdateDate",sDate).setParameter("UpdateUserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update ENT_INFO set InputOrgID = :InputOrgID,UpdateDate=:UpdateDate where InputUserID = :InputUserID ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrgID",sToOrgID).setParameter("UpdateDate",sDate).setParameter("InputUserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update EVALUATE_RECORD set OrgID =:OrgID where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so); */
		
		sSql =  " update FLOW_OBJECT set OrgID = :OrgID,OrgName = :OrgName where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("OrgName",sToOrgName).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update FLOW_TASK set OrgID = :OrgID,OrgName = :OrgName where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("OrgName",sToOrgName).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		/* sSql =  " update FLOW_TASK_CLOSED set OrgID = :OrgID,OrgName =:OrgName where UserID = :UserID";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("OrgName",sToOrgName).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so); */
		
		/* sSql =  " update FORMATDOC_CATALOG set OrgID = :OrgID,UpdateDate=:UpdateDate where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("UpdateDate",sDate).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update FORMATDOC_DATA set OrgID = :OrgID,UpdateDate = :UpdateDate where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("UpdateDate",sDate).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update FORMATDOC_DEF set OrgID = :OrgID,UpdateDate = :UpdateDate where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("UpdateDate",sDate).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update OBJECTTYPE_CATALOG set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so); */
		
		sSql =  " update ORG_INFO set InputOrg = :InputOrg,UpdateTime = :UpdateTime,UpdateDate = :UpdateDate where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("UpdateDate",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);

		/* sSql =  " update REPORT_RECORD set OrgID = :OrgID,UpdateTime = :UpdateTime where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("OrgID",sToOrgID).setParameter("UpdateTime",sDate).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so); */ 
		
		sSql =  " update RIGHT_INFO set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so); 

		sSql =  " update ROLE_INFO set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update ROLE_RIGHT set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);

		sSql =  " update USER_INFO set InputOrg = :InputOrg,UpdateTime = :UpdateTime,UpdateDate = :UpdateDate where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateDate",sDate).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update USER_INFO set BelongOrg = :BelongOrg,UpdateTime = :UpdateTime,UpdateDate = :UpdateDate where UserID = :UserID ";
		so = new SqlObject(sSql);
		so.setParameter("BelongOrg",sToOrgID).setParameter("UpdateDate",sDate).setParameter("UpdateTime",sDate).setParameter("UserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update USER_RIGHT set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update USER_ROLE set InputOrg = :InputOrg,UpdateTime = :UpdateTime where InputUser = :InputUser ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrg",sToOrgID).setParameter("UpdateTime",sDate).setParameter("InputUser",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update WORK_RECORD set OperateOrgID = :OperateOrgID,UpdateDate = :UpdateDate where OperateUserID = :OperateUserID ";
		so = new SqlObject(sSql);
		so.setParameter("OperateOrgID",sToOrgID).setParameter("UpdateDate",sDate).setParameter("OperateUserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		sSql =  " update WORK_RECORD set InputOrgID = :InputOrgID,UpdateDate = :UpdateDate where InputUserID = :InputUserID ";
		so = new SqlObject(sSql);
		so.setParameter("InputOrgID",sToOrgID).setParameter("UpdateDate",sDate).setParameter("InputUserID",sFromUserID);
		Sqlca.executeSQL(so);
		
		//在MANAGE_CHANGE表中插入记录，用于记录这次变更操作
        /* String sSerialNo1 =  DBKeyHelp.getSerialNo("MANAGE_CHANGE","SerialNo",Sqlca);
        sSql =  " INSERT INTO MANAGE_CHANGE(ObjectType,ObjectNo,SerialNo,OldOrgID,OldOrgName,NewOrgID,NewOrgName,OldUserID, "+
				" OldUserName,NewUserID,NewUserName,ChangeReason,ChangeOrgID,ChangeUserID,ChangeTime) "+
		        " VALUES('User',:ObjectNo,:SerialNo,:OldOrgID,:OldOrgName,:NewOrgID, "+
		        " :NewOrgName,'','','','',:ChangeReason,:ChangeOrgID,:ChangeUserID,:ChangeTime)";
    	so = new SqlObject(sSql);
		so.setParameter("ObjectNo",sFromUserID);
		so.setParameter("SerialNo",sSerialNo1);
		so.setParameter("OldOrgID",sFromOrgID);
		so.setParameter("OldOrgName",sFromOrgName);
		so.setParameter("NewOrgID",sToOrgID);
		so.setParameter("NewOrgName",sToOrgName);
		so.setParameter("ChangeReason",sChangeReason);
		so.setParameter("ChangeOrgID",CurOrg.getOrgID());
		so.setParameter("ChangeUserID",CurUser.getUserID());
		so.setParameter("ChangeTime",sDate);
		Sqlca.executeSQL(so); */
		
        sReturnValue = "TRUE";
	}catch(Exception e){
		sReturnValue = "FALSE";
	}

	out.println(sReturnValue);
%><%@ include file="/IncludeEndAJAX.jsp"%>
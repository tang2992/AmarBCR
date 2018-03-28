<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
 	/* 
 		页面说明： 通过数组定义生成strip框架页面示例
 	*/
 	String sMAINBUSINESSNO=CurPage.getParameter("MAINBUSINESSNO");
 	 if(sMAINBUSINESSNO==null) sMAINBUSINESSNO="";
 	 String sCIFCustomerID=sMAINBUSINESSNO;
  
	String sRECORDTYPE = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("sRECORDTYPE"));
	if(sRECORDTYPE == null) sRECORDTYPE = "";
	String sFlag = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("sFlag"));
	if(sFlag == null) sFlag = "";
	//在只能查询的模块中隐藏保存按钮
	String sSql1="";
	  String sFirstValue = sCIFCustomerID;
	
	ASResultSet rs = null;
	if("allHis".equals(sFlag)){
		sSql1=" select CIFCustomerID,GETRORGANNAME(CIFCustomerID),LOANCARDNO from HIS_ORGANINFO  where CIFCustomerID='"+sCIFCustomerID+"'" ;
	}else{
		sSql1=" select CIFCustomerID,GETRORGANNAME(CIFCustomerID),LOANCARDNO from HIS_ORGANINFO  where CIFCustomerID='"+sCIFCustomerID+"' and SESSIONID='9999999999'" ;
	
	rs = Sqlca.getASResultSet(sSql1);
	String sShowButton = "false";
	//显示校验信息，机构信息等等
	%>	
	<%@include file="/Resources/CodeParts/Table08.jsp"%>
	<%
	rs.getStatement().close();
	}
    //table数组 1.表名 2.表中文名 3.LIST模板名 4.LIST模板中文名
	String[][] sTableName = {
			{"HIS_ORGANATTRIBUTE","机构基本属性信息表","HIS_ORGANBASELIST","机构信息列表"},
			{"HIS_ORGANSTATUS","机构状态信息表","HIS_ORGANSTATUSLIST","机构状态列表"},
			{"HIS_ORGANCONTACT","机构联络信息表","HIS_ORGANCONTACTLIST","机构联络信息列表"},
			{"HIS_ORGANKEEPER","机构高管及主要关系人表","HIS_ORGANKEEPERLIST","机构高管及主要关系人列表"},
			{"HIS_ORGANSTOCKHOLDER","机构重要股东表","HIS_ORGANSTOCKHOLDERLIST","重要股东列表"},
			{"HIS_ORGANRELATED","机构主要关联企业表","HIS_ORGANRELATEDLIST","机构关联企业列表"},
			{"HIS_ORGANSUPERIOR","机构上级机构表","HIS_ORGANSUPERIORLIST","上级机构列表"},
			{"HIS_ORGANFAMILY","机构家族成员表","HIS_ORGANFAMILYLIST","家族成员列表"},
		  };    
    
    //控制Strips是否可见，无数据不可见
    String sStripVisible[]={"true","true","true","true","true","true","true","true"};
    String[] sParameter =new String[8];//定义传递参数

    for(int i=0;i<sTableName.length;i++){
    	String sSql;
    	if("allHis".equals(sFlag)){
    		sSql="select count(*) from "+sTableName[i][0]+" where CIFCustomerID='"+sCIFCustomerID+"'";
    	}else{
    		sSql="select count(*) from "+sTableName[i][0]+" where CIFCustomerID='"+sCIFCustomerID+"'"+" and SESSIONID='9999999999'";
        	  	}
    		String sCount=Sqlca.getString(sSql);
    	if(sCount.equals("0")||sCount==null){
    	    sStripVisible[i]="false";
    	}
    	
    	if("allHis".equals(sFlag)){
    		sParameter[i]="sTablbeName="+sTableName[i][0]+"&sDono="+sTableName[i][2]+"&sFlag=Detail&sCIFCustomerID="+sCIFCustomerID+"&IsShow=true&IsPatch=true";
    	}else{
    		sParameter[i]="sTablbeName="+sTableName[i][0]+"&sDono="+sTableName[i][2]+"&sFlag=Detail&sCIFCustomerID="+sCIFCustomerID;
    	}
    } 
    
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sStrips[][] = {
		{"true","机构基础信息表" ,"120","OrgnizationBaseList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp","sTablbeName=HIS_ORGANINFO&sDono=HIS_ORGANBASELIST&sFlag=Detail&IsShow=true&IsPatch=true&sCIFCustomerID="+sCIFCustomerID,""},
		{sStripVisible[0],"机构基本属性信息表" ,"120","OrgnizationAttribute","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[0],""},
		{sStripVisible[1],"机构状态信息表" ,"120","OrgnizationStatusList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[1],""},
		{sStripVisible[2],"机构联络信息表" ,"120","OrgnizationContactList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[2],""},
		{sStripVisible[3],"机构高管及主要关系人表" ,"120","OrgnizationKeeperList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[3],""},
		{sStripVisible[4]," 机构重要股东表" ,"120","OrgnizationStockHolderList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[4],""},
		{sStripVisible[5],"机构主要关联企业表" ,"120","OrgnizationRelatedList.jsp","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[5],""},
		{sStripVisible[6],"机构上级机构表" ,"120","OrgnizationSuperiorList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[6],""},
		{sStripVisible[7],"机构家族成员表" ,"120","OrgnizationFamilyList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[7],""}		
	};
 	String sButtons[][] = {
 	};
 	if(!"allHis".equals(sFlag)){
%>
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Strip05;Describe=定义按钮;]~*/%>
 <div style="float:left;width:100px; overflow: hidden;padding_left:25px;"><%=new Button("更多历史信息","更多历史信息","javascript:showAllInfo()","","").getHtmlText() %></div>
 <div style="float:left;width:70px; overflow: hidden"><%=new Button("全部重报","全部重报","javascript:reReport()","","").getHtmlText() %></div>
 <div style="width:90px; overflow: hidden"><%=new Button("全部不上报","全部不上报","javascript:unReport()","","").getHtmlText() %></div>
<div></div>
<%}/*~END~*/%>

<%@include file="/Resources/CodeParts/Strip05.jsp"%>
<script type="text/javascript">
/*~[Describe=漏报情况补报：跳转到ECR页面，从正常报文中补报漏报的记录;InputParam=无;OutPutParam=无;]~*/
function showAllInfo(){
		//显示所有的记录
		AsControl.PopView("/ErrorManage/FeedBackManage/FeedbackOrgan/FeedBackOrganDetail.jsp","sFlag=allHis","");
	}


function reReport(){
if(confirm("确定将该业务的全部出错记录重新上报?")){
	sReturn = PopPage("/ErrorManage/UpdateAllSessionIDAction.jsp?MainBusinessNo=<%=sMAINBUSINESSNO%>&CustomerID=<%=sCIFCustomerID%>&Flag=REREPORT","_self","");

	if(sReturn == "Success"){
			alert("设置重报标志成功!");
			
		}else{
			alert("设置重报标志失败!");
		}
	}
	top.close(); 
}
function unReport(){
	if(confirm("确定将该业务的全部出错记录暂不上报?")){
		sReturn = PopPage("/ErrorManage/UpdateAllSessionIDAction.jsp?MainBusinessNo=<%=sMAINBUSINESSNO%>&CustomerID=<%=sCIFCustomerID%>&Flag=UNREPORT","_self","");
		if(sReturn == "Success"){
			alert("设置暂不上报标志成功!");
			
		}else{
			alert("设置暂不上报标志失败!");
		}
	}
	top.close(); 
}
</script>
<%@ include file="/IncludeEnd.jsp"%>

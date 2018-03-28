<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "客户信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.ECR_ORGANINFO");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	doTemp.setJboWhere("LOANCARDNO is not null");
	if(!CurUser.getUserID().equals("system")){
		doTemp.setJboWhere(doTemp.getJboWhere()+" and O.FINANCEID IN (select OI.ORGID from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')");
	}

	//设置html格式
	doTemp.setHTMLStyle("CUSTOMERNAME"," style={width:200px;} ");

	//设置过滤字段
	doTemp.setColumnFilter("*",false);
	doTemp.setColumnFilter("CIFCUSTOMERID,LSCUSTOMERID,CUSTOMERNAME,LOANCARDNO", true);
	doTemp.setVisible("*",false);
	doTemp.setVisible("CIFCUSTOMERID,LSCUSTOMERID,CUSTOMERNAME,FINANCEID,CORPID,LOANCARDNO,REGISTERTYPE,REGISTERNO,OCCURDATE", true);

	//设置双击事件
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);//分页显示
	
	dwTemp.genHTMLObjectWindow("");
	
%>

	<%
	String sButtons[][] = {
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script language=javascript>

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=新增记录;InputParam=无;OutPutParam=无;]~*/

	//获取贷款卡编码
	function viewAndEdit()
	{
		var sLOANCARDNO = getItemValue(0,getRow(),"LOANCARDNO");
		var sCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
    	if(typeof(sLOANCARDNO)=="undefined" || sLOANCARDNO.length==0) {
			alert("请选择一条信息！");//请选择一条信息！
            return ;
		}
		popComp("SynthesisMaintanceInfoDetail","/DataMaintain/SynthesisMaintance/SynthesisMaintanceInfoDetail.jsp","LoanCardNo="+sLOANCARDNO+"&CustomerID="+sCustomerID,"");
		reloadSelf();
	}
	 
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
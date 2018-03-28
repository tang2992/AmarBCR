<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
        Author: #{author} #{createddate}
        Content: 示例详情页面
        History Log: 
    */
	String sPrevUrl = CurPage.getParameter("PrevUrl");
	if(sPrevUrl == null) sPrevUrl = "";
	String sContractNo = CurPage.getParameter("ContractNo");
	if(sContractNo==null) sContractNo="";
	String sInsertDate = CurPage.getParameter("InsertDate");
	if(sInsertDate==null) sInsertDate="";
	String sGuarantyContNo = CurPage.getParameter("GuarantyContNo");
	if(sGuarantyContNo==null) sGuarantyContNo="";
	String sGuarantySerialNo = CurPage.getParameter("GuarantySerialNo");
	if(sGuarantySerialNo==null) sGuarantySerialNo="";

	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.HIS_RELIEVEGUARANTY"));
	doTemp.setJboWhere("O.ContractNo=:ContractNo and O.InsertDate=:InsertDate and O.GuarantyContNo=:GuarantyContNo and O.GuarantySerialNo=:GuarantySerialNo");
	doTemp.setVisible("UpdateDate", false);
	doTemp.setEditStyle("RelieveType,BusinessType,GuarantyType,Status,IncrementFlag,AvailabStatus", "Select");
	doTemp.setDDDWCodeTable("RelieveType","B,主业务担保,G,最高额担保业务");
	doTemp.setDDDWCodeTable("BusinessType","1,贷款业务,2,保理业务,3,贸易融资,4,信用证,5,保函业务,6,承兑汇票");
	doTemp.setDDDWCodeTable("GuarantyType","1,保证,2,抵押,3,质押");
	doTemp.setDDDWCodeTable("Status","1,正常,2,已撤销");
	doTemp.setDDDWJbo("AvailabStatus", "jbo.ecr.ECR_CODEMAP,CtCode,Note,ColName='7525'");
	doTemp.setDDDWJbo("IncrementFlag","jbo.ecr.ECR_CODEMAP,CtCode,Note,ColName='7511'");

	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.ReadOnly = "1";//只读
	dwTemp.genHTMLObjectWindow(sContractNo+","+sInsertDate+","+sGuarantyContNo+","+sGuarantySerialNo);
	
	String sButtons[][] = {
		{"true","All","Button","返回","返回列表","returnList()","","","",""}
	};
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function returnList(){
		top.close();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
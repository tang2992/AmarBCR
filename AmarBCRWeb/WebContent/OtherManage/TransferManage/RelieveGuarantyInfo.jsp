<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
        Author: #{author} #{createddate}
        Content: ʾ������ҳ��
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
	doTemp.setDDDWCodeTable("RelieveType","B,��ҵ�񵣱�,G,��߶��ҵ��");
	doTemp.setDDDWCodeTable("BusinessType","1,����ҵ��,2,����ҵ��,3,ó������,4,����֤,5,����ҵ��,6,�жһ�Ʊ");
	doTemp.setDDDWCodeTable("GuarantyType","1,��֤,2,��Ѻ,3,��Ѻ");
	doTemp.setDDDWCodeTable("Status","1,����,2,�ѳ���");
	doTemp.setDDDWJbo("AvailabStatus", "jbo.ecr.ECR_CODEMAP,CtCode,Note,ColName='7525'");
	doTemp.setDDDWJbo("IncrementFlag","jbo.ecr.ECR_CODEMAP,CtCode,Note,ColName='7511'");

	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.ReadOnly = "1";//ֻ��
	dwTemp.genHTMLObjectWindow(sContractNo+","+sInsertDate+","+sGuarantyContNo+","+sGuarantySerialNo);
	
	String sButtons[][] = {
		{"true","All","Button","����","�����б�","returnList()","","","",""}
	};
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function returnList(){
		top.close();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
        Author: #{author} #{createddate}
        Content: ʾ������ҳ��
        History Log: 
    */
    String sContractNo = CurPage.getParameter("ContractNo");
     if(sContractNo==null) sContractNo="";
     String sInsertDate = CurPage.getParameter("InsertDate");
     if(sInsertDate==null) sInsertDate="";


	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.HIS_RELIEVEBUSINESS"));
	doTemp.setJboWhere("O.ContractNo=:ContractNo and O.InsertDate=:InsertDate"); 
	doTemp.setVisible("Updatedate,", false);
	doTemp.setEditStyle("IncrementFlag,GuarantyFlag,BusinessType,Status","Select");
	 doTemp.setDDDWJbo("IncrementFlag","jbo.ecr.ECR_CODEMAP,ctcode,note,colname='7511'");
	 doTemp.setDDDWJbo("GuarantyFlag","jbo.ecr.ECR_CODEMAP,ctcode,note,colname='7523'");
	 doTemp.setDDDWCodeTable("BusinessType","1,����ҵ��,2,����ҵ��,3,ó������,4,����֤,5,����ҵ��,6,�жһ�Ʊ");
	 doTemp.setDDDWCodeTable("Status","1,����,2,�ѳ���");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.ReadOnly="1";
	dwTemp.genHTMLObjectWindow(sContractNo+","+sInsertDate);
	
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
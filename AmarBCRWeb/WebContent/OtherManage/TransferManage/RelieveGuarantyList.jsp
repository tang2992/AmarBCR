<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	String PG_TITLE = "��߶�����ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%	

	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.HIS_RELIEVEGUARANTY"));
    doTemp.setDDDWCodeTable("BusinessType","1,����ҵ��,2,����ҵ��,3,ó������,4,����֤,5,����ҵ��,6,�жһ�Ʊ");
    doTemp.setDDDWCodeTable("GuarantyType","1,��֤,2,��Ѻ,3,��Ѻ");
    doTemp.setDDDWCodeTable("Status","1,����,2,�ѳ���");
    doTemp.setDDDWJbo("IncrementFlag", "jbo.ecr.ECR_CODEMAP,CtCode,Note,ColName='7511'");
    doTemp.setVisible("Availabstatus,Updatedate,Relievetype,Oldoccurdate,Sessionid", false);
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("OccurDate,ContractNo,GuarantyType", true);
    String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
    
    
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--����ΪGrid���--
	//dwTemp.MultiSelect = true;	 //��ѡ/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	//dwTemp.ShowSummary="1";	 	 //����/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	dwTemp.ReadOnly = "1";	 //ֻ��ģʽ
	dwTemp.setPageSize(10);
	dwTemp.genHTMLObjectWindow("");

	//0���Ƿ�չʾ 1��	Ȩ�޿���  2�� չʾ���� 3����ť��ʾ���� 4����ť�������� 5����ť�����¼�����	6��	7��	8��	9��ͼ�꣬CSS�����ʽ 10�����
	String sButtons[][] = {
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","btn_icon_detail",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function viewAndEdit(){
		var sContractNo = getItemValue(0,getRow(),"ContractNo");
		var sGuarantyContNo = getItemValue(0,getRow(),"GuarantyContNo");
		var sGuarantySerialNo = getItemValue(0,getRow(),"GuarantySerialNo");
		var sInsertDate = getItemValue(0,getRow(),"InsertDate");
		//alert(sContractNo+"&&"+sGuarantyContNo+"&&"+sGuarantySerialNo+"$$"+sInsertDate);
		if (typeof(sContractNo)=="undefined" || sContractNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		AsControl.PopView("/OtherManage/TransferManage/RelieveGuarantyInfo.jsp","ContractNo="+sContractNo+"&InsertDate="+sInsertDate+"&GuarantyContNo="+sGuarantyContNo+"&GuarantySerialNo="+sGuarantySerialNo,"");
		//popComp("RelieveGuarantyInfo","/OtherManage/TransferManage/RelieveGuarantyInfo.jsp","ContractNo="+sContractNo+"&InsertDate="+sInsertDate+"&GuarantyContNo="+sGuarantyContNo+"&GuarantySerialNo="+sGuarantySerialNo,"");
		reloadSelf();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
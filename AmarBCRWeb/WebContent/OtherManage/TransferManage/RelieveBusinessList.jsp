<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
   String PG_TITLE = "��������ͬ���ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
%>
<%	

	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.HIS_RELIEVEBUSINESS"));
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	doTemp.setDDDWCodeTable("BusinessType","1,����ҵ��,2,����ҵ��,3,ó������,4,����֤,5,����ҵ��,6,�жһ�Ʊ");
	doTemp.setDDDWCodeTable("Status","1,����,2,�ѳ���");
	 doTemp.setVisible("RelieveType,Oldoccurdate,Sessionid,Updatedate",false);
	 doTemp.setDDDWJbo("IncrementFlag","jbo.ecr.ECR_CODEMAP,ctcode,note,colname='7511'");
	 doTemp.setDDDWJbo("GuarantyFlag","jbo.ecr.ECR_CODEMAP,ctcode,note,colname='7523'");
	 doTemp.setColumnFilter("*",false);
	 doTemp.setColumnFilter("ContractNo,BusinessType,OccurDate", true);
	 String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\"";
     doTemp.appendHTMLStyle("",sStyle);
	
	dwTemp.Style="1";      	     //--����ΪGrid���--
	//dwTemp.MultiSelect = true;	 //��ѡ/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	//dwTemp.ShowSummary="1";	 	 //����/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	dwTemp.ReadOnly = "1";	 //ֻ��ģʽ
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	//0���Ƿ�չʾ 1��	Ȩ�޿���  2�� չʾ���� 3����ť��ʾ���� 4����ť�������� 5����ť�����¼�����	6��	7��	8��	9��ͼ�꣬CSS�����ʽ 10�����
	String sButtons[][] = {
		{"true","","Button","����","����","viewAndEdit()","","","","btn_icon_detail",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function viewAndEdit(){
		var sContractNo = getItemValue(0,getRow(),"ContractNo");
		var sInsertDate = getItemValue(0,getRow(),"InsertDate");		
		if (typeof(sContractNo)=="undefined" || sContractNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		popComp("RelieveBusinessInfo","/OtherManage/TransferManage/RelieveBusinessInfo.jsp","ContractNo="+sContractNo+"&InsertDate="+sInsertDate,"");
		reloadSelf();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
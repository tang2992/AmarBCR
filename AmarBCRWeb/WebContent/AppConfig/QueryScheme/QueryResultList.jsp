<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: �Բ�ѯ�������д���������ʾ���ݴ���
	 */
	//����������	������Ҫִ�е�sql��䡢��ѯ����
	String querySQL   = CurPage.getAttribute("JBOQL"); 	//��ѯ���
	String queryClass = CurPage.getParameter("MajorObjClass"); 		//��ѯ��jboclass
	String statResult = CurPage.getParameter("StatResult"); 		//��ѯ����,1--����,2--��ϸ
	String sumFields = CurPage.getParameter("SumFields"); 		//�����ֶ�
	//System.out.println(statResult+"@"+sumFields+"@"+queryClass+"@"+querySQL);
	
	ASObjectModel doTemp = new ASObjectModel();
	doTemp.initQuery(queryClass, querySQL);
	doTemp.setColumnType(sumFields, "3"); //�ܼ�+С�� 
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.setPageSize(20);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1";//ֻ��ģʽ
	if(statResult.equals("1")){//���ܲ�ѯ
		dwTemp.ShowSummary="1";//���úϼ���
	}
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"false","","Button","�鿴�ͻ�����","�鿴�ͻ�����","my_CustomerInfo()","","","",""},
		{"true","","Button","����Excel","����Excel","exportPage('"+sWebRootPath+"',0,'excel','"+dwTemp.getArgsValue()+"')","","","",""},
	};
%><%@ include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=�鿴�ͻ�����;]~*/
	function my_CustomerInfo(){
		sCustomerID=getItemValue(0,getRow(),"CustomerID");	
		if (typeof(sCustomerID)=="undefined" || sCustomerID.length==0){
			alert(getHtmlMessage(1));  //��ѡ��һ����¼��
		}else{
			openObject("Customer",sCustomerID,"002");
		}
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
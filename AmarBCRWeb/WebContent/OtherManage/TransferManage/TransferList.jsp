<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%><%	

	String sType = CurComp.getParameter("type");
	if(sType == null) sType = "";

    ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.ECR_TRANSFERFILTER"));
    doTemp.setVisible("UpdateTime,Operator", false);
    doTemp.setColumnFilter("UpdateTime,Note,RecordScope,Operator", false);
    doTemp.setHTMLStyle("Note","size=30");
	doTemp.setDDDWJbo("FilterCause","jbo.ecr.CODE_LIBRARY,ItemNo,ItemName,CodeNo='FilterCause'");
	doTemp.setDDDWJbo("Recordscope","jbo.ecr.CODE_LIBRARY,ItemNo,ItemName,CodeNo='Recordscope'");
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
    String jBOWhere="";
    jBOWhere=(sType.equals("1")?"FilterCause='T'":"FilterCause<>'T'");

	doTemp.setJboWhere(jBOWhere);
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--����ΪGrid���--
	//dwTemp.MultiSelect = true;	 //��ѡ/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	//dwTemp.ShowSummary="1";	 	 //����/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	dwTemp.ReadOnly = "1";	 //ֻ��ģʽ
	dwTemp.setPageSize(10);
	dwTemp.genHTMLObjectWindow("");//����window

	//0���Ƿ�չʾ 1��	Ȩ�޿���  2�� չʾ���� 3����ť��ʾ���� 4����ť�������� 5����ť�����¼�����	6��	7��	8��	9��ͼ�꣬CSS�����ʽ 10�����
	String sButtons[][] = {
		{sType.equals("1")?"true":"false","All","Button","����","����","newRecord()","","","","btn_icon_add",""},
		{"true","","Button","����","����","viewAndEdit()","","","","btn_icon_detail",""},
		{"true","","Button","ɾ��","ɾ��","deleteRecord()","","","","btn_icon_delete",""},
		{sType.equals("1")?"true":"false","","Button","����EXCEL","����EXCEL","as_defaultExport()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		 //AsControl.PopView("/OtherManage/TransferManage/TransferInfo.jsp","","dialogWidth=800;dialogHeight=400;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		 popComp("TransferInfo","/OtherManage/TransferManage/TransferInfo.jsp","sType=<%=sType%>","dialogWidth=645px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;"); 
		 reloadSelf();
	}
	
	function deleteRecord(){
		var sMainBusinessNo = getItemValue(0,getRow(),"MainBusinessNo");
		if (typeof(sMainBusinessNo)=="undefined" || sMainBusinessNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		if(confirm("�������ɾ������Ϣ��")) 
		{
			as_delete("myiframe0","reloadSelf()");
		}
	}
	
	function viewAndEdit(){

		var sMainBusinessNo = getItemValue(0,getRow(),"MainBusinessNo");
		var sRecordScope = getItemValue(0,getRow(),"RecordScope");
		var sFilterCause = getItemValue(0,getRow(),"FilterCause");
		if (typeof(sMainBusinessNo)=="undefined" || sMainBusinessNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		popComp("TransferInfo","/OtherManage/TransferManage/TransferInfo.jsp","MainBusinessNo="+sMainBusinessNo+"&RecordScope="+sRecordScope+"&FilterCause="+sFilterCause+"&sType=<%=sType%>","dialogWidth=645px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
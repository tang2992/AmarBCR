<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "����ɾ����������ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info02;Describe=�����������ȡ����;]~*/%>
<%
	String isReport = CurPage.getParameter("isReport");	//0-δ�ϱ���1-���ϱ���2-��ɾ���
	if(isReport == null) isReport = "";
	String sReadOnly = CurPage.getParameter("ReadOnly");
	if(sReadOnly==null) sReadOnly="T";
	String isNew = CurPage.getParameter("isNew");
	if(isNew==null) isNew="0";
	String keyValue = CurPage.getParameter("keyValue");//����
	if(keyValue == null) keyValue = "";
	String keyStr = null;
	String valueStr = null;
	String jboWhere = "";
	String args = "";
	if(keyValue.length()>0){
		String[] kv = keyValue.split("~");
		keyStr = kv[0];
		valueStr = kv[1];
		String[] kArr = keyStr.split("`");
		String[] vArr = valueStr.split("`");
		for(int ii=0; ii<kArr.length; ii++){
			String k = kArr[ii];
			String v = vArr[ii];
			jboWhere = jboWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
		jboWhere = jboWhere.substring(4);
		args = args.substring(1);
	}

	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETE");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere((!"1".equals(isNew)&&jboWhere.length()>0)?jboWhere:"1=2");
	//����
	//doTemp.setColCount(2);
	doTemp.setVisible("ModFlag,RecordFlag,TraceNumber,IncrementFlag,ErrorCode,SessionID",false);
	doTemp.setRequired("OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID",true);
	doTemp.setDDDWCodeTable("BusinessType","01,����ҵ��,02,����,03,Ʊ������,04,ó������,05,����֤,06,����,07,�жһ�Ʊ,08,��������,09,���,10,ǷϢ");
	doTemp.setEditStyle("OccurDate", "Date");
	doTemp.setEditStyle("BusinessType", "Select");
	 
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	if(isReport.equals("0"))
		dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	else
		dwTemp.ReadOnly = "1"; 
	dwTemp.genHTMLObjectWindow(args.length()>0?args:"%");

	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info04;Describe=���尴ť;]~*/%>
	<%
	//����Ϊ��
		//0.�Ƿ���ʾ
		//1.ע��Ŀ�������(Ϊ�����Զ�ȡ��ǰ���)
		//2.����(Button/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
		//3.��ť����
		//4.˵������
		//5.�¼�
		//6.��ԴͼƬ·��
	String sButtons[][] = {
		{isReport.equals("0")?"true":"false","","Button","����","����","saveRecord()","","","",""},
		{"true","","Button","����","�����б�ҳ��","goBack()","","","",""}
		};
	%> 
<%/*~END~*/%>

<%@include file="/Frame/resources/include/ui/include_info.jspf"%>

<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=Info06;Describe=���尴ť�¼�;]~*/%>
	<script type="text/javascript">

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=�����б�ҳ��;InputParam=��;OutPutParam=��;]~*/
	function saveRecord()
	{	
		//return true;
		var sLoanCardNo = getItemValue(0,0,"LoanCardNo");
		if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
			if(!CheckLoanCardID(sLoanCardNo)){
				alert('��������������!');
				return false;
			}
		} 
        as_save("myiframe0","");
	}
	function goBack()
	{
		var sReadOnly="<%=sReadOnly%>";
		if(sReadOnly=='F'){
			AsControl.OpenView("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteList.jsp","&isReport=<%=isReport%>","right");
		}else if(sReadOnly=='T'){
			AsControl.OpenView("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteList.jsp","&isReport=<%=isReport%>","right");
		}else if(sReadOnly=='T2'){
			AsControl.OpenView("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteList.jsp","&isReport=<%=isReport%>","right");
		}
	}
	function initRow(){
		if (getRowCount(0)==0) //���û���ҵ���Ӧ��¼��������һ�����������ֶ�Ĭ��ֵ
		{	
			setItemValue(0,0,"OccurDate","<%=DateX.format(new java.util.Date())%>");
			setItemValue(0,0,"SessionID","0000000000");
			setItemValue(0,0,"IncrementFlag","1");
			setItemValue(0,0,"RecordFlag","40");
		}
	}
	</script>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=Info08;Describe=ҳ��װ��ʱ�����г�ʼ��;]~*/%>
<script type="text/javascript">
	initRow();
</script>	
<%/*~END~*/%>

<%@ include file="/Frame/resources/include/include_end.jspf"%>

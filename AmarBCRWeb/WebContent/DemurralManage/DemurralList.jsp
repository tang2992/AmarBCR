<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	String PG_TITLE = "������Ϣ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%	
    String sFlag = CurPage.getParameter("Flag");
    if(sFlag==null) sFlag="";
    String sUserId = CurUser.getUserID();
    if(sUserId==null) sUserId="";
    
    String sReadOnly = "1" ;
	if(sFlag.equals("0")){
		sReadOnly = "0" ;
	}
    
	ASObjectModel doTemp = new ASObjectModel("Demurral");
	doTemp.setVisible("Operate,Flag,Proposer,Applyorg,Operator,Applytime,Operateorg,Operatetime", false);
	if(sFlag.equals("1") || sFlag.equals("4")){
    	doTemp.setJboWhere("Flag='1' ");
    	doTemp.setVisible("CUSTOMERID,DEMURRALPUTOUTNO,DEMURRALREASON,OPERATE,APPLYTIME", true);
    }else if(sFlag.equals("2") || sFlag.equals("3")){
    	doTemp.setJboWhere("Flag=:Flag and Proposer =:Proposer");
    	doTemp.setVisible("CUSTOMERID,DEMURRALPUTOUTNO,OPERATE,APPLYTIME,OPERATETIME",true);
    }else{
    	doTemp.setJboWhere("Flag=:Flag and Proposer =:Proposer");
    	doTemp.setVisible("CUSTOMERID,DEMURRALPUTOUTNO,OPERATE", true);
    }
    //˫���¼�
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewTab()\"");
    
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--����ΪGrid���--
	dwTemp.ReadOnly = "1";	 //ֻ��ģʽ
	dwTemp.setPageSize(20);
	
	dwTemp.genHTMLObjectWindow(sFlag+","+sUserId);

	//0���Ƿ�չʾ 1��	Ȩ�޿���  2�� չʾ���� 3����ť��ʾ���� 4����ť�������� 5����ť�����¼�����	6��	7��	8��	9��ͼ�꣬CSS�����ʽ 10�����
	String sButtons[][] = {
		{sFlag.equals("0") ? "true":"false","","Button","��������","��������","newApply()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewTab()","","","",""},
		{sFlag.equals("0") ? "true":"false","","Button","�ύ����","�ύ����","doSubmit()","","","",""},
		{sFlag.equals("0") ? "true":"false","","Button","ɾ��","ɾ��","takeBack()","","","",""},
		{sFlag.equals("4") ? "true":"false","","Button","��׼����","��׼����","approveApply()","","","",""},
		{sFlag.equals("4") ? "true":"false","","Button","�˻�����","��ͬ��/�˻�����","sendBack()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

<script type="text/javascript">
	function newApply()
	{
		sCompID = "DemurralInfo";
		sCompURL = "/DemurralManage/DemurralInfo.jsp";
		popComp(sCompID,sCompURL,"&ReadOnly=<%=sReadOnly%>","");
		reloadSelf();		
	}
	/*~[Describe=�鿴/�޸�����;InputParam=��;OutPutParam=��;]~*/
	function viewTab()
	{
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		popComp("DemurralInfo","/DemurralManage/DemurralInfo.jsp","SerialNo="+sSerialno+"&ReadOnly="+"<%=sReadOnly%>","");
		reloadSelf();
	}
	/*~[Describe=ȡ������;InputParam=��;OutPutParam=��;]~*/
	function takeBack()
	{
		//����������͡�������ˮ��
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		
		if(confirm("��ȷ��Ҫɾ�������룿"))//
		{
			as_delete("myiframe0");
		}
	}
	/*~[Describe=��׼����;InputParam=��;OutPutParam=��;]~*/
	function approveApply()
	{
		//����������͡�������ˮ��
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		
		if(confirm("��ȷ��Ҫ��׼�����룿"))
		{
			var returnValue = PopPage("/DemurralManage/ApproveApply.jsp?Serialno="+sSerialno+"&Flag=2","","resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
		}
		reloadSelf();
	}
	/*~[Describe=�ύ;InputParam=��;OutPutParam=��;]~*/
	function doSubmit()
	{
		//����������͡�������ˮ�š����̱�š��׶α��
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		if(confirm("��ȷ��Ҫ�ύ�����룿"))
		{
			var returnValue = PopPage("/DemurralManage/ApproveApply.jsp?Serialno="+sSerialno+"&Flag=1","","resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
		}
		reloadSelf();
		
	}
	//�˻�
	function sendBack()
	{
		//����������͡�������ˮ��
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}	
		if(confirm("��ȷ��Ҫ�˻ظ�������")){
		
			var returnValue = PopPage("/DemurralManage/ApproveApply.jsp?Serialno="+sSerialno+"&Flag=3","","resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
		}
		reloadSelf();	
	}

</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
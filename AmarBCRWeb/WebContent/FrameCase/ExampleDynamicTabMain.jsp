<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		ҳ��˵��: �Ա�ǩҳ��ʽ��
	 */
	ASObjectModel doTemp = new ASObjectModel("TestCustomerList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(15);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","openRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function openRecord(sSerialNo){
		var sParas = "";
		if(sSerialNo) sParas = "SerialNo="+sSerialNo;
		
		if(typeof parent.addTabItem == "function"){
			var text;
			if(sSerialNo) text = "���顾"+sSerialNo+"��";
			else text = "����";
			parent.addTabItem(text, "/FrameCase/widget/ow/DemoInfoSimple.jsp", sParas);
		}else{
			AsControl.OpenView("/FrameCase/widget/ow/DemoInfoSimple.jsp", sParas, "_self","");
		}
	}
	
	function viewAndEdit(){
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		openRecord(sSerialNo);
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%	
	ASObjectModel doTemp = new ASObjectModel("TestCustomerList");
 	doTemp.appendJboWhere("SerialNo like :SerialNo and ISINUSE=:IsInUse");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	
	//�µ����ò������� setParameter�����Զ����д
	dwTemp.setParameter("SerialNo", "20100426%").setParameter("IsInUse", "1");
	//����ԭ�����ԡ�,���ָ��Ĳ�����ʽ
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"true","","Button","����","����","edit()","","","","btn_icon_detail",""},
		{"true","","Button","����EXCEL","����EXCEL","exportPage('"+sWebRootPath+"',0,'excel','"+dwTemp.getArgsValue()+"')","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function edit(){
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		var sUrl = "/FrameCase/widget/ow/DemoInfoSimple.jsp";
		OpenPage(sUrl+'?SerialNo='+sSerialNo,'_self','');
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
 	String sMsgType = CurPage.getParameter("MsgType");
 	if(sMsgType == null) sMsgType = "";
 
 	ASObjectModel doTemp = new ASObjectModel("AWEDictErrMsg");
 	doTemp.setReadOnly("MSGTYPE", true);
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "0";//ֻ��ģʽ
	dwTemp.setPageSize(50);
	dwTemp.genHTMLObjectWindow(sMsgType);
	String sButtons[][] = {
		{"true", "All","Button","��������","��ǰҳ������","afterAdd()","","","","btn_icon_add"},
		{"true", "All","Button","���ٱ���","���ٱ��浱ǰҳ��","as_save(0)","","","","btn_icon_save"},
		{"true","","Button","ɾ��","ɾ��","if(confirm('ȷʵҪɾ����?'))as_delete(0)","","","","btn_icon_delete",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function afterAdd(){
		as_add(0);
		//��������ʱ�����Ĭ��ֵ
		setItemValue(0, getRow(), "MSGTYPE", "<%=sMsgType%>");
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
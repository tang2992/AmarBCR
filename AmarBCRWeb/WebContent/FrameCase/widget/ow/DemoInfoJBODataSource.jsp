<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%@
 page import="com.amarsoft.are.jbo.*" %><%
	BizObjectManager bomOne = JBOFactory.getFactory().getManager("jbo.ui.test.TEST_CUSTOMER_INFO");
	ASObjectModel doTemp = new ASObjectModel(bomOne);
	doTemp.setJboWhere("SERIALNO=:SERIALNO");
	doTemp.setVisible("*",false); //ȱʡ��ʾȫ�����ԣ���������ȫ������ʾ��
	doTemp.setVisible("SERIALNO,CUSTOMERNAME,TELEPHONE",true);   //������ʾ��
	doTemp.setReadOnly("CUSTOMERNAME,TELEPHONE", false);
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.ReadOnly = "0";//ֻ��ģʽ
	dwTemp.genHTMLObjectWindow(CurPage.getParameter("SerialNo"));
	
	String sButtons[][] = {
		{"true","All","Button","����","���������޸�","as_save(0)","","","",""},
		{"true","All","Button","����","�����б�","returnList2()","","","",""}
	};
	sButtonPosition = "south";
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
function returnList2(){
	var sUrl = "/FrameCase/widget/ow/DemoListCustomDataSource.jsp";
	OpenPage(sUrl,'_self','');
}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>

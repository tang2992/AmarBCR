<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%>
<%	
	ASObjectModel doTemp = new ASObjectModel("TestCustomerList");
	doTemp.setReadOnly("SERIALNO",true);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "0";//�༭ģʽ
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","����","����","as_add(0)","","","",""},
		{"true","","Button","����","����","as_save(0)","","","",""},
		{"true","","Button","ɾ��","ɾ��","if(confirm('ȷʵҪɾ����?'))as_delete(0)","","","",""},
		{"true","","Button","setitemvalue","setitemvalue","testv(0)","","","",""},
		{"true","","Button","getitemvalue","getitemvalue","testv2(0)","","","",""},
	};
%> 
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<%@
 include file="/Frame/resources/include/include_end.jspf"%>
<script type="text/javascript">
function testv(){
	setItemValue(0,getRow(),"CustomerName",prompt("�߹�����",getItemValue(0,getRow(),"CustomerName")));
}
function testv2(){
	alert(getItemValue(0,getRow(),"CustomerName"));
}
function testColInnerBtEvent(sString, iInt){
	var str = "��ť�����¼�";
	str += "\n�����ַ���������"+sString+" ,�������ֲ�����"+iInt;
	str += "\n��ȡ���кţ�"+getRow(0);
	alert(str);
}
</script>
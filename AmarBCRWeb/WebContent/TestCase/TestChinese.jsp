<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMD.jsp"%><%
/* 
 * Content: ���������ַ���
 */
String sTestChinese = CurPage.getParameter("TestChinese");
if(sTestChinese==null || !sTestChinese.equals("���������ַ���")){
%>
<script type="text/javascript">	
	self.returnValue = "failure";
	//self.close();	
</script>
<%
	throw new Exception("��һ̨�ͻ����޷���ȷ���������ַ�,��ᵼ��ϵͳ��������ϵͳ����Ա��ϵ��");
}else{
%>
<script type="text/javascript">	
	self.returnValue = "success";
	self.close();	
</script>
<%
}
%>
<%@ include file="/IncludeEnd.jsp"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
/*
	ҳ��˵��: ʾ�������������ҳ��
 */
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
	OpenList();
	
	function OpenList(){
		AsControl.OpenView("/FrameCase/widget/dw/ExampleList07.jsp","","frameleft");
	}
	
	function OpenInfo(sExampleId){
		AsControl.OpenView("/FrameCase/widget/dw/ExampleInfo.jsp", "ExampleId="+sExampleId, "frameright");
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>
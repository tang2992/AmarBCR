<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
/*
	ҳ��˵��: ʾ�������������ҳ��
 */
%><%@include file="/Resources/CodeParts/Frame02.jsp"%>
<script type="text/javascript">
	mytoptd.height=300;
	OpenList();
	
	function OpenList(){
		AsControl.OpenView("/FrameCase/widget/dw/ExampleList06.jsp","","rightup");
	}
	
	function OpenInfo(sExampleId){
		AsControl.OpenView("/FrameCase/widget/dw/ExampleInfo.jsp", "ExampleId="+sExampleId, "rightdown");
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>
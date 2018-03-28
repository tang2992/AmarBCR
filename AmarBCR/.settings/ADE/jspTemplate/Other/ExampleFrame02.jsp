<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
 	/*
        Author: #{author} #{createddate}
        Content: 
        History Log: 
    */
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">	
	AsControl.OpenView("/FrameCase/ExampleList.jsp","","frameleft","");
	AsControl.OpenView("/FrameCase/ExampleList.jsp","","frameright","");
	setTitle("区域1标题",true);
	setTitle("区域2标题",false);
</script>
<%@ include file="/IncludeEnd.jsp"%>
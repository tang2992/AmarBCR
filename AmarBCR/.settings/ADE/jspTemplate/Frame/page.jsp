<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%><%
 	/*
        Author: #{author} #{createddate}
        Content: 
        History Log: 
    */
%><%@include file="/Resources/CodeParts/Frame02.jsp"%>
<script type="text/javascript">	
	AsControl.OpenView("/FrameCase/ExampleList.jsp","","rightup","");
	AsControl.OpenView("/FrameCase/ExampleList.jsp","","rightdown","");
	setTitle("区域1标题",true);
	setTitle("区域2标题",false);
</script>	
<%@ include file="/IncludeEnd.jsp"%>
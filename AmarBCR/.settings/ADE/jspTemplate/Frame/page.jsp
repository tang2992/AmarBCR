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
	setTitle("����1����",true);
	setTitle("����2����",false);
</script>	
<%@ include file="/IncludeEnd.jsp"%>
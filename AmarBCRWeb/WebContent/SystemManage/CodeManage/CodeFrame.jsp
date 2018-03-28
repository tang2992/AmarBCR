<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
/*
	页面说明: 业务对象左右框架页面
 */
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
	myleft.width=660;//设置左边区域宽度
	AsControl.OpenView("/SystemManage/CodeManage/CodeList.jsp","","frameleft","");
</script>
<%@ include file="/IncludeEnd.jsp"%>
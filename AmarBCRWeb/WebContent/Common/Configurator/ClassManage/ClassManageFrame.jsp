<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%-- 页面说明: 上下框架页面 --%>
<%@include file="/Resources/CodeParts/Frame02.jsp"%>
<script type="text/javascript">	
	AsControl.OpenView("/Common/Configurator/ClassManage/ClassCatalogList.jsp","","rightup","");
	AsControl.OpenView("/Blank.jsp","TextToShow=请先选择相应的信息!","rightdown","");
</script>
<%@ include file="/IncludeEnd.jsp"%>
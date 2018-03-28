<%@page import="com.amarsoft.app.bcr.common.worktip.WorkTipUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head>
<title>业务通知</title>
<link rel="stylesheet" href="<%=sWebRootPath%>/AppMain/resources/css/notice.css">
</head>
<body>
<div class="container">
<a href="javascript:goBatch(2)" >1、担保业务批删反馈失败信息：<%=WorkTipUtil.getTableCount("BCR_GUARANTEEDELETE", CurUser.getUserID(), CurUser.getRelativeOrgID(),"sessionid='7777777777'") %>笔
<img src="<%=sWebRootPath%>/Frame/page/resources/images/common/new.gif"/>
</a>
<a href="javascript:goChange(2)" >2、担保业务变更反馈失败信息：<%=WorkTipUtil.getTableCount("BCR_GUARANTEECHANGE", CurUser.getUserID(), CurUser.getRelativeOrgID(),"sessionid='7777777777'") %>笔
<img src="<%=sWebRootPath%>/Frame/page/resources/images/common/new.gif"/>
</a>

<script type="text/javascript">
	//业务批删反馈
	function goBatch(flag){
		AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","isReport="+flag,"right");
	}
	//业务变更反馈
	function goChange(flag){
		AsControl.OpenView("/ChangeManage/ChangeGuaranteeManage/GuaranteeChangeList.jsp","isReport="+flag,"right");
	}
</script>
</div>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>
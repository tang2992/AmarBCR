<%@page import="com.amarsoft.app.bcr.common.worktip.WorkTipUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head>
<title>ҵ��֪ͨ</title>
<link rel="stylesheet" href="<%=sWebRootPath%>/AppMain/resources/css/notice.css">
</head>
<body>
<div class="container">
<a href="javascript:goBatch(2)" >1������ҵ����ɾ����ʧ����Ϣ��<%=WorkTipUtil.getTableCount("BCR_GUARANTEEDELETE", CurUser.getUserID(), CurUser.getRelativeOrgID(),"sessionid='7777777777'") %>��
<img src="<%=sWebRootPath%>/Frame/page/resources/images/common/new.gif"/>
</a>
<a href="javascript:goChange(2)" >2������ҵ��������ʧ����Ϣ��<%=WorkTipUtil.getTableCount("BCR_GUARANTEECHANGE", CurUser.getUserID(), CurUser.getRelativeOrgID(),"sessionid='7777777777'") %>��
<img src="<%=sWebRootPath%>/Frame/page/resources/images/common/new.gif"/>
</a>

<script type="text/javascript">
	//ҵ����ɾ����
	function goBatch(flag){
		AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","isReport="+flag,"right");
	}
	//ҵ��������
	function goChange(flag){
		AsControl.OpenView("/ChangeManage/ChangeGuaranteeManage/GuaranteeChangeList.jsp","isReport="+flag,"right");
	}
</script>
</div>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>
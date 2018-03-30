<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head>
<title>Welcome 欢迎界面</title>
<link rel="stylesheet" href="<%=sWebRootPath%>/AppMain/resources/css/welcome.css">
<link rel="stylesheet" href="<%=sWebRootPath%><%=sSkinPath%>/css/welcome.css">
</head>
<body>
<div id="panel0" class="panel show">
	<div class="title">
		<span>快捷菜单</span>
		<a class="show" href="javascript:void(0);" onclick="$('#panel0').removeClass('show').addClass('edit');return false;" hidefocus >定制</a>
		<a class="edit" href="javascript:void(0);" onclick="$('#panel0').removeClass('edit').addClass('show');return false;" hidefocus >确定</a>
		<a class="edit" href="javascript:void(0);" onclick="selectMenu();return false;" hidefocus >菜单</a>
	</div>
	<div class="container">
		<div class="quicker">
		<%{
			ASResultSet rs = null;
			try{
				rs = Sqlca.getASResultSet(new SqlObject("select QuickId, QuickName, QuickType, QuickParams, Remark from AWE_QUICK_HREF where ForUser = :ForUser and IsInUse = '1' order by SortNo").setParameter("ForUser", CurUser.getUserID()));
				while(rs.next()){
					String sRemark = rs.getString("Remark");
					if(StringX.isSpace(sRemark)) sRemark = "";
					String sQuickId = rs.getString("QuickId");
					String sQuickName = rs.getString("QuickName");
					String sQuickType = rs.getString("QuickType");
					String sQuickParams = rs.getString("QuickParams");
					
					String sQuickEvent = null;
					if("01".equals(sQuickType)){ // 快捷菜单
						sQuickEvent = "quickMenu('"+sQuickId+"', '"+sQuickParams+"')";
					}else{
						// TODO 其他快捷 实现快捷链接
					}
					if(sQuickEvent == null) continue;
		%><span id="<%=sQuickId%>" onmousedown="if($('#panel0').hasClass('edit')){moveQuick(this, event);}" title="<%=sRemark%>" >
			<a class="quick" href="javascript:void(0);" onclick="if(!$('#panel0').hasClass('edit')){<%=sQuickEvent%>;}return false;" hidefocus ><%=sQuickName%></a>
			<a class="close edit" href="javascript:void(0);" onmousedown="AsLink.stopEvent(event);" onclick="deleteQuick('<%=sQuickId%>','<%=sQuickName%>');return false;" hidefocus >&nbsp;</a>
			<a class="change edit" href="javascript:void(0);" onmousedown="AsLink.stopEvent(event);" onclick="editQuick('<%=sQuickType%>', '<%=sQuickId%>');return false;" hidefocus >&nbsp;</a>
		</span><%
				}
			}finally{
				if(rs != null) rs.close();
			}
		}%>
		</div>
		<div class="calendar">
			<iframe src="<%=sWebRootPath%>/AppMain/MyCalendar.jsp?CompClientID=<%=CurComp.getClientID()%>" width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency ></iframe>
		</div>
	</div>
</div>
<div id="panel1" class="panel">
	<div class="title">
		<span>工作提示</span>
		<div>
			<a href="javascript:void(0);" onclick="return false;"
				><span UrlParams="/AppMain/WorkTips.jsp@@">任务提示</span
				><span UrlParams="/Frame/page/ow/ExportFileList.jsp@@">数据导出</span
				><span UrlParams="/AppMain/EarlyWarning.jsp@@">预警信息</span
			></a>
		</div>
	</div>
	<div class="container"></div>
</div>
<div id="panel2" class="panel">
	<div class="title">
		<span>特殊业务统计</span>
	</div>
	<div class="container">
		<iframe src="<%=sWebRootPath%>/AppMain/BusinessNotices.jsp?CompClientID=<%=sCompClientID%>" width="100%" height="100%" frameborder="0" allowtransparency ></iframe>
	</div>
</div> 
<!-- <div id="panel3" class="panel">
	<div class="title">
		<span>公告信息</span>
	</div>
	<div class="container">
		<iframe src="<%=sWebRootPath%>/AppMain/BankNotices.jsp?CompClientID=<%=sCompClientID%>" width="100%" height="100%" frameborder="0" allowtransparency ></iframe>
	</div>
</div>-->
</body>
<script src="<%=sWebRootPath%>/AppMain/resources/js/welcome.js" charset="UTF-8" type="text/javascript"></script>
</html>
<%@ include file="/IncludeEnd.jsp"%>
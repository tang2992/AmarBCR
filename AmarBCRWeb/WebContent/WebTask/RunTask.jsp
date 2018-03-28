<%@page import="com.amarsoft.task.*"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ include file="/WebTask/plan.jsp"%>
<%
	//获得组件参数	
	//获得页面参数
	//String sTaskName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("TaskName"));
    String sTaskName = CurPage.getParameter("TaskName");
    if(sTaskName==null) sTaskName="";
	Task task = (Task)session.getAttribute(sTaskName);
	//运行任务
	String unitReturn = "1";
	if(task!=null){
		try{
			task.start();
		}catch(Exception e){
			unitReturn = "2";
		}
	}else{
		unitReturn = "3";
	}
%>
<script language=javascript> 
	top.returnValue="<%=unitReturn%>";
	top.close();
</script> 
<%@ include file="/IncludeEnd.jsp"%>

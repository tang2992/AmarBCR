<%@ page contentType="text/html; charset=GBK"
		 import="com.amarsoft.task.*"
%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "运行模块"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取组件参数
	String sTaskName = CurPage.getParameter("taskName");
	if(sTaskName == null) sTaskName ="";
	//获取页面参数
	
%>

<%	
	Task task = null;
	try
	{
		String taskfile = ARE.getProperty(sTaskName);
		task = TaskBuilder.buildTaskFromXML(taskfile);
		if(task!=null)
			session.setAttribute(sTaskName,task);

	}
	catch(Exception e)
	{
		out.print(e.getMessage());
	}
		
%>
<%@include file="/WebTask/TaskInfo.jsp"%>

	<script type="text/javascript">
	function runTarget(){
    if("<%=sTaskName%>"=="initTaskFile"){
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=init");
		alert(ret)
    }else if("<%=sTaskName%>"=="prepareTaskFile"){
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=prepare");
		alert(ret);
    }else if("<%=sTaskName%>"=="validateTaskFile"){
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=validate");
		alert(ret);
    }else if("<%=sTaskName%>"=="transferTaskFile"){
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=transfer");
		alert(ret);
    }else if("<%=sTaskName%>"=="reportTaskFile"){
    	//生成报文前先判断是否有符合条件的数据，没有则提示，不在跑批
    	var sReturn = RunJavaMethodTrans("com.amarsoft.app.util.CheckNeedReportAction","checkReport","");
    	if(sReturn=="NotNeed"){
    		alert("没有符合生成报文条件的数据，无需执行报文生成！");
    		return;
    	}
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=report");
		alert(ret);
    }else if("<%=sTaskName%>"=="changeTaskFile"){
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=change");
		alert(ret);
    }else if("<%=sTaskName%>"=="batchdelTaskFile"){
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=batchdel");
		alert(ret);
    }else if("<%=sTaskName%>"=="feedbackTaskFile"){
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=feedback");
		alert(ret);
    }
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>

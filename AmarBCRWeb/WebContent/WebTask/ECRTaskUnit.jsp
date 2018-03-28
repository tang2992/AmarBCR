<%@ page contentType="text/html; charset=GBK"
		 import="com.amarsoft.task.*"
%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "����ģ��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡ�������
	String sTaskName = CurPage.getParameter("taskName");
	if(sTaskName == null) sTaskName ="";
	//��ȡҳ�����
	
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
    	//���ɱ���ǰ���ж��Ƿ��з������������ݣ�û������ʾ����������
    	var sReturn = RunJavaMethodTrans("com.amarsoft.app.util.CheckNeedReportAction","checkReport","");
    	if(sReturn=="NotNeed"){
    		alert("û�з������ɱ������������ݣ�����ִ�б������ɣ�");
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

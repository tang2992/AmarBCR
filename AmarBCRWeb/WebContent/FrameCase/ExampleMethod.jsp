<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	//���ҳ�����
	String showText =  CurPage.getParameter("ShowText");
	String flag =  CurPage.getParameter("Flag");
	if(showText==null) showText="";
	if(flag==null) flag="";

	String sButtons[][] = {
		{(flag.equals("1"))?"true":"false","","Button","����RunMethodʾ��","����RunMethodʾ��","run1()","","","","btn_icon_up"},
		{(flag.equals("2"))?"true":"false","","Button","����RunJavaMethodʾ��","����RunJavaMethodʾ��","run2()","","","", "btn_icon_down"},
		{(flag.equals("3"))?"true":"false","","Button","����RunJavaMethodSqlcaʾ��","����RunJavaMethodSqlcaʾ��","run3()","","","","btn_icon_left"},	
		{(flag.equals("4"))?"true":"false","","Button","����RunJavaMethodTransʾ��","����RunJavaMethodTransʾ��","run4()","","","","btn_icon_right"},
		{(flag.equals("5"))?"true":"false","","Button","Transaction���е���","���е���","run5()","","","","btn_icon_right"},
		{(flag.equals("5"))?"true":"false","","Button","Transaction��ε���","��ε���","run6()","","","","btn_icon_right"},
	};
%>
<script type="text/javascript">
	function run1(){
		var sExampleId = document.getElementById("ExampleId").value;
		if(!sExampleId){
			alert("������ExampleId");
			return;
		}
		var sReturn = RunMethod("ʾ��","GetExmapleName",sExampleId);
		alert(sExampleId+"��������"+sReturn);
	}
	function run2(){
		var sExampleId = document.getElementById("ExampleId").value;
		if(!sExampleId){
			alert("������ExampleId");
			return;
		}
		var sReturn = AsControl.RunJavaMethod("com.amarsoft.app.awe.framecase.Example4RJM","getExampleName","ExampleId="+sExampleId);
		alert(sExampleId+"��������"+sReturn);
	}
	function run3(){
		var sExampleId = document.getElementById("ExampleId").value;
		if(!sExampleId){
			alert("������ExampleId");
			return;
		}
		var sReturn = AsControl.RunJavaMethodSqlca("com.amarsoft.app.awe.framecase.Example4RJM","deleteExample","ExampleId="+sExampleId);
		alert(sExampleId+"���丸ʾ����ɾ��"+sReturn);
	}
	function run4(){
		var sExampleId = document.getElementById("ExampleId").value;
		var sApplySum = document.getElementById("ApplySum").value;
		if(!sExampleId || !sApplySum){
			alert("������ExampleId��ApplySum");
			return;
		}
		var sReturn = AsControl.RunJavaMethodTrans("com.amarsoft.app.awe.framecase.Example4RJM","changeExample","ExampleId="+sExampleId+",applySum="+sApplySum);
		alert(sExampleId+"��������applySum������Ϊ"+sApplySum+" "+sReturn);
	}
	function run5(){
		var sExampleId = document.getElementById("ExampleId").value;
		if(!sExampleId){
			alert("������ExampleId");
			return;
		}
		var sReturn = AsControl.RunJavaMethodSqlca("com.amarsoft.app.awe.framecase.Example4RJM","getExampleName","ExampleId="+sExampleId);
		alert(sReturn);
	}
	function run6(){
		var sExampleId = document.getElementById("ExampleId").value;
		if(!sExampleId){
			alert("������ExampleId");
			return;
		}
		var sReturn = AsControl.RunJavaMethodTrans("com.amarsoft.app.awe.framecase.Example4RJM","getExampleName","ExampleId="+sExampleId);
		alert(sReturn);
	}
</script>
<div align="left" style="text-align: left;">
    <pre>
<%if("1".equals(flag)){ %>
		AsControl.RunMethod(ClassName,MethodName,Args)��
		 ֻ�ܵ����Ѿ������"�෽��"(SQL,Bizlet,AmarScript).
		
		ClassName��������������ӦCLASS_CATALOG�е�ClassName
		MethodName: �������ƣ���ӦCLASS_METHOD�е�MethodName
		Args��������ʽ  "����ֵ1,����ֵ2,����ֵ3..."
				
		var sReturn = AsControl.RunMethod("ʾ��","GetExmapleName",sExampleId);
<%}else if("2".equals(flag)){%>
		AsControl.RunJavaMethod(ClassName,MethodName,Args)��
		������ͨJAVA��.
		
		ClassName����ͨJAVA���ȫ����
		MethodName: ��������
		Args����Ӧ��ĳ�Ա������������ʽ "������1=����ֵ1,������2=����ֵ2,...".
		
		AsControl.RunJavaMethod("com.amarsoft.app.awe.framecase.Example4RJM","getExampleName","ExampleId="+sExampleId);
<%}else if("3".equals(flag)){%>
		AsControl.RunJavaMethodSqlca(ClassName,MethodName,Args)��
		������ͨJAVA�࣬��Ҫ����Sqlca��������ô�function.
		
		ClassName����ͨJAVA���ȫ����
		MethodName: ��������
		Args����Ӧ��ĳ�Ա������������ʽ  "������1=����ֵ1,������2=����ֵ2,...".
		
		AsControl.RunJavaMethodSqlca("com.amarsoft.app.awe.framecase.Example4RJM","deleteExample","ExampleId="+sExampleId);
<%}else if("4".equals(flag)){%>
		AsControl.RunJavaMethodTrans(ClassName,MethodName,Args)��
		������ͨJAVA�࣬��Ҫ����JBOTransation��������ô�function.
		
		ClassName����ͨJAVA���ȫ����
		MethodName: ��������
		Args����Ӧ��ĳ�Ա������������ʽ  "������1=����ֵ1,������2=����ֵ2,...".
		
		AsControl.RunJavaMethodTrans("com.amarsoft.app.awe.framecase.Example4RJM","changeExample","ExampleId="+sExampleId+",applySum="+sApplySum);
<%} %>
    </pre>
</div>
<%@ include file="/Frame/resources/include/ui/include_buttonset_dw.jspf"%>
<table style="text-align: left;">
	<td>������ExampleId:</td><td><input id="ExampleId" type="text" /></td>
	</tr>
	<tr>
	<td>������ApplySum:</td><td><input id="ApplySum" type="text" /></td>
	</tr>
</table>
<%@ include file="/IncludeEnd.jsp"%>
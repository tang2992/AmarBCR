<%@page import="com.amarsoft.app.awe.config.query.GenerateQuerySql"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf"%><%
	String sMajorObjClass = CurPage.getParameter("MajorObjClass");
	String sJBOQL = CurPage.getParameter("JBOQL");
	String sExportFields = CurPage.getParameter("ExportFields");
	String sSumFields = CurPage.getParameter("SumFields");
	if(sMajorObjClass == null) sMajorObjClass = "";
	if(sJBOQL == null) sJBOQL = "";
	
	String sJBOQLModify = GenerateQuerySql.getModefiedQuerySql(sJBOQL);
%>
<style>
.tdr{text-align: right; width:80px; padding:1px;vertical-align: middle;}
.tdl{text-align: left; padding:5px;vertical-align: middle;}
.input{text-align: left; width:150px; padding:2px;vertical-align: middle;}
</style>
<body>
<form enctype="multipart/form-data" action="AppConfig/QueryScheme/QueryResult.jsp?CompClientID=<%=CurComp.getClientID()%>" name="form1" method="post" onSubmit="">
	<div style="text-align: left; margin-left: 15px;">
	������<input type="text" id="MajorObjClass" value="<%=sMajorObjClass%>" readonly="readonly">
	<input type="hidden" id="JBOQL" value="<%=sJBOQL%>" />
	<input type="hidden" id="ExportFields" value="<%=sExportFields%>" />
	<input type="hidden" id="SumFields" value="<%=sSumFields%>" />
	<input type="hidden" id="Parameters" value="" />
	<!-- <input type="checkbox" checked id="rowLimitCheckbox">
	��������<input type="text" id="rowLimit" value="100" style="width: 50px;text-align: right;"> -->
	<%=new Button("��ѯ","��ѯ","doQuery()").getHtmlText()%>
	<br><br>
	<textarea cols="90" rows="15" id="queryString" onchange="getParamList();" readonly="readonly"><%=sJBOQLModify%></textarea>
	<table style="width:100%;">
		<tr id="paramContainer"></tr>
	</table>
	</div>
</form>
</body>
<script type="text/javascript">
	setDialogTitle("Ԥ��JBOQL��ѯ���");
	var checkFlag = true;
	var paramArray = new Array();
	
	$(document).ready(function(){
		getParamList();
	});

	function doQuery(){
		var rowLimitChecked = $("#rowLimitCheckbox").is(":checked").toString();
		var rowLimit = $("#rowLimit").val();
		//��ѯǰ���Ƚ�������Parameters��ֵ��Ϊ��
		$("#Parameters").val("");
		
		//ȡ������ڵ������󡢲�ѯ���
		var majorObjClass = $("#MajorObjClass").val();
		var queryString = $("#queryString").val();
		if(iV_all()){
			//��������ʽ�滻���س����з�
			queryString = queryString.replace(/\r/ig,"").replace(/\n/ig,"");
			var parametersValue = $("#Parameters").val();
			var statResult = "<%=sSumFields%>".length ==0 ?"2":"1";
			var paraString = "MajorObjClass="+majorObjClass+"&JBOQL="+queryString+"&ExportFields=<%=sExportFields%>&SumFields=<%=sSumFields%>"+
							"&Parameters="+parametersValue+"&RowLimitChecked="+rowLimitChecked+"&RowLimit="+rowLimit+"&StatResult="+statResult;
			top.close();
//			AsControl.PopComp("/AppConfig/QueryScheme/QueryResult.jsp", paraString, "");
			AsControl.PopComp("/AppConfig/QueryScheme/QueryResultList.jsp", paraString, "");
		}
	}
	
	/*����jquery�﷨*/
	function checkRequired(paramid,messageid){
		var value = $("#"+paramid).val();
	    if(value.length == 0){
	    	$("#"+messageid).show();
	    	$("#"+messageid).text("���������"+paramid+"��");
			checkFlag = false;
		}else{
			$("#"+messageid).hide();
	    	$("#"+messageid).text("");
			
			//������ֵ���򱣴��������Parameters
			var parametersValue = $("#Parameters").val() + "," +paramid+"@"+value;
			$("#Parameters").val(parametersValue);
			checkFlag = true;
		}
	    return checkFlag;
	}
	
	function iV_all(){
		for(var i=0;i<paramArray.length;i++){
			var sParameter = paramArray[i];
			var sReturn = checkRequired(sParameter,'msg'+sParameter);
			checkFlag = checkFlag && sReturn;
		}
		return checkFlag;

	}
	/*~[Describe=��ȡ�����б�;InputParam=��;OutPutParam=��;]~*/
	function getParamList(){
		paramArray = []; //��ȡǰ�����
		var majorObjClass = $("#MajorObjClass").val();
		var queryString = $("#queryString").val();
		if(majorObjClass.length == 0  || queryString.length == 0) return;
		queryString = queryString.replace(/\r/ig,"").replace(/\n/ig,"");
		$.ajax({
			type: "POST",
			url: '<%=sWebRootPath%>/AppConfig/QueryScheme/LoadParameterAjax.jsp?CompClientID=<%=CurComp.getClientID()%>&MajorObjClass='+majorObjClass+'&JBOQL='+queryString,
			async: true,
			success: function(msg){
				var list = $.parseJSON(msg);
				if(list.length > 0) $('#paramContainer').html("<font style='font-size: 9pt;'>������ֵ��</font>");
				else $('#paramContainer').html("");
				$('#paramContainer').nextAll('.no').remove();//���
				for(var j=0;j<list.length;j++){
					var obj = list[j];
					var sParameter = obj.Parameter;
					paramArray[j] = sParameter;  //����������ȫ������
					//���paramContainer
					$('#paramContainer').after(addItem(sParameter));
				}
		    }
		});
	}
	
	function addItem(sParameter){
		var item = "<tr class=\"no\"><td class=\"tdr\">"+sParameter+" &nbsp;<font color=\"red\">*</font></td>"+
				"<td class=\"tdl\"><input class=\"input\" type=\"text\" id=\""+sParameter+"\" onblur=\"javascript:checkRequired('"+sParameter+"','msg"+sParameter+"')\"/>"+
				"<label id=\"msg"+sParameter+"\" style=\"color:red\"></label></td></tr>";
		return item;
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
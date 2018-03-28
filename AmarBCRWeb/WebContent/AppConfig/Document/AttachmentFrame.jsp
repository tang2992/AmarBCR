<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%><%
	String sDocNo = CurPage.getParameter("DocNo");
	boolean isReadOnly = "ReadOnly".equals(CurPage.getParameter("RightType"));
	if(sDocNo == null) sDocNo = "";
	
	String[][] sButtons = {
		{"true","All","Button","�ϴ�","","importRecord()","","","",""},
		{"false","","Button","�鿴����","","viewFile()","","","",""},
		{"false","All","Button","ɾ��","","delRecord()","","","",""},
	};
%>
<body style="overflow:hidden;" onresize="javascript:changeStyle();">
<div id="ButtonsDiv" style="margin-left:5px;">
<table><tr><%if(!isReadOnly){%>
	<td><form name="Attachment" style="margin-bottom:0px;" enctype="multipart/form-data" action="<%=sWebRootPath%>/AppConfig/Document/AttachmentUpload.jsp?CompClientID=<%=CurComp.getClientID()%>" method="post">
		<input type="file" name="File" />
		<input type="hidden" name="DocNo" value="<%=sDocNo%>" >
		<input type="hidden" name="FileName" />
	</form></td><%}%>
	<td><%@ include file="/Frame/resources/include/ui/include_buttonset_dw.jspf"%></td>
</tr></table>
</div>
<iframe name="AttachmentList" id="AttachmentList" style="width: 100%;" frameborder="0"></iframe>
</body>
<script type="text/javascript">
	setDialogTitle("��������");

	$(document).ready(function(){
		changeStyle();
		//��list��ʽչʾʱ�����鿴���ݡ�����ɾ������������ť����Ч
		//AsControl.OpenView("/AppConfig/Document/AttachmentList.jsp", "DocNo=<%=sDocNo%>", "AttachmentList");
		AsControl.OpenView("/AppConfig/Document/AttachmentFiles.jsp", "DocNo=<%=sDocNo%>", "AttachmentList");
	});
	
	function changeStyle(){
		document.getElementById("AttachmentList").style.height = document.body.clientHeight - document.getElementById("ButtonsDiv").offsetHeight;
	}
	function importRecord(){
		var o = document.forms["Attachment"];
		var sFileName = o.File.value;
		o.FileName.value = sFileName;
		if (typeof(sFileName) == "undefined" || sFileName==""){
			alert("��ѡ��һ���ļ���!");
			return false;
		}
		var fileSize;
		if(typeof(ActiveXObject) == "function"){ // IE
			var fso = new ActiveXObject("Scripting.FileSystemObject");
			var f1 = fso.GetFile(sFileName);
			fileSize = f1.size;
		}else{
			fileSize = o.File.files[0].size;
		}
		if(fileSize > 2*1024*1024){
			alert("�ļ�����2048k�������ϴ���");
			return false;
		}
		return o.submit();
	}
	
	function delRecord(){
		window.frames["AttachmentList"].deleteRecord();
	}
	
	function viewFile(){
		window.frames["AttachmentList"].viewFile();
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>
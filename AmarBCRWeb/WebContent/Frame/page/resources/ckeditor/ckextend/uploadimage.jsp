<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%><%@ include file="uploadCommon.jsp"%>
<%
//�ļ��ϴ�
UploadManager manager = new UploadManager();
manager.setAllowdFiles("jpg,jpeg,png,gif,swf");
try{
	manager.setSmallWidth(150);
	manager.upload(pageContext);
	//���ش���
	String sFileName = manager.getSmallFilePath();
	String sFileLink = manager.getFilePath();
%>
	<script>
	if(parent.document.getElementById('cke_103_textInput')){//ͼƬsrc
		parent.document.getElementById('cke_103_textInput').value = '<%=sFileName%>';
	}
	if(parent.document.getElementById('cke_142_textInput')){//ͼƬ����
		parent.document.getElementById('cke_142_textInput').value = '<%=sFileLink%>';
		parent.document.getElementById('cke_147_select').value="_blank";
	}
	if(parent.document.getElementById('cke_99_previewImage')){//ͼƬԤ��
		parent.document.getElementById('cke_99_previewImage').src = '<%=sFileName%>';
		parent.document.getElementById('cke_99_previewImage').style.display = '';
		
	}
	
	</script>
<%
}
catch(Exception e){
	out.println("<script>alert('�ϴ��ļ����ִ���"+e.getMessage()+"');</script>"); 
}
 %>
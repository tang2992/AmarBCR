<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<style>
	* {
		font-size: 12px;
	}
</style>
<%@ include file="uploadCommon.jsp"%>
<%
//�ļ��ϴ�
UploadManager manager = new UploadManager();
manager.setAllowdFiles(".jpg,.jpeg,.png,.gif,.bmp");
try{
	manager.upload(pageContext);
	//���ش���
	String callback = request.getParameter("CKEditorFuncNum");//��ȡ�ص�JS�ĺ���Num
	//System.out.println("callback="+ callback);
	out.println("<script>parent.CKEDITOR.tools.callFunction("+callback+",'"+manager.getFilePath()+"');</script>"); 
}
catch(Exception e){
	out.print(e.getMessage()); 
}
%>
<%@ page language="java" contentType="text/html; charset=GBK" %><%@
include file="/Frame/resources/include/include_begin_ajax.jspf"%><script><%
	try{
		// ObjectType="+ObjectType+"&ObjectNo="+sObjectNo+"&ReportScope="+sReportScope+"&ReportDate="+sReportDate
		String sObjectType = CurPage.getParameter("ObjectType");
		String sObjectNo = CurPage.getParameter("ObjectNo");
		String sReportScope = CurPage.getParameter("ReportScope");
		String sReportDate = CurPage.getParameter("ReportDate");
		
		com.amarsoft.awe.common.attachment.AmarsoftUpload upload = new com.amarsoft.awe.common.attachment.AmarsoftUpload();
		upload.initialize(pageContext);
		upload.upload();
		
		com.amarsoft.awe.common.attachment.File file = upload.getFiles().getFile("importfsfile");
		if(file.getSize() > 3){
			com.amarsoft.biz.finance.ExcelImport ei = new com.amarsoft.biz.finance.ExcelImport(sObjectType, sObjectNo, sReportScope, sReportDate);
			InputStream is = file.toInputStream();
			String sReturn = ei.run(is, Sqlca);
			is.close();
			if(com.amarsoft.biz.finance.ExcelImport.SUCCESS.equals(sReturn)){%>alert("导入成功");parent.afterUpload(true);<%}
			else {%>alert("<%=sReturn%>");parent.afterUpload();<%}
		}else{
			%>alert("未上传文档");parent.afterUpload();<%
		}
	}catch(Exception e){
		ARE.getLog().debug(e);
		%>alert("文档不符合规范：<%=e.getMessage()%>");parent.afterUpload();<%
	}
%></script><%@ include file="/Frame/resources/include/include_end_ajax.jspf"%>
<%@ page language="java"
    pageEncoding="GBK"
    import="java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%	
	//��ò���
	String  file = CurPage.getParameter("file");
	if(file==null){
		
		out.println("û�д���Ҫ���ص��ļ���");
		return;
	}
	File f = new File(java.net.URLDecoder.decode(file,"UTF-8"));
	//����
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename=\"" + f.getName() + "\"");
	response.setHeader("cache-control", "no-cache");
	response.setContentLength((int)f.length());
	//���������
	OutputStream os = response.getOutputStream();
	InputStream is = new FileInputStream(f);
	byte buffer[] = new byte[1024];
	int l = 0;
	//д��
	while((l=is.read(buffer))>0) os.write(buffer,0,l);
	os.flush();
	is.close();
	os.close();
%>
<%@ include file="/IncludeEnd.jsp"%>
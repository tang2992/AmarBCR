<%@ page language="java"
    pageEncoding="GBK"
    import="java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%	
	//获得参数
	String  file = CurPage.getParameter("file");
	if(file==null){
		
		out.println("没有传递要下载的文件！");
		return;
	}
	File f = new File(java.net.URLDecoder.decode(file,"UTF-8"));
	//下载
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename=\"" + f.getName() + "\"");
	response.setHeader("cache-control", "no-cache");
	response.setContentLength((int)f.length());
	//设置输出流
	OutputStream os = response.getOutputStream();
	InputStream is = new FileInputStream(f);
	byte buffer[] = new byte[1024];
	int l = 0;
	//写出
	while((l=is.read(buffer))>0) os.write(buffer,0,l);
	os.flush();
	is.close();
	os.close();
%>
<%@ include file="/IncludeEnd.jsp"%>
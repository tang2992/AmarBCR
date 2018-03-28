<%@ page language="java" contentType="text/html; charset=GBK"
    import="java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head></head>
<title>查看文件</title>
<%
	//定义变量
	String file="";
	//获得参数
	String iCount = CurPage.getParameter("iCount");
	java.io.File lf[] =(File[])session.getAttribute("files");
	if(lf!=null){
		File f = lf[Integer.valueOf(iCount).intValue()];
		file=java.net.URLEncoder.encode(f.getPath(),"UTF-8");
	}
	
%>
<%
	if(file==null){
%>
	<script language="javascript">
			alert(getHtmlMessage(74));
			top.close();
	</script>
<%
		return;
	}
	File f = new File(java.net.URLDecoder.decode(file,"UTF-8"));
	//文件不存在
	if(!f.exists()){
%>
		<script language="javascript">
				alert(getHtmlMessage(74));
				top.close();
		</script>
<%
	}
	FileReader fr = new FileReader(f);
	char buff[]=new char[2048];
	try{
		int r = 0;
		while((r=fr.read(buff))>0){
			out.print(new String(buff,0,r)); //输出读取到的字符
		}
	}catch(IOException e){
		out.print(e.getMessage());
	}finally{
		fr.close();
	}
%>
</html>
<%@ include file="/IncludeEnd.jsp"%>
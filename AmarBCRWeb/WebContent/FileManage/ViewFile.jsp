<%@ page language="java" contentType="text/html; charset=GBK"
    import="java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head></head>
<title>�鿴�ļ�</title>
<%
	//�������
	String file="";
	//��ò���
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
	//�ļ�������
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
			out.print(new String(buff,0,r)); //�����ȡ�����ַ�
		}
	}catch(IOException e){
		out.print(e.getMessage());
	}finally{
		fr.close();
	}
%>
</html>
<%@ include file="/IncludeEnd.jsp"%>
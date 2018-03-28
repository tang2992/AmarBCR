<%@ page language="java" contentType="text/html; charset=GBK"
    import="java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	//定义变量
	String file="";
	//获得组件参数	
	//获得页面参数	
	String iCount = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("iCount"));
	java.io.File lf[] =(File[])session.getAttribute("files");
	//获取文件
	if(lf!=null){
		File f = lf[Integer.valueOf(iCount).intValue()];
		file=java.net.URLEncoder.encode(f.getPath(),"UTF-8");
	}
	
%>
<%
	if(file==null){
%>
		<script language=javascript>
		top.returnValue = "1";
			top.close();
		</script>
<%
	}
 	//删除文件
	File f = new File(java.net.URLDecoder.decode(file,"UTF-8"));
	try{
		if(f.delete()){
	%>
			<script language=javascript>
			top.returnValue = "2";
			top.close();
			</script>
	<%
		}else{
	%>
			<script language=javascript>
			top.returnValue = "3";
				top.close();
			</script>
	<%
		}
	}catch(Exception e){
		ARE.getLog().debug(e);
		
		%>
		<script language=javascript>
			top.returnValue = "3";
			top.close();
		</script>
<%
	}
%>
<%@ include file="/IncludeEnd.jsp"%>
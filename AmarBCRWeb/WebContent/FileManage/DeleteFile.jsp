<%@ page language="java" contentType="text/html; charset=GBK"
    import="java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	//�������
	String file="";
	//����������	
	//���ҳ�����	
	String iCount = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("iCount"));
	java.io.File lf[] =(File[])session.getAttribute("files");
	//��ȡ�ļ�
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
 	//ɾ���ļ�
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
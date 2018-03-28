<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="java.io.*"
    import="java.util.*"
    import="com.amarsoft.are.*"
    import="org.apache.commons.fileupload.*"
    import="org.apache.commons.fileupload.disk.*"
    import="org.apache.commons.fileupload.servlet.*"
    import="org.apache.commons.io.output.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head>
<title>上传文件</title>

<%
	//获得参数，上传文件属性
	String folder = CurPage.getParameter("folder");
	if(folder==null) folder="";
	String isFeedback = CurPage.getParameter("isFeedback");
	if(isFeedback==null) isFeedback="0";
	boolean flag = true;
	
%>
<script type="text/javascript">
	//上传文件的位置
	function fileSelected(){
		var filename = document.uploadFileForm.file.value;
		
		var patrn=/^.+\.(enc|txt)$/;
		if (!patrn.exec(filename)){
			alert("请选择要上传的.txt和.enc的报文文件！");
			return false;
		}else{
			if((filename.length>0) && (filename!="undefined")) 
		   		return true;
			else{
				alert(getHtmlMessage(71));//上传文件的位置参数不正确
			   return false;
		   	}	
		}
	}

</script>
</head>
<body bgColor=#ececec>
<%
	if(FileUpload.isMultipartContent(request)){ //上传处理接收
		DiskFileItemFactory factory = new DiskFileItemFactory(); //Create a factory for disk-based file items
		factory.setSizeThreshold(102400); //大于100K的文件，需要缓冲
		ServletFileUpload upload = new ServletFileUpload(factory);//Create a new file upload handler
		upload.setSizeMax(-1); //Set overall request size constraint
		List items = upload.parseRequest(request);
		Iterator iter = items.iterator();
		File saveTo = null;

		while (iter.hasNext()) {
		    FileItem item = (FileItem) iter.next();
		    if (!item.isFormField()) continue;
		    if (item.getFieldName().equals("folder")) {
		    	folder = item.getString();
		    	break;
		    }
		}
		if(folder==null){
			flag = false;
		 %>
	    	<script language=javascript>
			 	alert(getHtmlMessage(71));//上传文件的位置参数不正确
 				top.close();
			</script>
	    <%	
		}else{
			String sFile = java.net.URLDecoder.decode(folder,"UTF-8");
			File fd = new File(sFile);
			if(!(fd.exists() && fd.isDirectory())){
				
		%>
			 <script language=javascript>
					alert(getHtmlMessage(72));//上传文件的位置参数不正确
		 			top.close();
			</script>
		 <%	
			}else{
				iter = items.iterator();
				while (iter.hasNext()) {
				    FileItem item = (FileItem) iter.next();
				    if (item.isFormField()) continue;
				    String fileName = item.getName();
				    String fn[] = fileName.split("\\\\");
				    fileName = fn[fn.length-1];
				    try{
				    	saveTo = new File(fd,fileName);
				    	item.write(saveTo);
				    }catch(Exception ex){
				    	flag = false;
				    %>
				    	<script language=javascript>
            			 	alert(getHtmlMessage(10));//上传文件失败！
             				top.close();
       					</script>
				    <%
				    }
				    break;
				}
			}
		}
		if(flag==true){
%>
	   <script language=javascript>
	   if(<%=isFeedback%>=="1"){
        	if(confirm(getHtmlMessage(13)+"是否开始解析反馈报文？")){
        		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun","taskName=feedback");
        		alert(ret);
        	}
        }else{
       	 alert(getHtmlMessage(13)); 
        } 
        top.close();
       </script>
<% 		
		}
	}else{//非上传文件接收，显示文件浏览的画面
		if(folder==null||flag==false){
 %>
		 	<script language=javascript>
 			 	alert(getHtmlMessage(71));//上传文件失败！
  				top.close();
			</script>
<%			
		}else{
%>
			<h2>请选择要上传的文件：</h2>
			<form method="POST"  enctype="multipart/form-data" name="uploadFileForm" action="<%=sWebRootPath%>/FileManage/UploadFile.jsp?CompClientID=<%=CurComp.getClientID()%>" onSubmit="return fileSelected()">
				<table align="center">
				<tr>
    				<td>   
    					<input type="file" size=30  name="file"> 
    				</td>
    			</tr>
		      	<tr>
		      		<td>
		      			&nbsp;&nbsp;
		    			<input type="hidden" name="folder" value="<%=folder%>">
						<input type=hidden name="FileName" value="" >
		    		</td> 
		    	</tr>
		    	<tr>
		      		<td>
		      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input  type="submit" style="width:50px"  name="ok" value="确认" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" style="width:50px"  name="Cancel" value="取消" onclick="javascript:self.returnValue='_none_';self.close()">
				</td>	    
			</tr>
 			</table>	
			</form>
		<%} %>
<%		
	}
%>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>
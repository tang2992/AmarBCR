<%@ page language="java" contentType="text/html; charset=GBK"
	import="com.amarsoft.are.io.FileFilterByName" 
	import="com.amarsoft.are.*,com.amarsoft.app.bcr.common.worktip.*"%>
<%@ include file="/IncludeBegin.jsp"%>

<%
	//����������	
   String sFlag = CurPage.getParameter("Flag");
%>

<html>
<body class=pagebackground >
<%	
	//���session�е�����
	String[][] dir = (String[][])session.getAttribute("DirectoryDefine");
	String folder ="";	
    //��session��ȡ����������
	int i= Integer.valueOf(sFlag).intValue();
	//�Ƿ���
	String isFeedback = dir[i][0].indexOf("����")>-1?"1":"0";
	//�����ļ��б�����
	folder = java.net.URLEncoder.encode(dir[i][1],"UTF-8");
	System.out.print(")))))))))))))))"+folder);
    java.io.File dataDir = new java.io.File(dir[i][1]);
    System.out.print(")))))))))))))))"+dataDir);
	if(dataDir.exists() && dataDir.isDirectory()){//�ļ����ڣ�������Ŀ¼,Ѱ��Ŀ¼�����ļ�
		FileFilterByName ff = new FileFilterByName("",dir[i][2]);
		ff.setDirectoryInclude(false);
		java.io.File lf[] = dataDir.listFiles((FileFilter)ff);
		java.io.File temp = null;
		boolean condition = false;
		for (int k=0;k<lf.length;k++){
				for(int j=lf.length-1;j>k;j--){
					condition=lf[j].lastModified()>lf[j-1].lastModified();
					if(condition){
						temp=lf[j];   
						lf[j]=lf[j-1];   
						lf[j-1]=temp;
				}
			}
		}
		session.setAttribute("files",lf);		
		%>
		<TABLE>
			<TR>
				<%
				if(dir[i][3].indexOf("upload")>=0){
				%>
					<TD class="buttontd"><%=new Button("�ϴ��ļ�","�ϴ��ļ�","uploadFile()","","").getHtmlText()%></TD>
				<%
				}
				if(dir[i][3].indexOf("parse")>=0){
				%>
					<TD class="buttontd"><%=new Button("��������","��������","parseFiles()","","").getHtmlText()%></TD>
				<%}%>
			</TR>
		</TABLE>
		<div id="view_body" style="overflow:auto;">
			<%
				if(lf.length==0){
			%>
			<p>
			<TABLE id = "fileHeader" align="left" border=0 cellspacing=0 cellpadding=0 bgcolor=#E4E4E4 bordercolor=#999999 bordercolordark=#FFFFFF >
				<TR height=20>
					<TD style='font-family:����,arial,sans-serif;font-size: 12pt;font-weight: normal; ' >�������ļ�</TD>
				</TR>		
			</TABLE>
			<%		
			}else{
				if(dir[i][3].indexOf("view")>=0){
				%>
				<p>
				<TABLE id = "fileBody" align=left border=1 cellspacing=0 cellpadding=0 bgcolor=#E4E4E4 bordercolor=#999999 bordercolordark=#FFFFFF>
				<%
					for (int k=0;k<lf.length;k++){
						if(k==0){				
				%>
						<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#cccccc height=20 >
							<TD style='font-family:����,arial,sans-serif;font-size: 9pt;font-weight: normal; padding-left: 2;color: #55554B;background-color: #FEFEFE;  background-image:url(Resources/1/Support/back.gif);cursor: hand;	text-decoration: none;	text-align:center;'  noWrap>&nbsp;</TD>
							<TD style='font-family:����,arial,sans-serif;font-size: 9pt;font-weight: normal; padding-left: 2;color: #55554B;background-color: #FEFEFE;  background-image:url(/Resources/1/Support/back.gif);cursor: hand;	text-decoration: none;	text-align:center;'  noWrap  >��Ŀ���ļ�&nbsp;&nbsp;</TD>
				<%
						if(dir[i][3].indexOf("download")>=0){
				%>
							<TD style='font-family:����,arial,sans-serif;font-size: 9pt;font-weight: normal; padding-left: 2;color: #55554B;background-color: #FEFEFE;  background-image:url(/Resources/1/Support/back.gif);cursor: hand;	text-decoration: none;	text-align:center;'  noWrap >����&nbsp;</TD>
				<%} 
						if(dir[i][3].indexOf("delete")>=0){
				%>
							<TD style='font-family:����,arial,sans-serif;font-size: 9pt;font-weight: normal; padding-left: 2;color: #55554B;background-color: #FEFEFE;  background-image:url(/Resources/1/Support/back.gif);cursor: hand;	text-decoration: none;	text-align:center;'  noWrap  >ɾ��&nbsp;</TD>
				<%}
				%>
							<TD style='font-family:����,arial,sans-serif;font-size: 9pt;font-weight: normal; padding-left: 2;color: #55554B;background-color: #FEFEFE;  background-image:url(/Resources/1/Support/back.gif);cursor: hand;	text-decoration: none;	text-align:center;'  noWrap  >�ļ��޸�����&nbsp;</TD>
							<TD style='font-family:����,arial,sans-serif;font-size: 9pt;font-weight: normal; padding-left: 2;color: #55554B;background-color: #FEFEFE;  background-image:url(/Resources/1/Support/back.gif);cursor: hand;	text-decoration: none;	text-align:center;'  noWrap >�ļ���С(K)&nbsp;</TD>
						</TR>
				<%
			 			}
				%>
						<TR height=20>
							<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 9pt; CURSOR: hand; COLOR: black; valign: top; cursor: hand;align: absmiddle" vAlign=top align=middle width=20 bgColor=#ececec ><%=k+1%></TD>
				<%
						if(dir[i][3].indexOf("view")>=0){
				%>
							<TD noWrap style='height:20;font-family:����,arial,sans-serif;font-size:9pt; COLOR: black;background-color: #FEFEFE; cursor: hand;valign: middle; align: absmiddle'>
								<% if(lf[k].getName().endsWith("enc")||lf[k].getName().endsWith("zip")){ %>
									<%=lf[k].getName()%>
								<% }else{ %>
									<a href="javascript:viewFile('<%=k%>')"><%=lf[k].getName()%></a>
								<%} %>
							</TD>
				<%			
						}else{
				%>
							<TD noWrap style='height:20;font-family:����,arial,sans-serif;font-size:9pt; COLOR: black;background-color: #FEFEFE; cursor: hand;valign: middle; align: absmiddle'>
								<%=lf[k].getName()%>
							</TD>
				<%			
						}
						if(dir[i][3].indexOf("download")>=0){
				%>
							<TD noWrap style='height:20;font-family:����,arial,sans-serif;font-size:9pt; COLOR: black;background-color: #FEFEFE; cursor: hand;valign: middle; align: absmiddle'>
								<a href="javascript:downloadFile('<%=lf[k].getPath().replaceAll("\\\\","/")%>');">[�����ļ�]</a>
							</TD>
				<%			
						} 
						if(dir[i][3].indexOf("delete")>=0){
				%>
							<TD noWrap style='height:20;font-family:����,arial,sans-serif;font-size:9pt; COLOR: black;background-color: #FEFEFE; cursor: hand;valign: middle; align: absmiddle'>
								<a href="javascript:deleteFile('<%=k%>')">[ɾ���ļ�]</a>
							</TD>
				<%
						}
						java.util.Date date = new java.util.Date(lf[k].lastModified());
						SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String dateString = formate.format(date);
				%>
							<TD noWrap style='height:20;font-family:����,arial,sans-serif;font-size:9pt; COLOR: gray;background-color: #FEFEFE; cursor: hand;valign: middle; align: absmiddle' align="center"><%=dateString%> </TD>
							<TD  noWrap style='height:20;font-family:����,arial,sans-serif;font-size:9pt; COLOR: gray;background-color: #FEFEFE; cursor: hand;valign: middle; align: absmiddle' align="center"><%=lf[k].length()/1024+1%></TD>
						</TR>		
				<%			
						if(k==lf.length){	
					 	}
					}
				%>
				</TABLE>	
			<%	}else{
	    	%>
				<TABLE id=dataTable width="100%"  borderColor=#999999  cellspacing=0 borderColorDark=#ffffff cellPadding=0 align=left  border=0>
				<TR>
					<TD class=ListDWArea>	
				  		<TR height=20>
							<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 12pt; CURSOR: hand; COLOR: balck; cursor: hand;valign: middle; align: absmiddle" ><%=dir[i][0]%><b>�Բ�����û�в鿴���ļ���Ȩ��</b></TD>
				  		</TR>
					</TD>
				</TR>
				</TABLE>
	    	<%
			}	
		}
		%>
		</div>
		<%
	}
%>

</body>
<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Main05;Describe=��ͼ�¼�;]~*/%>
	<script type="text/javascript">
	//�����ļ�
	function downloadFile(file){
		AsControl.OpenView("/AppConfig/ControlCenter/LogManage/FileView.jsp","file="+file,"");
	}
	
	/*~[Describe=�ϴ��ļ�;InputParam=��;OutPutParam=��;]~*/
	function uploadFile(){
		var isFeedback = "<%=isFeedback%>";
      	var feedbackErrorCount = "<%=WorkTipUtil.getFeedbackErrCount(CurUser.getUserID(),CurUser.getRelativeOrgID())%>";
      	AsControl.PopComp("/FileManage/UploadFile.jsp","folder=<%=folder%>&isFeedback="+isFeedback,"dialogWidth=350px;dialogHeight=250px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		var feedbackErrorCount2 = "<%=WorkTipUtil.getFeedbackErrCount(CurUser.getUserID(),CurUser.getRelativeOrgID())%>";
		if(isFeedback=='1'&&(feedbackErrorCount2>feedbackErrorCount))
			openComp('FeedBackMain','/ErrorManage/FeedBackManage/FeedBackMain.jsp','','_top','');
		else
			reloadSelf(); 
		
	}
	/*~[Describe=��������;InputParam=��;OutPutParam=��;]~*/
	function parseFiles(){
		popComp("ParseFile","/FileManage/ParseFile.jsp","folder="+"<%=folder%>","dialogWidth=350px;dialogHeight=250px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
		
	}
	/*~[Describe=ɾ���ļ�;InputParam=��;OutPutParam=��;]~*/
	function deleteFile(k){
		if(confirm(getHtmlMessage('2'))){
			var returnValue=popComp("DeleteFile","/FileManage/DeleteFile.jsp","iCount="+k,"dialogWidth=150px;dialogHeight=70px;resizable=no;scrollbars=no;status:no;maximize:no;help:no;");
			if(returnValue=="1")	alert(getHtmlMessage(73));
			if(returnValue=="2")	alert(getHtmlMessage(7));
			if(returnValue=="3")	alert(getHtmlMessage(8));		
			reloadSelf();	
		}
	}
	/*~[Describe=�ļ�����;InputParam=��;OutPutParam=��;]~*/
	function viewFile(k){
		popComp("ViewFile","/FileManage/ViewFile.jsp","iCount="+k,"dialogWidth=60;dialogHeight=40;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}

	/*~�ļ���������ʱresize��������ַ�IE������޹������������ļ���ʾ��ȫ�����*/
	var defaultHeight = 30 ;	
	(function(){
		$(window).resize(function(){
			var height = $("#fileBody tr").length;
			var height0 = $("#view_body").height("auto").height();
			if(height > defaultHeight+1)//
				$("#view_body").height(height0 = ((defaultHeight+1)*height0/height)- 30);
			//$("#view_bottom").height(height - height0 - 30);
		}).resize();
	})();  
	</script> 
</html>
<%@ include file="/IncludeEnd.jsp"%>
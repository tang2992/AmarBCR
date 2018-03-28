<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��:�ĵ������б�
 	*/
	String sDocNo = CurPage.getParameter("DocNo");
	String sUserID = CurPage.getParameter("UserID");
	if(sDocNo == null) sDocNo = "";
	if(sUserID == null) sUserID = "";
	boolean isReadOnly = "ReadOnly".equals(CurPage.getParameter("RightType"));
%>
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/Frame/page/resources/css/attachment.css"/>
<body style="height: 100%;overflow: hidden;">
<div class="attachment_wrap" style="height:30px;">
<%
	String iconClass = "icon icon_file";
	DecimalFormat FORMAT = new DecimalFormat("###.0");
	SqlObject asql = new SqlObject("select AttachmentNo,FileName,ContentType,ContentLength from DOC_ATTACHMENT where DOCNO=:DOCNO order by AttachmentNo desc");
	ASResultSet rs = Sqlca.getASResultSet(asql.setParameter("DOCNO", sDocNo));
	while(rs.next()){
		String sContentType = rs.getString("ContentType").trim();
		if(sContentType.equals("application/msword") || sContentType.equals("application/kswps")) iconClass = "icon icon_word";
		else if(sContentType.equals("application/vnd.ms-excel") || sContentType.equals("application/kset")) iconClass = "icon icon_excel";
		else if(sContentType.equals("application/vnd.ms-powerpoint")) iconClass = "icon icon_ppt";
		else if(sContentType.equals("application/pdf")) iconClass = "icon icon_pdf";
		else if(sContentType.equals("image/bmp")) iconClass = "icon icon_bmp";
		else if(sContentType.equals("image/gif")) iconClass = "icon icon_gif";
		else if(sContentType.equals("image/jpeg")) iconClass = "icon icon_jpeg";
		else if(sContentType.equals("image/png") || sContentType.equals("image/x-png")) iconClass = "icon icon_png";
		else if (sContentType.equals("application/zip")
			 	|| sContentType.equals("application/x-rar")
				|| sContentType.equals("application/x-java-archive")
				|| sContentType.equals("application/x-7z-compressed")){
			iconClass = "icon icon_compress";
		}else if(sContentType.equals("text/plain")) iconClass = "icon icon_text";
		else if(sContentType.equals("text/html")) iconClass = "icon icon_html";
		else if(sContentType.equals("text/css")) iconClass = "icon icon_css";
		else
			iconClass = "icon icon_file";
		
		double iContentLength = rs.getDouble("ContentLength"); //�ֽ���
		String sLength ="";
		if(iContentLength >= 1024*1024) sLength = FORMAT.format(iContentLength/(1024*1024)) +" MB";
		else sLength = FORMAT.format(iContentLength/1024) +" KB";
%>
    <div class="attachment_block" >
		<div class="attachment_show">
            <div class="<%=iconClass%>"></div>
            <a class="attachment_name" onclick="viewFile('<%=rs.getString(1)%>');return false;"><%=rs.getString(2)%></a>
            <%if(!isReadOnly){%>
	            <a class="attachment_delete" href="javascript:void(0);" onmousedown="AsLink.stopEvent(event);" onclick="deleteRecord('<%=rs.getString(1)%>');return false;" hidefocus="">&nbsp;</a>
            <%} %>
            <div class="attachment_info">��С�� <%=sLength%></div>
        </div>
        <div class="attachment_shadow"></div>
    </div>
    <%}
	rs.close(); %>
</div>
</body>
<script type="text/javascript">
	(function(){
		var body = $(document.body);
		var div1 = $(">div:eq(0)", body);
		$(window).resize(function(){
			div1.height(body.innerHeight());
		}).resize();
	})();
	
	function deleteRecord(sAttachmentNo){
		if(confirm(getHtmlMessage(2))){ //�������ɾ������Ϣ��
       		var sPara = "DocNo=<%=sDocNo%>,AttachmentNo="+sAttachmentNo;
       		var sReturn = RunJavaMethodSqlca("com.amarsoft.app.awe.config.document.AttachmentAction","deleteAttachment",sPara);
    		if(sReturn != "SUCCESS"){
    			alert("ɾ������ʧ�ܣ�");
    		}else{
    		    alert("ɾ�������ɹ���");
    		    top.reloadSelf();
    		}
		}
	}

	<%/*~[Describe=�鿴���޸�����;]~*/%>
	function viewFile(sAttachmentNo){
		AsControl.OpenPage("/AppConfig/Document/AttachmentView.jsp","DocNo=<%=sDocNo%>&AttachmentNo="+sAttachmentNo);
	}

</script>	
<%@ include file="/IncludeEnd.jsp"%>
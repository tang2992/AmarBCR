<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="java.util.*,java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	String sOccurTIMES = "",sName="";
	//���ø��µı�
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	String sOccurDate =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OccurDate"));
	session.setAttribute("OCCURDATE",sOccurDate);
	//���ݸ��µı������ø��µ��ֶ������ǻ����������չ�ڴ���
	if(sDBTableName.equals("HIS_LOANRETURN")||sDBTableName.equals("HIS_FINARETURN")){
		sName = "RETURNTIMES";
		sOccurTIMES = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("RETURNTIMES"));
		session.setAttribute("RETURNTIMES",sOccurTIMES);
	}
	if(sDBTableName.equals("HIS_LOANEXTENSION")||sDBTableName.equals("HIS_FINAEXTENSION")){
		sName = "EXTENTIMES";
		sOccurTIMES = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("EXTENTIMES"));
		session.setAttribute("EXTENTIMES",sOccurTIMES);
	}
	//��ȡ���±��������������ֵ
	String sKeyName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));
	String sKeyValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));
%>
<html>
<head>
<title>���Ļ���/չ�ڴ���</title>
</head>
<body  class=pagebackground  >
<%=new Button("����","����","javascript:SaveOccurTimes()","","").getHtmlText()%>
<p>
<TABLE id=dataTable borderColor=#999999  cellspacing="0" borderColorDark=#ffffff cellPadding=0 align=left bgColor=#e4e4e4 border=1>
<TR>
<TD class=ListDWArea>
<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#cccccc height=20>
<TD class=GDTdHeader  noWrap align=left >����/չ�ڴ���&nbsp;&nbsp;</TD>
</TR>
<TR height=21>
<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 9pt; CURSOR: hand; COLOR: gray; valign: top; align: absmiddle"  align=left width=170 bgColor=#ececec>
<INPUT id="Times"" name="Times" value="<%=sOccurTIMES%>"  >
</TD>
</TR>
</TD>
</TR>
</TABLE>
</body>
<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Main05;Describe=��ͼ�¼�;]~*/%>
	<script language=javascript> 
	/*~[Describe=treeview���浽�ļ���;InputParam=��;OutPutParam=��;]~*/
	//��������ֵ
	function SaveOccurTimes(){
		var sTimes = document.getElementById("Times").value;
		var patrn=/^[0-9]{1,2}$/; 
		
		
		//if(typeof(sTimes)=="undefined" || sTimes=="") return;
		
		if(sTimes==""){
			alert("�����뻹�����");
			return;
		}
		
		if (!patrn.exec(sTimes)) {
			alert("����/չ�ڴ���ֻ��Ϊ���֣�");
			return;
		}
		 
		var returnValue = popComp("ChangeKeyWord","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeKeyWord.jsp","DBTableName=<%=sDBTableName%>&KeyName=<%=sKeyName%>&KeyValue=<%=sKeyValue%>&NEWName=<%=sName%>&NEWValue="+sTimes,"");
		if(returnValue.split("@")[0]=="false"){
		 	alert("����/չ�ڴ����ظ�,�����¼��");
		 	top.returnValue = "<%=sOccurTIMES%>";
		}else{
		 	alert("�޸Ļ���/չ�ڴ����ɹ���");
		 	top.returnValue = sTimes;
		}
		top.close();
	}
	
	
</script>
	</script> 
<%/*~END~*/%>
</html>
<%@ include file="/IncludeEnd.jsp"%>
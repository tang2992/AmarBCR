<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="java.util.*,java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	//����ҵ��������
	//��ȡ���µ�ҵ��������ֵ
	String sOCCURDATE = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OCCURDATE"));
	//���µı�
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	//���±��������
	String sKeyName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));
	//���±������ֵ
	String sKeyValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));
	
	String[] sName = sKeyName.split("@");
	String[] sValue = sKeyValue.split("@");
	for(int i=0;i<sName.length;i++){	
		if("OCCURDATE".equalsIgnoreCase(sName[i])||"RETURNTIMES".equalsIgnoreCase(sName[i])||"EXTENTIMES".equalsIgnoreCase(sName[i]))
			session.setAttribute(sName[i],sValue[i]);
	}
%>
<html>
<head>
<title>����ҵ��������</title>
</head>
<body  class=pagebackground  >
<%=new Button("����","����","javascript:SaveOccurDate()","","").getHtmlText()%>
<p>
<TABLE id=dataTable borderColor=#999999  cellspacing="0" borderColorDark=#ffffff cellPadding=0 align=left bgColor=#e4e4e4 border=1>
<TR>
<TD class=ListDWArea>
<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#cccccc height=20>
<TD class=GDTdHeader  noWrap align=left >ҵ��������&nbsp;&nbsp;</TD>
</TR>
<TR height=21>
<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 9pt; CURSOR: hand; COLOR: gray; valign: top; align: absmiddle"  align=left width=170 bgColor=#ececec>
<INPUT id="date" name="date" value="<%=sOCCURDATE%>" readonly >
<INPUT type="button" class="inputDate" value="..." onclick="selectDate()" >
</TD>
</TR>
</TD>
</TR>
</TABLE>
</body>
<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Main05;Describe=��ͼ�¼�;]~*/%>
	<script language=javascript> 
	/*~[Describe=treeview���浽�ļ���;InputParam=��;OutPutParam=��;]~*/
	//������µ�����
	function SaveOccurDate(){
		var date = document.getElementById("date").value;
		if (typeof(date)=="undefined" || date.length==0) {
			alert("ҵ�������ڲ���Ϊ�գ�");
			return;
		}
		var returnValue = popComp("ChangeKeyWord","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeKeyWord.jsp","DBTableName=<%=sDBTableName%>&KeyName=<%=sKeyName%>&KeyValue=<%=sKeyValue%>&NEWName=OCCURDATE&NEWValue="+date,"");
		if(returnValue.split("@")[0]=="false"){
    			alert("ҵ���������ظ�,�����¼��");
    		}else{
    			alert("�޸�ҵ�������ڳɹ���");
    			top.close();
			}
	}
	/*~[Describe=treeview���浽�ļ���;InputParam=��;OutPutParam=��;]~*/
	//ѡ������
	function selectDate(){
		var date = document.getElementById("date").value;
		date =  PopPage("/Resources/1/Support/XCalendar.jsp?d="+date,"","dialogWidth=19;dialogHeight=17;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		if (date==""||typeof(date)!="undefined"){
			document.getElementById("date").value = date;
		}else if(typeof(date)=="undefined"){
			document.getElementById("date").value="<%=sOCCURDATE%>";
		}
	}
	</script> 
<%/*~END~*/%>
</html>
<%@ include file="/IncludeEnd.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="java.util.*,java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	String sALoanCardNo = "",sName="";
	//���ø��µı�
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	//���ݸ��µı������ø��µ��ֶ���
	if(sDBTableName.equals("ECR_ASSURECONT")){
		sName = "ALOANCARDNO";
		sALoanCardNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("ALOANCARDNO"));
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
<%=new Button("����","����","javascript:SaveALoanCardNo()","","").getHtmlText()%>
<p>
<TABLE id=dataTable borderColor=#999999  cellspacing="0" borderColorDark=#ffffff cellPadding=0 align=left bgColor=#e4e4e4 border=1>
<TR>
<TD class=ListDWArea>
<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#cccccc height=20>
<TD class=GDTdHeader  noWrap align=left >��֤�˴�����&nbsp;&nbsp;</TD>
</TR>
<TR height=21>
<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 9pt; CURSOR: hand; COLOR: gray; valign: top; align: absmiddle"  align=left width=170 bgColor=#ececec>
<INPUT id="ALoanCardNo"" name="ALoanCardNo" value="<%=sALoanCardNo%>"  >
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
	function SaveALoanCardNo(){
		var sALoanCardNo = document.getElementById("ALoanCardNo").value;
		if (!ValidityCheck()) return;
		var returnValue = popComp("ChangeKeyWord","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeKeyWord.jsp","DBTableName=<%=sDBTableName%>&KeyName=<%=sKeyName%>&KeyValue=<%=sKeyValue%>&NEWName=<%=sName%>&NEWValue="+sALoanCardNo,"");
		if(returnValue.split("@")[0]=="false"){
    			alert("��Ϣ����ʧ�ܣ�");
    		}else{
    			alert("�޸ı�֤�˴����ųɹ���");
    			top.close();
			}
	}
	
	function ValidityCheck()
	{	
		//������У��
		var sLoanCardNo = document.getElementById("ALoanCardNo").value;
		if(typeof(sLoanCardNo)=="undefined"||sLoanCardNo==""){
			alert('�����Ų���Ϊ��!');
			return false;
		}else if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
			if(!CheckLoanCardID(sLoanCardNo)||sLoanCardNo.length>16){
				alert('��������������!');
				return false;
			}
		}
		return true;
	}
	</script> 
<%/*~END~*/%>
</html>
<%@ include file="/IncludeEnd.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="java.util.*,java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	String sOccurTIMES = "",sName="";
	//设置更新的表
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	String sOccurDate =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OccurDate"));
	session.setAttribute("OCCURDATE",sOccurDate);
	//根据更新的表来设置更新的字段名：是还款次数还是展期次数
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
	//获取更新表的主键名和主键值
	String sKeyName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));
	String sKeyValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));
%>
<html>
<head>
<title>更改还款/展期次数</title>
</head>
<body  class=pagebackground  >
<%=new Button("保存","保存","javascript:SaveOccurTimes()","","").getHtmlText()%>
<p>
<TABLE id=dataTable borderColor=#999999  cellspacing="0" borderColorDark=#ffffff cellPadding=0 align=left bgColor=#e4e4e4 border=1>
<TR>
<TD class=ListDWArea>
<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#cccccc height=20>
<TD class=GDTdHeader  noWrap align=left >还款/展期次数&nbsp;&nbsp;</TD>
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
<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main05;Describe=树图事件;]~*/%>
	<script language=javascript> 
	/*~[Describe=treeview保存到文件中;InputParam=无;OutPutParam=无;]~*/
	//保存主键值
	function SaveOccurTimes(){
		var sTimes = document.getElementById("Times").value;
		var patrn=/^[0-9]{1,2}$/; 
		
		
		//if(typeof(sTimes)=="undefined" || sTimes=="") return;
		
		if(sTimes==""){
			alert("请输入还款次数");
			return;
		}
		
		if (!patrn.exec(sTimes)) {
			alert("还款/展期次数只能为数字！");
			return;
		}
		 
		var returnValue = popComp("ChangeKeyWord","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeKeyWord.jsp","DBTableName=<%=sDBTableName%>&KeyName=<%=sKeyName%>&KeyValue=<%=sKeyValue%>&NEWName=<%=sName%>&NEWValue="+sTimes,"");
		if(returnValue.split("@")[0]=="false"){
		 	alert("还款/展期次数重复,请重新检查");
		 	top.returnValue = "<%=sOccurTIMES%>";
		}else{
		 	alert("修改还款/展期次数成功！");
		 	top.returnValue = sTimes;
		}
		top.close();
	}
	
	
</script>
	</script> 
<%/*~END~*/%>
</html>
<%@ include file="/IncludeEnd.jsp"%>
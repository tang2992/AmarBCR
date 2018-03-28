<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="java.util.*,java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	//更新业务发生日期
	//获取更新的业务发生日期值
	String sOCCURDATE = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OCCURDATE"));
	//更新的表
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	//更新表的主键名
	String sKeyName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));
	//更新表的主键值
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
<title>更改业务发生日期</title>
</head>
<body  class=pagebackground  >
<%=new Button("保存","保存","javascript:SaveOccurDate()","","").getHtmlText()%>
<p>
<TABLE id=dataTable borderColor=#999999  cellspacing="0" borderColorDark=#ffffff cellPadding=0 align=left bgColor=#e4e4e4 border=1>
<TR>
<TD class=ListDWArea>
<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#cccccc height=20>
<TD class=GDTdHeader  noWrap align=left >业务发生日期&nbsp;&nbsp;</TD>
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
<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main05;Describe=树图事件;]~*/%>
	<script language=javascript> 
	/*~[Describe=treeview保存到文件中;InputParam=无;OutPutParam=无;]~*/
	//保存更新的主键
	function SaveOccurDate(){
		var date = document.getElementById("date").value;
		if (typeof(date)=="undefined" || date.length==0) {
			alert("业务发生日期不能为空！");
			return;
		}
		var returnValue = popComp("ChangeKeyWord","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeKeyWord.jsp","DBTableName=<%=sDBTableName%>&KeyName=<%=sKeyName%>&KeyValue=<%=sKeyValue%>&NEWName=OCCURDATE&NEWValue="+date,"");
		if(returnValue.split("@")[0]=="false"){
    			alert("业务发生日期重复,请重新检查");
    		}else{
    			alert("修改业务发生日期成功！");
    			top.close();
			}
	}
	/*~[Describe=treeview保存到文件中;InputParam=无;OutPutParam=无;]~*/
	//选择日期
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
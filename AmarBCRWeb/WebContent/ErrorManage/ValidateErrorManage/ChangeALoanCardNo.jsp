<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"
    import="java.util.*,java.io.*,com.amarsoft.are.*"
%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	String sALoanCardNo = "",sName="";
	//设置更新的表
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	//根据更新的表来设置更新的字段名
	if(sDBTableName.equals("ECR_ASSURECONT")){
		sName = "ALOANCARDNO";
		sALoanCardNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("ALOANCARDNO"));
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
<%=new Button("保存","保存","javascript:SaveALoanCardNo()","","").getHtmlText()%>
<p>
<TABLE id=dataTable borderColor=#999999  cellspacing="0" borderColorDark=#ffffff cellPadding=0 align=left bgColor=#e4e4e4 border=1>
<TR>
<TD class=ListDWArea>
<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#cccccc height=20>
<TD class=GDTdHeader  noWrap align=left >保证人贷款卡编号&nbsp;&nbsp;</TD>
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
<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main05;Describe=树图事件;]~*/%>
	<script language=javascript> 
	/*~[Describe=treeview保存到文件中;InputParam=无;OutPutParam=无;]~*/
	//保存主键值
	function SaveALoanCardNo(){
		var sALoanCardNo = document.getElementById("ALoanCardNo").value;
		if (!ValidityCheck()) return;
		var returnValue = popComp("ChangeKeyWord","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeKeyWord.jsp","DBTableName=<%=sDBTableName%>&KeyName=<%=sKeyName%>&KeyValue=<%=sKeyValue%>&NEWName=<%=sName%>&NEWValue="+sALoanCardNo,"");
		if(returnValue.split("@")[0]=="false"){
    			alert("信息更新失败！");
    		}else{
    			alert("修改保证人贷款卡编号成功！");
    			top.close();
			}
	}
	
	function ValidityCheck()
	{	
		//贷款卡编号校验
		var sLoanCardNo = document.getElementById("ALoanCardNo").value;
		if(typeof(sLoanCardNo)=="undefined"||sLoanCardNo==""){
			alert('贷款卡编号不能为空!');
			return false;
		}else if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
			if(!CheckLoanCardID(sLoanCardNo)||sLoanCardNo.length>16){
				alert('贷款卡编号输入有误!');
				return false;
			}
		}
		return true;
	}
	</script> 
<%/*~END~*/%>
</html>
<%@ include file="/IncludeEnd.jsp"%>
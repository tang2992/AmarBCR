<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<% 
	//定义变量
	ASResultSet rs = null;
	String sSql="";
	int size = 460;
	String[][] sTableName = null;
	
	//获取参数
	
	String sKeyValueMain = CurComp.getParameter("MAINBUSINESSNO");
	if(sKeyValueMain == null) sKeyValueMain = "";
	
	String sLOANCARDNO = CurComp.getParameter("LOANCARDNO");
	if(sLOANCARDNO == null) sLOANCARDNO = "";
	
	String sCUSTOMERID = CurComp.getParameter("CUSTOMERID");
	if(sCUSTOMERID == null) sCUSTOMERID = "";
	String sRecordKey = CurComp.getParameter("RECORDKEY");
	if(sRecordKey == null) sRecordKey = "";
	String sRECORDTYPE = CurComp.getParameter("sRECORDTYPE");
	if(sRECORDTYPE == null) sRECORDTYPE = "";
	
%>

<%
	//根据业务主键查询反馈表中所有的错误信息
	//根据反馈表中recordtype字段到codelibrary中查询该业务对应的表的相关信息：表名,表的描述,表的业务主键
	//对于客户的反馈信息和业务的反馈信息是采取不同显示方式
	//将查询到的信息保存到sTableName数组中：保存的信息包括：
	//sTableName[m][0]:表的描述
	//sTableName[m][1]:表名
	//sTableName[m][3]：查找属性-TRACENUMBER
	//sTableName[m][2]：查找值-TRACENUMBER的值
	//sTableName[m][4]:主键名
	//sTableName[m][5]:主键值,当主键值存在时，表示已经找到了记录，可以进行显示
	//对于显示的反馈的信息：是根据错误跟踪编号进行查找的
	//获取feedback表中的记录类型，错误跟踪编号，错误信息
	sSql=" select FEED.RECORDTYPE,TRACENUMBER,ERRMSG,SORTNO FROM ECR_FEEDBACK FEED,CODE_LIBRARY CODE "
		+ " WHERE CODE.ITEMNO = FEED.RECORDTYPE AND CODE.CODENO='recordtype' ";

	 if((Integer.parseInt(sRECORDTYPE)>=1&&Integer.parseInt(sRECORDTYPE)<=7)||(Integer.parseInt(sRECORDTYPE)>=43&Integer.parseInt(sRECORDTYPE)<=47)){
		sSql=  sSql  +  " AND CUSTOMERID='" +sCUSTOMERID+"' AND FEED.RECORDTYPE IN ('1','2','3','4','5','6','7','43','44','45','46','47')";	
	}else{
		sSql= sSql  + " AND MAINBUSINESSNO='" +sKeyValueMain+"' AND LOANCARDNO='"+ sLOANCARDNO +"' AND SORTNO > '07' ";	
	     if(sRecordKey.indexOf("QBZHT")==0 ){
	    	sSql = sSql +" AND  FEED.RECORDKEY='"+sRecordKey+"'";	
	    }
	}
	 
    int iCount=0;
	String countSql= "select count(*) from "+sSql.substring(sSql.indexOf("FROM")+4);
    sSql = sSql + " ORDER BY  SORTNO ";
	ASResultSet rss = Sqlca.getASResultSet(new SqlObject(countSql));
	if(rss.next()){
		iCount= rss.getInt(1);
	}
	rss.getStatement().close();
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	if(iCount==0){
		//如果不能查到个记录,则需要对
		sTableName = new String[1][6];
	}
	else{
		if((Integer.parseInt(sRECORDTYPE)>=1&&Integer.parseInt(sRECORDTYPE)<=7)||(Integer.parseInt(sRECORDTYPE)>=43&&Integer.parseInt(sRECORDTYPE)<=47)||(Integer.parseInt(sRECORDTYPE)>=71&&Integer.parseInt(sRECORDTYPE)<=78))
			iCount = iCount + 5;
		sTableName = new String[iCount][6];
	}
	for(int k=0;k<sTableName.length;k++){
		sTableName[k][0]="";
		sTableName[k][1]="";
		sTableName[k][2]="";
		sTableName[k][3]="";
		sTableName[k][4]="";
		sTableName[k][5]="";
	}
%>
<%@include file="/Resources/CodeParts/Table02.jsp"%>
<%
		rs.getStatement().close();
%>
<%	
	//对于一个客户或一种业务有多条错误的时候,需要对错误跟踪编号进行合并：通过或关系进行组合
	//对于只有一条记录的情况下，会进行特殊处理
	for(int k=0;k<sTableName.length;k++){
		for(int l=k+1;l<sTableName.length;l++){
			if(sTableName[k][1].equals(sTableName[l][1])&&!sTableName[k][5].equals("")){
				sTableName[k][2] = sTableName[k][2] + "-" + sTableName[l][2];
				//对于其他的信息设置为空即可
				sTableName[l][0]="";
				sTableName[l][1]="";
				sTableName[l][2]="";
				sTableName[l][3]="";
				sTableName[l][4]="";
				sTableName[l][5]="";
			}
		}
	}

	//通过feedback的反馈记录不能查找到对应的记录,需要进行判断
	boolean bShow = false;
	for(int k=0;k<sTableName.length;k++){
		if(!sTableName[k][5].equals("")){
			bShow = true;
			break;
		}
	}
	
	//显示页面的组件和组件路径:包括客户显示组件和业务显示组件
	String sCustomerCompName = "CustomerRelativeList";
	String sCustomerCompPath = "/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp";
	String sBusinessCompName = "FeedBackRelativeList";
	String sBusinessCompPath = "/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp";
	
	//设置strip页面
	String sStrips[][] = new String[sTableName.length][7];
	//对于没有记录显示的时候，需要对sStrips进行初始化,否则页面将会出现错误
	if(sTableName.length==1&&bShow==false){
		sStrips[0][0]="false";
		sStrips[0][1]="";
		sStrips[0][2]="";
		sStrips[0][3]="";
		sStrips[0][4]="";
		sStrips[0][5]="";
		sStrips[0][6]="";

	}else{
		int iLength = 0;
		for(int t=0;t<sTableName.length;t++){
			if(!sTableName[t][5].equals("")){
				sStrips[t][0]= "true";
				sStrips[t][1]= sTableName[t][0]+"(共有"+sTableName[t][2].split("-").length+"条)";
				if(sTableName[t][2].split("-").length>20)
					iLength = 22;
				else 
					iLength = sTableName[t][2].split("-").length;
				sStrips[t][2]= String.valueOf(size+ iLength*23);
				 if((Integer.parseInt(sRECORDTYPE)>=1&&Integer.parseInt(sRECORDTYPE)<=7)||(Integer.parseInt(sRECORDTYPE)>=43&&Integer.parseInt(sRECORDTYPE)<=47)){//借款人反馈
					sStrips[t][3]= sCustomerCompName;//组件
					sStrips[t][4]= sCustomerCompPath;//组件路径
					//传递参数
					sStrips[t][5]= "sTableName="+StringFunction.replace(sTableName[t][1],"ECR","HIS")+"&CustomerID="+sCUSTOMERID+"&KeyName="+sTableName[t][3]+"&KeyValue="+sTableName[t][2]+"&sFlag=Feedback";
				}else{//业务反馈
					sStrips[t][3]= sBusinessCompName;
					sStrips[t][4]= sBusinessCompPath;
					sStrips[t][5]= "sTableName="+StringFunction.replace(sTableName[t][1],"ECR","HIS")+"&KeyName="+sTableName[t][3]+"&KeyValue="+sTableName[t][2]+"&sFlag=Feedback";
				}
				sStrips[t][6]="";
			}	
		}
	}
%>

<%

		String sButtons[][] = {
			};

%> 

<%
	if(bShow==false){
%>
<script type="text/javascript">
	top.returnValue="<%=bShow%>";
	top.close();
</script>
<%
	}
%>
<%@include file="/Resources/CodeParts/Strip05.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>

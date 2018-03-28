<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	 String PG_TITLE = "反馈信息列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	 String PG_CONTENT_TITLE = "&nbsp;&nbsp;反馈信息列表&nbsp;&nbsp;"; //默认的内容区标题
	 String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	 String PG_LEFT_WIDTH = "280";//默认的treeview宽度
	%>
	
<%

	//定义变量
	//获得组件参数	
	//获得页面参数	
   String sMAINBUSINESSNO=CurPage.getParameter("MAINBUSINESSNO");
 	 if(sMAINBUSINESSNO==null) sMAINBUSINESSNO="";
 	 String sCIFCustomerID=sMAINBUSINESSNO;
  
	String sRECORDTYPE = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("sRECORDTYPE"));
	if(sRECORDTYPE == null) sRECORDTYPE = "";

	String sSql1="";
	  String sFirstValue = sCIFCustomerID;
	
	ASResultSet rs = null;
		sSql1=" select CIFCustomerID,GETRORGANNAME(CIFCustomerID),LOANCARDNO from HIS_ORGANINFO  where CIFCustomerID='"+sCIFCustomerID+"' and SESSIONID='9999999999'" ;
	rs = Sqlca.getASResultSet(new SqlObject(sSql1));
	String sShowButton = "false";
	//显示校验信息，机构信息等等
	%>	
	<%@include file="/Resources/CodeParts/Table08.jsp"%>
	<%
	rs.getStatement().close();
	//table数组 1.表名 2.表中文名 3.LIST模板名 4.LIST模板中文名
		String[][] sTableName = {
				{"HIS_ORGANATTRIBUTE","机构基本属性信息表"},
				{"HIS_ORGANSTATUS","机构状态信息表"},
				{"HIS_ORGANCONTACT","机构联络信息表"},
				{"HIS_ORGANKEEPER","机构高管及主要关系人表"},
				{"HIS_ORGANSTOCKHOLDER","机构重要股东表"},
				{"HIS_ORGANRELATED","机构主要关联企业表"},
				{"HIS_ORGANSUPERIOR","机构上级机构表"},
				{"HIS_ORGANFAMILY","机构家族成员表"},
			  };    
	    
	    String[] sParameter =new String[8];//定义传递参数

	    for(int i=0;i<sTableName.length;i++){    	
	    		sParameter[i]="sTable="+sTableName[i][0]+"&sFlag=Feedback&sCIFCustomerID="+sCIFCustomerID;
	    }
	    
    %>
	
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"机构基础信息表","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	tviTemp.insertPage("root","机构基础信息表","",1);
	tviTemp.insertPage("root","机构基本属性信息表","",2);
	tviTemp.insertPage("root","机构状态信息表","",3);
	tviTemp.insertPage("root","机构联络信息表","",4);
	tviTemp.insertPage("root","机构高管及主要关系人表","",5);
	tviTemp.insertPage("root","机构重要股东表","",6);
	tviTemp.insertPage("root","机构主要关联企业表","",7);
	tviTemp.insertPage("root","机构上级机构表","",8);
	tviTemp.insertPage("root","机构家族成员表","",9);
	%>

	<%@include file="/Resources/CodeParts/View04.jsp"%>

	<script language=javascript> 
	
	/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/

  function TreeViewOnClick(){
 		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数
		 var sCurItemname = getCurTVItem().name;
		var sCIFCustomerID = "<%=sCIFCustomerID%>";	

		if(sCurItemname == '机构基础信息表'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sTable=HIS_ORGANINFO&sFlag=Feedback&sCIFCustomerID="+sCIFCustomerID,"right");
		}else if(sCurItemname == '机构基本属性信息表'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[0]%>","right");
		}else if(sCurItemname == '机构状态信息表'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[1]%>","right");
		}else if(sCurItemname == '机构联络信息表'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[2]%>","right");
		}else if(sCurItemname == '机构高管及主要关系人表'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[3]%>","right");
		}
		else if(sCurItemname == '机构重要股东表'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[4]%>","right");
		}
		else if(sCurItemname == '机构主要关联企业表'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[5]%>","right");
		}
		else if(sCurItemname == '机构上级机构表'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[6]%>","right");
		}
		else {
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[7]%>","right");
		}
		setTitle(getCurTVItem().name);  
	}  
	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
		
	 function closeAndReturn()
	 {
	     parent.reloadOpener();
	     parent.close();
	 }
	</script> 

	<script language="JavaScript">
	startMenu();
	expandNode('root');
	selectItem(1);
	selectItemByName("机构信息列表"); 
	</script>
<%@ include file="/IncludeEnd.jsp"%>

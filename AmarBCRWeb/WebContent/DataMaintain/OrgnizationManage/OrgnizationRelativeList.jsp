<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	 String PG_TITLE = "机构信息列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	 String PG_CONTENT_TITLE = "&nbsp;&nbsp;机构信息列表&nbsp;&nbsp;"; //默认的内容区标题
	 String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	 String PG_LEFT_WIDTH = "280";//默认的treeview宽度
	%>
<%

	//定义变量
	//获得组件参数	
	//获得页面参数	
    String sCIFCustomerID=CurPage.getParameter("sCIFCustomerID");
  	if(sCIFCustomerID==null) sCIFCustomerID="";
  	String sCustomerID=sCIFCustomerID;
  	String sDono =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sDono"));
    if(sDono ==null) sDono ="";
	//校验错误修改隐藏按钮
	String sQueryType = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("QueryType"));
	if(sQueryType == null) sQueryType = "";
	//在只能查询的模块中隐藏保存按钮
	String IsQuery = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("IsQuery"));
	if(IsQuery == null) IsQuery = "";
	String sTempWhere=" ITEMNO in ('71','72') ";
	String sSql1="";
    String sFirstValue = sCIFCustomerID;
	
	ASResultSet rs = null;
	sSql1=" select CIFCustomerID,GETRORGANNAME(CIFCustomerID),LOANCARDNO from ECR_ORGANINFO  where CIFCustomerID='"+sCIFCustomerID+"'";
	rs = Sqlca.getASResultSet(new SqlObject(sSql1));
	String sShowButton = "false";
	//显示校验信息，机构信息等等
	%>	
	<div id="view_top" style="overflow:auto;"><%@include file="/Resources/CodeParts/Table01.jsp"%></div>
	<%
	rs.getStatement().close();
	%>
	
   <%	
    //table数组 1.表名 2.表中文名
	String[][] sTableName = {
		   {"ECR_ORGANINFO","机构基础信息表"},
			{"ECR_ORGANATTRIBUTE","机构基本属性信息表"},
			{"ECR_ORGANSTATUS","机构状态信息表"},
			{"ECR_ORGANCONTACT","机构联络信息表"},
			{"ECR_ORGANKEEPER","机构高管及主要关系人表"},
			{"ECR_ORGANSTOCKHOLDER","机构重要股东表"},
			{"ECR_ORGANRELATED","机构主要关联企业表"},
			{"ECR_ORGANSUPERIOR","机构上级机构表"},
			{"ECR_ORGANFAMILY","机构家族成员表"},
			
    };    
    
    String[] sParameter =new String[9];//定义传递参数
    String[] count=new String[9];
	String sSql="";
	sSql = "select 0, count(*) from " + sTableName[0][0] +" where CIFCustomerID='"+sCIFCustomerID+"'";
 	
 	for(int i=0;i<sTableName.length;i++){
 		sSql = sSql + " union all " + "select "+i+", count(*) from " + sTableName[i][0] +" where CIFCustomerID='"+sCIFCustomerID+"'";
 		rs = Sqlca.getASResultSet(new SqlObject(sSql));
 		while(rs.next()){
 			count[i]=""+rs.getInt(2);
 		}
 		sParameter[i]="sTable="+sTableName[i][0]+"&sFlag=Detail&sCIFCustomerID="+sCIFCustomerID+"&IsQuery="+IsQuery;
 	}
 
  %>
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"机构基础信息表","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

 	int treecode=1;
	for(int i=0;i<sTableName.length;i++)
	tviTemp.insertPage("root",sTableName[i][1]+"(共"+count[i]+"条)","","",treecode++);
	%>

<%
	if(sQueryType.equals("ERROR")&&sShowButton.equals("true")){
	%>
		<div style="width:100px; overflow: hidden;padding_left:25px;"><%=new Button("修改完毕","修改完成,删除对应的错误信息","amendRecord()","","").getHtmlText() %> </div>
	<%
	}%>

	<div id="view_bottom"><%@include file="/Resources/CodeParts/View04.jsp"%></div>

	<script type="text/javascript"> 
	
	/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/

  function TreeViewOnClick(){
 		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数
		 var sCurItemname = getCurTVItem().name;
		  <%for(int i=0;i<sTableName.length;i++){
		  if(i<4||i==7){
		  %>
		 if(sCurItemname == "<%=sTableName[i][1]%>(共<%=count[i]%>条)"){
	        	OpenComp("OrgnizationBaseInfo","/DataMaintain/OrgnizationManage/OrgnizationBaseInfo.jsp","sFlags=Info&sTable=<%=sTableName[i][0]%>&sFlag=Detail&sCIFCustomerID=<%=sCIFCustomerID%>&IsQuery=<%=IsQuery%>","right");
				setTitle(getCurTVItem().name);  
	     }
     <%} else if(i>3&&i!=7){%>
        if(sCurItemname == "<%=sTableName[i][1]%>(共<%=count[i]%>条)"){
        	
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[i]%>","right");
			setTitle(getCurTVItem().name);  
        }
		<%     }}%>
	}
	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>;
	}
		
	 function closeAndReturn()
	 {
	     parent.reloadOpener();
	     parent.close();
	 }
	 
	function amendRecord() {
		if(confirm("确认已修改完成,并删除对应的校验错误信息?")){
			var sReturnValue = popComp("DeleteValidteErr","/ErrorManage/ValidateErrorManage/DeleteValidteErr.jsp","","");
			if(typeof(sReturnValue)!="undefined" && sReturnValue=="ok") {
				alert("设置成功,已删除相应的校验错误信息!");
				self.close();
			}
		}
	}
	
	(function(){
		$(window).resize(function(){
			var height = $("body").height();
			var height0 = $("#view_top").height("auto").height();
			if(height0 > height/2)
				$("#view_top").height(height0 = height/2);
			$("#view_bottom").height(height - height0 - 30);
		}).resize();
	})();
	</script> 

	<script type="text/javascript">
	startMenu();
	expandNode('root');
	selectItem(1);
	selectItemByName("机构信息列表"); 
	</script>
<%@ include file="/IncludeEnd.jsp"%>

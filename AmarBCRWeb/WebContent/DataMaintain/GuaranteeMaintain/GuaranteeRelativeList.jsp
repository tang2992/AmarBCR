<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	 String PG_TITLE = "�����Ե���ҵ����Ϣ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	 String PG_CONTENT_TITLE = "&nbsp;&nbsp;�����Ե���ҵ����Ϣ�б�&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	 String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	 String PG_LEFT_WIDTH = "280";//Ĭ�ϵ�treeview���
	%>
<%

	//�������
	//����������	
	//���ҳ�����	
    String sGBusinessNo=CurPage.getParameter("GBusinessNo");
  	if(sGBusinessNo==null) sGBusinessNo="";
  	String sDono =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sDono"));
    if(sDono ==null) sDono ="";
	//У������޸����ذ�ť
	String sQueryType = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("QueryType"));
	if(sQueryType == null) sQueryType = "";
	System.out.print(sQueryType);
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String IsQuery = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("IsQuery"));
	if(IsQuery == null) IsQuery = "";
	String sTempWhere=" ITEMNO in ('811','821','831') ";
	String sSql1="";
    String sFirstValue = sGBusinessNo;
	
	ASResultSet rs = null;
	sSql1=" select GBusinessNo,GContractNo from BCR_GUARANTEEINFO  where GBusinessNo='"+sGBusinessNo+"'";
	rs = Sqlca.getASResultSet(new SqlObject(sSql1));
	String sShowButton = "false";
	//��ʾУ����Ϣ������ҵ����Ϣ�ȵ�
	%>	
	<div id="view_top" style="overflow:auto;"><%@include file="/Resources/CodeParts/Table01.jsp"%></div>
	<%
	rs.getStatement().close();
	%>
	
   <%	
    //table���� 1.���� 2.��������
	String[][] sTableName = {
		  	{"BCR_GUARANTEEINFO","����ҵ�������Ϣ��"},
			{"BCR_GUARANTEECONT","������ͬ��Ϣ��"},
			{"BCR_INSUREDS","����������Ϣ��"},
			{"BCR_CREDITORINFO","ծȨ�˼�����ͬ��Ϣ��"},
			{"BCR_COUNTERGUARANTOR","����������Ϣ��"},
			{"BCR_GUARANTEEDUTY","ʵ���ڱ�������Ϣ��"},
			{"BCR_COMPENSATORYINFO","�����ſ���Ϣ��"},
			{"BCR_COMPENSATORYDETAIL","������ϸ��Ϣ��"},
			{"BCR_RECOVERYDETAIL","׷����ϸ��Ϣ��"},
			{"BCR_PREMIUMINFO","���ѽ��ɸſ���Ϣ��"},
			{"BCR_PREMIUMDETAIL","���ѽ�����ϸ��Ϣ��"},
			
    };    
    
    String[] sParameter =new String[11];//���崫�ݲ���
    String[] count=new String[11];
	String sSql="";
	sSql = "select 0, count(*) from " + sTableName[0][0] +" where GBusinessNo='"+sGBusinessNo+"'";
 	
 	for(int i=0;i<sTableName.length;i++){
 		sSql = sSql + " union all " + "select "+i+", count(*) from " + sTableName[i][0] +" where GBusinessNo='"+sGBusinessNo+"'";
 		rs = Sqlca.getASResultSet(new SqlObject(sSql));
 		while(rs.next()){
 			count[i]=""+rs.getInt(2);
 		}
 		sParameter[i]="sTable="+sTableName[i][0]+"&sFlag=Detail&GBusinessNo="+sGBusinessNo+"&IsQuery="+IsQuery;
 	}
 
  %>
	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"����ҵ�������Ϣ��","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

 	int treecode=1;
	for(int i=0;i<sTableName.length;i++)
	tviTemp.insertPage("root",sTableName[i][1]+"(��"+count[i]+"��)","","",treecode++);
	%>

<%
	if(sQueryType.equals("ERROR")&&sShowButton.equals("true")){
	%>
		<div style="width:100px; overflow: hidden;padding_left:25px;"><%=new Button("�޸����","�޸����,ɾ����Ӧ�Ĵ�����Ϣ","amendRecord()","","").getHtmlText() %> </div>
	<%
	}%>

	<div id="view_bottom"><%@include file="/Resources/CodeParts/View04.jsp"%></div>

	<script type="text/javascript"> 
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/

  function TreeViewOnClick(){
 		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������
		var sCurItemname = getCurTVItem().name;
		  <%for(int i=0;i<sTableName.length;i++){
		  if(i==0||i==1||i==6||i==9||i==5){
		  %>
		 if(sCurItemname == "<%=sTableName[i][1]%>(��<%=count[i]%>��)"){
			 OpenComp("GuaranteeInfoBaseInfo","/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseInfo.jsp","&sFlags=Info&sTable=<%=sTableName[i][0]%>&sFlag=Detail&GBusinessNo=<%=sGBusinessNo%>&IsQuery=<%=IsQuery%>","right");
	     }
     <%} else{%>
        if(sCurItemname == "<%=sTableName[i][1]%>(��<%=count[i]%>��)"){
			OpenComp("GuaranteeInfoBaseList","/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseList.jsp","<%=sParameter[i]%>","right");
			setTitle(getCurTVItem().name);  
        }
		<%     }}%>
	}
	/*~[Describe=����treeview;InputParam=��;OutPutParam=��;]~*/
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
		if(confirm("ȷ�����޸����,��ɾ����Ӧ��У�������Ϣ?")){
			var sReturnValue = popComp("DeleteValidteErr","/ErrorManage/ValidateErrorManage/DeleteValidteErr.jsp","","");
			if(typeof(sReturnValue)!="undefined" && sReturnValue=="ok") {
				alert("���óɹ�,��ɾ����Ӧ��У�������Ϣ!");
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
	selectItemByName("�����Ե���ҵ����Ϣ�б�"); 
	</script>
<%@ include file="/IncludeEnd.jsp"%>

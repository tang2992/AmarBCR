<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	 String PG_TITLE = "������Ϣ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	 String PG_CONTENT_TITLE = "&nbsp;&nbsp;������Ϣ�б�&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	 String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	 String PG_LEFT_WIDTH = "280";//Ĭ�ϵ�treeview���
	%>
<%

	//�������
	//����������	
	//���ҳ�����	
    String sCIFCustomerID=CurPage.getParameter("sCIFCustomerID");
  	if(sCIFCustomerID==null) sCIFCustomerID="";
  	String sCustomerID=sCIFCustomerID;
  	String sDono =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sDono"));
    if(sDono ==null) sDono ="";
	//У������޸����ذ�ť
	String sQueryType = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("QueryType"));
	if(sQueryType == null) sQueryType = "";
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String IsQuery = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("IsQuery"));
	if(IsQuery == null) IsQuery = "";
	String sTempWhere=" ITEMNO in ('71','72') ";
	String sSql1="";
    String sFirstValue = sCIFCustomerID;
	
	ASResultSet rs = null;
	sSql1=" select CIFCustomerID,GETRORGANNAME(CIFCustomerID),LOANCARDNO from ECR_ORGANINFO  where CIFCustomerID='"+sCIFCustomerID+"'";
	rs = Sqlca.getASResultSet(new SqlObject(sSql1));
	String sShowButton = "false";
	//��ʾУ����Ϣ��������Ϣ�ȵ�
	%>	
	<div id="view_top" style="overflow:auto;"><%@include file="/Resources/CodeParts/Table01.jsp"%></div>
	<%
	rs.getStatement().close();
	%>
	
   <%	
    //table���� 1.���� 2.��������
	String[][] sTableName = {
		   {"ECR_ORGANINFO","����������Ϣ��"},
			{"ECR_ORGANATTRIBUTE","��������������Ϣ��"},
			{"ECR_ORGANSTATUS","����״̬��Ϣ��"},
			{"ECR_ORGANCONTACT","����������Ϣ��"},
			{"ECR_ORGANKEEPER","�����߹ܼ���Ҫ��ϵ�˱�"},
			{"ECR_ORGANSTOCKHOLDER","������Ҫ�ɶ���"},
			{"ECR_ORGANRELATED","������Ҫ������ҵ��"},
			{"ECR_ORGANSUPERIOR","�����ϼ�������"},
			{"ECR_ORGANFAMILY","���������Ա��"},
			
    };    
    
    String[] sParameter =new String[9];//���崫�ݲ���
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
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"����������Ϣ��","right");
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
		  if(i<4||i==7){
		  %>
		 if(sCurItemname == "<%=sTableName[i][1]%>(��<%=count[i]%>��)"){
	        	OpenComp("OrgnizationBaseInfo","/DataMaintain/OrgnizationManage/OrgnizationBaseInfo.jsp","sFlags=Info&sTable=<%=sTableName[i][0]%>&sFlag=Detail&sCIFCustomerID=<%=sCIFCustomerID%>&IsQuery=<%=IsQuery%>","right");
				setTitle(getCurTVItem().name);  
	     }
     <%} else if(i>3&&i!=7){%>
        if(sCurItemname == "<%=sTableName[i][1]%>(��<%=count[i]%>��)"){
        	
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[i]%>","right");
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
	selectItemByName("������Ϣ�б�"); 
	</script>
<%@ include file="/IncludeEnd.jsp"%>

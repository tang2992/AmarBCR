<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<% 
	//�������
	ASResultSet rs = null;
	String sSql="";
	String sCustomerID="";
	int size=75;
	boolean flag = false;
	String sTempWhere = " (SORTNO <='07' or  (SORTNO >='43' and SORTNO<='47')  )";
	//��ȡ����
	//��ҳ���ǿͻ���Ϣ�Ĺ���ҳ��
	//���ݿͻ�ID����ʾ�ͻ����е������Ϣ
	sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID==null) sCustomerID = "";
	String sFirstValue = sCustomerID;
	String sQueryType = CurComp.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String sIsQuery = CurComp.getParameter("Query");
	if(sIsQuery == null) sIsQuery = "";
%>
	<%
	 String PG_TITLE = "�ͻ���Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	 String PG_CONTENT_TITLE = "&nbsp;&nbsp;�ͻ��������&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	 String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	 String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	%>
<%	
	//�ͻ���Ϣ��
	String[][] sTableName = {
			{"ECR_ORGANINFO","����˸ſ���Ϣ"},//ECR_CUSTOMER�Ѿ����ã��ͻ���Ϣ��ʱ��Ϊ��ECR_ORGANINFO����ȡ
			{"ECR_FINANCEBS","������ʲ���ծ��"},
			{"ECR_FINANCEPS","�����������������"},
			{"ECR_FINANCECF","������ֽ�������"},
			{"ECR_FINANCEBS_2007","2007���ʲ���ծ��"},
			{"ECR_FINANCEPS_2007","2007��������������"},
			{"ECR_FINANCECF_2007","2007���ֽ�������"},
			{"ECR_FINANCEBS_IN","��ҵ��λ�ʲ���ծ��"},
			{"ECR_FINANCECF_IN","��ҵ��λ����֧����"},
			{"ECR_CUSTOMERLAW","�����������Ϣ"},
			{"ECR_CUSTOMERFACT","����˴��¼�"}		
		};
	//�������еĿͻ���ص���Ϣ���в�ѯ
	sSql = "select 0, count(*) from " + sTableName[0][0] +" where LSCustomerID='"+sCustomerID+"'";
	
	for(int i=1;i<sTableName.length;i++){
		sSql = sSql + " union all " + "select "+i+", count(*) from " + sTableName[i][0] +" where CustomerID='"+sCustomerID+"'";
	}
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	int[] iShow = new int[sTableName.length];
	String[] sShow = new String[sTableName.length];
	//�����Ƿ���ʾ���г�ʼ��
	for(int i=0;i<sShow.length;i++){
		sShow[i] = "false";
		iShow[i] = 0;
	}
	boolean bShowAll = false;
	//���ݲ�ѯ������Ƿ���ʾ��������
	while(rs.next()){
		int l  = rs.getInt(2);
		if(l>0){
			sShow[rs.getInt(1)]="true";
			iShow[rs.getInt(1)] = l;
			if(bShowAll==false)
				bShowAll = true;
		}
	}
	rs.getStatement().close();
	
	 //������ʾ����������·��
	String sCompName = "CustomerRelativeList";
	String sCompPath = "/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp";


	String sStrips[][] = new String[sTableName.length][9];
	for(int t=0;t<sTableName.length;t++){
			sStrips[t][0]= sShow[t];
			sStrips[t][1]= sTableName[t][1]+"(����" + iShow[t] + "��)";
			if(iShow[t]>20){
				iShow[t] = 22;
			}
			sStrips[t][2]= String.valueOf(size+ iShow[t]*23);
			sStrips[t][3]= sCompName;//���
			sStrips[t][4]= sCompPath;//���·��
			sStrips[t][5]= "sTableName="+sTableName[t][0]+"&CustomerID="+sCustomerID+"&TableFlag=ECR"+"&IsQuery="+sIsQuery;
			sStrips[t][6]="";
	}
	
	if(bShowAll==false){
		sStrips = new String[1][7];
		sStrips[0][0]= "false";
		sStrips[0][1]= "";
		sStrips[0][2]= "";
		sStrips[0][3]= "";
		sStrips[0][4]= "";
		sStrips[0][5]= "";
		sStrips[0][6]= "";
	}  
	
%>

<%
	//��ȡ���е���صĹ�����Ϣ�������ͻ�ID,�ͻ�����,�������
	sSql=" select LSCUSTOMERID,GETRORGANNAME(CIFCUSTOMERID) as CHINANAME,LOANCARDNO from ECR_ORGANINFO  where LSCustomerID='"+sCustomerID+"'";
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	String sShowButton = "false";
%>
<div id="view_top" style="overflow:auto;"><%@include file="/Resources/CodeParts/Table01.jsp"%></div>
<%
	rs.getStatement().close();
%>
	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�ͻ��������","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	int iTreeNode=1;
	for(int i=1;i<sTableName.length;i++){
		tviTemp.insertPage("root",sStrips[i][1],"","",iTreeNode++);
	}
	
	%>

<%
	if(sQueryType.equals("ERROR")&&sShowButton.equals("true")){
	%>
		<div style="width:100px; overflow: hidden;padding_left:25px;"><%=new Button("�޸����","�޸����,ɾ����Ӧ�Ĵ�����Ϣ","amendRecord()","","").getHtmlText() %></div>
	<%
	} 
	String sButtons[][] = {
			
		};
%> 
	<div id="view_bottom"><%@include file="/Resources/CodeParts/View04.jsp"%></div>

	<script type="text/javascript"> 

	function TreeViewOnClick()
	{
		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������
		var sCurItemname = getCurTVItem().name;
		<%  for(int i=1;i<sTableName.length;i++){
			if(i==0){%>
				if(sCurItemname=="<%=sStrips[i][1]%>"){
					AsControl.OpenView("/DataMaintain/CustomerMaintain/CustomerRelativeInfo.jsp","<%=sStrips[i][5]%>&Type=Info","right");
				}
				<%				
			}else{
		%>
		if(sCurItemname=="<%=sStrips[i][1]%>"){
			AsControl.OpenView("/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp","<%=sStrips[i][5]%>","right");
		}
		<%
		}
		}
		%>
	     setTitle(getCurTVItem().name);
	}
	
	/*~[Describe=����treeview;InputParam=��;OutPutParam=��;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}

		function amendRecord() {
			if(confirm("ȷ�����޸����,��ɾ����Ӧ��У�������Ϣ?")){
				var sReturnValue = popComp("DeleteValidteErr","/ErrorManage/ValidateErrorManage/DeleteValidteErr.jsp","","");
				if(typeof(sReturnValue)!="undefined" && sReturnValue=="ok") {
					alert("���óɹ�,��ɾ����Ӧ��У�������Ϣ!");
					top.close();
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
	selectItemByName("������ʲ���ծ��");
	</script>

<%@ include file="/IncludeEnd.jsp"%>

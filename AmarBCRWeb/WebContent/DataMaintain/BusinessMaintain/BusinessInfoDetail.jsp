<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
 <% 
	//�������
	ASResultSet rs = null;
	String sSql="",sGetDueBill="";
	int size=70;
	String sTempWhere = "";
	String sCustomerID = null;
	
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sKeyName =  CurPage.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurPage.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";
	//У������޸����ذ�ť
	String sQueryType = CurComp.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	//�ڲ�ѯʱ���ر��水ť
	String sIsQuery = CurComp.getParameter("sIsQuery");
	if(sIsQuery == null) sIsQuery = "";

	// ��������Ѻ����Ѻʱ���Ӵ��뵣���������  add by jhli
	String sKeyName1 =  CurPage.getParameter("KeyName1");
	if(sKeyName1 == null) sKeyName1 = "";
	String sKeyValue1 =  CurPage.getParameter("KeyValue1");
	if(sKeyValue1 == null) sKeyValue1 = "";
	
	String[]  stName =  sKeyName.split("@");
	String[]  stValue = sKeyValue.split("@");
	
	String sWhereClause = " where 1=1 ";
	String sFirstValue = "";
	for(int i=0;i<stName.length;i++){
		if(i==0)
			sFirstValue = stValue[i];
		sWhereClause = sWhereClause + " and " + stName[i] + "='" + stValue[i] +"'";
	}
	String[][] TableName = null;
%>

<%
	//��CODE_LIBRARY��recordtype��Ӧ�洢����ص�ҵ��Ϳͻ���Ϣ,������Ӧ��ҵ��Ϳͻ�����,�Լ���Ӧ�ı�,�Ͷ�Ӧ��������Ϣ
	sSql = "SELECT ITEMNAME,ITEMDESCRIBE,ITEMATTRIBUTE,RELATIVECODE  FROM CODE_LIBRARY WHERE CODENO='recordtype'";
	//���ڲ�ͬ��ҵ������ı��ǲ�ͬ��
	//���ڴ���ҵ����˵,��Ҫ��ѯ�ı����,��ͬ��,��ݱ�,�����,չ�ڱ�,��֤��,��Ѻ��,��Ѻ��
	if(sTableName.equals("ECR_LOANCONTRACT")){
		sSql = sSql + " and  ITEMNO IN ('8','9','10','11','22','23','24')";
		sTempWhere = " SORTNO IN ('08','09','10','11','22','23','24')";
	}else if(sTableName.equals("ECR_FINAINFO")){
	//����ó������ҵ����˵,��Ҫ��ѯ�ı����,��ͬ��,��ݱ�,�����,չ�ڱ�,��֤��,��Ѻ��,��Ѻ��
		sSql = sSql + " and  ITEMNO IN ('14','15','16','17','22','23','24')";
		sTempWhere = " SORTNO IN ('14','15','16','17','22','23','24')";
	}else if(sTableName.equals("ECR_ASSETSDISPOSE")||sTableName.equals("ECR_INTERESTDUE")||sTableName.equals("ECR_FLOORFUND")||sTableName.equals("ECR_DISCOUNT")||sTableName.equals("ECR_CUSTOMERCREDIT")){
		//���ڲ����Ŵ��ʲ�����,ǷϢ,���,Ʊ������,����ֻ������,û����������ر�
		sSql = sSql + " and  ITEMDESCRIBE='" + sTableName +"'";
		if(sTableName.equals("ECR_INTERESTDUE"))
			sTempWhere = " ITEMDESCRIBE='" + sTableName +"' AND ITEMNO ='26' ";
		else
			sTempWhere = " ITEMDESCRIBE='" + sTableName +"'";
	}else{
		//����ʣ�µ�����ҵ��:��������,�жһ�Ʊ,����,����֤
		//������ҵ�����е�����Ϣ�ģ���֤,��Ѻ,��Ѻ
		sSql = sSql + " and (ITEMNO IN ('22','23','24') or ITEMDESCRIBE='" + sTableName +"')";
		sTempWhere = " (SORTNO IN ('22','23','24') or ITEMDESCRIBE='" + sTableName +"')";
	}
	String countSql= "select count(*) from "+sSql.substring(sSql.indexOf("FROM")+4);
	ASResultSet rs1 = Sqlca.getASResultSet(new SqlObject(countSql));
	while(rs1.next()){
		TableName = new String[rs1.getInt(1)][6];
	}
	rs1.getStatement().close();

	sSql = sSql + " ORDER BY  SORTNO ";
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	int k = 0;
	String sRelative = null;
	//���ڲ�ѯ��������,��������,������,���������,�������ֵ,������������������ؼ���,������������������ؼ�ֵ
	//ͨ����ѯ�������
	//���ڱ������ֵ��˵��,��ͨ��listҳ�洫�ݹ����Ĺ����Ĳ���KeyValue�����õ�,ȡ��һ��������ֵ
	//��������������,��������metadata.xml�����õ���������������,��һ��������������
	//�����ж�����������,ҵ�������ں��ϱ��ڴ������е���ҳ��ŵĺ���,���Ի�ȡ�ĵ�һ��������ֵ������ҵ���ŵ�ֵ

	while(rs.next()){	
		   TableName[k][0]  = rs.getString(2);//����
		/* 	if(sTableName.equals(sTableName)){
			TableName[k][0]  = rs.getString(2);//����
		}else{
			TableName[k][0]  = StringFunction.replace(rs.getString(2),"ECR","HIS");//����
		} */
		//����ǷϢ�ı�,Ϊ���뷴������ҵ���Ž��м���,��������Ϊ�������
		//������Ҫ��������������ΪCUSTOMERID
		TableName[k][1]  = rs.getString(1);//������
		TableName[k][2]  = rs.getString(3);//������
		TableName[k][3]  = sKeyValue.split("@")[0];//������ֵ(���ڻ����չ������Ҫ����������)
	
		sRelative = rs.getString(4);
		if(sRelative!=null){
		//����ǵ�����Ϣʱ,��������ص�ҵ������,����ͬ�����ͬ,��ҵ�����಻ͬʱ
			TableName[k][4]  = "BUSINESSTYPE";//��������ҵ������
			if(TableName[0][0].equals("ECR_LOANCONTRACT")){
			TableName[k][5]  = "1";}//ҵ�������ֵ
		  if (TableName[0][0].equals("ECR_FINAINFO")){
			TableName[k][5]  = "4";}
			if (TableName[0][0].equals("ECR_ACCEPTANCE")){
			TableName[k][5]  = "7";}
			if (TableName[0][0].equals("ECR_GUARANTEEBILL")){
			TableName[k][5]  = "6";}
			if (TableName[0][0].equals("ECR_CREDITLETTER")){
			TableName[k][5]  = "5";}
			if (TableName[0][0].equals("ECR_FACTORING")){
			TableName[k][5]  = "2";}
		}
		k++;
	}

	//������ҵ�����ҵ�����½��в�ѯ
	//���û����ص���Ϣ,�򲻽�����ʾ,���������ʾ
	rs.getStatement().close();
%>
<%
	//��ȡ���е���صĹ�����Ϣ,������ʾ��ҵ�������Ŀͻ�������Ϣ,�����ͻ����,�ͻ�����,�������
	//�������е�ҵ���,����ǷϢ��,�����Ķ������ͻ�����
	sSql=" select CUSTOMERID,GETRORGANNAME(CUSTOMERID),LOANCARDNO from "+  sTableName + sWhereClause;
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	String sShowButton = "false";
%>
<div id="view_top" style="overflow:auto;"><%@include file="/Resources/CodeParts/Table01.jsp"%></div>

	<%
	if(sQueryType.equals("ERROR")&&sShowButton.equals("true"))
	{
		
%> 
     <%=new Button("����޸�","����޸�","amendRecord()","","").getHtmlText()%>
<%	}%>
<%
	rs.getStatement().close();
%>

<%	

	sSql = "SELECT 0,COUNT(*) FROM " + TableName[0][0] + sWhereClause; 
	for(int i=1;i<TableName.length;i++){
		//���ڻ����չ�ڽ������⴦��(��Ϊ�����չ�ڵ������ǣ���ݱ��,�����Ǻ�ͬ���)
		String sTemp = StringFunction.replace(TableName[i][0],"HIS","ECR");
		if(sTemp.equals("ECR_FINARETURN")||sTemp.equals("ECR_FINAEXTENSION")
			||sTemp.equals("ECR_LOANRETURN")||sTemp.equals("ECR_LOANEXTENSION")){
			sSql  = sSql  + " UNION ALL SELECT "+i+",COUNT(*)" +" FROM " +  TableName[i][0] + " WHERE " + TableName[i][2] + " in  (SELECT "+ TableName[i][2] + " FROM " + TableName[1][0] +  sWhereClause+")";
			if(sGetDueBill.equals(""))
				sGetDueBill = "SELECT DISTINCT "+ TableName[i][2] + " FROM " + TableName[1][0] +  sWhereClause;
		}else{
			sSql  = sSql  + " UNION ALL SELECT "+i+",COUNT(*) FROM " +  TableName[i][0] + " WHERE " + TableName[i][2] + "='" +  TableName[i][3] + "'";
			if(sTemp.equals("ECR_IMPAWNCONT")||sTemp.equals("ECR_ASSURECONT")||sTemp.equals("ECR_GUARANTYCONT")){
				sSql = sSql + " and " + TableName[0][4] +"='" + TableName[0][5] + "'";}
		}
	}

	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	boolean bShowAll = false;
	int[] iShow = new int[TableName.length];
	String[] sShow = new String[TableName.length];
	//��ʼ����ʾ��״̬
	for(int i=0;i<sShow.length;i++){
		sShow[i] = "false";
		iShow[i] = 0;
	}
	//���ݲ�ѯ�����������
	while(rs.next()){
		int l  = rs.getInt(2);
			sShow[rs.getInt(1)]="true";
			iShow[rs.getInt(1)] = l;
			if(bShowAll==false)
				bShowAll = true;
	}	
	rs.getStatement().close();
	
	//��һ�������ͬ���ж����ݵ����,�����еĽ�ݱ�Ž������
	//��"-"�Խ�ݽ�������,��ʾ"��"��ϵ
     
	if(!sGetDueBill.equals("")){
		rs = Sqlca.getASResultSet(new SqlObject(sGetDueBill));
		String sDueBill = "";
		while(rs.next()){
			if(sDueBill.equals(""))
				sDueBill = rs.getString(1);
			else
				sDueBill = sDueBill + "-" + rs.getString(1);
		}
		TableName[2][3] = sDueBill;
		TableName[3][3] = sDueBill;
		rs.getStatement().close();
	}

	//������ʾ����������·��
	String sCompName = "BusinessRelativeList";
	String sCompPath = "/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp";
	//����strip��������
		String sStrips[][] = new String[TableName.length][7];
		String sTableFlag = "ECR"; 
		for(int t=0;t<TableName.length;t++){
			if(sShow[t]=="true"){
				sStrips[t][0]= sShow[t];
				sStrips[t][1]= TableName[t][1]+"(����" + iShow[t] + "��)";
				if(iShow[t]>20){
					iShow[t] = 22;
				}
				sStrips[t][2]= String.valueOf(size+ iShow[t]*23);
				sStrips[t][3]= sCompName;
				sStrips[t][4]= sCompPath;
				if(TableName[t][0].indexOf("HIS")>=0){
					sTableName = StringFunction.replace(TableName[t][0],"HIS","ECR");
					sTableFlag = "HIS";
				}else{
					sTableName = TableName[t][0];
				}
				//������Ҫ�������sTableName���������������
				//TableFlag��ʾ������ʾhis��,����ecr��
				//��������������������QueryType,Query,IsPatch(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
				sStrips[t][5]= "sTableName="+sTableName+"&sTableName1="+TableName[t][1]+"&KeyName="+TableName[t][2]+"&KeyValue="+TableName[t][3]+"&TableFlag="+sTableFlag+"&IsQuery="+sIsQuery+"&QueryType="+sQueryType+"&IsQuery="+sIsQuery;
				sStrips[t][6]="";
			}
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
	/*
		ҳ��˵��:ʾ��������Ϣ�鿴ҳ��
	 */
	String PG_TITLE = "ҵ����Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;SQL������ͼ&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"SQL������ͼ","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�

	//������ͼ�ṹ
	int iTreeNode=1;
	for(int i=0;i<TableName.length;i++){
		tviTemp.insertPage("root",TableName[i][1]+"(" + iShow[i] + "��)","","",iTreeNode++);
	}
%>	
<div id="view_bottom"><%@include file="/Resources/CodeParts/View04.jsp"%></div>
<script type="text/javascript"> 


	function openChildComp(sURL,sParameterString){
		sParaStringTmp = "";
		sLastChar=sParameterString.substring(sParameterString.length-1);
		if(sLastChar=="&") sParaStringTmp=sParameterString;
		else sParaStringTmp=sParameterString+"&";

		/*
		 * ������������
		 * ToInheritObj:�Ƿ񽫶����Ȩ��״̬��ر��������������
		 * OpenerFunctionName:�����Զ�ע�����������REG_FUNCTION_DEF.TargetComp��
		 */
		sParaStringTmp += "ToInheritObj=y&OpenerFunctionName="+getCurTVItem().name;
		AsControl.OpenView(sURL,sParaStringTmp,"right");
	}
	
	//treeview����ѡ���¼�
	function TreeViewOnClick(){
		var sCurItemname = getCurTVItem().name;
		
		<%
		for(int i=0;i<TableName.length;i++){
			if(i==0){
				%>
				if(sCurItemname==("<%=TableName[i][1]%>"+"(" + <%=iShow[i]%> + "��)")){
					openChildComp("/DataMaintain/BusinessMaintain/BusinessRelativeInfo.jsp","sTableName=<%=TableName[i][0]%>&TableFlag=ECR&KeyName=<%=TableName[i][2]%>&KeyValue=<%=TableName[i][3]%>&Type=info&IsQuery=<%=sIsQuery%>");
				}
				<%
				
			}else{
		%>
		if(sCurItemname==("<%=TableName[i][1]%>"+"(" +<%= iShow[i]%> + "��)")){
			openChildComp("/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp","<%=sStrips[i][5]%>");
		}
		<%
		}
		}
		%>
		setTitle(getCurTVItem().name);
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
	
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("<%=TableName[0][1]%>"+"(" + <%=iShow[0]%> + "��)");
	}
		
	initTreeView();
	
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
<%@ include file="/IncludeEnd.jsp"%>

<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: ҵ����������ҳ��
		Input Param:CustomerID
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<% 
	//�������
	ASResultSet rs = null;
	String sSql="",sGetDueBill="";
	int size=100;
	//��ȡ����
	//��ҳ��������е�ҵ����ͳһ����ʾҳ��,��ʾ�ķ�ʽ��stripЧ��
	//������Ҫ���ĸ���MetaTableName(xml����name),DBTableName(���ݿ���Ҫ���ҵ��ֶ�),KeyName(Ҫ���ҵı�ҵ��Ĺؼ���),KeyValue(Ҫ���ҵı�ҵ��Ĺؼ��ֵ�ֵ)
	String sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("MetaTableName"));
	if(sMetaTableName == null) sMetaTableName = "";
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	if(sDBTableName == null) sDBTableName = "";
	String sKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));
	if(sKeyName == null) sKeyName = "";
	String sKeyValue =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));
	if(sKeyValue == null) sKeyValue = "";
	
	String[]  stName =  sKeyName.split("@");
	String[]  stValue = sKeyValue.split("@");
	
	String sWhereClause = " where 1=1 ";
	
	for(int i=0;i<stName.length;i++){
		sWhereClause = sWhereClause + " and " + stName[i] + "='" + stValue[i] +"'";
	}
	String[][] sTableName = null;
%>
<%/*~END~*/%>
<%
	//��ȡ���е���صĹ�����Ϣ,������ʾ��ҵ�������Ŀͻ�������Ϣ,�����ͻ����,�ͻ�����,�������
	//�������е�ҵ���,����ǷϢ��,�����Ķ������ͻ�����
	sSql=" select CUSTOMERID,GETCUSTOMERNAME(CUSTOMERID),LOANCARDNO from "+  sMetaTableName + sWhereClause;
	rs = Sqlca.getASResultSet(sSql);
%>
<%@include file="/Resources/CodeParts/Table03.jsp"%>
<%
	rs.getStatement().close();
%>
<%/*~END~*/%>
<%
	//��CODE_LIBRARY��recordtype��Ӧ�洢����ص�ҵ��Ϳͻ���Ϣ,������Ӧ��ҵ��Ϳͻ�����,�Լ���Ӧ�ı�,�Ͷ�Ӧ��������Ϣ
	sSql = "SELECT ITEMNAME,ITEMDESCRIBE,ITEMATTRIBUTE,RELATIVECODE FROM CODE_LIBRARY WHERE CODENO='recordtype'";
	//���ڲ�ͬ��ҵ������ı��ǲ�ͬ��
	//���ڴ���ҵ����˵,��Ҫ��ѯ�ı����,��ͬ��,��ݱ�,�����,չ�ڱ�,��֤��,��Ѻ��,��Ѻ��
	if(sMetaTableName.equals("ECR_LOANCONTRACT")){
		sSql = sSql + " and  ITEMNO IN ('8','9','10','11','22','23','24')";
	}else if(sMetaTableName.equals("ECR_FINAINFO")){
	//����ó������ҵ����˵,��Ҫ��ѯ�ı����,��ͬ��,��ݱ�,�����,չ�ڱ�,��֤��,��Ѻ��,��Ѻ��
		sSql = sSql + " and  ITEMNO IN ('14','15','16','17','22','23','24')";
	}else if(sMetaTableName.equals("ECR_ASSETSDISPOSE")||sMetaTableName.equals("ECR_INTERESTDUE")||sMetaTableName.equals("ECR_FLOORFUND")||sMetaTableName.equals("ECR_DISCOUNT")||sMetaTableName.equals("ECR_CUSTOMERCREDIT")){
		//���ڲ����Ŵ��ʲ�����,ǷϢ,���,Ʊ������,����ֻ������,û����������ر�
		sSql = sSql + " and  ITEMDESCRIBE='" + sMetaTableName +"'";
	}else{
		//����ʣ�µ�����ҵ��:��������,�жһ�Ʊ,����,����֤
		//������ҵ�����е�����Ϣ�ģ���֤,��Ѻ,��Ѻ
		sSql = sSql + " and (ITEMNO IN ('22','23','24') or ITEMDESCRIBE='" + sMetaTableName +"')";
	}
	sSql = sSql + " ORDER BY  SORTNO ";
	
	rs = Sqlca.getASResultSet(sSql);
	//System.out.println("****"+sSql);
	sTableName = new String[rs.getRowCount()][6];
	int k = 0;
	String sRelative = null;
	//���ڲ�ѯ��������,��������,������,���������,�������ֵ,������������������ؼ���,������������������ؼ�ֵ
	//ͨ����ѯ�������
	//���ڱ������ֵ��˵��,��ͨ��listҳ�洫�ݹ����Ĺ����Ĳ���KeyValue�����õ�,ȡ��һ��������ֵ
	//��������������,��������metadata.xml�����õ���������������,��һ��������������
	//�����ж�����������,ҵ�������ں��ϱ��ڴ������е���ҳ��ŵĺ���,���Ի�ȡ�ĵ�һ��������ֵ������ҵ���ŵ�ֵ
	while(rs.next()){
		if(sMetaTableName.equals(sDBTableName)){
			sTableName[k][0]  = rs.getString(2);//����
		}else{
			sTableName[k][0]  = StringFunction.replace(rs.getString(2),"ECR","HIS");//����
		}
		//����ǷϢ�ı�,Ϊ���뷴������ҵ���Ž��м���,��������Ϊ�������
		//������Ҫ��������������ΪCUSTOMERID
		sTableName[k][1]  = rs.getString(1);//������
		if(sTableName[k][0].indexOf("INTERESTDUE")>0)
			sTableName[k][2] = "CUSTOMERID";
		else
			sTableName[k][2]  = rs.getString(3);//������
		sTableName[k][3]  = sKeyValue.split("@")[0];//������ֵ(���ڻ����չ������Ҫ����������)
		
		sRelative = rs.getString(4);
		//System.out.println("*******"+sTableName[0][0]);
		if(sRelative!=null){
		//����ǵ�����Ϣʱ,��������ص�ҵ������,����ͬ�����ͬ,��ҵ�����಻ͬʱ
			sTableName[0][4]  = "BUSINESSTYPE";//��������ҵ������
		  if(sTableName[0][0].indexOf("LOANCONTRACT")!=-1){
			sTableName[0][5]  = "1";}//ҵ�������ֵ
		  if (sTableName[0][0].indexOf("FINAINFO")!=-1){
			sTableName[0][5]  = "4";}
			if (sTableName[0][0].indexOf("ACCEPTANCE")!=-1){
			sTableName[0][5]  = "7";}
			if (sTableName[0][0].indexOf("GUARANTEEBILL")!=-1){
			sTableName[0][5]  = "6";}
			if (sTableName[0][0].indexOf("CREDITLETTER")!=-1){
			sTableName[0][5]  = "5";}
			if (sTableName[0][0].indexOf("FACTORING")!=-1){
			sTableName[0][5]  = "2";}
			}
		k++;
	}
	rs.getStatement().close();
	//������ҵ�����ҵ�����½��в�ѯ
	//���û����ص���Ϣ,�򲻽�����ʾ,���������ʾ
	sSql = "SELECT 0,COUNT(*) FROM " + sTableName[0][0] + sWhereClause; 
	for(int i=1;i<sTableName.length;i++){
		//���ڻ����չ�ڽ������⴦��(��Ϊ�����չ�ڵ������ǣ���ݱ��,�����Ǻ�ͬ���)
		String sTemp = StringFunction.replace(sTableName[i][0],"HIS","ECR");
		if(sTemp.equals("ECR_FINARETURN")||sTemp.equals("ECR_FINAEXTENSION")
			||sTemp.equals("ECR_LOANRETURN")||sTemp.equals("ECR_LOANEXTENSION")){
			sSql  = sSql  + " UNION SELECT "+i+",COUNT(*)" +" FROM " +  sTableName[i][0] + " WHERE " + sTableName[i][2] + " in  (SELECT "+ sTableName[i][2] + " FROM " + sTableName[1][0] +  sWhereClause+")";
			if(sGetDueBill.equals(""))
				sGetDueBill = "SELECT DISTINCT "+ sTableName[i][2] + " FROM " + sTableName[1][0] +  sWhereClause;
		}else{
			sSql  = sSql  + " UNION SELECT "+i+",COUNT(*) FROM " +  sTableName[i][0] + " WHERE " + sTableName[i][2] + "='" +  sTableName[i][3] + "'";
			if(sTemp.equals("ECR_IMPAWNCONT")||sTemp.equals("ECR_ASSURECONT")||sTemp.equals("ECR_GUARANTYCONT"))
				sSql = sSql + " and " + sTableName[0][4] +"='" + sTableName[0][5] + "'";
		}
	}
	rs = Sqlca.getASResultSet(sSql);
	
	int[] iShow = new int[sTableName.length];
	String[] sShow = new String[sTableName.length];
	//��ʼ����ʾ��״̬
	for(int i=0;i<sShow.length;i++){
		sShow[i] = "false";
		iShow[i] = 0;
	}
	//���ݲ�ѯ�����������
	while(rs.next()){
		int l  = rs.getInt(2);
		if(l>0){
			sShow[rs.getInt(1)]="true";
			iShow[rs.getInt(1)] = l;
		}
	}
	rs.getStatement().close();
	
	//��һ�������ͬ���ж����ݵ����,�����еĽ�ݱ�Ž������
	//��"-"�Խ�ݽ�������,��ʾ"��"��ϵ
	if(!sGetDueBill.equals("")){
		rs = Sqlca.getASResultSet(sGetDueBill);
		String sDueBill = "";
		while(rs.next()){
			if(sDueBill.equals(""))
				sDueBill = rs.getString(1);
			else
				sDueBill = sDueBill + "-" + rs.getString(1);
		}
		sTableName[2][3] = sDueBill;
		sTableName[3][3] = sDueBill;
		rs.getStatement().close();
	}
	
	//������ʾ����������·��
	String sCompName = "FeedBackRelativeList";
	String sCompPath = "/ErrorManage/FeedBackManage/FeedBackBusiness/FeedBackRelativeList.jsp";
	
	//����strip��������
	String sStrips[][] = new String[sTableName.length][7];
	String sTableFlag = "ECR"; 
	for(int t=0;t<sTableName.length;t++){
		sStrips[t][0]= sShow[t];
		sStrips[t][1]= sTableName[t][1]+"(����" + iShow[t] + "��)";
		if(iShow[t]>20){
			iShow[t] = 22;
		}
		sStrips[t][2]= String.valueOf(size+ iShow[t]*20);
		sStrips[t][3]= sCompName;
		sStrips[t][4]= sCompPath;
	
		sMetaTableName = StringFunction.replace(sTableName[t][0],"HIS","ECR");
		sTableFlag = "HIS";
		
		//������Ҫ�������MetaTableName(xml����name),DBTableName(���ݿ���Ҫ���ҵ��ֶ�),KeyName(Ҫ���ҵı�ҵ��Ĺؼ���),KeyValue(Ҫ���ҵı�ҵ��Ĺؼ��ֵ�ֵ)
		//TableFlag��ʾ������ʾhis��,����ecr��
		sStrips[t][5]= "MetaTableName="+sMetaTableName+"&DBTableName="+sTableName[t][0]+"&KeyName="+sTableName[t][2]+"&KeyValue="+sTableName[t][3]+"&TableFlag="+sTableFlag+"&IsPatch=true";
		sStrips[t][6]="";
	}
	

	
%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
<script language=javascript>
</script>
<%/*~END~*/%>
<%@include file="/Resources/CodeParts/Strip06.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>

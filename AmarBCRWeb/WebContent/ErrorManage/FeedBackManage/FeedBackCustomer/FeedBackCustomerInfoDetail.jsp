<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: �ͻ���������ҳ��
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
	String sSql="";
	String sCustomerID="";
	int size=100;
	boolean flag = false;
	//��ȡ����
	//��ҳ���ǿͻ���Ϣ�Ĺ���ҳ��
	//���ݿͻ�ID����ʾ�ͻ����е������Ϣ
	sCustomerID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("CustomerID"));	
	
%>
<%
	//��ȡ���е���صĹ�����Ϣ�������ͻ�ID,�ͻ�����,�������
	sSql=" select CUSTOMERID,CHINANAME,LOANCARDNO from ECR_CUSTOMERINFO  where CustomerID='"+sCustomerID+"'";
	rs = Sqlca.getASResultSet(sSql);
%>
<%@include file="/Resources/CodeParts/Table03.jsp"%>
<%
	rs.getStatement().close();
%>
<%/*~END~*/%>

<%	
	//�ͻ���Ϣ��
	String[][] sTableName = {
			{"HIS_CUSTOMERINFO","����˸ſ���Ϣ��"},
			{"HIS_CUSTOMERSTOCK","����˹�Ʊ��Ϣ��"},
			{"HIS_CUSTCAPIINFO","�����ע���ʱ���Ϣ��"},
			{"HIS_CUSTOMERCAPI","������ʱ�������Ϣ��"},
			{"HIS_CUSTOMERINVEST","����˶���Ͷ����Ϣ��"},
			{"HIS_CUSTOMERKEEPER","����˸߼�������Ա��Ϣ��"},
			{"HIS_CUSTOMERFAMILY","���˷��˴�������Ա��ҵ��Ϣ��"},
			{"HIS_CUSTOMERlAW","�����������Ϣ��"},
			{"HIS_CUSTOMERFACT","����˴��¼�"}
		};
	//�������еĿͻ���ص���Ϣ���в�ѯ
	sSql = "select 0, count(*) from " + sTableName[0][0] +" where CustomerID='"+sCustomerID+"'";
	
	for(int i=1;i<sTableName.length;i++){
		sSql = sSql + " union " + "select "+i+", count(*) from " + sTableName[i][0] +" where CustomerID='"+sCustomerID+"'";
	}
	rs = Sqlca.getASResultSet(sSql);
	int[] iShow = new int[sTableName.length];
	String[] sShow = new String[sTableName.length];
	//�����Ƿ���ʾ���г�ʼ��
	for(int i=0;i<sShow.length;i++){
		sShow[i] = "false";
		iShow[i] = 0;
	}
	//���ݲ�ѯ������Ƿ���ʾ��������
	while(rs.next()){
		int l  = rs.getInt(2);
		if(l>0){
			sShow[rs.getInt(1)]="true";
			iShow[rs.getInt(1)] = l;
		}
	}
	rs.getStatement().close();
	
	//������ʾ����������·��
	String sCustomerCompName = "FeedBackCustomerList";
	String sCustomerCompPath = "/ErrorManage/FeedBackManage/FeedBackCustomer/FeedBackCustomerList.jsp";

	String sStrips[][] = new String[sTableName.length][9];
	for(int t=0;t<sTableName.length;t++){
			sStrips[t][0]= sShow[t];
			sStrips[t][1]= sTableName[t][1]+"(����" + iShow[t] + "��)";
			if(iShow[t]>20){
				iShow[t] = 22;
			}
			sStrips[t][2]= String.valueOf(size+ iShow[t]*20);
			sStrips[t][3]= sCustomerCompName;//���
			sStrips[t][4]= sCustomerCompPath;//���·��
			sStrips[t][5]= "MetaTableName="+StringFunction.replace(sTableName[t][0],"HIS","ECR")+"&DBTableName="+sTableName[t][0]+"&CustomerID="+sCustomerID+"&TableFlag=HIS&IsShow=true&IsPatch=true";
			sStrips[t][6]="";
	}
%>

<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
<script language=javascript>

</script>
<%/*~END~*/%>
<%@include file="/Resources/CodeParts/Strip06.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>

<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<% 
	//�������
	ASResultSet rs = null;
	String sSql="";
	int size = 460;
	String[][] sTableName = null;
	
	//��ȡ����
	
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
	//����ҵ��������ѯ�����������еĴ�����Ϣ
	//���ݷ�������recordtype�ֶε�codelibrary�в�ѯ��ҵ���Ӧ�ı�������Ϣ������,�������,���ҵ������
	//���ڿͻ��ķ�����Ϣ��ҵ��ķ�����Ϣ�ǲ�ȡ��ͬ��ʾ��ʽ
	//����ѯ������Ϣ���浽sTableName�����У��������Ϣ������
	//sTableName[m][0]:�������
	//sTableName[m][1]:����
	//sTableName[m][3]����������-TRACENUMBER
	//sTableName[m][2]������ֵ-TRACENUMBER��ֵ
	//sTableName[m][4]:������
	//sTableName[m][5]:����ֵ,������ֵ����ʱ����ʾ�Ѿ��ҵ��˼�¼�����Խ�����ʾ
	//������ʾ�ķ�������Ϣ���Ǹ��ݴ�����ٱ�Ž��в��ҵ�
	//��ȡfeedback���еļ�¼���ͣ�������ٱ�ţ�������Ϣ
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
		//������ܲ鵽����¼,����Ҫ��
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
	//����һ���ͻ���һ��ҵ���ж��������ʱ��,��Ҫ�Դ�����ٱ�Ž��кϲ���ͨ�����ϵ�������
	//����ֻ��һ����¼������£���������⴦��
	for(int k=0;k<sTableName.length;k++){
		for(int l=k+1;l<sTableName.length;l++){
			if(sTableName[k][1].equals(sTableName[l][1])&&!sTableName[k][5].equals("")){
				sTableName[k][2] = sTableName[k][2] + "-" + sTableName[l][2];
				//������������Ϣ����Ϊ�ռ���
				sTableName[l][0]="";
				sTableName[l][1]="";
				sTableName[l][2]="";
				sTableName[l][3]="";
				sTableName[l][4]="";
				sTableName[l][5]="";
			}
		}
	}

	//ͨ��feedback�ķ�����¼���ܲ��ҵ���Ӧ�ļ�¼,��Ҫ�����ж�
	boolean bShow = false;
	for(int k=0;k<sTableName.length;k++){
		if(!sTableName[k][5].equals("")){
			bShow = true;
			break;
		}
	}
	
	//��ʾҳ�����������·��:�����ͻ���ʾ�����ҵ����ʾ���
	String sCustomerCompName = "CustomerRelativeList";
	String sCustomerCompPath = "/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp";
	String sBusinessCompName = "FeedBackRelativeList";
	String sBusinessCompPath = "/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp";
	
	//����stripҳ��
	String sStrips[][] = new String[sTableName.length][7];
	//����û�м�¼��ʾ��ʱ����Ҫ��sStrips���г�ʼ��,����ҳ�潫����ִ���
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
				sStrips[t][1]= sTableName[t][0]+"(����"+sTableName[t][2].split("-").length+"��)";
				if(sTableName[t][2].split("-").length>20)
					iLength = 22;
				else 
					iLength = sTableName[t][2].split("-").length;
				sStrips[t][2]= String.valueOf(size+ iLength*23);
				 if((Integer.parseInt(sRECORDTYPE)>=1&&Integer.parseInt(sRECORDTYPE)<=7)||(Integer.parseInt(sRECORDTYPE)>=43&&Integer.parseInt(sRECORDTYPE)<=47)){//����˷���
					sStrips[t][3]= sCustomerCompName;//���
					sStrips[t][4]= sCustomerCompPath;//���·��
					//���ݲ���
					sStrips[t][5]= "sTableName="+StringFunction.replace(sTableName[t][1],"ECR","HIS")+"&CustomerID="+sCUSTOMERID+"&KeyName="+sTableName[t][3]+"&KeyValue="+sTableName[t][2]+"&sFlag=Feedback";
				}else{//ҵ����
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

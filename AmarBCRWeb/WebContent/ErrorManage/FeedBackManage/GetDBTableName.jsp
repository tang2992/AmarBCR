<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	String sSQL = "",sSql="";
	ASResultSet rs= null,rs1=null,rs2=null;	
	//��ȡ��ѯ��
	String sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("MetaTableName"));
	if(sMetaTableName == null) sMetaTableName = "";
	//������
	String sKeyName =  DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("KeyName"));
	if(sKeyName == null) sKeyName = "";
	//����ֵ
	String sKeyValue =  DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("KeyValue"));
	if(sKeyValue == null) sKeyValue = "";
	if(sKeyValue.indexOf("-")>0){
		sKeyValue = sKeyValue.substring(0,sKeyValue.indexOf("-"));
	}
	
	String sKeyNameMain = "";
	String sReutrnValue = "";
	String sTableName = "";
	
	//�������ҵ�������Ӧ����ҵ��
	HashMap sBTHash = new HashMap();
	sBTHash.put("1","ECR_LOANCONTRACT");
	sBTHash.put("2","ECR_FACTORING");
	sBTHash.put("3","ECR_DISCOUNT");
	sBTHash.put("4","ECR_FINAINFO");
	sBTHash.put("5","ECR_CREDITLETTER");
	sBTHash.put("6","ECR_GUARANTEEBILL");
	sBTHash.put("7","ECR_ACCEPTANCE");
	sBTHash.put("8","ECR_CUSTOMERCREDIT");
	sBTHash.put("9","ECR_FLOORFUND");
	sBTHash.put("10","ECR_INTERESTDUE");
	
	
	//���������Ϣ���뵣�����йصļ�¼,��Ҫ���ݺ�ͬ���ҵ������,��ѯ�õ�����Ӧ����ҵ��
	if(sMetaTableName.equals("ECR_ASSURECONT")||sMetaTableName.equals("ECR_GUARANTYCONT")||sMetaTableName.equals("ECR_IMPAWNCONT")){
		//���ݵ���������ҵ��Ʒ�������ò�ѯ�ı�
		sSQL = "select  BUSINESSTYPE from "+sMetaTableName+" WHERE " +sKeyName +"='"+ sKeyValue+"'";
		rs = Sqlca.getASResultSet(sSQL);
		if(rs.next()){
			sMetaTableName = (String)sBTHash.get(rs.getString(1));
			sSql = "select ITEMATTRIBUTE AS ITEMATTRIBUTE from CODE_LIBRARY WHERE ITEMDESCRIBE='" + sMetaTableName  + "' and codeno='recordtype'";
			rs1 = Sqlca.getASResultSet(sSql);
			if(rs1.next()){
				sKeyName = rs1.getString("ITEMATTRIBUTE");
			}
			rs1.getStatement().close();
			//����������,������,����ֵ
			sReutrnValue = sMetaTableName+","+sKeyName+","+sKeyValue;
			rs.getStatement().close();
		}
	}else{
		//���ڽ��,����,չ�ڶ�Ӧ�����е�ҵ����Ϣ
		if(sMetaTableName.equals("ECR_FINARETURN")||sMetaTableName.equals("ECR_FINAEXTENSION")
				||sMetaTableName.equals("ECR_LOANRETURN")||sMetaTableName.equals("ECR_LOANEXTENSION")
				||sMetaTableName.equals("ECR_FINADUEBILL")||sMetaTableName.equals("ECR_LOANDUEBILL")){
				if(sMetaTableName.indexOf("FINA")>=0){
					sMetaTableName = "ECR_FINADUEBILL";
					sKeyNameMain = "FCONTRACTNO";
					sTableName = "ECR_FINAINFO";
				}else{
					sMetaTableName = "ECR_LOANDUEBILL";
					sKeyNameMain = "LCONTRACTNO";
					sTableName = "ECR_LOANCONTRACT";
				}
				//��ϳ�sql���
				sSQL = "select "+ sKeyNameMain + " from " + sMetaTableName  + " where " + sKeyName + " ='" + sKeyValue +"'";
				rs1 = Sqlca.getASResultSet(sSQL);
				if(rs1.next()){
					sKeyValue = rs1.getString(1);
				}
				rs1.getStatement().close();
				//����������,������,����ֵ
				sReutrnValue =  sTableName+","+sKeyNameMain+","+sKeyValue;
		}else{
			sReutrnValue = sMetaTableName + "," +  sKeyName +"," +sKeyValue;
		}
	}
	
%>
<script type="text/javascript">
	top.returnValue = "<%=sReutrnValue%>";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>
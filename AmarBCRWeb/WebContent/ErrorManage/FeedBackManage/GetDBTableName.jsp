<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	String sSQL = "",sSql="";
	ASResultSet rs= null,rs1=null,rs2=null;	
	//获取查询表
	String sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("MetaTableName"));
	if(sMetaTableName == null) sMetaTableName = "";
	//主键名
	String sKeyName =  DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("KeyName"));
	if(sKeyName == null) sKeyName = "";
	//主键值
	String sKeyValue =  DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("KeyValue"));
	if(sKeyValue == null) sKeyValue = "";
	if(sKeyValue.indexOf("-")>0){
		sKeyValue = sKeyValue.substring(0,sKeyValue.indexOf("-"));
	}
	
	String sKeyNameMain = "";
	String sReutrnValue = "";
	String sTableName = "";
	
	//担保表的业务种类对应的主业务
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
	
	
	//如果错误信息是与担保表有关的记录,需要根据合同表的业务种类,查询该担保对应的主业务
	if(sMetaTableName.equals("ECR_ASSURECONT")||sMetaTableName.equals("ECR_GUARANTYCONT")||sMetaTableName.equals("ECR_IMPAWNCONT")){
		//根据担保所属的业务品种来设置查询的表
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
			//返回主表名,主键名,主键值
			sReutrnValue = sMetaTableName+","+sKeyName+","+sKeyValue;
			rs.getStatement().close();
		}
	}else{
		//对于借据,还款,展期对应的所有的业务信息
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
				//组合成sql语句
				sSQL = "select "+ sKeyNameMain + " from " + sMetaTableName  + " where " + sKeyName + " ='" + sKeyValue +"'";
				rs1 = Sqlca.getASResultSet(sSQL);
				if(rs1.next()){
					sKeyValue = rs1.getString(1);
				}
				rs1.getStatement().close();
				//返回主表名,主键名,主键值
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
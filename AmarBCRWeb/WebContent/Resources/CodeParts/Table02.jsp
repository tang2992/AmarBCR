<html>
<head>
<style type="text/css">
.style15{
margin: 0px auto;
margin-bottom:10px;
border:2px solid #A5B6C8;
background-color: #EEF3F7
}
</style>
<%@ include file="/Resources/CodeParts/progressSet.jsp"%>
<body class=pagebackground leftmargin="0" topmargin="0" >
<table align='center' width='98%'  cellspacing="4" cellpadding="4"  class='style15'>
<%
	String ErrMsg="";
	ASResultSet rs1 = null, rs2 = null;
	String sSQL = "",sSelectMainName = "";
	boolean bFirst = true,bFirst1 = true;
	String[][] sOtherTable = {
			{"ECR_CUSTOMERINFO","借款人概况信息表"},
			{"ECR_CUSTOMERSTOCK","借款人股票信息表"},
			{"ECR_CUSTOMERCAPI","借款人资本构成信息表"},
			{"ECR_CUSTCAPIINFO","借款人注册资本信息表"},
			{"ECR_CUSTOMERINVEST","借款人对外投资信息表"},
			{"ECR_CUSTOMERKEEPER","借款人高级管理人员信息表"},
			{"ECR_CUSTOMERFAMILY","款人法人代表家族成员企业信息表"}
	};
	
%>
<%
	int m = 0;
	//把feedback表中所有的主键相同，贷款卡编码相同的记录都获取到
	while(rs.next()){
		out.println("<tr bgcolor='#FFFFFF' valign=center height='25' border='3' bordercolordark=#F8B3D0 bordercolorlight=#000000 > ");
		//根据记录类型来获取，表名，表描述，主键值
		sSQL = "SELECT ITEMNAME,ITEMDESCRIBE,ITEMATTRIBUTE FROM CODE_LIBRARY WHERE CODENO='recordtype' and ITEMNO='" + rs.getString(1) +"'  ORDER BY  SORTNO " ;
		rs1 = Sqlca.getASResultSet(new SqlObject( sSQL));
		//输出错误信息和记录类型
		if(rs1.next()){
			out.println("<td align='left'><strong><font color=red>"+rs1.getString(1)+":</font><strong>");
			sTableName[m][1] = rs1.getString(2);//表名
			sTableName[m][0] = rs1.getString(1);//表描述
			sTableName[m][2] = rs.getString(2);//错误跟踪号码
			sTableName[m][3] =  "TRACENUMBER";//查找属性
			sTableName[m][4] = rs1.getString(3);//主键名
			//获取tracenumber对应的主从表的主键值
			sSelectMainName = "SELECT distinct "+ sTableName[m][4]+ " FROM " + StringFunction.replace(sTableName[m][1],"ECR","HIS") +" WHERE TRACENUMBER='" + sTableName[m][2]+"'" ;
			rs2 = Sqlca.getASResultSet(new SqlObject(sSelectMainName));
			if(rs2.next()){
				sTableName[m][5] = rs2.getString(1);//主键值
			}else{
				sTableName[m][5] = "";//没有获取该记录,这种情况会导致不能获取记录的情况，需要进行特殊处理
			}
			rs2.getStatement().close();
			
			
			out.println("<strong><font color=red>"+rs.getString(3)+"</font><strong></td>");
			out.println("</tr>");
			
			
			//对于关联表的设置
			int n=m;
			if(sTableName[m][1].equals("ECR_CUSTOMERCAPI")&&bFirst == true){
				for(int i=3;i<7;i++){
					n++;
					sTableName[n][0] = sOtherTable[i][1];//表描述
					sTableName[n][1] = sOtherTable[i][0];//表名
					sTableName[n][2] = sTableName[m][2];//错误跟踪号码
					sTableName[n][3] = "TRACENUMBER";//名称
					sTableName[n][4] =  "CUSTOMERID";//查找属性
					//获取tracenumber对应的主从表的主键值
					sSelectMainName = "SELECT distinct "+ sTableName[n][4]+ " FROM " + StringFunction.replace(sTableName[n][1],"ECR","HIS") +" WHERE TRACENUMBER='" + sTableName[n][2]+"'" ;
					rs2 = Sqlca.getASResultSet(sSelectMainName);
					if(rs2.next()){
						sTableName[n][5] = rs2.getString(1);//主键值
					}else{
						sTableName[n][5] = "";//没有获取该记录,这种情况会导致不能获取记录的情况，需要进行特殊处理
					}
					rs2.getStatement().close();
					bFirst = false;
				}
				m = n;
				n= 0 ;
			}else if(sTableName[m][1].equals("ECR_CUSTOMERINFO")&&bFirst1 == true){
					n++;
					sTableName[n][0] = sOtherTable[1][1];//错误跟踪号码
					sTableName[n][1] = sOtherTable[1][0];//错误跟踪号码
					sTableName[n][2] = sTableName[m][2];//错误跟踪号码
					sTableName[n][3] = "TRACENUMBER";//名称
					sTableName[n][4] =  "CUSTOMERID";//查找属性
					//获取tracenumber对应的主从表的主键值
					sSelectMainName = "SELECT distinct "+ sTableName[n][4]+ " FROM " + StringFunction.replace(sTableName[n][1],"ECR","HIS") +" WHERE TRACENUMBER='" + sTableName[n][2]+"'" ;
					rs2 = Sqlca.getASResultSet(sSelectMainName);
					if(rs2.next()){
						sTableName[n][5] = rs2.getString(1);//主键值
					}else{
						sTableName[n][5] = "";//没有获取该记录,这种情况会导致不能获取记录的情况，需要进行特殊处理
					}
					rs2.getStatement().close();
					bFirst1 = false;
					m = n;
					n= 0 ;
				}
			m++;
		}
		rs1.getStatement().close();
	}
%>
</table>
</body>
</html>

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
			{"ECR_CUSTOMERINFO","����˸ſ���Ϣ��"},
			{"ECR_CUSTOMERSTOCK","����˹�Ʊ��Ϣ��"},
			{"ECR_CUSTOMERCAPI","������ʱ�������Ϣ��"},
			{"ECR_CUSTCAPIINFO","�����ע���ʱ���Ϣ��"},
			{"ECR_CUSTOMERINVEST","����˶���Ͷ����Ϣ��"},
			{"ECR_CUSTOMERKEEPER","����˸߼�������Ա��Ϣ��"},
			{"ECR_CUSTOMERFAMILY","���˷��˴�������Ա��ҵ��Ϣ��"}
	};
	
%>
<%
	int m = 0;
	//��feedback�������е�������ͬ�����������ͬ�ļ�¼����ȡ��
	while(rs.next()){
		out.println("<tr bgcolor='#FFFFFF' valign=center height='25' border='3' bordercolordark=#F8B3D0 bordercolorlight=#000000 > ");
		//���ݼ�¼��������ȡ��������������������ֵ
		sSQL = "SELECT ITEMNAME,ITEMDESCRIBE,ITEMATTRIBUTE FROM CODE_LIBRARY WHERE CODENO='recordtype' and ITEMNO='" + rs.getString(1) +"'  ORDER BY  SORTNO " ;
		rs1 = Sqlca.getASResultSet(new SqlObject( sSQL));
		//���������Ϣ�ͼ�¼����
		if(rs1.next()){
			out.println("<td align='left'><strong><font color=red>"+rs1.getString(1)+":</font><strong>");
			sTableName[m][1] = rs1.getString(2);//����
			sTableName[m][0] = rs1.getString(1);//������
			sTableName[m][2] = rs.getString(2);//������ٺ���
			sTableName[m][3] =  "TRACENUMBER";//��������
			sTableName[m][4] = rs1.getString(3);//������
			//��ȡtracenumber��Ӧ�����ӱ������ֵ
			sSelectMainName = "SELECT distinct "+ sTableName[m][4]+ " FROM " + StringFunction.replace(sTableName[m][1],"ECR","HIS") +" WHERE TRACENUMBER='" + sTableName[m][2]+"'" ;
			rs2 = Sqlca.getASResultSet(new SqlObject(sSelectMainName));
			if(rs2.next()){
				sTableName[m][5] = rs2.getString(1);//����ֵ
			}else{
				sTableName[m][5] = "";//û�л�ȡ�ü�¼,��������ᵼ�²��ܻ�ȡ��¼���������Ҫ�������⴦��
			}
			rs2.getStatement().close();
			
			
			out.println("<strong><font color=red>"+rs.getString(3)+"</font><strong></td>");
			out.println("</tr>");
			
			
			//���ڹ����������
			int n=m;
			if(sTableName[m][1].equals("ECR_CUSTOMERCAPI")&&bFirst == true){
				for(int i=3;i<7;i++){
					n++;
					sTableName[n][0] = sOtherTable[i][1];//������
					sTableName[n][1] = sOtherTable[i][0];//����
					sTableName[n][2] = sTableName[m][2];//������ٺ���
					sTableName[n][3] = "TRACENUMBER";//����
					sTableName[n][4] =  "CUSTOMERID";//��������
					//��ȡtracenumber��Ӧ�����ӱ������ֵ
					sSelectMainName = "SELECT distinct "+ sTableName[n][4]+ " FROM " + StringFunction.replace(sTableName[n][1],"ECR","HIS") +" WHERE TRACENUMBER='" + sTableName[n][2]+"'" ;
					rs2 = Sqlca.getASResultSet(sSelectMainName);
					if(rs2.next()){
						sTableName[n][5] = rs2.getString(1);//����ֵ
					}else{
						sTableName[n][5] = "";//û�л�ȡ�ü�¼,��������ᵼ�²��ܻ�ȡ��¼���������Ҫ�������⴦��
					}
					rs2.getStatement().close();
					bFirst = false;
				}
				m = n;
				n= 0 ;
			}else if(sTableName[m][1].equals("ECR_CUSTOMERINFO")&&bFirst1 == true){
					n++;
					sTableName[n][0] = sOtherTable[1][1];//������ٺ���
					sTableName[n][1] = sOtherTable[1][0];//������ٺ���
					sTableName[n][2] = sTableName[m][2];//������ٺ���
					sTableName[n][3] = "TRACENUMBER";//����
					sTableName[n][4] =  "CUSTOMERID";//��������
					//��ȡtracenumber��Ӧ�����ӱ������ֵ
					sSelectMainName = "SELECT distinct "+ sTableName[n][4]+ " FROM " + StringFunction.replace(sTableName[n][1],"ECR","HIS") +" WHERE TRACENUMBER='" + sTableName[n][2]+"'" ;
					rs2 = Sqlca.getASResultSet(sSelectMainName);
					if(rs2.next()){
						sTableName[n][5] = rs2.getString(1);//����ֵ
					}else{
						sTableName[n][5] = "";//û�л�ȡ�ü�¼,��������ᵼ�²��ܻ�ȡ��¼���������Ҫ�������⴦��
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

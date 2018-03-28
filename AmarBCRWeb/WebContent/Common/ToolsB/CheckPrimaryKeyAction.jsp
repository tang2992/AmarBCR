<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
/*
 * Content: ���ݴ���Ĳ��������ü�¼�������Ƿ��ظ�
 * Input Param: 
 *		Type:����ж�
 *			PRIMARYKEY:�������     
 * 		TableName :����
 *		FieldName1 :����1
 *		FieldValue1 :����1��Ӧ��ֵ
 *		FieldName2 :����2
 *		FieldValue2 :����2��Ӧ��ֵ
 *		FieldName3 :����3
 *		FieldValue3 :����3��Ӧ��ֵ
 *		FieldName4 :����4
 *		FieldValue4 :����4��Ӧ��ֵ	
 * Output param:
 *      ReturnValue:���ڱ�־(TRUE�������ظ���FALSE���������ظ�)
 */
 	//��ȡ���͡�����������1������1��Ӧ��ֵ������2������2��Ӧ��ֵ������3������3��Ӧ��ֵ������4������4��Ӧ��ֵ
	String sType  = CurPage.getParameter("Type");
	String sTableName  = CurPage.getParameter("TableName");
	String sFieldName1  = CurPage.getParameter("FieldName1");
	String sFieldValue1 = CurPage.getParameter("FieldValue1");
	String sFieldName2 = CurPage.getParameter("FieldName2");
	String sFieldValue2  = CurPage.getParameter("FieldValue2");
	String sFieldName3 = CurPage.getParameter("FieldName3");
	String sFieldValue3 = CurPage.getParameter("FieldValue3");
	String sFieldName4 = CurPage.getParameter("FieldName4");
	String sFieldValue4 = CurPage.getParameter("FieldValue4");
	
	String sSql = "",sReturnValue = "FALSE";
	int iCount = 0;
	
	if(sType.equals("PRIMARYKEY")){
		if(sFieldName1 !=null && sFieldName1 !="") {
			String sWhere = sFieldName1+" = :"+sFieldName1;
			if(sFieldName2 !=null && sFieldName2 !="") sWhere = sWhere + " and "+sFieldName2+" = :"+sFieldName2;
			if(sFieldName3 !=null && sFieldName3 !="") sWhere = sWhere + " and "+sFieldName3+" = :"+sFieldName3;
			if(sFieldName4 !=null && sFieldName4 !="") sWhere = sWhere + " and "+sFieldName4+" = :"+sFieldName4;
			sSql = " select count(1) from "+sTableName+" where  "+sWhere;
			SqlObject  sqlObject=new SqlObject(sSql);
			sqlObject.setParameter(sFieldName1, sFieldValue1);
			if(sFieldName2 !=null && sFieldName2 !="") sqlObject.setParameter(sFieldName2, sFieldValue2);
			if(sFieldName3 !=null && sFieldName3 !="") sqlObject.setParameter(sFieldName3, sFieldValue3);
			if(sFieldName4 !=null && sFieldName4 !="") sqlObject.setParameter(sFieldName4, sFieldValue4);
			ASResultSet rs  = Sqlca.getASResultSet(sqlObject);
			if(rs.next()){
				iCount = rs.getInt(1);
				if(iCount > 0)
					sReturnValue = "TRUE";			
				else
					sReturnValue = "FALSE";
			}else
				sReturnValue = "FALSE";
			rs.getStatement().close();	
		}
	}
	out.print(sReturnValue); 
%><%@ include file="/IncludeEndAJAX.jsp"%>
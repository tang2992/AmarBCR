<%@page import="com.amarsoft.dict.als.object.Item"%>
<%@page import="com.amarsoft.dict.als.manage.CodeManager"%>
<%@page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
	  author:syang 2009/10/20
		Content: ����̨��WorkTips������ʾAjaxչʾ�ܵ���ҳ��
		Input Param:
			Type:�������ͣ������꣬չ��ʱType ="1"��
	 */
	String sType = CurPage.getParameter("Type");
	String sItemNo = CurPage.getParameter("ItemNo");
	if(sType == null) sType = "0";
	if(sItemNo == null) throw new Exception("�봫����");
	
	//ȡ���������
	Item[] codeDef = CodeManager.getItems("PlantformTask");
	String sURLName = "";
	for(int i=0;i<codeDef.length;i++){
		Item vpItem = codeDef[i];
		String sCurItemNo = vpItem.getItemNo();
		if(sItemNo.equals(sCurItemNo)){	//�������봫��Ľ��бȽ�
			sURLName = vpItem.getItemAttribute();
			break;
		}
	}
	//����ҳ��URL����Ϊ��
	if(sURLName == null || sURLName.length() == 0){
		throw new Exception("�����[PlantformTask]��ItemNo["+sItemNo+"],û������ItemAttribute�ֶε�ֵ");
	}
	response.sendRedirect(SpecialTools.amarsoft2Real(sWebRootPath+sURLName+"?Flag="+sType+"&CompClientID="+sCompClientID));
%><%@ include file="/IncludeEndAJAX.jsp"%>
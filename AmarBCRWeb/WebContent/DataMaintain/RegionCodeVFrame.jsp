<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Frame00;Describe=ע����;]~*/%>
	<%
	/*
		Author:
		Tester:
		Content: ��������ѡ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Frame01;Describe=�����������ȡ����;]~*/%>
<%
	String sRegionCode = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("RegionCode"));
	//System.out.println("----------"+sRegionCode);
%>
<%/*~END~*/%>
 

<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=Frame02;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/Frame03.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=Frame03;Describe=�Զ��庯��;]~*/%>
	<script language=javascript>
	
	</script>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=Frame04;Describe=ҳ��װ��ʱ�����г�ʼ��;]~*/%>
<script language=javascript>
	myleft.width=340;
	OpenPage("/DataMaintain/RegionCodeSelect.jsp?RegionCode=<%=sRegionCode%>","frameleft","");
	OpenPage("/Blank.jsp?TextToShow=�������б���ѡ��һ��","frameright","");
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>

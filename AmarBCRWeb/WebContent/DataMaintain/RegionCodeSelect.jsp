<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info00;Describe=ע����;]~*/%>
	<%
	/*
		Author:  
				
		Tester:
		Describe: ��������ѡ��
		Input Param:
		Output Param:
			ItemNo����Ŀ���
			ItemName����Ŀ����

		HistoryLog:
			
	 */
	%>
<%/*~END~*/%>

<html>
<head>
<title>��ѡ���������� </title>
</head>

<script language=javascript>

<%
	String sRegionCodeValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("RegionCodeValue"));
	String sRegionCode = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("RegionCode"));
	String sOpen = "";
	String sDefaultItem = "";
	//�����жϣ���ֹ���� null���� add by jbye 2009/03/30
	if(sRegionCode.length()>3) sDefaultItem = sRegionCode.substring(0,3);
	if(sRegionCode!=null&&sRegionCode.length()>3) sOpen = "YES";
%>


	function TreeViewOnClick(){

		var sRegionCode=getCurTVItem().id;
		var sRegionCodeName=getCurTVItem().name;
		var sType = getCurTVItem().type;
		buff.RegionCode.value=sRegionCode+"@"+sRegionCodeName;
		<%

		if(sRegionCodeValue == null)
		{
		%>
		newBusiness();
		<%
		}
		%>
	}
	
	function TreeViewOnDBClick()
	{
		newBusiness();
	}


	function newBusiness(){
<%
	if(sRegionCodeValue == null)
	{
%>
		if(buff.RegionCode.value!=""){
			sReturnValue = buff.RegionCode.value;
			top.OpenPage("/DataMaintain/RegionCodeSelect.jsp?RegionCodeValue="+getCurTVItem().id,"frameright","");
		}
		else{
			alert("��ѡ��������������");
		}
<%	}
	else
	{	
%>
		var s,sValue,sName;
		var sReturnValue = "";
		s=buff.RegionCode.value;
		s = s.split('@');
		sValue = s[0];
		sName = s[1];
               
		if(buff.RegionCode.value.length<6){
			alert("��ѡ����������ϸ��");//��ѡ����ҵ����ϸ�
		}else{
			if(sValue.length==6){
				top.returnValue = buff.RegionCode.value;
				top.close();
			}
		}

<%
	}
%>
	}
	//����
	function goBack()
	{
		top.close();
	}

	//����ѯ����������������TreeViewչʾ
	function startMenu()
	{
	<%

		HTMLTreeView tviTemp = new HTMLTreeView("���������б�","right");
		tviTemp.TriggerClickEvent=true;
		//ѡ����������һ
		if(sRegionCodeValue == null)
			tviTemp.initWithSql("PbCode","Note","PbCode","","from WEB_CODEMAP where ColName='5527' and length(PbCode) <= 2",Sqlca);
		else
			tviTemp.initWithSql("PbCode","Note","PbCode","","from WEB_CODEMAP where ColName='5527' and PbCode like '"+sRegionCodeValue+"%' and PBCode<>'"+sRegionCodeValue+"'",Sqlca);
		
		tviTemp.ImageDirectory = sResourcesPath; //������Դ�ļ�Ŀ¼��ͼƬ��CSS��
		out.println(tviTemp.generateHTMLTreeView());

	%>

	}


</script>

<body bgcolor="#DCDCDC">
<center>
<form  name="buff">
<input type="hidden" name="RegionCode" value="">
<table width="90%" align=center border='1' height="98%" cellspacing='0' bordercolor='#999999' bordercolordark='#FFFFFF'>
<tr>
        <td id="myleft"  colspan='3' align=center width=100%><iframe name="left" src="" width=100% height=100% frameborder=0 scrolling=no ></iframe></td>
</tr>



<tr height=4%>
<%
	if(sRegionCodeValue == null){
%>
<span class="STYLE9"></span>
<p align="left" class="black9pt">������������</p>
<td nowrap align="right" class="black9pt" bgcolor="#F0F1DE" >
</td>
<%
	}else{
%>
<span class="STYLE9"></span>
<p align="left" class="black9pt">������������</p>
<td nowrap align="right" class="black9pt" bgcolor="#F0F1DE" >
	<%=HTMLControls.generateButton("ȷ��","ȷ��","javascript:newBusiness()",sResourcesPath)%>
</td>
<td nowrap bgcolor="#F0F1DE" >
	<%=HTMLControls.generateButton("ȡ��","ȡ��","javascript:goBack()",sResourcesPath)%>
</td>
<%};%>

</tr>

</table>
</form>
</center>
</body>
</html>

<script language="JavaScript">
	startMenu();
	expandNode('root');
	selectItem('<%=sDefaultItem%>');//�Զ������ͼ��Ŀǰд����Ҳ�������õ� code_library�н����趨
	selectItem('<%=sRegionCode%>');//�Զ������ͼ��Ŀǰд����Ҳ�������õ� code_library�н����趨
	expandNode('<%=sRegionCodeValue%>');
</script>

<%@ include file="/IncludeEnd.jsp"%>

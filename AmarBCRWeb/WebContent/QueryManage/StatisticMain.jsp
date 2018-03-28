<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
 
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main00;Describe=注释区;]~*/%>
	<%
	/*
		Author:   
		Tester:
		Content: 主页面
		Input Param:
			          
		Output param:
			      
		History Log: 
	 */
	%>
<%/*~END~*/%>

<%
	//取系统名称
	String sImplementationName = CurConfig.getConfigure("ImplementationName");
	if (sImplementationName == null) sImplementationName = "";
	    
%>
<html>
<head>
<title><%=sImplementationName%></title>
</head>
<script language=javascript>

    function openFile(sBoardNo)
    {
        popComp("BoardView","/SystemManage/SynthesisManage/BoardView.jsp","BoardNo="+sBoardNo,"","");
    }

    function saveFile(sBoardNo)
    {
        window.open("<%=sWebRootPath%>/SystemManage/BoardManage/BoardView2.jsp?BoardNo="+sBoardNo+"&rand="+randomNumber(),"_blank",OpenStyle);
    }

</script>

<body leftmargin="0" topmargin="0" class="windowbackground" style="{overflow:scroll;overflow-x:visible;overflow-y:visible}">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
	<tr>
	  <td id=mytop class="mytop">
	       	<%@include file="/MainTop.jsp"%>
          </td>
	</tr> 
	<tr>
	  <td valign="top" id="mymiddle" class="mymiddle"></td>
	</tr>
	<tr>
	  <td valign="top" id="mymiddleShadow" class="mymiddleShadow"></td>
	</tr>
        <tr>
          <td valign="top"  onMouseOver="showlayer(0,this)">
            <table width="100%" border="0" cellpadding="5" height="100%" cellspacing="0">
              <tr>
                <td valign="top" rowspan=2>
                  <div class="groupboxmaxcontent" >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                      <tr>
                        <td height="1">
                          <table cols=2 border=0 cellpadding=0 cellspacing=0>
                            <tr>
                                <td nowrap class="groupboxheader">
                              	<font class="groupbox"> &nbsp;&nbsp;数据统计&nbsp;&nbsp;</font> </td>
                              <td nowrap class="groupboxcorner"><img class="groupboxcornerimg" src=<%=sResourcesPath%>/1x1.gif width="1" height="1" name="Image1"></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td>
                         <div  valign=middle class="groupboxmaxcontent" style="position:absolute; width: 100%;overflow:auto;visibility: inherit" id="window1">
						<%
							String sTableStyle = "valign=middle align=center cellspacing=0 cellpadding=0 border=0 width=95% height=95%";
							String sTabHeadStyle = "";
							String sTabHeadText = "<br>";
							String sTopRight = "";
							String sTabID = "tabtd";
							String sIframeName = "DeskTopTab";
							String sDefaultPage = sWebRootPath+"/Blank.jsp?TextToShow=正在打开页面，请稍候";
							String sIframeStyle = "width=100% height=100% frameborder=0	hspace=0 vspace=0 marginwidth=0	marginheight=0 scrolling=no";
						%>
						<%@include file="/Resources/CodeParts/Tab04.jsp"%>
                          </div>
                        </td>
                      </tr>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<script language="JavaScript">
	
	var tabstrip = new Array();
  	<%
  	
	String sStrips[][] = {
	  		{"010","业务统计查询","doTabAction('Synthesis')"},
	  		{"020","数据核对查询","doTabAction('DataCheck')"}
	 };
  	
	String sTabStrip[][]=new String[2][3];
  	 
	//if(CurUser.hasRole("0100")||CurUser.hasRole("0500")||CurUser.hasRole("0501")){
		for(int k=0;k<2;k++){
			for(int j=0;j<3;j++){
				sTabStrip[k][j]=sStrips[k][j];
			}
		}
	//}else{
	//	for(int j=0;j<3;j++){
	//		sTabStrip[0][j]=sStrips[1][j];
	//	}
	//}
	  
		out.println(HTMLTab.genTabArray(sTabStrip,"tab_DeskTopInfo","document.all('tabtd')"));
  	%>

  	function doTabAction(sArg)
  	{
  		var pageArea="WorkBench";
  		if(sArg=="Synthesis")
  		{
  			OpenComp("SynthesisQueryList","/QueryManage/SynthesisQueryList.jsp","","<%=sIframeName%>","");
  		}
  		else if(sArg=="DataCheck")
  		{	
	  		OpenComp("DataCheckQueryList","/QueryManage/DataCheckQueryList.jsp","","<%=sIframeName%>","");
  		}
  	}

	hc_drawTabToTable("tab_DeskTopInfo",tabstrip,1,document.all('<%=sTabID%>'));
	<%=sTabStrip[0][2]%>;
</script>

<%@ include file="/IncludeEnd.jsp" %>
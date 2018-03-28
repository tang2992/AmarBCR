<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_multi.jspf"%>
 <!-- <input type="button" name="submit" value="Ìá½»" onclick="as_save('frame_info,frame_list')"> -->
<%
	String sOrgId = CurPage.getParameter("OrgId");
	if(sOrgId == null) sOrgId = "";
	String sOrgCode = CurPage.getParameter("OrgCode");
	if(sOrgCode == null) sOrgCode = "";
	String isNew = CurPage.getParameter("isNew");
	if(isNew == null) isNew = "0";
	int size = "1".equals(isNew)?150:230;
%>
<iframe name="frame_info" width="100%" height="<%=size%>px" frameborder="0"></iframe>
<hr class="list_hr">
<iframe name="frame_list" width="100%" height="340px" frameborder="0"></iframe>
<%@include file="/Frame/resources/include/ui/include_multi.jspf"%>
<script>
	var sUrl = "/WebTask/ReportOrgInfo.jsp";
	OpenPage(sUrl+"?OrgId=<%=sOrgId%>&isNew=<%=isNew%>","frame_info","");
	sUrl = "/WebTask/ContactPersons.jsp";
	OpenPage(sUrl+"?OrgCode=<%=sOrgCode%>","frame_list","");
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>
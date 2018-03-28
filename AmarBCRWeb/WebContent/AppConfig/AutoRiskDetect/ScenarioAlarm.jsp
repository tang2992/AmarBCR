<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%> 
<%@page import="com.amarsoft.app.alarm.*"%>
<%@page import="com.amarsoft.awe.util.ObjectConverts"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/AppConfig/AutoRiskDetect/resources/scenario.css">
<%
	//����������	
	String sScenarioNo = CurPage.getParameter("ScenarioNo");
	String sBizArg = CurPage.getParameter("BizArg");
	String sSubTypeNo = CurPage.getParameter("SubTypeNo");
	ARE.getLog().debug("����ҵ�����:"+sBizArg);

	//������
	ScenarioContextLoader loader = new DefaultScenarioContextLoader();
	((DefaultScenarioContextLoader)loader).init(Sqlca,sScenarioNo,sBizArg,sSubTypeNo);
	
	ScenarioContext context = loader.getContext();				//��ȡ��������
	context.setCheckItemRunner(new DefaultCheckItemRunner());	//ģ��������
	
	String scenarioSerializable = ObjectConverts.getString(context);	//���л�
%>
<body style="overflow:hidden;overflow-y:auto;height:100%">
    <div class="r_main">
    <%
    	List<ItemGroup> gList0 = context.getScenario().getGroupList();
    	List<ItemGroup> gList = new ArrayList<ItemGroup>();
    
    	//����������������Ԥ����,�����¼������������ûͨ��������ʾ�÷���
    	for(int i=0;i<gList0.size();i++){
    		ItemGroup group = gList0.get(i);
    		List<CheckItem> ckList0 = group.getCheckItemList();
    		List<CheckItem> ckList1 = new ArrayList<CheckItem>();	//��ż��ͨ����
    		for(int j=0;j<ckList0.size();j++){
    			CheckItem ckItem = ckList0.get(j);
	           	String sCondition = ckItem.getRunCondition();	//��������
	           	if(sCondition!=null&&sCondition.length()>0){
	               	boolean bCondition = StringTool.runAmarScript(Sqlca, sCondition, context.getParameter()).booleanValue();
	               	if(!bCondition)continue;
	               	else ckList1.add(ckItem);
	           	}else{
	               	ckList1.add(ckItem);
	           	}
    		}
    		if(ckList1.size()>0){	//�������
    			group.getCheckItemList().clear();
    			group.getCheckItemList().addAll(ckList1);
    			gList.add(group);
    		}
    	}
    	//���ɽ���
    	for(int i=0;i<gList.size();i++){
    		ItemGroup group = gList.get(i);
    		List<CheckItem> ckList = group.getCheckItemList();
    %>
        <div class="r_group" id="Group<%=group.getGroupID()%>" groupID="<%=group.getGroupID()%>" groupName="<%=group.getGroupName()%>">
            <div class="r_info">
                <div style="float:left;"><%=group.getGroupName()%></div>  
                <div class="group_result"></div>
            </div>
            <div class="r_head"></div>
            <div class="r_x">
                <table class="r_tb">
                    <thead>
	                    <tr>
	                        <td class="r_35 r_tb_tit">���������</td>
	                        <td class="r_9 r_tb_tit">������</td>
	                        <td class="r_55 r_tb_tit">��ʾ��Ϣ</td>
	                        <td class="r_6 r_tb_tit">����</td>
	                    </tr>
                    </thead>
                    <tbody>
                    <%for(int j=0;j<ckList.size();j++){
                    	CheckItem ckItem = ckList.get(j);
                    	String viewerScript = ckItem.getBizViewer();
                    	if(viewerScript==null)viewerScript="";
                    	else viewerScript = StringTool.pretreat(context.getParameter(), viewerScript);
                    	String viewNode = "&nbsp;";
                    	if(viewerScript.length()>0){
                    		viewNode = "<a href='javascript:void(0);'>�޸�</a>";
                    	}
                    %>
                    <tr class="ck_item default" groupID="<%=group.getGroupID()%>" itemID="<%=ckItem.getItemID()%>" noPassDeal="<%=ckItem.getNoPassDeal()%>">
                        <td class="r_35"><%=ckItem.getItemName()%></td>
                        <td class="r_9"><div class="icon"></div></td>
                        <td class="r_55 message">&nbsp;</td>
                        <td class="r_6 viewer"><span class="label"><%=viewNode%></span><span class="script"><%=viewerScript%></span></td>
                    </tr>
 					<%}%>
                    </tbody>
                </table>
            </div>
            <div class="r_footer"></div>
        </div>
        <%}%>
        <div class="r_ending">
	    	<table style="width: 820px">
				<tr>
					<td colspan="3" id="scenario-message" height="50px" vAlign="middle">&nbsp;
					</td>
				</tr>
				<tr id="scenario-button">
				    <td align="center">
					    <table>
					        <tr>
						       <td><%=new Button("���¼��","���¼��","reRun()","","").getHtmlText()%></td>
						       <td><%=new Button("ȷ��","ȷ��","alarm_ok()","","").getHtmlText()%></td>
						       <td><%=new Button("ȡ��","ȡ��","alarm_exit()","","").getHtmlText()%></td>
					        </tr>
					    </table>
				    </td>
				</tr>
			</table>
		</div>
    </div> 
</body>
<script type="text/javascript">
function alarm_exit(){
	top.close();
}

function alarm_ok(){
	var ctx = $(".r_main");
	var bComplete = ctx.isComplete();
	if(bComplete){
		top.returnValue = (bComplete&&ctx.isPass());
		top.close();
	}else{
		alert("û���������");
	}
}

$(document).ready(function(){
	run();
});
function run(){
	var url = "<%=sWebRootPath%>/AppConfig/AutoRiskDetect/AlarmModelInvoker.jsp?CompClientID=<%=sCompClientID%>&randp="+randomNumber();
	var ser = "<%=scenarioSerializable%>";
	$(".r_main").riskScan({
		modelInvoker:url,
		scenarioSerial:ser
	});
}
function reRun(){
	run();
}
</script>
<%@	include file="/IncludeEnd.jsp"%>
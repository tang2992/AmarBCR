<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��:UI���������ҳ��
	 */
	String PG_TITLE = "UI�������"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;UI�������&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	CurPage.setAttribute("HideMinButton", "true");
	
	//����Treeview
	HTMLTreeView tviTemp = new OHTMLTreeView(SqlcaRepository,CurComp,sServletURL,"UI�������","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	//������ͼ�ṹ
	String sFolder10=tviTemp.insertFolder("root","�������","",1);
	String sFolder12=tviTemp.insertFolder(sFolder10,"Button","",2);
	tviTemp.insertPage(sFolder12,"���鶨�尴ť", "/FrameCase/widget/button/ExampleButtonArray.jsp","",1);
	tviTemp.insertPage(sFolder12,"Ӳ���밴ť", "/FrameCase/widget/button/ExampleButtonHardCoding.jsp","",2);
	String sFolder13=tviTemp.insertFolder(sFolder10,"TreeView","",3);
	tviTemp.insertPage(sFolder13,"SQL������ͼ", "/FrameCase/widget/treeview/ExampleView.jsp@ViewId=001","",1);
	tviTemp.insertPage(sFolder13,"����������ͼ", "/FrameCase/widget/treeview/ExampleView01.jsp@ViewId=001","",2);
	tviTemp.insertPage(sFolder13,"�ֹ�������ͼ", "/FrameCase/widget/treeview/ExampleView02.jsp@ViewId=001","",3);
	tviTemp.insertPage(sFolder13,"��ѡ��ͼ", "/FrameCase/widget/treeview/ExampleView04.jsp","",4);
	tviTemp.insertPage(sFolder13,"������ͼ", "/FrameCase/widget/treeview/ExampleMutilView.jsp","",5);
	String sFolder15=tviTemp.insertFolder(sFolder10,"Selector","",5);
	tviTemp.insertPage(sFolder15,"��ͼ/�б���ѡ���", "/FrameCase/widget/selector/ExampleSelect.jsp","",1);
	tviTemp.insertPage(sFolder15,"����ѡ��", "/FrameCase/widget/selector/ExampleCalendar.jsp","",3);
	
	String sFolder4=tviTemp.insertFolder("root","��ͼ���","",2);
	String sFolder7=tviTemp.insertFolder(sFolder4,"Main��ͼ","",4);
	tviTemp.insertPage(sFolder7,"һ��Main", "/FrameCase/Layout/ExampleMain01.jsp@ComponentName=һ��Main&ComponentType=MainWindow","",1);
	tviTemp.insertPage(sFolder7,"������������Main", "/FrameCase/Layout/ExampleMain02.jsp@ComponentName=������������Main&ComponentType=MainWindow","",2);
	tviTemp.insertPage(sFolder4,"��������", "/FrameCase/Layout/ExampleFrame01.jsp","",1);
	tviTemp.insertPage(sFolder4,"��������", "/FrameCase/Layout/ExampleFrame02.jsp","",2);
	tviTemp.insertPage(sFolder4,"���¡������л�", "/FrameCase/Layout/ExampleFrame01_02.jsp","",3);
	tviTemp.insertPage(sFolder4,"��������", "/FrameCase/Layout/ExampleFrame.jsp","",4);
	tviTemp.insertPage(sFolder4,"��������", "/FrameCase/Layout/ExampleFrame03.jsp","",5);
	tviTemp.insertPage(sFolder4,"Tab", "/FrameCase/Layout/ExampleTab.jsp","",6);
	tviTemp.insertPage(sFolder4,"Strip", "/FrameCase/Layout/ExampleStrip.jsp","",7);
	tviTemp.insertPage(sFolder4,"���ҳ����������Tab/Strip", "/FrameCase/Layout/ExampleTabStrip.jsp","",8);
	
	String sFolder1=tviTemp.insertFolder("root","���ݴ���(DataWindow)","",3);
	String sFolder2=tviTemp.insertFolder(sFolder1,"Listʾ��","",1);
	tviTemp.insertPage(sFolder2,"����List", "/FrameCase/widget/dw/ExampleList.jsp","",1);
	tviTemp.insertPage(sFolder2,"��ѡList", "/FrameCase/widget/dw/ExampleList02.jsp","",2);
	tviTemp.insertPage(sFolder2,"����List", "/FrameCase/widget/dw/ExampleList03.jsp","",3);
	tviTemp.insertPage(sFolder2,"�ɱ༭List", "/FrameCase/widget/dw/ExampleList05.jsp","",4);
	tviTemp.insertPage(sFolder2,"DW���ݹ�����", "/FrameCase/widget/dw/ExampleList08.jsp","",5);
	tviTemp.insertPage(sFolder2,"DW�����¼�", "/FrameCase/widget/dw/ExampleList04.jsp","",6);
	String sFolder3=tviTemp.insertFolder(sFolder1,"Infoʾ��","",2);
	tviTemp.insertPage(sFolder3,"����Info", "/FrameCase/widget/dw/ExampleInfo.jsp@ExampleId=2013012300000001","",1);
	tviTemp.insertPage(sFolder3,"����˫��Info", "/FrameCase/widget/dw/ExampleInfo01.jsp@ExampleId=2013012300000001","",2);
	tviTemp.insertPage(sFolder3,"InfoУ��", "/FrameCase/widget/dw/ExampleInfoWithValid.jsp","",3);
	tviTemp.insertPage(sFolder3,"js�ű�", "/FrameCase/widget/dw/ExampleSpecJS.jsp","",4);
	tviTemp.insertPage(sFolder3,"DW����У��", "/FrameCase/widget/dw/ExampleInfo03.jsp@ExampleId=2013012300000001","",5);
	tviTemp.insertPage(sFolder3,"DW�Զ��嵥Ԫ���¼�", "/FrameCase/widget/dw/ExampleInfo05.jsp@ExampleId=2013012300000001","",6);
	tviTemp.insertPage(sFolder3,"DWǰ��/�����¼�(����)", "/FrameCase/widget/dw/ExampleInfo04.jsp@ExampleId=2013012300000001","",7);
	
	String sFolder5 = tviTemp.insertFolder("root","���󴰿�(ObjectWindow)","",4);
	String sFolder51=tviTemp.insertFolder(sFolder5,"List��ʾ","",1);
	tviTemp.insertPage(sFolder51,"���б�[��������ͷ����]", "/FrameCase/widget/ow/DemoListSimple.jsp","",1);
	tviTemp.insertPage(sFolder51,"��ѡ�б�", "/FrameCase/widget/ow/DemoListMulty.jsp","",2);
	tviTemp.insertPage(sFolder51,"�༭�б�", "/FrameCase/widget/ow/DemoListEdit.jsp","",3);
	tviTemp.insertPage(sFolder51,"���ݵ���", "/FrameCase/widget/ow/DemoListExport.jsp","",4);
	tviTemp.insertPage(sFolder51,"����jbo manager��������", "/FrameCase/widget/ow/DemoListSimpleJBO.jsp","",5);
	tviTemp.insertPage(sFolder51,"����jbo query��������", "/FrameCase/widget/ow/DemoListSimpleJBO2.jsp","",5);
	tviTemp.insertPage(sFolder51,"��ͼ���jbo��������", "/FrameCase/widget/ow/DemoListSimpleJBO3.jsp","",6);
	tviTemp.insertPage(sFolder51,"�б���� С�ơ��ϼ�", "/FrameCase/widget/ow/DemoListCount.jsp","",7);
	tviTemp.insertPage(sFolder51,"�Զ����б���ʽ", "/FrameCase/widget/ow/DemoListRegular.jsp","",8);
	tviTemp.insertPage(sFolder51,"�Զ���HTML�¼�", "/FrameCase/widget/ow/DemoListEvent2.jsp","",9);
	tviTemp.insertPage(sFolder51,"����������������", "/FrameCase/widget/ow/DemoListSimpleArray.jsp","",10);
	tviTemp.insertPage(sFolder51,"�Զ���������Դ", "/FrameCase/widget/ow/DemoListCustomDataSource2.jsp","",11);
	tviTemp.insertPage(sFolder51,"�Զ��������˵�", "/FrameCase/widget/ow/DemoListDMenu.jsp","",12);
	tviTemp.insertPage(sFolder51,"ÿ�з��Զ��尴ť", "/FrameCase/widget/ow/DemoListWithAction.jsp","",13);
	tviTemp.insertPage(sFolder51,"�б��Զ����������", "/FrameCase/widget/ow/DemoCustomListFilter.jsp","",14);
	tviTemp.insertPage(sFolder51,"�б��Զ�����", "/FrameCase/widget/ow/DemoWizard.jsp","",15);
	tviTemp.insertPage(sFolder51,"json�Զ����ʽ������(List)", "/FrameCase/widget/ow/DemoListJSONDataSource.jsp","",15);
	tviTemp.insertPage(sFolder51,"�²�����ʽ", "/FrameCase/widget/ow/DemoList4Params.jsp","",16);
	tviTemp.insertPage(sFolder51,"�ֶ�����ͬ_list", "/FrameCase/widget/ow/DemoDupColumnList.jsp","",17);
	String sFolder52=tviTemp.insertFolder(sFolder5,"Info��ʾ","",2);
	tviTemp.insertPage(sFolder52,"��Info", "/FrameCase/widget/ow/DemoInfoSimple.jsp","",1);
	tviTemp.insertPage(sFolder52,"�Զ���HTML�¼�(Info)", "/FrameCase/widget/ow/DemoInfoEvent2.jsp","",2);
	tviTemp.insertPage(sFolder52,"�������", "/FrameCase/widget/ow/DemoInfoGroup.jsp","",3);
	tviTemp.insertPage(sFolder52,"���ڿؼ������Զ���", "/FrameCase/widget/ow/DemoInfoCalendarWidget.jsp","",4);
	tviTemp.insertPage(sFolder52,"����js�ű�", "/FrameCase/widget/ow/DemoInfoSpecJS.jsp","",5);
	tviTemp.insertPage(sFolder52,"ǰ��ͳһ�Զ���У��", "/FrameCase/widget/ow/DemoInfoCValid.jsp","",6);
	tviTemp.insertPage(sFolder52,"�Զ��������˵�(Info)", "/FrameCase/widget/ow/DemoInfoDMenu.jsp","",7);
	tviTemp.insertPage(sFolder52,"����ҳ��", "/FrameCase/widget/ow/DemoMultiPage.jsp","",8);
	tviTemp.insertPage(sFolder52,"���ǿؼ�", "/FrameCase/widget/ow/FiveStarMark.jsp","",9);
	tviTemp.insertPage(sFolder52,"�Զ����ʽ������(Info)", "/FrameCase/widget/ow/DemoInfoCustomDataSource.jsp","",10);
	tviTemp.insertPage(sFolder52,"json�Զ����ʽ������(Info)", "/FrameCase/widget/ow/DemoInfoJSONDataSource.jsp","",11);
	tviTemp.insertPage(sFolder52,"jbo������Դ(info)", "/FrameCase/widget/ow/DemoInfoJBODataSource.jsp","",12);
	tviTemp.insertPage(sFolder52,"12��ģʽInfo", "/FrameCase/widget/ow/DemoInfoMulticols.jsp","",13);
	tviTemp.insertPage(sFolder52,"�ֶ�����ͬ_info", "/FrameCase/widget/ow/DemoDupColumnInfo.jsp","",14);
	
	String sFolder6 = tviTemp.insertFolder("root","SWFͼ��","",5);
	tviTemp.insertPage(sFolder6,"bar", "/FrameCase/Chart/ChartData.jsp@GraphType=bar","",1);
	tviTemp.insertPage(sFolder6,"bar_stack", "/FrameCase/Chart/ChartData.jsp@GraphType=bar_stack","",2);
	tviTemp.insertPage(sFolder6,"hbar", "/FrameCase/Chart/ChartData.jsp@GraphType=hbar","",3);
	tviTemp.insertPage(sFolder6,"line", "/FrameCase/Chart/ChartData.jsp@GraphType=line","",4);
	tviTemp.insertPage(sFolder6,"area_hollow", "/FrameCase/Chart/ChartData.jsp@GraphType=area_hollow","",5);
	tviTemp.insertPage(sFolder6,"pie", "/FrameCase/Chart/ChartData.jsp@GraphType=pie","",6);
	tviTemp.insertPage(sFolder6,"Chart����д��", "/FrameCase/Chart/ChartDataFile.jsp@GraphType=bar","",7);
	tviTemp.insertPage(sFolder6,"�Ǳ���", "/FrameCase/Chart/CharDial.jsp@GraphType=bar","",8);
	tviTemp.insertPage(sFolder6,"DragNode", "/FrameCase/Chart/DragNodeData.jsp","",9);

	String sFolder8 = tviTemp.insertFolder("root", "�������", "", 6);
	String sFolder81 = tviTemp.insertFolder(sFolder8, "��ͼ", "", 1);
	tviTemp.insertPage(sFolder81, "��ͼ", "/FrameCase/widget/htmltree/ExampleHtmlTree.jsp@ClikItemNo=360821", "", 1);
	tviTemp.insertPage(sFolder81, "��ѡ��ͼ", "/FrameCase/widget/htmltree/ExampleHtmlTree.jsp@ClikItemNo=360821&SelectItemNo=120200,120115,360881", "", 2);
	tviTemp.insertPage(sFolder81, "��ѡ�ΰ���ͼ", "/FrameCase/widget/htmltree/ExampleHtmlTree2.jsp", "", 3);
	String sFolder82 = tviTemp.insertFolder(sFolder8, "ͼ��", "", 2);
	tviTemp.insertPage(sFolder82, "��׼��״ͼ", "/FrameCase/widget/echart/EChartsStandardBar.jsp", "", 1);
	tviTemp.insertPage(sFolder82, "�ѻ���״ͼ", "/FrameCase/widget/echart/EChartsStackBar.jsp", "", 2);
	tviTemp.insertPage(sFolder82, "��׼����ͼ", "/FrameCase/widget/echart/EChartsStripBar.jsp", "", 3);
	tviTemp.insertPage(sFolder82, "��������ͼ", "/FrameCase/widget/echart/EChartsNagativeBar.jsp", "", 4);
	tviTemp.insertPage(sFolder82, "��׼����ͼ", "/FrameCase/widget/echart/EChartsStandardLine.jsp", "", 5);
	tviTemp.insertPage(sFolder82, "��׼���ͼ", "/FrameCase/widget/echart/EChartsAreaLine.jsp", "", 6);
	tviTemp.insertPage(sFolder82, "��׼��ͼ", "/FrameCase/widget/echart/EChartsStandardPie.jsp", "", 7);

	tviTemp.insertPage("root", "��", "/FrameCase/Wizard/ApplyList.jsp", "", 7);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	<%/*treeview����ѡ���¼�;���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������*/%>
	function TreeViewOnClick(){
		var node = getCurTVItem();
		if(node.type == "folder") return false;
		
		var sValue = node.value;
		if(!sValue) return false;
		var target = "right";
		var sCurItemname = node.name;
		var navigation = sValue.split("@");
		if(!navigation[1]) navigation[1] = "";
		
		if(sCurItemname.indexOf("Main") > -1){
			target = "_self";
		}
		
		setTitle(sCurItemname);
		return AsControl.OpenView(navigation[0], navigation[1], target);
	}
	
	<%/*~[Describe=����treeview;InputParam=��;OutPutParam=��;]~*/%>
	function initTreeVeiw(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		expandNode(getNodeIDByName("���ݴ���(DataWindow)"));
		expandNode(getNodeIDByName("Listʾ��"));
		expandNode(getNodeIDByName("Infoʾ��"));
		//Ĭ�ϴ򿪵�(Ҷ��)ѡ��
		selectItemByName("����List");
		myleft.width = 250;
	}

	initTreeVeiw();
</script>
<%@ include file="/IncludeEnd.jsp"%>
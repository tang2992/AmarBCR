<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
/*
	ҳ��˵��:ϵͳ�ڽ���ģʽʾ����ҳ��
 */
	String PG_TITLE = "ϵͳ�ڽ���ģʽʾ��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;ϵͳ�ڽ���ģʽʾ��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//���ҳ�����	

	//����Treeview
	HTMLTreeView tviTemp = new OHTMLTreeView(SqlcaRepository,CurComp,sServletURL,"ϵͳ�ڽ���ģʽ","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	//������ͼ�ṹ
	String sFolder1=tviTemp.insertFolder("root","ҳ��������","",1);
	tviTemp.insertPage(sFolder1,"OpenViewʾ��","",1);
	tviTemp.insertPage(sFolder1,"OpenPageʾ��","",2);
	tviTemp.insertPage(sFolder1,"PopViewʾ��","",3);
	String sFolder2=tviTemp.insertFolder("root","�������˷�������","",2);
	tviTemp.insertPage(sFolder2,"RunJavaMethodʾ��","",1);
	tviTemp.insertPage(sFolder2,"RunJavaMethodSqlcaʾ��","",2);
	tviTemp.insertPage(sFolder2,"RunJavaMethodTransʾ��","",3);
	tviTemp.insertPage(sFolder2,"JavaMethodʾ��_Transaction����","",4);
	String sFolder3=tviTemp.insertFolder("root","���Ƽ�ʹ��","",3);
	tviTemp.insertPage(sFolder3,"OpenPageʾ��","",1);
	tviTemp.insertPage(sFolder3,"PopPageʾ��","",2);
	tviTemp.insertPage(sFolder3,"RunMethodʾ��","",3);
	tviTemp.insertPage(sFolder3,"PopPageAjaxʾ��","",4);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	
	<%/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/%>
	function TreeViewOnClick(){
		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������
		var sCurItemID = getCurTVItem().id;
		var sCurItemname = getCurTVItem().name;
		if(sCurItemname=='OpenViewʾ��'){
			var text = "AsControl.OpenView";
			AsControl.OpenView("/FrameCase/ExampleControl.jsp","ShowText="+text,"right");
		}else if(sCurItemname=='OpenPageʾ��'){
			var text = "AsControl.OpenPage";
			AsControl.OpenPage("/FrameCase/ExampleControl.jsp","ShowText="+text,"right");
		}else if(sCurItemname=='PopViewʾ��'){
			var text = "AsControl.PopView";
			AsControl.PopView("/FrameCase/ExampleControl.jsp","ShowText="+text,"");
		}else if(sCurItemname=='RunMethodʾ��'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=1","right","");
		}else if(sCurItemname=='RunJavaMethodʾ��'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=2","right","");
		}else if(sCurItemname=='RunJavaMethodSqlcaʾ��'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=3","right","");
		}else if(sCurItemname=='RunJavaMethodTransʾ��'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=4","right","");
		}else if(sCurItemname=='JavaMethodʾ��_Transaction����'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=5","right","");
		}else if(sCurItemname=='OpenPageʾ��'){
			var text = "OpenPage";
			OpenPage("/FrameCase/ExampleControl.jsp?ShowText="+text,"right","");
		}else if(sCurItemname=='PopPageʾ��'){
			var text = "PopPage";
			PopPage("/FrameCase/ExampleControl.jsp?ShowText="+text,"","");
		}else if(sCurItemname=='PopPageAjaxʾ��'){//PopPageAjax���Ƽ�ʹ��,����ȫ������RunJavaMethod�������������
			var text = "PopPageAjax";
			AsControl.OpenView("/FrameCase/ExampleControl.jsp","Flag=1&ShowText="+text,"right","");
		}else{
			return;
		}
		setTitle(getCurTVItem().name);
	}
	
	<%/*~[Describe=����treeview;InputParam=��;OutPutParam=��;]~*/%>
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("�������˷�������");
		selectItemByName("OpenViewʾ��");	//Ĭ�ϴ򿪵�(Ҷ��)ѡ��
	}

	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>
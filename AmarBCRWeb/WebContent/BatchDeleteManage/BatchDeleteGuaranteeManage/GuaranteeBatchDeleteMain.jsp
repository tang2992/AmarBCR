<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��:ʾ��ģ����ҳ��
	 */
	String PG_TITLE = "����ҵ����Ϣɾ����ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;����ҵ����Ϣɾ����ҳ��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//���ҳ�����

	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"����ҵ����Ϣɾ��","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	//������ͼ�ṹ
	String sFolder1=tviTemp.insertFolder("root","����ҵ����Ϣ����ɾ��","",1);
	tviTemp.insertPage(sFolder1,"δ�ϱ�����ɾ��","",1);
	tviTemp.insertPage(sFolder1,"���ϱ�����ɾ��","",2);
	tviTemp.insertPage(sFolder1,"����ɾ�����","",3);
	//tviTemp.insertPage(sFolder1,"��ɾ�����ϱ�","",4);
	//�������ֶ�����ͼ�ṹ�ķ�����SQL���ɺʹ�������   �μ�View������ ExampleView.jsp��ExampleView01.jsp
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	function TreeViewOnClick(){
		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������
		var sCurItemID = getCurTVItem().id;
		var sCurItemname = getCurTVItem().name;
		if(sCurItemname=='δ�ϱ�����ɾ��'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=UnDelete","right");
		}else if(sCurItemname=='���ϱ�����ɾ��'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=Deleted","right");
		}else if(sCurItemname=='����ɾ�����'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=Result","right");
		}else if(sCurItemname=='��ɾ�����ϱ�'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=NotReport","right");
		}else{
			return;
		}
		setTitle(getCurTVItem().name);
	}
	
	<%/*~[Describe=����treeview;]~*/%>
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("δ�ϱ�����ɾ��");	//Ĭ�ϴ򿪵�(Ҷ��)ѡ��	
	}
	
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>

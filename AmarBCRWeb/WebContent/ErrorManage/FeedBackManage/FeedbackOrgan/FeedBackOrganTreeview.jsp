<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	 String PG_TITLE = "������Ϣ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	 String PG_CONTENT_TITLE = "&nbsp;&nbsp;������Ϣ�б�&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	 String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	 String PG_LEFT_WIDTH = "280";//Ĭ�ϵ�treeview���
	%>
	
<%

	//�������
	//����������	
	//���ҳ�����	
   String sMAINBUSINESSNO=CurPage.getParameter("MAINBUSINESSNO");
 	 if(sMAINBUSINESSNO==null) sMAINBUSINESSNO="";
 	 String sCIFCustomerID=sMAINBUSINESSNO;
  
	String sRECORDTYPE = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("sRECORDTYPE"));
	if(sRECORDTYPE == null) sRECORDTYPE = "";

	String sSql1="";
	  String sFirstValue = sCIFCustomerID;
	
	ASResultSet rs = null;
		sSql1=" select CIFCustomerID,GETRORGANNAME(CIFCustomerID),LOANCARDNO from HIS_ORGANINFO  where CIFCustomerID='"+sCIFCustomerID+"' and SESSIONID='9999999999'" ;
	rs = Sqlca.getASResultSet(new SqlObject(sSql1));
	String sShowButton = "false";
	//��ʾУ����Ϣ��������Ϣ�ȵ�
	%>	
	<%@include file="/Resources/CodeParts/Table08.jsp"%>
	<%
	rs.getStatement().close();
	//table���� 1.���� 2.�������� 3.LISTģ���� 4.LISTģ��������
		String[][] sTableName = {
				{"HIS_ORGANATTRIBUTE","��������������Ϣ��"},
				{"HIS_ORGANSTATUS","����״̬��Ϣ��"},
				{"HIS_ORGANCONTACT","����������Ϣ��"},
				{"HIS_ORGANKEEPER","�����߹ܼ���Ҫ��ϵ�˱�"},
				{"HIS_ORGANSTOCKHOLDER","������Ҫ�ɶ���"},
				{"HIS_ORGANRELATED","������Ҫ������ҵ��"},
				{"HIS_ORGANSUPERIOR","�����ϼ�������"},
				{"HIS_ORGANFAMILY","���������Ա��"},
			  };    
	    
	    String[] sParameter =new String[8];//���崫�ݲ���

	    for(int i=0;i<sTableName.length;i++){    	
	    		sParameter[i]="sTable="+sTableName[i][0]+"&sFlag=Feedback&sCIFCustomerID="+sCIFCustomerID;
	    }
	    
    %>
	
	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"����������Ϣ��","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	tviTemp.insertPage("root","����������Ϣ��","",1);
	tviTemp.insertPage("root","��������������Ϣ��","",2);
	tviTemp.insertPage("root","����״̬��Ϣ��","",3);
	tviTemp.insertPage("root","����������Ϣ��","",4);
	tviTemp.insertPage("root","�����߹ܼ���Ҫ��ϵ�˱�","",5);
	tviTemp.insertPage("root","������Ҫ�ɶ���","",6);
	tviTemp.insertPage("root","������Ҫ������ҵ��","",7);
	tviTemp.insertPage("root","�����ϼ�������","",8);
	tviTemp.insertPage("root","���������Ա��","",9);
	%>

	<%@include file="/Resources/CodeParts/View04.jsp"%>

	<script language=javascript> 
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/

  function TreeViewOnClick(){
 		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������
		 var sCurItemname = getCurTVItem().name;
		var sCIFCustomerID = "<%=sCIFCustomerID%>";	

		if(sCurItemname == '����������Ϣ��'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sTable=HIS_ORGANINFO&sFlag=Feedback&sCIFCustomerID="+sCIFCustomerID,"right");
		}else if(sCurItemname == '��������������Ϣ��'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[0]%>","right");
		}else if(sCurItemname == '����״̬��Ϣ��'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[1]%>","right");
		}else if(sCurItemname == '����������Ϣ��'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[2]%>","right");
		}else if(sCurItemname == '�����߹ܼ���Ҫ��ϵ�˱�'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[3]%>","right");
		}
		else if(sCurItemname == '������Ҫ�ɶ���'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[4]%>","right");
		}
		else if(sCurItemname == '������Ҫ������ҵ��'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[5]%>","right");
		}
		else if(sCurItemname == '�����ϼ�������'){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[6]%>","right");
		}
		else {
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","<%=sParameter[7]%>","right");
		}
		setTitle(getCurTVItem().name);  
	}  
	/*~[Describe=����treeview;InputParam=��;OutPutParam=��;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
		
	 function closeAndReturn()
	 {
	     parent.reloadOpener();
	     parent.close();
	 }
	</script> 

	<script language="JavaScript">
	startMenu();
	expandNode('root');
	selectItem(1);
	selectItemByName("������Ϣ�б�"); 
	</script>
<%@ include file="/IncludeEnd.jsp"%>

<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		页面说明:示例模块主页面
	 */
	String PG_TITLE = "担保业务信息删除主页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;担保业务信息删除主页面&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度

	//获得页面参数

	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"担保业务信息删除","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	//定义树图结构
	String sFolder1=tviTemp.insertFolder("root","担保业务信息批量删除","",1);
	tviTemp.insertPage(sFolder1,"未上报批量删除","",1);
	tviTemp.insertPage(sFolder1,"已上报批量删除","",2);
	tviTemp.insertPage(sFolder1,"批量删除结果","",3);
	//tviTemp.insertPage(sFolder1,"批删后不再上报","",4);
	//另外两种定义树图结构的方法：SQL生成和代码生成   参见View的生成 ExampleView.jsp和ExampleView01.jsp
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	function TreeViewOnClick(){
		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数
		var sCurItemID = getCurTVItem().id;
		var sCurItemname = getCurTVItem().name;
		if(sCurItemname=='未上报批量删除'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=UnDelete","right");
		}else if(sCurItemname=='已上报批量删除'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=Deleted","right");
		}else if(sCurItemname=='批量删除结果'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=Result","right");
		}else if(sCurItemname=='批删后不再上报'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=NotReport","right");
		}else{
			return;
		}
		setTitle(getCurTVItem().name);
	}
	
	<%/*~[Describe=生成treeview;]~*/%>
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("未上报批量删除");	//默认打开的(叶子)选项	
	}
	
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>

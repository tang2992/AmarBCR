<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
/*
	页面说明:系统内交互模式示例主页面
 */
	String PG_TITLE = "系统内交互模式示例"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;系统内交互模式示例&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度

	//获得页面参数	

	//定义Treeview
	HTMLTreeView tviTemp = new OHTMLTreeView(SqlcaRepository,CurComp,sServletURL,"系统内交互模式","right");
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	//定义树图结构
	String sFolder1=tviTemp.insertFolder("root","页面流控制","",1);
	tviTemp.insertPage(sFolder1,"OpenView示例","",1);
	tviTemp.insertPage(sFolder1,"OpenPage示例","",2);
	tviTemp.insertPage(sFolder1,"PopView示例","",3);
	String sFolder2=tviTemp.insertFolder("root","服务器端方法调用","",2);
	tviTemp.insertPage(sFolder2,"RunJavaMethod示例","",1);
	tviTemp.insertPage(sFolder2,"RunJavaMethodSqlca示例","",2);
	tviTemp.insertPage(sFolder2,"RunJavaMethodTrans示例","",3);
	tviTemp.insertPage(sFolder2,"JavaMethod示例_Transaction混用","",4);
	String sFolder3=tviTemp.insertFolder("root","不推荐使用","",3);
	tviTemp.insertPage(sFolder3,"OpenPage示例","",1);
	tviTemp.insertPage(sFolder3,"PopPage示例","",2);
	tviTemp.insertPage(sFolder3,"RunMethod示例","",3);
	tviTemp.insertPage(sFolder3,"PopPageAjax示例","",4);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	
	<%/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/%>
	function TreeViewOnClick(){
		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数
		var sCurItemID = getCurTVItem().id;
		var sCurItemname = getCurTVItem().name;
		if(sCurItemname=='OpenView示例'){
			var text = "AsControl.OpenView";
			AsControl.OpenView("/FrameCase/ExampleControl.jsp","ShowText="+text,"right");
		}else if(sCurItemname=='OpenPage示例'){
			var text = "AsControl.OpenPage";
			AsControl.OpenPage("/FrameCase/ExampleControl.jsp","ShowText="+text,"right");
		}else if(sCurItemname=='PopView示例'){
			var text = "AsControl.PopView";
			AsControl.PopView("/FrameCase/ExampleControl.jsp","ShowText="+text,"");
		}else if(sCurItemname=='RunMethod示例'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=1","right","");
		}else if(sCurItemname=='RunJavaMethod示例'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=2","right","");
		}else if(sCurItemname=='RunJavaMethodSqlca示例'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=3","right","");
		}else if(sCurItemname=='RunJavaMethodTrans示例'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=4","right","");
		}else if(sCurItemname=='JavaMethod示例_Transaction混用'){
			AsControl.OpenView("/FrameCase/ExampleMethod.jsp","Flag=5","right","");
		}else if(sCurItemname=='OpenPage示例'){
			var text = "OpenPage";
			OpenPage("/FrameCase/ExampleControl.jsp?ShowText="+text,"right","");
		}else if(sCurItemname=='PopPage示例'){
			var text = "PopPage";
			PopPage("/FrameCase/ExampleControl.jsp?ShowText="+text,"","");
		}else if(sCurItemname=='PopPageAjax示例'){//PopPageAjax不推荐使用,它完全可以用RunJavaMethod等三个方法替代
			var text = "PopPageAjax";
			AsControl.OpenView("/FrameCase/ExampleControl.jsp","Flag=1&ShowText="+text,"right","");
		}else{
			return;
		}
		setTitle(getCurTVItem().name);
	}
	
	<%/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/%>
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("服务器端方法调用");
		selectItemByName("OpenView示例");	//默认打开的(叶子)选项
	}

	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>
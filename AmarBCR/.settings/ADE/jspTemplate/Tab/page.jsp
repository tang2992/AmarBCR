<%@ page contentType="text/html; charset=GBK"%><%@
include file="/IncludeBegin.jsp"%><%
 	/*
        Author: #{author} #{createddate}
        Content: ͨ�����鶨������Tab���ҳ��ʾ��
        History Log: 
    */
	//����tab���飺
	//������0.�Ƿ���ʾ, 1.���⣬2.URL��3��������
	String sTabStrip[][] = {
		{"true", "List", "/FrameCase/ExampleList.jsp", ""},
		{"true", "Info", "/FrameCase/ExampleInfo.jsp", "ExampleId=2013012300000001"},
		{"true", "Tab", "/FrameCase/ExampleTab.jsp", ""},
		{"true", "Blank", "/Blank.jsp", ""},
	};
%><%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>
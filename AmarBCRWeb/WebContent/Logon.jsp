<%@page contentType="text/html; charset=GBK"%><%@
page import="com.amarsoft.are.util.*"%><%@
page import="com.amarsoft.awe.util.*"%><%@
page import="com.amarsoft.context.*"%><%@
page import="com.amarsoft.web.*"%><%@
page import="com.amarsoft.web.dw.*"%><%@
page import="com.amarsoft.awe.*"%><%@
page import="com.amarsoft.awe.control.SessionListener"%><%@
page import="com.amarsoft.awe.control.model.*"%><%@
page import="com.amarsoft.awe.util.*"%><%@
page import="com.amarsoft.awe.Configure"%><%@
page import="com.amarsoft.awe.security.*"%><%@
page import="com.amarsoft.awe.security.pwdrule.*"%><%!
//检验验证码
public boolean vaildCheckCode(HttpServletRequest request) {
	String sCheckCode = request.getParameter("CheckCode");
	String sSaveCheckCode = (String)request.getSession().getAttribute("CheckCode");
	if (sSaveCheckCode==null || sCheckCode==null) return true;
	else if (sCheckCode.equalsIgnoreCase(sSaveCheckCode)) return true;
	else return false;
}

//用户登录检查与密码验证性检查
public boolean validUserPassword(HttpServletRequest request, Transaction Sqlca,String sUserID,String sPWD) throws Exception {
    String userName = Sqlca.getString(new SqlObject("select userName from USER_INFO where userid=:userid").setParameter("userid", sUserID));
    LogonUser user = new LogonUser(userName, sUserID, sPWD);
	SecurityAudit securityAudit = new SecurityAudit(user);
	String requestMessage = request.getRemoteAddr() + "," + request.getRemoteAddr() + "," + request.getServerName() + "," + request.getServerPort();//将request请求信息拼接一下，传进去
	if(securityAudit.isLogonSuccessful(Sqlca, null, requestMessage)){//目前这步不需要别的登录验证
		//登录成功，还需进一步进行密码验证
		PasswordRuleManager pwm = new PasswordRuleManager();
		IsPasswordOverdueRule isPWDOverdueRule = new IsPasswordOverdueRule(sUserID, SecurityOptionManager.getPWDLimitDays(Sqlca), Sqlca);//该规则只是验证性规则，不是登录成功失败的必要条件
		ALSPWDRules alsRules = new ALSPWDRules(SecurityOptionManager.getRules(Sqlca));
		pwm.addRule(isPWDOverdueRule);//该规则比ALSPWDRules更重要，先添加进去
		pwm.addRule(alsRules);
		securityAudit.isValidateSuccessful(Sqlca, pwm);
		return true;
	}
	else return false;
}
%><%
	if (!vaildCheckCode(request)) {
	%><script type="text/javascript">
		alert("登录失败,验证码检验错误。");
		window.open("index.html","_top");
	</script><%
	return;
	}

	java.util.Enumeration<String> attrs = session.getAttributeNames();
	while (attrs.hasMoreElements()) {session.removeAttribute(attrs.nextElement());}

	if (!session.isNew()) {
		session.invalidate();
		session = request.getSession();
	}

	Transaction Sqlca = null;
	try {
		//获得传入的参数：用户登录账号、口令、界面风格
		String sUserID = request.getParameter("UserID");
		String sPWD = request.getParameter("Password");
		String sScreenWidth = request.getParameter("ScreenWidth");

		//下拉选框用户快速登陆，系统正式运行后可删除
		String sUserIDSelected = "";
		if (sUserID == null || sUserID.equals("")) {
			sUserIDSelected = request.getParameter("UserIDSelected");
			sUserID = sUserIDSelected;
		}

		Configure CurConfig = Configure.getInstance(application);
		CurConfig.setContextPath(request.getContextPath());
		Sqlca = new Transaction(CurConfig.getConfigure("DataSource"));
		if (!validUserPassword(request, Sqlca, sUserID, sPWD)) throw new Exception("用户["+sUserID+"]登录失败:用户密码检验失败");
		Sqlca.commit();
		
		//取当前用户和机构，并将其放入 Session
		ASUser CurUser = ASUser.getUser(SpecialTools.real2Amarsoft(sUserID),Sqlca);

		//设置运行上下文参数 CurARC　在IncludeBegin.jsp中使用
		RuntimeContext CurARC = new RuntimeContext();
		CurARC.setAttribute("ScreenWidth",sScreenWidth);
		CurARC.setUser(CurUser);
		CurARC.setPref(new ASPreference(CurUser.getUserID()));
		CurARC.setCompSession(new ComponentSession());

		session.setAttribute("CurARC",CurARC);

		//用户登陆成功，记录登陆信息
	    SessionListener sessionListener=new SessionListener(request,session,CurUser,CurConfig.getConfigure("DataSource"));
	    session.setAttribute("listener",sessionListener);
%><script type="text/javascript">
<%
		String sPWDState =  new UserMarkInfo(Sqlca,CurUser.getUserID()).getPasswordState();
		/* 正式使用时请将代码启用密码状态校验 */
		//if(sPWDState.equals(String.valueOf(SecurityAuditConstants.CODE_USER_FIRST_LOGON)) || sPWDState.equals(String.valueOf(SecurityAuditConstants.CODE_PWD_OVERDUE))){
		if(false){
%>
			window.open("<%=CurConfig.getContextPath() %>/Redirector?ComponentURL=/AppMain/ModifyPassword.jsp","_top");
<%
		}else{
%>
			window.open("<%=CurConfig.getContextPath() %>/Redirector?ComponentURL=/Main.jsp","_top");
<%	  
		}
%></script>
<%
	} catch (Exception e) {
		e.printStackTrace();
		e.fillInStackTrace();
		e.printStackTrace(new java.io.PrintWriter(System.out));
%>
		<script type="text/javascript">
			alert("登录失败,请检查用户名和密码是否输入正确！\n如果您忘记了密码，请与系统管理员联系，恢复初始密码。");
			window.open("index.html","_top");
		</script>			
<%
		return;
	} finally {
		if(Sqlca!=null) {
			//断掉当前数据连接
			Sqlca.commit();
			Sqlca.disConnect();
			Sqlca = null;
		}
	}
%>
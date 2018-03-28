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
//������֤��
public boolean vaildCheckCode(HttpServletRequest request) {
	String sCheckCode = request.getParameter("CheckCode");
	String sSaveCheckCode = (String)request.getSession().getAttribute("CheckCode");
	if (sSaveCheckCode==null || sCheckCode==null) return true;
	else if (sCheckCode.equalsIgnoreCase(sSaveCheckCode)) return true;
	else return false;
}

//�û���¼�����������֤�Լ��
public boolean validUserPassword(HttpServletRequest request, Transaction Sqlca,String sUserID,String sPWD) throws Exception {
    String userName = Sqlca.getString(new SqlObject("select userName from USER_INFO where userid=:userid").setParameter("userid", sUserID));
    LogonUser user = new LogonUser(userName, sUserID, sPWD);
	SecurityAudit securityAudit = new SecurityAudit(user);
	String requestMessage = request.getRemoteAddr() + "," + request.getRemoteAddr() + "," + request.getServerName() + "," + request.getServerPort();//��request������Ϣƴ��һ�£�����ȥ
	if(securityAudit.isLogonSuccessful(Sqlca, null, requestMessage)){//Ŀǰ�ⲽ����Ҫ��ĵ�¼��֤
		//��¼�ɹ��������һ������������֤
		PasswordRuleManager pwm = new PasswordRuleManager();
		IsPasswordOverdueRule isPWDOverdueRule = new IsPasswordOverdueRule(sUserID, SecurityOptionManager.getPWDLimitDays(Sqlca), Sqlca);//�ù���ֻ����֤�Թ��򣬲��ǵ�¼�ɹ�ʧ�ܵı�Ҫ����
		ALSPWDRules alsRules = new ALSPWDRules(SecurityOptionManager.getRules(Sqlca));
		pwm.addRule(isPWDOverdueRule);//�ù����ALSPWDRules����Ҫ������ӽ�ȥ
		pwm.addRule(alsRules);
		securityAudit.isValidateSuccessful(Sqlca, pwm);
		return true;
	}
	else return false;
}
%><%
	if (!vaildCheckCode(request)) {
	%><script type="text/javascript">
		alert("��¼ʧ��,��֤��������");
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
		//��ô���Ĳ������û���¼�˺š����������
		String sUserID = request.getParameter("UserID");
		String sPWD = request.getParameter("Password");
		String sScreenWidth = request.getParameter("ScreenWidth");

		//����ѡ���û����ٵ�½��ϵͳ��ʽ���к��ɾ��
		String sUserIDSelected = "";
		if (sUserID == null || sUserID.equals("")) {
			sUserIDSelected = request.getParameter("UserIDSelected");
			sUserID = sUserIDSelected;
		}

		Configure CurConfig = Configure.getInstance(application);
		CurConfig.setContextPath(request.getContextPath());
		Sqlca = new Transaction(CurConfig.getConfigure("DataSource"));
		if (!validUserPassword(request, Sqlca, sUserID, sPWD)) throw new Exception("�û�["+sUserID+"]��¼ʧ��:�û��������ʧ��");
		Sqlca.commit();
		
		//ȡ��ǰ�û��ͻ�������������� Session
		ASUser CurUser = ASUser.getUser(SpecialTools.real2Amarsoft(sUserID),Sqlca);

		//�������������Ĳ��� CurARC����IncludeBegin.jsp��ʹ��
		RuntimeContext CurARC = new RuntimeContext();
		CurARC.setAttribute("ScreenWidth",sScreenWidth);
		CurARC.setUser(CurUser);
		CurARC.setPref(new ASPreference(CurUser.getUserID()));
		CurARC.setCompSession(new ComponentSession());

		session.setAttribute("CurARC",CurARC);

		//�û���½�ɹ�����¼��½��Ϣ
	    SessionListener sessionListener=new SessionListener(request,session,CurUser,CurConfig.getConfigure("DataSource"));
	    session.setAttribute("listener",sessionListener);
%><script type="text/javascript">
<%
		String sPWDState =  new UserMarkInfo(Sqlca,CurUser.getUserID()).getPasswordState();
		/* ��ʽʹ��ʱ�뽫������������״̬У�� */
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
			alert("��¼ʧ��,�����û����������Ƿ�������ȷ��\n��������������룬����ϵͳ����Ա��ϵ���ָ���ʼ���롣");
			window.open("index.html","_top");
		</script>			
<%
		return;
	} finally {
		if(Sqlca!=null) {
			//�ϵ���ǰ��������
			Sqlca.commit();
			Sqlca.disConnect();
			Sqlca = null;
		}
	}
%>
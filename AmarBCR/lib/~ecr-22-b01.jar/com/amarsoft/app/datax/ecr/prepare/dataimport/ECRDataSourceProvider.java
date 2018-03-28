// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ECRDataSourceProvider.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.*;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.metadata.ColumnMetaData;
import com.amarsoft.are.metadata.TableMetaData;
import java.sql.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ECRDataSourceProvider extends DefaultDataSourceProvider
{

	public static final int FP_8D855E38622A53D6 = 1;
	public static final int FP_8EAB4EFD8BC18F6C6362 = 2;
	public static final int FP_65705B57516889D28F6C534A89D2 = 4;
	public static final int FP_63A752365B577B268FC76EE4 = 8;
	private int weight[] = {
		7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 
		7, 9, 10, 5, 8, 4, 2, 1
	};
	private char vcode[] = {
		'1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', 
		'2'
	};
	private String hzDigital;
	private Pattern dpattern;
	private int fieldsProcess[][];
	private boolean fixGuarantyFlag;
	private boolean fixKind;
	private boolean fixAvailabBalance;
	private boolean fixBalanceChangeDate;
	private Connection connection;
	private PreparedStatement pstmtGuarantyCount;
	private PreparedStatement pstmtSelectECR_LoanDueBill;
	private PreparedStatement pstmtSelectECR_FINADUEBILL;
	private String mainContractNoField;
	private String businessType;
	private String upTable;
	Log logger;

	public ECRDataSourceProvider()
	{
		hzDigital = "([１一壹])|([２二贰])|([３三叁])|([４四肆])|([５五伍])|([６六陆])|([７七柒])|([８八捌])|([９九玖])|([０〇零])";
		dpattern = Pattern.compile(hzDigital);
		fieldsProcess = null;
		fixGuarantyFlag = false;
		fixKind = false;
		fixAvailabBalance = false;
		fixBalanceChangeDate = false;
		connection = null;
		pstmtGuarantyCount = null;
		pstmtSelectECR_LoanDueBill = null;
		pstmtSelectECR_FINADUEBILL = null;
		mainContractNoField = null;
		businessType = null;
		upTable = "";
		logger = ARE.getLog();
	}

	public void open(RecordSet recordSet)
		throws RecordSetException
	{
		super.open(recordSet);
		Record r = recordSet.getRecordTemplet();
		Field flds[] = r.getFields();
		fieldsProcess = new int[flds.length][2];
		for (int i = 0; i < flds.length; i++)
			if (flds[i].getType() == 0)
			{
				ColumnMetaData cm = flds[i].getMetaData();
				if (cm != null)
				{
					fieldsProcess[i][0] = fieldsProcess[i][0] | 1;
					fieldsProcess[i][1] = cm.getPrecision();
					String fp = cm.getProperty("isCertNo");
					if (StringX.parseBoolean(fp))
						fieldsProcess[i][0] = fieldsProcess[i][0] | 2;
					fp = cm.getProperty("pureDigital");
					if (StringX.parseBoolean(fp))
						fieldsProcess[i][0] = fieldsProcess[i][0] | 4;
					fp = cm.getProperty("filterControlChar");
					if (StringX.parseBoolean(fp))
						fieldsProcess[i][0] = fieldsProcess[i][0] | 8;
				}
			}

		String table = recordSet.getMetaData().getName();
		if (table.equalsIgnoreCase("ECR_LOANCONTRACT"))
		{
			mainContractNoField = "LContractNo";
			businessType = "1";
			fixGuarantyFlag = true;
			fixAvailabBalance = true;
		}
		if (table.equalsIgnoreCase("ECR_FACTORING"))
		{
			mainContractNoField = "FactoringNo";
			businessType = "2";
			fixGuarantyFlag = true;
		}
		if (table.equalsIgnoreCase("ECR_FINAINFO"))
		{
			mainContractNoField = "FContractNo";
			businessType = "4";
			fixGuarantyFlag = true;
			fixAvailabBalance = true;
		}
		if (table.equalsIgnoreCase("ECR_GUARANTEEBILL"))
		{
			mainContractNoField = "GuaranteeBillNo";
			businessType = "6";
			fixGuarantyFlag = true;
		}
		if (table.equalsIgnoreCase("ECR_CREDITLETTER"))
		{
			mainContractNoField = "CreditLetterNo";
			businessType = "5";
			fixGuarantyFlag = true;
		}
		if (table.equalsIgnoreCase("ECR_ACCEPTANCE"))
		{
			mainContractNoField = "AcceptNo";
			businessType = "7";
			fixGuarantyFlag = true;
		}
		if (table.equalsIgnoreCase("ECR_LOANDUEBILL"))
			fixKind = true;
		if (table.equalsIgnoreCase("ECR_FACTORING"))
		{
			fixBalanceChangeDate = true;
			upTable = "ECR_FACTORING";
		}
		if (table.equalsIgnoreCase("ECR_CREDITLETTER"))
		{
			fixBalanceChangeDate = true;
			upTable = "ECR_CREDITLETTER";
		}
		if (table.equalsIgnoreCase("ECR_GUARANTEEBILL"))
		{
			fixBalanceChangeDate = true;
			upTable = "ECR_GUARANTEEBILL";
		}
		if (table.equalsIgnoreCase("ECR_FLOORFUND"))
		{
			fixBalanceChangeDate = true;
			upTable = "ECR_FLOORFUND";
		}
	}

	protected void fillRecord()
		throws SQLException
	{
		super.fillRecord();
		for (int i = 0; i < fieldsProcess.length; i++)
			if (fieldsProcess[i][0] >= 1)
			{
				Field f = currentRecord.fieldAt(i);
				if (f != null)
				{
					String v = f.getString();
					if (v != null)
					{
						if ((fieldsProcess[i][0] & 8) > 0)
							v = filterControlChar(v);
						if ((fieldsProcess[i][0] & 4) > 0)
							v = fixDigital(v);
						if ((fieldsProcess[i][0] & 2) > 0)
							v = fixPID(v);
						if ((fieldsProcess[i][0] & 1) > 0)
							v = truncateLength(v, fieldsProcess[i][1]);
						f.setValue(v);
					}
				}
			}

		if (fixGuarantyFlag)
		{
			String mainContractNo = currentRecord.getField(mainContractNoField).getString();
			currentRecord.getField("GUARANTYFLAG").setValue(getGuarantyFlag(mainContractNo, businessType));
		}
		if (fixKind)
		{
			String putOutDate = currentRecord.getField("PUTOUTDATE").getString();
			String putOutEndDate = currentRecord.getField("PUTOUTENDDATE").getString();
			String kind = currentRecord.getField("Kind").getString();
			if (kind != null && kind.length() > 0)
				return;
			if (putOutDate != null && putOutEndDate != null && putOutDate.length() == 10 && putOutEndDate.length() == 10)
			{
				int month = Tools.betweenMonths(putOutDate, putOutEndDate);
				if (month <= 12)
					kind = "10";
				else
				if (month > 12 && month <= 60)
					kind = "20";
				else
					kind = "30";
			} else
			{
				kind = "10";
			}
			currentRecord.getField("KIND").setValue(kind);
		}
		if (fixAvailabBalance)
		{
			String ContractNo = currentRecord.getField(mainContractNoField).getString();
			double businessSum = currentRecord.getField("BUSINESSSUM").getDouble();
			String recycle = currentRecord.getField("RECYCLE").getString();
			double availabBalance = getAvailabBalance(mainContractNoField, ContractNo, businessSum, recycle);
			currentRecord.getField("AVAILABBALANCE").setValue(availabBalance);
		}
		if (fixBalanceChangeDate)
			currentRecord.getField("RECORDFLAG").setValue(upTable);
	}

	private double getAvailabBalance(String fieldName, String contractNo, double businessSum, String recycle)
		throws SQLException
	{
		double availabBalance = 0.0D;
		double putoutAmount = 0.0D;
		double balance = 0.0D;
		ResultSet rs = null;
		if (fieldName != null && fieldName.equalsIgnoreCase("LCONTRACTNO"))
		{
			if (pstmtSelectECR_LoanDueBill == null)
			{
				String sql = "Select Sum(PutOutAmount) as PutOutAmount,Sum(Balance) as Balance FROM ECR_LOANDUEBILL where LCONTRACTNO=?";
				pstmtSelectECR_LoanDueBill = connection.prepareStatement(sql);
				logger.debug((new StringBuilder("获取合同可用余额:")).append(sql).toString());
			}
			pstmtSelectECR_LoanDueBill.setString(1, contractNo);
			rs = pstmtSelectECR_LoanDueBill.executeQuery();
		} else
		{
			if (pstmtSelectECR_FINADUEBILL == null)
			{
				String sql = "Select Sum(PutOutAmount) as PutOutAmount,Sum(Balance) as Balance FROM ECR_FINADUEBILL where FCONTRACTNO=?";
				pstmtSelectECR_FINADUEBILL = connection.prepareStatement(sql);
				logger.debug((new StringBuilder("获取贸易融资可用余额:")).append(sql).toString());
			}
			pstmtSelectECR_FINADUEBILL.setString(1, contractNo);
			rs = pstmtSelectECR_FINADUEBILL.executeQuery();
		}
		if (rs.next())
		{
			putoutAmount = rs.getDouble("PutOutAmount");
			balance = rs.getDouble("Balance");
		}
		rs.close();
		if (recycle != null && recycle.equals("1"))
			availabBalance = businessSum - balance;
		else
			availabBalance = businessSum - putoutAmount;
		if (availabBalance < 0.0D)
			availabBalance = 0.0D;
		return availabBalance;
	}

	protected String filterControlChar(String str)
	{
		return str.replaceAll("\\p{Cntrl}", "");
	}

	protected String fixDigital(String str)
	{
		Matcher m = dpattern.matcher(str);
		StringBuffer sb = new StringBuffer();
		int g;
		for (; m.find(); m.appendReplacement(sb, String.valueOf(g % 10)))
		{
			g = 0;
			for (int i = 1; i <= 10; i++)
			{
				if (m.group(i) == null)
					continue;
				g = i;
				break;
			}

		}

		m.appendTail(sb);
		return sb.toString();
	}

	protected String truncateLength(String str, int bytes)
	{
		byte b[] = str.getBytes();
		if (b.length <= bytes)
			return str;
		byte nb[] = new byte[bytes];
		System.arraycopy(b, 0, nb, 0, bytes);
		int halfHZ = 0;
		for (int i = nb.length - 1; i >= 0; i--)
		{
			if (nb[i] >= 0)
				break;
			halfHZ++;
		}

		return halfHZ % 2 != 0 ? new String(nb, 0, nb.length - 1) : new String(nb);
	}

	protected String fixPID(String str)
	{
		String s = filterControlChar(str);
		String ID15 = fixDigital(s);
		if (ID15.length() != 15)
			return ID15.toUpperCase();
		StringBuffer ID18 = new StringBuffer(ID15);
		ID18.insert(6, "19");
		int vsum = 0;
		for (int i = 0; i < 17; i++)
			vsum += Character.digit(ID18.charAt(i), 10) * weight[i];

		ID18.append(vcode[vsum % 11]);
		return ID18.toString();
	}

	protected String getGuarantyFlag(String Contractno, String businessType)
		throws SQLException
	{
		int gcount = 0;
		if (connection == null)
			connection = ARE.getDBConnection("ecr");
		if (pstmtGuarantyCount == null)
		{
			String sql = (new StringBuilder(" select count(Contractno) as GuarantyCount from ECR_ASSURECONT where Contractno= ?  and AvailabStatus='1' and BusinessType='")).append(businessType).append("'").append(" union select count(Contractno) as GuarantyCount from ECR_GUARANTYCONT where Contractno= ? and AvailabStatus='1' and BusinessType='").append(businessType).append("'").append(" union select count(Contractno) as GuarantyCount from ECR_IMPAWNCONT where Contractno= ? and AvailabStatus='1' and BusinessType='").append(businessType).append("'").toString();
			logger.debug((new StringBuilder("获取担保个数：")).append(sql).toString());
			pstmtGuarantyCount = connection.prepareStatement(sql);
		}
		pstmtGuarantyCount.setString(1, Contractno);
		pstmtGuarantyCount.setString(2, Contractno);
		pstmtGuarantyCount.setString(3, Contractno);
		ResultSet rs;
		for (rs = pstmtGuarantyCount.executeQuery(); rs.next();)
			gcount += rs.getInt(1);

		rs.close();
		return gcount <= 0 ? "2" : "1";
	}

	public void close()
		throws RecordSetException
	{
		if (pstmtSelectECR_LoanDueBill != null)
		{
			try
			{
				pstmtSelectECR_LoanDueBill.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtSelectECR_LoanDueBill = null;
		}
		if (pstmtSelectECR_FINADUEBILL != null)
		{
			try
			{
				pstmtSelectECR_FINADUEBILL.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtSelectECR_FINADUEBILL = null;
		}
		if (pstmtGuarantyCount != null)
		{
			try
			{
				pstmtGuarantyCount.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtGuarantyCount = null;
		}
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			connection = null;
		}
		super.close();
	}
}

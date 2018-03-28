package com.amarsoft.app.datax.bcr.prepare.dataimport;

import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.*;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.metadata.ColumnMetaData;
import java.sql.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BCRDataSourceProvider extends DefaultDataSourceProvider
{

	public static final int FP_超常截取 = 1;
	public static final int FP_身份证转换 = 2;
	public static final int FP_数字全角转半角 = 4;
	public static final int FP_控制字符过滤 = 8;
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
	private boolean fixBalanceChangeDate;
	private Connection connection;
	private PreparedStatement pstmtGuarantyCount;
	private PreparedStatement pstmtSelectECR_LoanDueBill;
	private PreparedStatement pstmtSelectECR_FINADUEBILL;
	private String upTable;
	Log logger;

	public BCRDataSourceProvider()
	{
		hzDigital = "([１一壹])|([２二贰])|([３三叁])|([４四肆])|([５五伍])|([６六陆])|([７七柒])|([８八捌])|([９九玖])|([０〇零])";
		dpattern = Pattern.compile(hzDigital);
		fieldsProcess = null;
		fixBalanceChangeDate = false;
		connection = null;
		pstmtGuarantyCount = null;
		pstmtSelectECR_LoanDueBill = null;
		pstmtSelectECR_FINADUEBILL = null;
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
		
		if (table.equalsIgnoreCase("BCR_GUARANTEEDUTY"))
		{
			fixBalanceChangeDate = true;
			upTable = "BCR_GUARANTEEDUTY";
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
		
		if (fixBalanceChangeDate)
			currentRecord.getField("RECORDFLAG").setValue(upTable);
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

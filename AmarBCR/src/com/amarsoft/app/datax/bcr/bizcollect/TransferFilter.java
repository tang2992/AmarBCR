package com.amarsoft.app.datax.bcr.bizcollect;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;
import java.util.*;

public class TransferFilter
	implements RecordFilter
{

	public static final String FILTER_CAUSE_ERROR = "E";
	public static final String FILTER_CAUSE_FEEDBACK = "F";
	public static final String FILTER_CAUSE_HISTORY = "H";
	public static final String FILTER_CAUSE_OTHER = "O";
	public static final int RECORD_ALL = 0;
	public static final int RECORD_BUSINESS = 27;
	public static final int RECORD_CUSTOMER = 28;
	private String database;
	private Set recordFilter[];
	private Set organInfoSet;
	private Set organFamilySet;

	public TransferFilter()
	{
		database = "bcr";
		recordFilter = new TreeSet[52];
		organInfoSet = new TreeSet();
		organFamilySet = new TreeSet();
	}

	public void init()
		    throws BCRException
		  {
		    Connection conn = null;
		    try
		    {
		      conn = ARE.getDBConnection(this.database);
		      Statement stmt = conn.createStatement();
		      ResultSet rs = stmt.executeQuery("select MainBusinessNo,RecordScope,FilterCause from ECR_TRANSFERFILTER");
		      while (rs.next()) {
		        String mb = rs.getString("MainBusinessNo");
		        String rt = rs.getString("RecordScope");
		        addFilter(rt, mb);
		      }
		      rs.close();
		      stmt.close();

		      if (!(ARE.getLog().isTraceEnabled())){
		    	  StringBuffer sb = new StringBuffer();
			      for (int i = 0; i < this.recordFilter.length; ++i) {
			        sb.append("RecordType=").append(i).append(",");
			        sb.append("FilterBusinessNo=");
			        if (this.recordFilter[i] == null) {
			          sb.append("");
			        } else {
			          Iterator it = this.recordFilter[i].iterator();
			          for (; it.hasNext(); sb.append(it.next()).append("|"));
			        }
			        sb.append("\n");
			      }
			      ARE.getLog().trace(sb);
		      }		      
		    }
		    catch (SQLException e) {
		      throw new BCRException("³õÊ¼»¯¹ýÂËÆ÷Ê§°Ü", e);
		    } finally {
		      if (conn != null)
		        try {
		          conn.close();
		        } catch (SQLException e) {
		          ARE.getLog().debug(e);
		        }
		    }
		  }

	public boolean accept(Message message, Record record)
	{
		return !containts(record.getType(), record.getMainBusinessNo());
	}

	public void close()
	{
	}

	private void addFilter(String recScope, String bizNo)
	{
		if (recScope == null)
			return;
		int a = recScope.indexOf("A");
		int b = recScope.indexOf("B");
		int c = recScope.indexOf("C");
		if (a >= 0 || b >= 0 && c >= 0)
		{
			addFilter(0, bizNo);
			return;
		}
		if (b >= 0)
			addFilter(27, bizNo);
		if (c >= 0)
			addFilter(28, bizNo);
		if ("O".equals(recScope) && !organInfoSet.contains(bizNo))
			organInfoSet.add(bizNo);
		else
		if ("F".equals(recScope) && !organFamilySet.contains(bizNo))
			organFamilySet.add(bizNo);
		String rec[] = recScope.split(",");
		if (rec.length < 1)
			return;
		for (int i = 0; i < rec.length; i++)
		{
			String r = rec[i].replaceAll("\\s", "");
			if (!r.equals("A") && !r.equals("B") && !r.equals("C") && !r.equals("O") && !r.equals("F"))
			{
				int i_ = r.indexOf("-");
				if (i_ <= 0 || i_ == r.length() - 1)
					try
					{
						int ri = Integer.parseInt(r);
						addFilter(ri, bizNo);
					}
					catch (NumberFormatException e)
					{
						ARE.getLog().debug(e);
					}
				else
					try
					{
						int s = Integer.parseInt(r.substring(0, i_));
						int e = Integer.parseInt(r.substring(i_ + 1));
						if (s >= e)
						{
							int m = s;
							s = e;
							e = m;
						}
						for (int rt = s; rt <= e; rt++)
							addFilter(rt, bizNo);

					}
					catch (NumberFormatException e)
					{
						ARE.getLog().debug(e);
					}
			}
		}

	}

	private void addFilter(int recType, String bizNo)
	{
		if (recType < 0 || recType > recordFilter.length)
			return;
		if (recordFilter[recType] == null)
			recordFilter[recType] = new TreeSet();
		if (containts(recType, bizNo))
		{
			return;
		} else
		{
			recordFilter[recType].add(bizNo);
			return;
		}
	}

	private boolean containts(int recType, String bizNo)
	{
		if (recType == 71 || recType == 72)
		{
			if (recType == 71 && organInfoSet.contains(bizNo) || recType == 72 && organFamilySet.contains(bizNo))
				return true;
			return recordFilter[0] != null && recordFilter[0].contains(bizNo);
		}
		if (recType < 0 || recType > recordFilter.length)
			return false;
		if (recordFilter[recType] != null && recordFilter[recType].contains(bizNo))
			return true;
		if (recordFilter[0] != null && recordFilter[0].contains(bizNo))
			return true;
		if (recordFilter[28] != null && (recType >= 1 && recType <= 7 || recType >= 43 && recType <= 47) && recordFilter[28].contains(bizNo))
			return true;
		return recordFilter[27] != null && (recType >= 8 && recType <= 26 || recType >= 32 && recType <= 51) && recordFilter[27].contains(bizNo);
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}
}

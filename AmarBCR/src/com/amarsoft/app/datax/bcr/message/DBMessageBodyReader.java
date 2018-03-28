package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public abstract class DBMessageBodyReader extends MessageBodyReader
{

	protected String database;
	private Connection connection;
	private List stmtList;

	public DBMessageBodyReader(Message message, String database)
	{
		super(message);
		connection = null;
		stmtList = null;
		this.database = database;
		stmtList = new ArrayList();
	}

	public DBMessageBodyReader(Message message)
	{
		this(message, "bcr");
	}

	public void open()
		throws BCRException
	{
		try
		{
			connection = ARE.getDBConnection("bcr");
			int isolation = ARE.getProperty("connection.bcr.isolation", -1);
			if (isolation != -1)
			{
				logger.debug((new StringBuilder("JDBC transactionIsolation set to ")).append(isolation).toString());
				connection.setTransactionIsolation(isolation);
			}
		}
		catch (SQLException e)
		{
			clearResource();
			throw new BCRException("Open messagebody db error.", e);
		}
	}

	public ResultSet executeQuery(String sql)
		throws SQLException
	{
		Statement st = null;
		ResultSet rs = null;
		logger.debug(sql);
		st = connection.createStatement();
		stmtList.add(st);
		rs = st.executeQuery(sql);
		return rs;
	}

	public PreparedStatement prepareStatement(String sql)
		throws SQLException
	{
		logger.debug(sql);
		PreparedStatement ps = connection.prepareStatement(sql);
		stmtList.add(ps);
		return ps;
	}

	public void close()
		throws BCRException
	{
		clearResource();
	}

	private void clearResource()
	{
		for (int i = 0; i < stmtList.size(); i++)
		{
			Statement stmt = (Statement)stmtList.get(i);
			if (stmt != null)
			{
				try
				{
					stmt.close();
				}
				catch (SQLException e)
				{
					logger.debug(e);
				}
				stmt = null;
				stmtList.set(i, null);
			}
		}

		if (connection != null)
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}

	protected Segment fillBaseSegment(Record r, ResultSet rs)
		throws BCRException, SQLException
	{
		Segment segB = r.createSegment("B");
		segB.getField(7653).setString(segB.getField(7653).getDefaultValue());
		int rt = r.getType();
		if (rt != 9 && rt != 10 && rt != 11 && rt != 15 && rt != 16 && rt != 17 && rt != 22 && rt != 23 && rt != 24 && rt != 32 && rt != 33 && rt != 34)
			if (rt == 51)
				segB.getField(6509).setString(rs.getString("FinanceId"));
			else
				segB.getField(6501).setString(rs.getString("FinanceId"));
		segB.getField(2501).setDate(rs.getString("OccurDate"));
		segB.getField(7511).setString(rs.getString("IncrementFlag"));
		if (rt != 51)
		{
			String sTracenumber = rs.getString("TraceNumber");
			if (sTracenumber == null || sTracenumber.equals(""))
				sTracenumber = "00000000000000000000";
			segB.getField(7641).setString(sTracenumber);
		}
		return segB;
	}

	protected void fillIDChangeSegment(Record r, ResultSet rs)
		throws SQLException, BCRException
	{
		String fid = rs.getString("FinanceId");
		String oid = rs.getString("OldFinanceId");
		if (fid == null || oid == null || "".equals(fid) || "".equals(oid))
			return;
		if (!oid.endsWith(fid))
		{
			Segment segC = r.createSegment("C");
			segC.getField(7543).setString("C");
			segC.getField(7515).setString("1");
			int i;
			for (; oid.indexOf("#") != -1; oid = oid.substring(i + 1))
				i = oid.indexOf("#");

			segC.getField(7517).setString(oid);
		}
	}
}

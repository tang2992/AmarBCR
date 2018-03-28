// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ValidateHelp.java

package com.amarsoft.app.datax.ecr.validate;

import com.amarsoft.app.datax.ecr.message.Field;
import com.amarsoft.app.datax.ecr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class ValidateHelp
{

	private static Map codeMaps;
	private static String tableArr[][] = {
		{
			"71B", "ECR_ORGANINFO", "机构基础信息表", "", "", ""
		}, {
			"71C", "ECR_ORGANATTRIBUTE", "机构基本属性信息表", "", "", ""
		}, {
			"71D", "ECR_ORGANSTATUS", "机构状态信息表", "", "", ""
		}, {
			"71E", "ECR_ORGANCONTACT", "机构联络信息表", "", "", ""
		}, {
			"71F", "ECR_ORGANKEEPER", "机构高管及主要关系人表", "MANAGERTYPE,CERTTYPE,CERTID", "1502,1503", "关系类型,证件类型,证件号"
		}, {
			"71G", "ECR_ORGANSTOCKHOLDER", "机构重要股东表", "STOCKHOLDERTYPE,STOCKHOLDERNAME", "1602,1603", "股东类型,股东名称"
		}, {
			"71H", "ECR_ORGANRELATED", "机构主要关联企业表", "RELATIONSHIP,RELATIVEENTNAME", "1702,1703", "关联类型,关联企业名称"
		}, {
			"71I", "ECR_ORGANSUPERIOR", "机构上级机构表", "", "", ""
		}, {
			"72B", "ECR_ORGANFAMILY", "机构家族成员表", "MANAGERCERTTYPE,MANAGERCERTID,MEMBERRELATYPE,MEMBERCERTTYPE,MEMBERCERTID", "1903,1904,1905,1907,1908", "主要关系人证件类型,证件号码,家族关系,家族成员证件类型,证件号码"
		}
	};

	public ValidateHelp()
	{
	}

	public static String getTableKey(Segment seg, String recordSegmentId)
	{
		if (seg != null && recordSegmentId != null)
		{
			for (int i = 0; i < tableArr.length; i++)
				if (tableArr[i][0].equalsIgnoreCase(recordSegmentId))
				{
					if (StringX.isEmpty(tableArr[i][3]))
						return null;
					StringBuffer sb = new StringBuffer();
					String keyIds[] = tableArr[i][4].split(",");
					String keyColumns[] = tableArr[i][3].split(",");
					for (int j = 0; j < keyIds.length; j++)
						sb.append((new StringBuilder("{")).append(keyColumns[j]).append("=").append(seg.getField(Integer.parseInt(keyIds[j])).getString()).append("}").toString());

					return sb.toString();
				}

		}
		return null;
	}

	public static String getTableNameById(String recordSegmentId)
	{
		for (int i = 0; i < tableArr.length; i++)
			if (tableArr[i][0].equalsIgnoreCase(recordSegmentId))
				return tableArr[i][1];

		return null;
	}

	public static String getKeyColumnLabels(String tableName, String tableKeys)
	{
		return getKeyLabels(tableName, tableKeys, false);
	}

	public static String getKeyLabels(String tableName, String tableKeys)
	{
		return getKeyLabels(tableName, tableKeys, true);
	}

	public static String getKeyLabels(String tableName, String tableKeys, boolean flag)
	{
		if (StringX.isEmpty(tableName) || StringX.isEmpty(tableKeys))
			return tableKeys;
		String keys[];
		int j = -1;
		for (int k = 0; k < tableArr.length; k++)
		{
			if (!tableArr[k][1].equalsIgnoreCase(tableName))
				continue;
			j = k;
			break;
		}

		if (j < 0 || j >= tableArr.length)
			break MISSING_BLOCK_LABEL_289;
		keys = StringX.parseArray(tableKeys);
		for (int m = 0; m < keys.length; m++)
			if (keys[m].indexOf("=") > -1 && tableArr[j][3].split(",").length > m && tableArr[j][5].split(",").length > m)
			{
				String column = keys[m].split("=")[0];
				String value = keys[m].split("=")[1];
				if (flag && codeMaps.containsKey(column) && ((Map)codeMaps.get(column)).containsKey(value))
					value = (String)((Map)codeMaps.get(column)).get(value);
				keys[m] = (new StringBuilder(String.valueOf(tableArr[j][5].split(",")[m]))).append("=").append(value).toString();
			}

		return toArray(keys);
		Exception ex;
		ex;
		ex.printStackTrace();
		return tableKeys;
	}

	public static String toArray(String str[])
	{
		if (str != null)
		{
			StringBuffer sb = new StringBuffer();
			for (int j = 0; j < str.length; j++)
				sb.append((new StringBuilder("{")).append(str[j]).append("}").toString());

			return sb.toString();
		} else
		{
			return null;
		}
	}

	static 
	{
		try
		{
			Connection conn = ARE.getDBConnection("ecr");
			String sql = "select distinct 'MANAGERTYPE',pbcode,note from web_codemap where colname in '9046' union all select distinct 'CERTTYPE',pbcode,note from web_codemap where colname in '9047' union all select distinct 'STOCKHOLDERTYPE',pbcode,note from web_codemap where colname in '9048' union all select distinct 'RELATIONSHIP',pbcode,note from web_codemap where colname in '9049' union all select distinct 'MANAGERCERTTYPE',pbcode,note from web_codemap where colname in '9047' union all select distinct 'MEMBERRELATYPE',pbcode,note from web_codemap where colname in '5555' union all select distinct 'MEMBERCERTTYPE',pbcode,note from web_codemap where colname in '9047' ";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			codeMaps = new HashMap();
			while (rs.next()) 
				if (codeMaps.containsKey(rs.getString(1)))
				{
					((Map)codeMaps.get(rs.getString(1))).put(rs.getString(2).trim(), rs.getString(3));
				} else
				{
					Map map = new HashMap();
					map.put(rs.getString(2).trim(), rs.getString(3));
					codeMaps.put(rs.getString(1), map);
				}
			rs.close();
			st.close();
			conn.close();
			conn = null;
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}

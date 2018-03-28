package com.amarsoft.app.datax.bcr.validate;

import com.amarsoft.app.datax.bcr.message.Field;
import com.amarsoft.app.datax.bcr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class ValidateHelp
{
  private static Map<String, Map<String, String>> codeMaps;
  private static String[][] tableArr = { 
    new String[] { "811B", "BCR_GUARANTEEINFO", "担保基础信息 表", "", "", "" },
    { "811D", "BCR_GUARANTEECONT", "担保合同信息  表", "", "", "" }, 
    { "811E", "BCR_INSUREDS", "担保人信息 表", "CERTTYPE,CERTID", "1304,1305", "被担保人证件类型,被担保人证件号码" }, 
    { "811F", "BCR_CREDITORINFO", "债权人及主合同信息 表", "", "", "" }, 
    { "811G", "BCR_COUNTERGUARANTOR", "反担保人信息 表", "", "", "" }, 
    { "811H", "BCR_GUARANTEEDUTY", "实际在保（代偿）责任信息 表", "", "", "" }, 
    { "811I", "BCR_COMPENSATORYINFO", "代偿概况信息 表", "", "", "" },
    { "811J", "BCR_COMPENSATORYDETAIL", "代偿明细信息 表", "", "", "" },
    { "811K", "BCR_RECOVERYDETAIL", "追偿明细信息 表", "", "", "" },
    { "811L", "BCR_PREMIUMINFO", "保费缴纳概况信息 表", "", "", "" },
    { "811M", "BCR_PREMIUMDETAIL", "保费缴纳明细信息 表", "", "", "" },
    { "821C", "BCR_GUARANTEECHANGE", "担保业务标识变更记录信息 表", "", "", "" },
    { "831S", "BCR_GUARANTEEDELETE", "担保业务删除请求记录信息 表", "", "", "" }
    };

  static
  {
    try
    {
      Connection conn = ARE.getDBConnection("bcr");
      String sql = "select distinct upper(COLNAME),PBCODE,NOTE from BCR.BCR_CODEMAP where COLNAME='CertType' ";

      Statement st = conn.createStatement();
      ResultSet rs = st.executeQuery(sql);
      codeMaps = new HashMap();
      while (rs.next())
        if (codeMaps.containsKey(rs.getString(1))) {
          ((Map)codeMaps.get(rs.getString(1))).put(rs.getString(2).trim(), rs.getString(3));
        } else {
          Map map = new HashMap();
          map.put(rs.getString(2).trim(), rs.getString(3));
          codeMaps.put(rs.getString(1), map);
        }

      rs.close();
      st.close();
      conn.close();
      conn = null;
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static String getTableKey(Segment seg, String recordSegmentId)
  {
    if ((seg != null) && (recordSegmentId != null))
      for (int i = 0; i < tableArr.length; ++i)
        if (tableArr[i][0].equalsIgnoreCase(recordSegmentId)) {
          if (StringX.isEmpty(tableArr[i][3]))
            return null;
          StringBuffer sb = new StringBuffer();
          String[] keyIds = tableArr[i][4].split(",");
          String[] keyColumns = tableArr[i][3].split(",");
          for (int j = 0; j < keyIds.length; ++j)
            sb.append("{" + keyColumns[j] + "=" + seg.getField(Integer.parseInt(keyIds[j])).getString() + "}");

          return sb.toString();
        }



    return null;
  }

  public static String getTableNameById(String recordSegmentId)
  {
    for (int i = 0; i < tableArr.length; ++i) {
      if (tableArr[i][0].equalsIgnoreCase(recordSegmentId))
        return tableArr[i][1];

    }

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
      if(StringX.isEmpty(tableName) || StringX.isEmpty(tableKeys))
          return tableKeys;
      try
      {
          int j = -1;
          for(int k = 0; k < tableArr.length; k++)
          {
              if(!tableArr[k][1].equalsIgnoreCase(tableName))
                  continue;
              j = k;
              break;
          }

          if(j >= 0 && j < tableArr.length)
          {
              String keys[] = StringX.parseArray(tableKeys);
              for(int m = 0; m < keys.length; m++)
                  if(keys[m].indexOf("=") > -1 && tableArr[j][3].split(",").length > m && tableArr[j][5].split(",").length > m)
                  {
                      String column = keys[m].split("=")[0];
                      String value = keys[m].split("=")[1];
                      if(flag && codeMaps.containsKey(column) && ((Map)codeMaps.get(column)).containsKey(value))
                          value = (String)((Map)codeMaps.get(column)).get(value);
                      keys[m] = (new StringBuilder(String.valueOf(tableArr[j][5].split(",")[m]))).append("=").append(value).toString();
                  }

              return toArray(keys);
          }
      }
      catch(Exception ex)
      {
          ex.printStackTrace();
      }
      return tableKeys;
  }

  public static String toArray(String[] str)
  {
    if (str != null) {
      StringBuffer sb = new StringBuffer();
      for (int j = 0; j < str.length; ++j)
        sb.append("{" + str[j] + "}");
      return sb.toString();
    }
    return null;
  }
}
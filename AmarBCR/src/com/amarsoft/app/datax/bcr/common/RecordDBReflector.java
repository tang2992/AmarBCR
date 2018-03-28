package com.amarsoft.app.datax.bcr.common;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.Record;
import com.amarsoft.app.datax.bcr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.log.Log;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Properties;

public class RecordDBReflector
{

	private String mainTable;
	private Field mainKeyColumn[];
	private String relativeTables[];
	private Properties fieldMapper;
	private String loanBusinessType;
	private int parentRecordType;
	private boolean rootRecord;
	private int childrenRecordType[];
	private int recordType;
	private String GBusinessNo;
	private String recordName;
	private static HashMap reflectorPool = new HashMap();

	private RecordDBReflector(int i)
	{
		mainTable = null;
		relativeTables = null;
		loanBusinessType = null;
		parentRecordType = 0;
		rootRecord = true;
		childrenRecordType = null;
		recordType = 0;
		GBusinessNo = null;
		recordName = null;
		fieldMapper = new Properties();
		recordType = i;
		parentRecordType = i;
		rootRecord = true;
		GBusinessNo = "B.1106";
	}

	public final Field[] getMainKeyColumn()
	{
		return mainKeyColumn;
	}

	public final String getMainKeyString()
	{
		StringBuffer stringbuffer = new StringBuffer();
		for (int i = 0; i < mainKeyColumn.length; i++)
		{
			stringbuffer.append('{');
			stringbuffer.append(mainKeyColumn[i].getType()).append(':');
			stringbuffer.append(mainKeyColumn[i].getString()).append('}');
		}

		return stringbuffer.toString();
	}

	public final void computeKey(Record record)
	{
		for (int i = 0; i < mainKeyColumn.length; i++)
		{
			com.amarsoft.app.datax.bcr.message.Field field = null;
			mainKeyColumn[i].setNull();
			field = lookupField(mainKeyColumn[i].getName(), record);
			if (field == null)
				continue;
			if (mainKeyColumn[i].getType() == 1)
			{
				mainKeyColumn[i].setValue(field.getInt());
				continue;
			}
			if ("UpdateDate".equalsIgnoreCase(mainKeyColumn[i].getName()))
			{
				mainKeyColumn[i].setValue((new SimpleDateFormat("yyyy/MM/dd")).format(field.getDate()));
				continue;
			}
			String s1 = field.getString();
			if (s1 != null)
				mainKeyColumn[i].setValue(s1.trim());
		}

	}

	private com.amarsoft.app.datax.bcr.message.Field lookupField(String s, Record record)
	{
		String s1 = fieldMapper.getProperty(s);
		String as[] = s1.split("\\.");
		Object obj = null;
		com.amarsoft.app.datax.bcr.message.Field field = null;
		try
		{
			Segment segment = record.getFirstSegment(as[0]);
			field = segment.getField(Integer.parseInt(as[1]));
		}
		catch (BCRException BCRException)
		{
			ARE.getLog().debug(BCRException);
		}
		return field;
	}

	public final String getMainTable()
	{
		return mainTable;
	}

	public final String[] getRelativeTables()
	{
		if (relativeTables == null)
			relativeTables = new String[0];
		return relativeTables;
	}

	public static RecordDBReflector getReflector(Record record)
	{
		return getReflector(record.getType());
	}

	public static RecordDBReflector getReflector(int i)
	{
		Integer integer = new Integer(i);
		if (reflectorPool.containsKey(integer))
			return (RecordDBReflector)reflectorPool.get(integer);
		RecordDBReflector recorddbreflector = new RecordDBReflector(i);
		reflectorPool.put(integer, recorddbreflector);
		switch (i)
		{
		case 811: 
			recorddbreflector.mainTable = "GUARANTEEINFO";
			recorddbreflector.GBusinessNo = "B.1106";
			recorddbreflector.mainKeyColumn = (new Field[] {
				new Field(1, "GBusinessNo", (byte)0)
			});
			recorddbreflector.relativeTables = (new String[] {
				"GUARANTEECONT", "INSUREDS", "CREDITORINFO", "COUNTERGUARANTOR", "GUARANTEEDUTY", "COMPENSATORYINFO", "COMPENSATORYDETAIL", "RECOVERYDETAIL", "PREMIUMINFO", "PREMIUMDETAIL"
			});
			recorddbreflector.fieldMapper.setProperty("GBusinessNo", "B.1105");
			recorddbreflector.recordName = "担保业务基础信息";
			break;
			
		case 821: 
			recorddbreflector.mainTable = "GUARANTEECHANGE";
			recorddbreflector.GBusinessNo = "C.2002";
			recorddbreflector.mainKeyColumn = (new Field[] {
				new Field(1, "GBusinessNo", (byte)0)
			});			
			recorddbreflector.fieldMapper.setProperty("GBusinessNo", "C.2002");
			/*recorddbreflector.fieldMapper.setProperty("NEWGBusinessNo", "C.2003");
			recorddbreflector.fieldMapper.setProperty("UpdateDate", "C.2004");*/
			recorddbreflector.recordName = "担保业务变更信息";
			break;
		
		case 831: 
			recorddbreflector.mainTable = "GUARANTEEDELETE";
			recorddbreflector.GBusinessNo = "S.2002";
			recorddbreflector.mainKeyColumn = (new Field[] {
				new Field(1, "GBusinessNo", (byte)0)
			});			
			recorddbreflector.fieldMapper.setProperty("GBusinessNo", "S.2002");
			/*recorddbreflector.fieldMapper.setProperty("DeleteType", "S.2003");
			recorddbreflector.fieldMapper.setProperty("UpdateDate", "S.2004");*/
			recorddbreflector.recordName = "担保业务删除请求";
			break;

		default:
			recorddbreflector = null;
			break;
		}
		return recorddbreflector;
	}

	public String getLoanBusinessType()
	{
		return loanBusinessType;
	}

	public Properties getFieldMapper()
	{
		return fieldMapper;
	}

	public int getParentRecordType()
	{
		return parentRecordType;
	}

	public int getRecordType()
	{
		return recordType;
	}

	public boolean isRootRecord()
	{
		return rootRecord;
	}

	public int[] getChildrenRecordType()
	{
		return childrenRecordType;
	}

	public String getGBusinessNoField()
	{
		return GBusinessNo;
	}

	public String getRecordName()
	{
		return recordName;
	}

}

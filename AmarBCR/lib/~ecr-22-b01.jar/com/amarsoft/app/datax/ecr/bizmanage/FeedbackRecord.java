// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FeedbackRecord.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class FeedbackRecord
{

	private int errorCount;
	private int errorRow;
	private int errorColumns[];
	private String errorCode[];
	private String traceNumber;
	private String financeCode;
	private byte recordData[];
	private static Record recordTemplete[] = new Record[60];

	public FeedbackRecord(Record feedbackRec)
		throws ECRException
	{
		errorCount = 0;
		errorRow = 0;
		errorColumns = null;
		errorCode = null;
		traceNumber = null;
		financeCode = null;
		recordData = null;
		Segment segB = feedbackRec.getFirstSegment("B");
		errorCount = segB.getField(4515).getInt() / 8;
		errorRow = segB.getField(8527).getInt();
		errorColumns = new int[errorCount];
		errorCode = new String[errorCount];
		String s = segB.getField(9915).getString();
		for (int i = 0; i < errorCount; i++)
		{
			errorColumns[i] = Integer.parseInt(s.substring(i * 8, i * 8 + 4));
			errorCode[i] = s.substring(i * 8 + 4, i * 8 + 8);
		}

		traceNumber = segB.getField(7641).getTextValue();
		traceNumber = traceNumber.replaceAll(" ", "");
		financeCode = segB.getField(6501).getTextValue();
		recordData = segB.getField(9916).getTextValue().getBytes();
	}

	public String[] getErrorCode(String errCode[], int errorColumns[])
		throws ECRException
	{
		int errorColumn = 0;
		String name = "";
		for (int i = 0; i < errorCount; i++)
			if (errorColumns[i] == 0)
			{
				errorCode[i] = (new StringBuilder("0000")).append(errCode[i]).append("记录级错误").toString();
			} else
			{
				errorColumn = errorColumns[i];
				int recType = Integer.parseInt(new String(recordData, 4, 2));
				Record rec = createRecordByType(recType);
				if (rec == null)
					throw new ECRException((new StringBuilder("转换记录数据到记录对象失败: ")).append(recordData).toString());
				int offset = 0;
				Segment seg = rec.createSegment("B");
				readSegment(recordData, offset, seg);
				offset += seg.getSegmentLength();
				if (offset > errorColumn)
				{
					int position = ((errorColumn - offset) + seg.getSegmentLength()) - 1;
					Field f[] = seg.getFields();
					for (int j = 0; j < f.length; j++)
					{
						Field fd = f[j];
						if (fd.getStartPosition() == position)
							name = (new StringBuilder(String.valueOf(fd.getId().toString()))).append(errCode[i]).append(fd.getChineseName().toString()).toString();
					}

					errorCode[i] = name;
				} else
				{
					while (offset < errorColumn) 
					{
						seg = rec.createSegment(new String(recordData, offset, 1));
						offset += seg.getSegmentLength();
						if (offset > errorColumn)
						{
							int position = ((errorColumn - offset) + seg.getSegmentLength()) - 1;
							Field f[] = seg.getFields();
							for (int j = 0; j < f.length; j++)
							{
								Field fd = f[j];
								if (fd.getStartPosition() == position)
									name = (new StringBuilder(String.valueOf(fd.getId().toString()))).append(errCode[i]).append(fd.getChineseName().toString()).toString();
							}

						}
					}
					errorCode[i] = name;
				}
			}

		return errorCode;
	}

	public String[] getErrorCode()
	{
		return errorCode;
	}

	public void setErrorCode(String errorCode[])
	{
		this.errorCode = errorCode;
	}

	public int[] getErrorColumns()
	{
		return errorColumns;
	}

	public void setErrorColumns(int errorColumns[])
	{
		this.errorColumns = errorColumns;
	}

	public int getErrorCount()
	{
		return errorCount;
	}

	public void setErrorCount(int errorCount)
	{
		this.errorCount = errorCount;
	}

	public int getErrorRow()
	{
		return errorRow;
	}

	public void setErrorRow(int errorRow)
	{
		this.errorRow = errorRow;
	}

	public byte[] getRecordData()
	{
		return recordData;
	}

	public void setRecordData(byte recordData[])
	{
		this.recordData = recordData;
	}

	public String getTraceNumber()
	{
		return traceNumber;
	}

	public void setTraceNumber(String traceNumber)
	{
		this.traceNumber = traceNumber;
	}

	public String getFinanceCode()
	{
		return financeCode;
	}

	public void setFinanceCode(String financeCode)
	{
		this.financeCode = financeCode;
	}

	public Record getRecordDataAsRecord()
		throws ECRException
	{
		int recType = Integer.parseInt(new String(recordData, 4, 2));
		Record rec = createRecordByType(recType);
		if (rec == null)
			throw new ECRException((new StringBuilder("转换记录数据到记录对象失败: ")).append(recordData).toString());
		int offset = 0;
		Segment seg = rec.createSegment("B");
		readSegment(recordData, offset, seg);
		for (offset += seg.getSegmentLength(); offset < recordData.length; offset += seg.getSegmentLength())
		{
			seg = rec.createSegment(new String(recordData, offset, 1));
			readSegment(recordData, offset, seg);
		}

		return rec;
	}

	private void readSegment(byte data[], int offset, Segment segment)
	{
		String s = "";
		Field f[] = segment.getFields();
		for (int i = 0; i < f.length; i++)
		{
			Field fd = f[i];
			if (!fd.getId().equals("9991"))
			{
				s = new String(data, offset + fd.getStartPosition(), (fd.getEndPosition() - fd.getStartPosition()) + 1);
				switch (fd.getDataType())
				{
				case 1: // '\001'
					fd.setString(s);
					break;

				case 2: // '\002'
				case 3: // '\003'
					fd.setNumber(s);
					break;

				case 4: // '\004'
					fd.setDate(s);
					break;

				case 5: // '\005'
					try
					{
						fd.setDate((new SimpleDateFormat("yyyyMMddhhmmss")).parse(s));
					}
					catch (ParseException e)
					{
						ARE.getLog().warn(e);
					}
					break;

				default:
					fd.setString(s);
					break;
				}
			}
		}

	}

	private static Record createRecordByType(int rectype)
	{
		if (rectype < 0 || recordTemplete[rectype] == null)
			return null;
		Record rec = null;
		try
		{
			rec = (Record)recordTemplete[rectype].clone();
		}
		catch (CloneNotSupportedException e)
		{
			ARE.getLog().debug(e);
		}
		return rec;
	}

	public static void init(String messageSetXmlFiles[])
		throws ECRException
	{
		if (messageSetXmlFiles == null || messageSetXmlFiles.length < 1)
			throw new ECRException("无效的配置XML文件");
		for (int f = 0; f < messageSetXmlFiles.length; f++)
		{
			MessageSet ms = MessageSet.createMessageSetFromXml(messageSetXmlFiles[f]);
			Message msgs[] = ms.getMessages();
			if (msgs != null)
			{
				for (int i = 0; i < msgs.length; i++)
				{
					Record ra[] = msgs[i].getDataRecordArray();
					if (ra != null)
					{
						for (int r = 0; r < ra.length; r++)
							recordTemplete[ra[r].getType()] = ra[r];

					}
				}

			}
		}

	}

}

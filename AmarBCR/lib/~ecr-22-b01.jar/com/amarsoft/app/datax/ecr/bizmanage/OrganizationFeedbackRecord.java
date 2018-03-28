// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   OrganizationFeedbackRecord.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class OrganizationFeedbackRecord
{

	private int errorCount;
	private int errorRow;
	private int errorColumns[];
	private String errorCode[];
	private String traceNumber;
	private byte recordData[];
	private Record feedbackRec;
	private static Record recordTemplete[] = new Record[100];

	public Record getFeedbackRec()
	{
		return feedbackRec;
	}

	public OrganizationFeedbackRecord()
	{
		errorCount = 0;
		errorRow = 0;
		errorColumns = null;
		errorCode = null;
		traceNumber = null;
		recordData = null;
		feedbackRec = null;
	}

	public OrganizationFeedbackRecord(Record feedbackRec)
		throws ECRException
	{
		errorCount = 0;
		errorRow = 0;
		errorColumns = null;
		errorCode = null;
		traceNumber = null;
		recordData = null;
		this.feedbackRec = null;
		this.feedbackRec = feedbackRec;
		Segment segB = feedbackRec.getFirstSegment("B");
		errorCount = segB.getField(2402).getString().length() / 8;
		errorRow = segB.getField(2401).getInt();
		errorColumns = new int[errorCount];
		errorCode = new String[errorCount];
		String s = segB.getField(2402).getString();
		for (int i = 0; i < errorCount; i++)
		{
			errorColumns[i] = Integer.parseInt(s.substring(i * 8, i * 8 + 4));
			errorCode[i] = s.substring(i * 8 + 4, i * 8 + 8);
		}

		traceNumber = (new StringBuilder(String.valueOf((new Date()).getTime()))).toString();
		recordData = segB.getField(2403).getTextValue().getBytes();
	}

	public String[] getErrorCode(int recType, String errCode[], int errorColumns[])
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

	public Record getRecordDataAsRecord()
		throws ECRException
	{
		int feedbackRecType = feedbackRec.getFirstSegment("B").getField(2409).getInt();
		int recType = 0;
		switch (feedbackRecType)
		{
		case 77: // 'M'
			recType = 72;
			break;

		case 76: // 'L'
			recType = 73;
			break;

		case 78: // 'N'
			recType = 74;
			break;

		default:
			recType = 71;
			break;
		}
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
			if (!fd.getId().equals("9992") && !fd.getId().equals("9993"))
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

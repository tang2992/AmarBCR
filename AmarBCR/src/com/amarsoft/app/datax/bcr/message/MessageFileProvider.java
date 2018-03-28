package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public abstract class MessageFileProvider
	implements DataProvider
{

	private String dataFile;
	private Message message;
	private int recordCount;
	protected BufferedReader reader;

	public MessageFileProvider(String messageFile)
		throws BCRException
	{
		dataFile = null;
		message = null;
		recordCount = 0;
		reader = null;
		dataFile = messageFile;
		reader = openFile(messageFile);
	}

	public String generateFileName(MessageSet messageSet)
		throws BCRException
	{
		return dataFile;
	}

	public void readHeader(Message msg, Record header)
		throws BCRException
	{
		Segment seg = header.createSegment("A");
		byte row[];
		while ((row = readLine(reader)) != null) 
			if (row[0] == 65)
			{
				fillSegment(row, seg);
				return;
			}
		throw new BCRException((new StringBuilder("数据文件")).append(dataFile).append("之中没有头数据！").toString());
	}

	public void readFooter(Message msg, Record footer)
		throws BCRException
	{
		Segment seg = footer.createSegment("Z");
		seg.getField(8521).setString("Z");
		seg.getField(4513).setInt(msg.getRecordCount());
		recordCount += msg.getRecordCount();
	}

	private BufferedReader openFile(String messageFile)
		throws BCRException
	{
		BufferedReader r = null;
		try
		{
			FileInputStream fi = new FileInputStream(dataFile);
			r = new BufferedReader(new InputStreamReader(fi, "GBK"));
		}
		catch (FileNotFoundException e)
		{
			throw new BCRException(e);
		}
		catch (UnsupportedEncodingException e)
		{
			throw new BCRException(e);
		}
		return r;
	}

	public Message getCurrentMessage()
	{
		return message;
	}

	public static void fillSegment(byte segData[], Segment segment)
	{
		byte buffer[] = null;
		String s = "";
		int offset = 0;
		int length = 0;
		Field f[] = segment.getFields();
		buffer = segData;
		for (int i = 0; i < f.length; i++)
		{
			Field fd = f[i];
			offset = fd.getStartPosition();
			length = (fd.getEndPosition() - offset) + 1;
			s = new String(buffer, offset, length);
			switch (fd.getDataType())
			{
			case 1: // '\001'
				fd.setString(s.trim());
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
				fd.setString(s.trim());
				break;
			}
		}

	}

	public static byte[] readLine(BufferedReader reader)
		throws BCRException
	{
		byte row[] = null;
		try
		{
			String line = null;
			for (line = reader.readLine(); line != null && line.length() == 0; line = reader.readLine());
			if (line == null)
				try
				{
					reader.close();
				}
				catch (IOException ex)
				{
					ARE.getLog().debug(ex);
				}
			else
				row = line.getBytes();
		}
		catch (IOException exp)
		{
			if (reader != null)
				try
				{
					reader.close();
				}
				catch (IOException ex)
				{
					ARE.getLog().debug(ex);
				}
			throw new BCRException(exp);
		}
		return row;
	}

	public void setRecordCount(int recordCount)
	{
		this.recordCount = recordCount;
	}

	public int getRecordCount()
	{
		return recordCount;
	}
}

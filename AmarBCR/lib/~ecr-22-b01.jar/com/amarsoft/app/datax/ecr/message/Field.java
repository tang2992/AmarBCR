// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   Field.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.util.xml.Attribute;
import com.amarsoft.are.util.xml.Element;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			Segment

public class Field
	implements Cloneable
{

	public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyyMMdd");
	public static final SimpleDateFormat DATETIME_FORMAT = new SimpleDateFormat("yyyyMMddHHmmdd");
	public static final DecimalFormat NUMBER_FORMAT = new DecimalFormat("0.00");
	private String id;
	private int dataType;
	private String name;
	private String chineseName;
	private String defaultValue;
	private String status;
	private int type;
	private int startPosition;
	private int endPosition;
	private boolean optional;
	private boolean keyAttribute;
	private long longValue;
	private int intValue;
	private double doubleValue;
	private Date dateValue;
	private String stringValue;
	private String textValue;
	private Segment segment;

	protected static Field buildField(Element xField, Segment seg)
		throws ECRException
	{
		Field field = new Field();
		field.segment = seg;
		Attribute attribute = null;
		attribute = xField.getAttribute("id");
		if (attribute == null)
			throw new ECRException("No id   definition or error in field's attributes ");
		field.id = attribute.getValue();
		attribute = xField.getAttribute("dataType");
		if (attribute == null)
			field.dataType = 1;
		else
		if (attribute.getValue().equalsIgnoreCase("INT"))
			field.dataType = 2;
		else
		if (attribute.getValue().equalsIgnoreCase("DATE"))
			field.dataType = 4;
		else
		if (attribute.getValue().equalsIgnoreCase("DATETIME"))
			field.dataType = 5;
		else
		if (attribute.getValue().equalsIgnoreCase("DOUBLE"))
			field.dataType = 3;
		else
			field.dataType = 1;
		attribute = xField.getAttribute("keyAttribute");
		if (attribute == null)
			field.keyAttribute = false;
		else
			field.keyAttribute = attribute.getValue(false);
		attribute = xField.getAttribute("name");
		if (attribute == null)
			throw new ECRException("No optional   definition  or errorin field's attributes ");
		field.name = attribute.getValue();
		attribute = xField.getAttribute("chineseName");
		if (attribute == null)
			field.chineseName = "";
		else
			field.chineseName = attribute.getValue();
		attribute = xField.getAttribute("defaultValue");
		if (attribute == null)
			field.defaultValue = null;
		else
			field.defaultValue = attribute.getValue();
		attribute = xField.getAttribute("type");
		if (attribute == null)
		{
			field.type = 2;
		} else
		{
			String s = attribute.getValue();
			if (s.equalsIgnoreCase("N"))
				field.type = 0;
			else
			if (s.equalsIgnoreCase("AN"))
				field.type = 1;
			else
				field.type = 2;
		}
		attribute = xField.getAttribute("startPosition");
		if (attribute == null)
			throw new ECRException("No optional   definition or error in field's attributes ");
		try
		{
			field.startPosition = Integer.parseInt(attribute.getValue());
		}
		catch (NumberFormatException e)
		{
			e.printStackTrace();
			throw new ECRException("No optional   definition or error in field's attributes ");
		}
		attribute = xField.getAttribute("endPosition");
		if (attribute == null)
			throw new ECRException("No optional   definition or error in field's attributes ");
		try
		{
			field.endPosition = Integer.parseInt(attribute.getValue());
		}
		catch (NumberFormatException e)
		{
			e.printStackTrace();
			throw new ECRException("No optional   definition or error in field's attributes ");
		}
		attribute = xField.getAttribute("optional");
		if (attribute == null)
			throw new ECRException("No optional   definition or error in field's attributes ");
		field.optional = attribute.getValue(false);
		attribute = xField.getAttribute("status");
		if (attribute == null)
			field.status = "";
		else
			field.status = attribute.getValue();
		if (field.defaultValue != null && field.defaultValue.length() > 0)
			switch (field.dataType)
			{
			case 2: // '\002'
			case 3: // '\003'
				field.setNumber(field.defaultValue);
				break;

			case 4: // '\004'
			case 5: // '\005'
				field.setDate(field.defaultValue);
				break;

			default:
				field.setString(field.defaultValue);
				break;
			}
		return field;
	}

	public void clear()
	{
		stringValue = defaultValue;
		textValue = defaultValue;
		switch (dataType)
		{
		default:
			break;

		case 4: // '\004'
		case 5: // '\005'
			if (defaultValue != null)
				setDate(defaultValue);
			break;

		case 2: // '\002'
		case 3: // '\003'
			if (defaultValue != null)
				setNumber(defaultValue);
			break;
		}
	}

	public Segment getSegment()
	{
		return segment;
	}

	public void setSegment(Segment segment)
	{
		this.segment = segment;
	}

	public Field()
	{
		keyAttribute = false;
		dateValue = null;
		stringValue = null;
		textValue = null;
		segment = null;
		id = null;
		type = 1;
		dataType = 1;
		startPosition = 0;
		longValue = 0L;
		endPosition = -1;
		intValue = 0;
		doubleValue = 0.0D;
		stringValue = null;
		dateValue = null;
		textValue = null;
		status = null;
	}

	public Field(String id, String name, int dataType, int type, int startPosition, int endPosition, boolean optional, 
			boolean keyAttribute)
	{
		this.keyAttribute = false;
		dateValue = null;
		stringValue = null;
		textValue = null;
		segment = null;
		this.id = id;
		this.name = name;
		this.dataType = dataType;
		this.type = type;
		this.startPosition = startPosition;
		this.endPosition = endPosition;
		this.optional = optional;
		this.keyAttribute = keyAttribute;
	}

	public String getTextValue()
		throws ECRException
	{
		StringBuffer sb = null;
		boolean nullOption = false;
		switch (dataType)
		{
		case 2: // '\002'
			if (!(nullOption = optional && intValue == 0))
				sb = (new StringBuffer()).append(intValue);
			break;

		case 3: // '\003'
			if (!(nullOption = optional && doubleValue == 0.0D))
				sb = new StringBuffer(NUMBER_FORMAT.format(doubleValue));
			break;

		case 4: // '\004'
			if (!(nullOption = optional && dateValue == null))
				sb = new StringBuffer(dateValue != null ? DATE_FORMAT.format(dateValue) : "");
			break;

		case 5: // '\005'
			if (!(nullOption = optional && dateValue == null))
				sb = new StringBuffer(dateValue != null ? DATETIME_FORMAT.format(dateValue) : "");
			break;

		default:
			if (!(nullOption = optional && stringValue == null))
				sb = new StringBuffer(stringValue != null ? stringValue : "");
			break;
		}
		int needFieldLength = 0;
		if (name.equalsIgnoreCase("ChinaName"))
			needFieldLength = 0;
		needFieldLength = (endPosition - startPosition) + 1;
		if (nullOption)
			for (sb = new StringBuffer(32); sb.length() < needFieldLength; sb.append(' '));
		else
		if (status.equals("M") && sb.length() == 0)
			for (; sb.length() < needFieldLength; sb.append('#'));
		else
		if (type == 0)
		{
			for (; sb.length() < needFieldLength; sb.insert(0, '0'));
		} else
		{
			int ix;
			try
			{
				ix = sb.toString().getBytes("GBK").length;
			}
			catch (UnsupportedEncodingException e)
			{
				ix = sb.toString().getBytes().length;
			}
			for (int i = ix; i < needFieldLength; i++)
				sb.append(' ');

		}
		textValue = sb.toString();
		return textValue;
	}

	public String toString()
	{
		StringBuffer sb = new StringBuffer("");
		sb = sb.append("");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append((new StringBuilder("<field id=\"")).append(id).append("\" dataType=\"").append(dataType).append("\"").toString());
		sb = sb.append("\n");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append((new StringBuilder(" chineseName=\"")).append(chineseName).append("\" type=\"").append(type).append("\"").toString());
		sb = sb.append((new StringBuilder(" startPosition=\"")).append(startPosition).append("\" endPosition=\"").append(endPosition).append("\"").toString());
		sb = sb.append("\n");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append((new StringBuilder(" optional=\"")).append(optional).append("\" defaultValue=\"").append(defaultValue).append("\"").toString());
		sb = sb.append(" >");
		try
		{
			sb = sb.append((new StringBuilder(String.valueOf(getTextValue()))).toString());
		}
		catch (ECRException e)
		{
			e.printStackTrace();
			sb = sb.append("system error here");
		}
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append("</field>");
		return sb.toString();
	}

	public Object clone()
		throws CloneNotSupportedException
	{
		Field cloneField = (Field)super.clone();
		cloneField.id = id;
		cloneField.dataType = dataType;
		cloneField.name = name;
		cloneField.chineseName = chineseName;
		cloneField.defaultValue = defaultValue;
		cloneField.type = type;
		cloneField.startPosition = startPosition;
		cloneField.endPosition = endPosition;
		cloneField.optional = optional;
		cloneField.keyAttribute = keyAttribute;
		cloneField.status = status;
		return cloneField;
	}

	public void setDate(Date dateValue)
	{
		if (dateValue == null)
		{
			if (defaultValue != null)
			{
				dateValue = Tools.charToDate(defaultValue);
				return;
			}
			textValue = "null";
			segment.fieldValidate = false;
		}
		this.dateValue = dateValue;
	}

	public void setDate(String dateValue)
	{
		if (dateValue == null)
			if (defaultValue != null)
			{
				dateValue = defaultValue;
			} else
			{
				textValue = dateValue;
				segment.fieldValidate = false;
				this.dateValue = null;
				return;
			}
		this.dateValue = Tools.charToDate(dateValue);
	}

	public String getString()
	{
		return stringValue;
	}

	public Date getDate()
	{
		return dateValue;
	}

	public void setString(String stringValue)
	{
		this.stringValue = stringValue != null ? stringValue.replaceAll("[\\u0000-\\u001F]", "") : null;
	}

	public String getChineseName()
	{
		return chineseName;
	}

	public int getDataType()
	{
		return dataType;
	}

	public String getDefaultValue()
	{
		return defaultValue;
	}

	public String getId()
	{
		return id;
	}

	public String getName()
	{
		return name;
	}

	public String getStatus()
	{
		return status;
	}

	public boolean isOptional()
	{
		return optional;
	}

	public int getStartPosition()
	{
		return startPosition;
	}

	public int getType()
	{
		return type;
	}

	/**
	 * @deprecated Method setInt is deprecated
	 */

	public void setInt(String intVal)
	{
		setNumber(intVal);
	}

	public void setInt(int intVal)
	{
		intValue = intVal;
	}

	public int getInt()
	{
		return intValue;
	}

	public long getLong()
	{
		return longValue;
	}

	public void setLong(long longVal)
	{
		longValue = longVal;
	}

	/**
	 * @deprecated Method setLong is deprecated
	 */

	public void setLong(String longVal)
	{
		setNumber(longVal);
	}

	public double getDouble()
	{
		return doubleValue;
	}

	/**
	 * @deprecated Method setDouble is deprecated
	 */

	public void setDouble(String doubleValue)
	{
		setNumber(doubleValue);
	}

	public void setDouble(double doubleValue)
	{
		this.doubleValue = doubleValue;
	}

	public int getEndPosition()
	{
		return endPosition;
	}

	public void setEndPosition(int endPosition)
	{
		this.endPosition = endPosition;
	}

	public void setStartPosition(int startPosition)
	{
		this.startPosition = startPosition;
	}

	public boolean isKeyAttribute()
	{
		return keyAttribute;
	}

	private Number parseNumber(String str)
	{
		Number num = null;
		if (str == null)
		{
			if (defaultValue != null)
				str = defaultValue;
			return num;
		}
		try
		{
			num = Double.valueOf(str);
		}
		catch (NumberFormatException numberformatexception) { }
		return num;
	}

	public void setNumber(String numberVal)
	{
		Number n = parseNumber(numberVal);
		if (n == null)
		{
			intValue = 0;
			longValue = 0L;
			doubleValue = 0.0D;
			segment.fieldValidate = false;
			textValue = numberVal;
		} else
		{
			intValue = n.intValue();
			longValue = n.longValue();
			doubleValue = n.doubleValue();
		}
	}

}

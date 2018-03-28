// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   test0.java

package test;

import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import java.lang.reflect.Method;
import java.util.Date;

public class test0
{

	public String str;
	private int in;
	private Date da;
	protected String sa;

	public test0()
	{
		str = null;
		in = 0;
		da = null;
		sa = null;
	}

	protected Date getDa()
	{
		return da;
	}

	protected void setDa(Date da)
	{
		this.da = da;
	}

	public int getIn()
	{
		return in;
	}

	public void setIn(int in)
	{
		this.in = in;
	}

	public String getStr()
	{
		return str;
	}

	public void setStr(String str)
	{
		this.str = str;
	}

	public final void setProperty(String prop, String value)
	{
		Class c = getClass();
		if (!prop.startsWith((new StringBuilder(String.valueOf(c.getName()))).append(".").toString()))
			return;
		String f = prop.substring(c.getName().length() + 1);
		String m = (new StringBuilder("set")).append(f.substring(0, 1).toUpperCase()).append(f.substring(1)).toString();
		Method method = null;
		Class paramType[] = new Class[1];
		Object para[] = new Object[1];
		if (method == null)
		{
			paramType[0] = java/lang/String;
			try
			{
				method = c.getMethod(m, paramType);
				para[0] = value;
				method.invoke(this, para);
			}
			catch (Exception e)
			{
				method = null;
			}
		}
		if (method == null)
		{
			paramType[0] = java/util/Date;
			try
			{
				method = c.getMethod(m, paramType);
				try
				{
					para[0] = StringX.parseDate(value);
					method.invoke(this, para);
				}
				catch (Exception e)
				{
					ARE.getLog().debug((new StringBuilder("Invalid property name=: ")).append(prop).append("value=").append(value).toString());
				}
			}
			catch (Exception e)
			{
				method = null;
			}
		}
		if (method == null)
		{
			paramType[0] = Boolean.TYPE;
			try
			{
				method = c.getMethod(m, paramType);
				try
				{
					para[0] = new Boolean(StringX.parseBoolean(value));
					method.invoke(this, para);
				}
				catch (Exception e)
				{
					ARE.getLog().debug((new StringBuilder("Invalid property name=: ")).append(prop).append("value=").append(value).toString());
				}
			}
			catch (Exception e)
			{
				method = null;
			}
		}
		if (value == null || value.equals(""))
		{
			ARE.getLog().debug((new StringBuilder("Invalid property name=: ")).append(prop).append("value=").append(value).toString());
			return;
		}
		if (method == null)
		{
			paramType[0] = Integer.TYPE;
			try
			{
				method = c.getMethod(m, paramType);
				try
				{
					para[0] = Integer.valueOf(value);
					method.invoke(this, para);
				}
				catch (Exception e)
				{
					ARE.getLog().debug((new StringBuilder("Invalid property name=: ")).append(prop).append("value=").append(value).toString());
				}
			}
			catch (Exception e)
			{
				method = null;
			}
		}
		if (method == null)
		{
			paramType[0] = Long.TYPE;
			try
			{
				method = c.getMethod(m, paramType);
				try
				{
					para[0] = Long.valueOf(value);
					method.invoke(this, para);
				}
				catch (Exception e)
				{
					ARE.getLog().debug((new StringBuilder("Invalid property name=: ")).append(prop).append("value=").append(value).toString());
				}
			}
			catch (Exception e)
			{
				method = null;
			}
		}
		if (method == null)
		{
			paramType[0] = Byte.TYPE;
			try
			{
				method = c.getMethod(m, paramType);
				try
				{
					para[0] = Byte.valueOf(value);
					method.invoke(this, para);
				}
				catch (Exception e)
				{
					ARE.getLog().debug((new StringBuilder("Invalid property name=: ")).append(prop).append("value=").append(value).toString());
				}
			}
			catch (Exception e)
			{
				method = null;
			}
		}
		if (method == null)
		{
			paramType[0] = Character.TYPE;
			try
			{
				method = c.getMethod(m, paramType);
				para[0] = new Character(value.charAt(0));
				method.invoke(this, para);
			}
			catch (Exception e)
			{
				method = null;
			}
		}
		if (method == null)
		{
			paramType[0] = Double.TYPE;
			try
			{
				method = c.getMethod(m, paramType);
				try
				{
					para[0] = Double.valueOf(value);
					method.invoke(this, para);
				}
				catch (Exception e)
				{
					ARE.getLog().debug((new StringBuilder("Invalid property name=: ")).append(prop).append("value=").append(value).toString());
				}
			}
			catch (Exception e)
			{
				ARE.getLog().debug((new StringBuilder("set property error '")).append(prop).append("'").toString());
			}
		}
	}
}

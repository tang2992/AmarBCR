// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ECRException.java

package com.amarsoft.app.datax.ecr;


public class ECRException extends Exception
{

	private static final long serialVersionUID = 1L;
	protected Throwable cause;

	public ECRException()
	{
		cause = null;
	}

	public ECRException(String message)
	{
		super(message);
		cause = null;
	}

	public ECRException(Throwable cause)
	{
		this(cause != null ? cause.toString() : null, cause);
	}

	public ECRException(String message, Throwable cause)
	{
		super((new StringBuilder(String.valueOf(message))).append(" (Caused by ").append(cause.getMessage()).append(")").toString());
		this.cause = null;
		this.cause = cause;
	}

	public Throwable getCause()
	{
		return cause;
	}
}

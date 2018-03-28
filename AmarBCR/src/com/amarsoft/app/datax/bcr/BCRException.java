package com.amarsoft.app.datax.bcr;

public class BCRException extends Exception
{
  private static final long serialVersionUID = 1L;
  protected Throwable cause;

  public BCRException()
  {
    this.cause = null;
  }

  public BCRException(String message)
  {
    super(message);

    this.cause = null;
  }

  public BCRException(Throwable cause)
  {
    this((cause == null) ? null : cause.toString(), cause);
  }

  public BCRException(String message, Throwable cause)
  {
    super(message + " (Caused by " + cause.getMessage() + ")");

    this.cause = null;

    this.cause = cause;
  }

  public Throwable getCause()
  {
    return this.cause;
  }
}
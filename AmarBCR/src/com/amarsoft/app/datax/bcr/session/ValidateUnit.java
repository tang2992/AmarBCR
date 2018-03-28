package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;

public class ValidateUnit extends MessageProcessSessionUnit
{
  protected MessageProcessSession createSession()
    throws BCRException
  {
    ValidateSession sess = new ValidateSession();
    return sess;
  }
}

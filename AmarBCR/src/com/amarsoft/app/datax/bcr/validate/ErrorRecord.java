package com.amarsoft.app.datax.bcr.validate;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.Segment;

public interface ErrorRecord
{

	public abstract void writeError(ValidateRule validaterule, Segment segment)
		throws BCRException;

	public abstract void clearAllError()
		throws BCRException;

	public abstract void clearMessageError(int i)
		throws BCRException;

	public abstract void open()
		throws BCRException;

	public abstract void close();
}

package mybank;

import com.amarsoft.app.datacheck.DateChooser;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.util.DateRange;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.Target;
import com.amarsoft.task.Task;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class ChooseDateUnit extends ExecuteUnit {
	private String varFormat = "yyyyMMdd";
	private String varName = "bcr_bizDate";
	private String varScope = "task";

	public int execute() {

		Calendar localCalendar = Calendar.getInstance();
		localCalendar.set(5, 1);
		localCalendar.add(5, -1);
		Date localDate1 = localCalendar.getTime();
		DateChooser localDateChooser = new DateChooser(localDate1);
		localDateChooser.setAcceptRange(new DateRange(StringX.parseDate("2008/01/01"), new Date()));
		Date today = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);

		cal.add(Calendar.DATE, -1);

		Date localDate2 = cal.getTime();
		if (localDate2 == null) {
			//System.out.println("localdate2 is null");
			return 2;
		}
		String str1 = new SimpleDateFormat(getVarFormat()).format(localDate2);
		//System.out.println("str1 is " + str1);
		if (str1 == null) {
			//System.out.println("str1 is null");
			return 2;
		}
		String str2 = this.getVarScope();
		if (str2 == null)
			{str2 = "task";}
		if (str2.equalsIgnoreCase("task"))
		{getTarget().getTask().setProperty(getVarName(), str1);}
		else if (str2.equalsIgnoreCase("target"))
			getTarget().setProperty(getVarName(), str1);
		else if (str2.equalsIgnoreCase("are"))
			ARE.setProperty(getVarName(), str1);
		else if (str2.equalsIgnoreCase("system"))
			System.setProperty(getVarName(), str1);
		else
			return 2;
		return 1;
	}

	public String getVarFormat() {
		return this.varFormat;
	}

	public void setVarFormat(String paramString) {
		this.varFormat = paramString;
	}

	public String getVarName() {
		return this.varName;
	}

	public void setVarName(String paramString) {
		this.varName = paramString;
	}

	public String getVarScope() {
		return this.varScope;
	}

	public void setVarScope(String paramString) {
		this.varScope = paramString;
	}

	public static void main(String[] args) {
		ChooseDateUnit cu = new ChooseDateUnit();
		System.out.println(cu.execute());
	}

}

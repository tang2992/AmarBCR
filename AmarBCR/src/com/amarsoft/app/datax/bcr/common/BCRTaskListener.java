package com.amarsoft.app.datax.bcr.common;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.StringFunction;
import com.amarsoft.task.*;
import com.amarsoft.task.util.GenericTaskEventListener;
import java.sql.*;

public class BCRTaskListener extends GenericTaskEventListener
{

	private final String SUCCESSFLAG_OF_FAILED = "FAILED";
	private final String SUCCESSFLAG_OF_UNEXECUTE = "UNEXECUTE";
	private final String SUCCESSFLAG_OF_SUCCESSFUL = "SUCCESSFUL";
	private final String SUCCESSFLAG_OF_WARNING = "WARNING";
	private final String SUCCESSFLAG_OF_UNKNOWN = "UNKNOWN";
	private final String SUCCESSFLAG_OF_RUNNING = "RUNNING";
	private final int LOGTYPE_OF_TASK = 1;
	private final int LOGTYPE_OF_TARGET = 2;
	private final int LOGTYPE_OF_UNIT = 3;
	private boolean taskEventEnabled;
	private boolean targetEventEnabled;
	private boolean unitEventEnabled;
	private boolean routeEventEnabled;
	private String database;
	private Connection connection;
	private PreparedStatement insertPS;
	private PreparedStatement updatePS;
	private PreparedStatement selectPS;
	private ResultSet rs;
	private boolean isContinue;
	private boolean isInsert;
	private boolean isExecuted;
	private int serialNO;
	private String batchDate;
	private Log logger;

	public BCRTaskListener()
	{
		taskEventEnabled = false;
		targetEventEnabled = false;
		unitEventEnabled = false;
		routeEventEnabled = false;
		connection = null;
		insertPS = null;
		updatePS = null;
		selectPS = null;
		serialNO = 0;
		batchDate = null;
		database = "bcr";
		rs = null;
		isContinue = true;
		isInsert = true;
		isExecuted = false;
		logger = ARE.getLog();
	}

	public void listenerDBInit()
	{
		batchDate = batchDate != null ? batchDate : ARE.getProperty("businessOccurDate");
		try
		{
			connection = ARE.getDBConnection(getDatabase());
			if (logger == null)
				logger = ARE.getLog();
			String selectSQL = "SELECT max(SerialNO) as serialNO,max(case when (taskCode = ? and targetCode=? and unitCode =? )then SerialNO else 0 end) as unitMax FROM Batch_Ctrl where BatchDate = ?";
			String insertSQL = "INSERT INTO BATCH_CTRL (BATCHDATE,SERIALNO,TASKCODE,TARGETCODE,UNITCODE,RUNDESC,SUCCESSFLAG,BEGINDATE,ENDDATE,RUNTIME,FIRSTSTARTDATE,LOGTYPE) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
			String updateSQL = "update Batch_Ctrl set SuccessFlag = ? ,BeginDate = ?, EndDate = ?, RunTime= ? where BatchDate = ? and SerialNO = ?";
			selectPS = connection.prepareStatement(selectSQL);
			insertPS = connection.prepareStatement(insertSQL);
			updatePS = connection.prepareStatement(updateSQL);
			logger.info("target 开始启动");
			isExecuted = true;
		}
		catch (SQLException e)
		{
			logger.error("监听器启动失败,将停止监听，该操作不会影响批量运行，错误信息：", e);
			isContinue = false;
		}
	}

	public void listenerDBRelease()
	{
		isExecuted = false;
		release();
	}

	public void runBefore(TaskEvent taskEvent, int logType)
	{
		if (!isExecuted)
			listenerDBInit();
		long currentTime = System.currentTimeMillis();
		ARE.setProperty("startTime", String.valueOf(currentTime));
		ARE.setProperty("beginTime", StringFunction.getTodayNow());
		String taskCode = "";
		String targetCode = "";
		String unitCode = "";
		String errCode = "";
		if (logType == 1)
		{
			taskCode = taskEvent.getTask().getName();
			targetCode = "null";
			unitCode = "null";
			errCode = taskCode;
		} else
		if (logType == 2)
		{
			taskCode = taskEvent.getTask().getName();
			targetCode = taskEvent.getTarget().getName();
			unitCode = "null";
			errCode = (new StringBuilder(String.valueOf(taskCode))).append("@").append(targetCode).toString();
		} else
		{
			taskCode = taskEvent.getTask().getName();
			targetCode = taskEvent.getTarget().getName();
			unitCode = taskEvent.getUnit().getName();
			errCode = (new StringBuilder(String.valueOf(taskCode))).append("@").append(targetCode).append("@").append(unitCode).toString();
		}
		try
		{
			selectPS.setString(1, taskCode);
			selectPS.setString(2, targetCode);
			selectPS.setString(3, unitCode);
			selectPS.setString(4, batchDate);
			rs = selectPS.executeQuery();
			int unitMax = 0;
			if (rs.next())
			{
				serialNO = rs.getInt("serialNO");
				unitMax = rs.getInt("unitMax");
				if (unitMax > 0)
				{
					serialNO = unitMax;
					isInsert = false;
				} else
				{
					isInsert = true;
				}
			} else
			{
				isInsert = true;
			}
			rs.close();
		}
		catch (SQLException e)
		{
			logger.error((new StringBuilder("第")).append(serialNO).append("个单元初始化出错，单元名：").append(errCode).append(",错误信息,监听器启动失败！").toString(), e);
			isContinue = false;
			release();
		}
	}

	public void runAfter(TaskEvent taskEvent, int logType)
	{
		String startTime = ARE.getProperty("startTime");
		String beginTime = ARE.getProperty("beginTime");
		String taskCode = "";
		String targetCode = "";
		String unitCode = "";
		String runDesc = "";
		String errCode = "";
		String result = "";
		if (logType == 1)
		{
			taskCode = taskEvent.getTask().getName();
			targetCode = "null";
			unitCode = "null";
			runDesc = taskEvent.getTask().getDescribe();
			errCode = taskCode;
			result = "SUCCESSFUL";
		} else
		if (logType == 2)
		{
			taskCode = taskEvent.getTask().getName();
			targetCode = taskEvent.getTarget().getName();
			unitCode = "null";
			runDesc = taskEvent.getTarget().getDescribe();
			errCode = (new StringBuilder(String.valueOf(taskCode))).append("@").append(targetCode).toString();
			result = statusToString(taskEvent.getTarget().getLastUnitExecuteStatus());
		} else
		{
			taskCode = taskEvent.getTask().getName();
			targetCode = taskEvent.getTarget().getName();
			unitCode = taskEvent.getUnit().getName();
			runDesc = taskEvent.getUnit().getDescribe();
			errCode = (new StringBuilder(String.valueOf(taskCode))).append("@").append(targetCode).append("@").append(unitCode).toString();
			result = statusToString(taskEvent.getTarget().getLastUnitExecuteStatus());
		}
		String timeDis = null;
		long currentTime = System.currentTimeMillis();
		timeDis = getTimeDistance(startTime, String.valueOf(currentTime));
		String endTime = StringFunction.getTodayNow();
		try
		{
			if (isInsert)
			{
				insertPS.setString(1, batchDate);
				insertPS.setString(2, String.valueOf(++serialNO));
				insertPS.setString(3, taskCode);
				insertPS.setString(4, targetCode);
				insertPS.setString(5, unitCode);
				insertPS.setString(6, runDesc);
				insertPS.setString(7, result);
				insertPS.setString(8, beginTime);
				insertPS.setString(9, endTime);
				insertPS.setString(10, timeDis);
				insertPS.setString(11, beginTime);
				insertPS.setString(12, LogTypeToString(logType));
				insertPS.executeUpdate();
			} else
			{
				updatePS.setString(1, result);
				updatePS.setString(2, beginTime);
				updatePS.setString(3, endTime);
				updatePS.setString(4, timeDis);
				updatePS.setString(5, batchDate);
				updatePS.setInt(6, serialNO);
				updatePS.executeUpdate();
			}
		}
		catch (SQLException e)
		{
			logger.error((new StringBuilder("第")).append(serialNO).append("个单元初始化出错，单元名：").append(errCode).append(",错误信息,监听器异常，将停止监听，错误信息:").toString(), e);
			isContinue = false;
			release();
		}
		logger.info((new StringBuilder("isInsert:")).append(isInsert).append(",inputDate:").append(batchDate).append(",serialNO:").append(serialNO).append(",TaskCode:").append(taskCode).append(",startTime:").append(beginTime).append(",endTime:").append(endTime).append(",unitCode:").append(unitCode).append(",unitDisc:").append(runDesc).append(",timeDis:").append(timeDis).toString());
	}

	public void taskStart(TaskEvent taskEvent)
	{
		logger.info((new StringBuilder("进入 Task=")).append(taskEvent.getTask().getName()).append("[").append(taskEvent.getTask().getDescribe()).append("]").toString());
		listenerDBInit();
		if (!isTaskEventEnabled())
		{
			return;
		} else
		{
			runBefore(taskEvent, 1);
			return;
		}
	}

	public void taskExit(TaskEvent taskEvent)
	{
		logger.info((new StringBuilder("退出 Task=")).append(taskEvent.getTask().getName()).append("[").append(taskEvent.getTask().getDescribe()).append("]").toString());
		if (!isTaskEventEnabled())
		{
			listenerDBRelease();
			return;
		} else
		{
			runAfter(taskEvent, 1);
			listenerDBRelease();
			return;
		}
	}

	public void targetStart(TaskEvent taskEvent)
	{
		logger.info((new StringBuilder("进入 Target=")).append(taskEvent.getTarget().getName()).append("[").append(taskEvent.getTarget().getDescribe()).append("]").toString());
		if (!isTargetEventEnabled() || !isContinue)
		{
			return;
		} else
		{
			runBefore(taskEvent, 2);
			return;
		}
	}

	public void targetExit(TaskEvent taskEvent)
	{
		logger.info((new StringBuilder("退出 Target=")).append(taskEvent.getTarget().getName()).append("[").append(taskEvent.getTarget().getDescribe()).append("]").toString());
		if (!isTargetEventEnabled() || !isContinue)
		{
			return;
		} else
		{
			runAfter(taskEvent, 2);
			return;
		}
	}

	public void unitStart(TaskEvent taskEvent)
	{
		logger.info((new StringBuilder("进入 Unit=")).append(taskEvent.getUnit().getName()).append("[").append(taskEvent.getUnit().getDescribe()).append("]").toString());
		if (!isUnitEventEnabled() || !isContinue)
		{
			return;
		} else
		{
			runBefore(taskEvent, 3);
			return;
		}
	}

	public void unitExit(TaskEvent taskEvent)
	{
		logger.info((new StringBuilder("退出 Unit=")).append(taskEvent.getUnit().getName()).append("[").append(taskEvent.getUnit().getDescribe()).append("]").toString());
		if (!isUnitEventEnabled() || !isContinue)
		{
			return;
		} else
		{
			runAfter(taskEvent, 3);
			return;
		}
	}

	private String getTimeDistance(String startTime, String endTime)
	{
		String reback = null;
		long start = Long.parseLong(startTime) / 1000L;
		long end = Long.parseLong(endTime) / 1000L;
		long dis = end - start;
		String hour = String.valueOf(dis / 3600L);
		String minute = String.valueOf((dis % 3600L) / 60L);
		String second = String.valueOf(dis % 60L);
		minute = minute.length() > 1 ? minute : (new StringBuilder("0")).append(minute).toString();
		second = second.length() > 1 ? second : (new StringBuilder("0")).append(second).toString();
		reback = (new StringBuilder(String.valueOf(hour))).append(":").append(minute).append(":").append(second).toString();
		return reback;
	}

	public void release()
	{
		if (connection != null)
			try
			{
				connection.close();
				connection = null;
			}
			catch (SQLException e)
			{
				logger.error("关闭connection异常");
			}
		if (rs != null)
			try
			{
				rs.close();
				rs = null;
			}
			catch (SQLException e)
			{
				logger.error("关闭rs异常");
			}
		if (selectPS != null)
			try
			{
				selectPS.close();
				selectPS = null;
			}
			catch (SQLException e)
			{
				logger.error("关闭selectPS异常");
			}
		if (updatePS != null)
			try
			{
				updatePS.close();
				updatePS = null;
			}
			catch (SQLException e)
			{
				logger.error("关闭updatePS异常");
			}
		if (insertPS == null)
			return;
		try
		{
			insertPS.close();
			insertPS = null;
		}
		catch (SQLException e)
		{
			logger.error("关闭insertPS异常");
		}
	}

	private String statusToString(int executeStatus)
	{
		String tmp = "";
		if (executeStatus == 0)
			tmp = "UNEXECUTE";
		else
		if (executeStatus == 1)
			tmp = "SUCCESSFUL";
		else
		if (executeStatus == 3)
			tmp = "WARNING";
		else
		if (executeStatus == 2)
			tmp = "FAILED";
		else
		if (executeStatus == -1)
			tmp = "UNKNOWN";
		else
		if (executeStatus == 4)
			tmp = "RUNNING";
		else
			tmp = (new StringBuilder()).append(executeStatus).toString();
		return tmp;
	}

	private String LogTypeToString(int LogType)
	{
		String tmp = "";
		if (LogType == 1)
			tmp = "TASK";
		else
		if (LogType == 2)
			tmp = "TARGET";
		else
		if (LogType == 3)
			tmp = "UNIT";
		else
			tmp = "OTHER";
		return tmp;
	}

	private void printEvent(TaskEvent taskEvent)
	{
		Task task = taskEvent.getTask();
		Target target = taskEvent.getTarget();
		ExecuteUnit unit = taskEvent.getUnit();
		Route route = taskEvent.getRoute();
		logger.info((new StringBuilder("Task=")).append(task.getName()).append("[").append(task.getDescribe()).append("]").toString());
		if (target != null)
			logger.info((new StringBuilder("Target=")).append(target.getName()).append("[").append(target.getDescribe()).append("]").toString());
		if (unit != null)
			logger.info((new StringBuilder("Unit=")).append(unit.getName()).append("[").append(unit.getDescribe()).append("]").toString());
		if (route == null)
		{
			return;
		} else
		{
			logger.info((new StringBuilder(String.valueOf(route.nextUnit().getName()))).append("]").toString());
			return;
		}
	}

	public void targetAdded(TaskEvent e)
	{
		if (!isTargetEventEnabled())
		{
			return;
		} else
		{
			printEvent(e);
			return;
		}
	}

	public void unitAdded(TaskEvent e)
	{
		if (!isUnitEventEnabled())
		{
			return;
		} else
		{
			printEvent(e);
			return;
		}
	}

	public void routeAdded(TaskEvent e)
	{
		if (!isRouteEventEnabled())
		{
			return;
		} else
		{
			printEvent(e);
			return;
		}
	}

	public void targetRemoved(TaskEvent taskEvent)
	{
		if (!isTargetEventEnabled())
		{
			return;
		} else
		{
			printEvent(taskEvent);
			return;
		}
	}

	public void routeRemoved(TaskEvent taskEvent)
	{
		if (!isRouteEventEnabled())
		{
			return;
		} else
		{
			printEvent(taskEvent);
			return;
		}
	}

	public void unitRemoved(TaskEvent taskEvent)
	{
		if (!isUnitEventEnabled())
		{
			return;
		} else
		{
			printEvent(taskEvent);
			return;
		}
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	public final boolean isRouteEventEnabled()
	{
		return routeEventEnabled;
	}

	public final void setRouteEventEnabled(boolean routeEventEnabled)
	{
		this.routeEventEnabled = routeEventEnabled;
	}

	public final boolean isTargetEventEnabled()
	{
		return targetEventEnabled;
	}

	public final void setTargetEventEnabled(boolean targetEventEnabled)
	{
		this.targetEventEnabled = targetEventEnabled;
	}

	public final boolean isTaskEventEnabled()
	{
		return taskEventEnabled;
	}

	public final void setTaskEventEnabled(boolean taskEventEnabled)
	{
		this.taskEventEnabled = taskEventEnabled;
	}

	public final boolean isUnitEventEnabled()
	{
		return unitEventEnabled;
	}

	public final void setUnitEventEnabled(boolean unitEventEnabled)
	{
		this.unitEventEnabled = unitEventEnabled;
	}
}
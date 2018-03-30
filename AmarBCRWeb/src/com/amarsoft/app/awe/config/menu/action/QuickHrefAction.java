package com.amarsoft.app.awe.config.menu.action;

import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.BizObjectQuery;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.log.Log;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DecimalFormat;

public class QuickHrefAction {
	private String quickId;
	private DecimalFormat format = new DecimalFormat("0000");

	public void setQuickId(String quickId) {
		this.quickId = quickId;
	}

	public String getQuickId() {
		return quickId;
	}

	public String deleteQuick(JBOTransaction tx) {
		System.out.println("---------deleteQuick--------");
		try {
			JBOFactory.getBizObjectManager("jbo.awe.AWE_QUICK_HREF", tx)
					.createQuery("delete from O where QuickId =:QuickId").setParameter("QuickId", this.quickId)
					.executeUpdate();
			return "SUCCESS";
		} catch (Exception e) {
			e.printStackTrace();
			ARE.getLog().debug(e);
			return "删除数据异常！";
		}

	}

	public String deleteQuick() {
		Connection connection = null;
		PreparedStatement ps = null;
		try {
			connection = ARE.getDBConnection("ecr");
			ps = connection.prepareStatement("delete from AWE_QUICK_HREF where QuickId = ?");
			ps.setString(1, this.getQuickId());
			ps.executeUpdate();
			return "SUCCESS";
		} catch (Exception e) {
			e.printStackTrace();
			ARE.getLog().debug(e);
			// return "删除数据异常！";
			return "ERROR";
		}finally{
			if(ps!=null){
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null){
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

	}

	public String saveSort(JBOTransaction tx) {
		if (this.quickId == null)
			return "数据传递异常！";
		String[] sQuicks = this.quickId.split("@");
		for (int i = 0; i < sQuicks.length; i++) {
			try {
				JBOFactory.getBizObjectManager("jbo.awe.AWE_QUICK_HREF", tx)
						.createQuery("update O set SortNo = :SortNo where QuickId = :QuickId")
						.setParameter("SortNo", this.format.format(i)).setParameter("QuickId", sQuicks[i])
						.executeUpdate();
			} catch (Exception e) {
				ARE.getLog().debug(e);
				return "保存排序异常！";
			}
		}
		return "保存成功！";
	}

}
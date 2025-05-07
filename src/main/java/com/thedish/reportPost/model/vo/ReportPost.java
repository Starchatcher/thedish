package com.thedish.reportPost.model.vo;

import java.sql.Date;

public class ReportPost implements java.io.Serializable{
	private static final long serialVersionUID = 7110392793825329557L;

	private int reportId;
	private int boardId;
	private String reason;
	private String reporterId;
	private java.sql.Date reportedAt;
	private String isChecked;
	private java.sql.Date checked_at;
	
	
	public ReportPost() {
		super();
		// TODO Auto-generated constructor stub
	}


	public ReportPost(int reportId, int boardId, String reason, String reporterId, Date reportedAt, String isChecked,
			Date checked_at) {
		super();
		this.reportId = reportId;
		this.boardId = boardId;
		this.reason = reason;
		this.reporterId = reporterId;
		this.reportedAt = reportedAt;
		this.isChecked = isChecked;
		this.checked_at = checked_at;
	}


	public int getReportId() {
		return reportId;
	}


	public void setReportId(int reportId) {
		this.reportId = reportId;
	}


	public int getBoardId() {
		return boardId;
	}


	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}


	public String getReason() {
		return reason;
	}


	public void setReason(String reason) {
		this.reason = reason;
	}


	public String getReporterId() {
		return reporterId;
	}


	public void setReporterId(String reporterId) {
		this.reporterId = reporterId;
	}


	public java.sql.Date getReportedAt() {
		return reportedAt;
	}


	public void setReportedAt(java.sql.Date reportedAt) {
		this.reportedAt = reportedAt;
	}


	public String getIsChecked() {
		return isChecked;
	}


	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}


	public java.sql.Date getChecked_at() {
		return checked_at;
	}


	public void setChecked_at(java.sql.Date checked_at) {
		this.checked_at = checked_at;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	@Override
	public String toString() {
		return "ReportPost [reportId=" + reportId + ", boardId=" + boardId + ", reason=" + reason + ", reporterId="
				+ reporterId + ", reportedAt=" + reportedAt + ", isChecked=" + isChecked + ", checked_at=" + checked_at
				+ "]";
	}
	
}

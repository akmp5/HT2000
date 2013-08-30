package com.ht2000.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TaskInfoIOBean {
	
	private String taskId = null;
	private String taskDesc = null;
	private String start_utc = null;
	private String inputAddr = null;
	private String outputAddr = null;

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getTaskId() {
		return taskId;
	}
	public void setTaskDesc(String taskDesc) {
		this.taskDesc = taskDesc;
	}
	public String getTaskDesc() {
		return taskDesc;
	}
	public void setStart_utc(String start_utc) {
		Date start_date = new Date();
		start_date.setTime(Long.parseLong(start_utc)*1000);
		SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		this.start_utc = time.format(start_date);
	}
	public String getStart_utc() {
		return start_utc;
	}
	public String getInputAddr() {
		return inputAddr;
	}
	public void setInputAddr(String inputAddr) {
		this.inputAddr = inputAddr;
	}
	public String getOutputAddr() {
		return outputAddr;
	}
	public void setOutputAddr(String outputAddr) {
		this.outputAddr = outputAddr;
	}
}

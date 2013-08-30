package com.ht2000.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class UserInfoBean {

	private String name = null;
	private String pswd = null;
	private String error = null;
	private String startUtc = null;
	private String checkin = null;
	private String permission = null;
	private String validity = null;
	
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setPswd(String pswd) {
		this.pswd = pswd;
	}
	public String getPswd() {
		return pswd;
	}
	public void setError(String error) {
		this.error = error;
	}
	public String getError() {
		return error;
	}
	public void setStartUtc(String startUtc) {
		Date start_date = new Date();
		start_date.setTime(Long.parseLong(startUtc)*1000);
		SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		this.startUtc = time.format(start_date);
	}
	public String getStartUtc() {
		return startUtc;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	public String getPermission() {
		return permission;
	}
	public void setValidity(String validity) {
		if(validity.equals("4294967295")){
			this.validity = "永久有效";
		}else{
			Date start_date = new Date();
			start_date.setTime(Long.parseLong(validity)*1000);
			SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			this.validity = time.format(start_date).substring(0,10);
		}
	}
	public String getValidity() {
		if(validity.length() < 10){
			return validity;
		}else{
			return validity.substring(0,10);
		}
	}
}

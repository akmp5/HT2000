package com.ht2000.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MosaicInfoBean {

	private String id = "";
	private String start_utc = "";
	private String desc = "";

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setStart_utc(String start_utc) {
		Date start_date = new Date();
		start_date.setTime(Long.parseLong(start_utc) * 1000);
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.start_utc = time.format(start_date);
	}

	public String getStart_utc() {
		return start_utc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getDesc() {
		return desc;
	}
}

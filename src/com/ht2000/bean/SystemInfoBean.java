package com.ht2000.bean;


public class SystemInfoBean {

	private String macaddr = null;
	private String ipaddr = null;
	private String netmask = null;
	private String gateway = null;
	private String version = null;
	private String desc = null;
	private String usb = null;
	private String serialnum = null;
	
	public void setMacaddr(String macaddr) {
		this.macaddr = macaddr;
	}
	public String getMacaddr() {
		return macaddr;
	}
	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}
	public String getIpaddr() {
		return ipaddr;
	}
	public void setNetmask(String netmask) {
		this.netmask = netmask;
	}
	public String getNetmask() {
		return netmask;
	}
	public void setGateway(String gateway) {
		this.gateway = gateway;
	}
	public String getGateway() {
		return gateway;
	}
	public void setUsb(String usb) {
		this.usb = usb;
	}
	public String getUsb() {
		return usb;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getDesc() {
		return desc;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getVersion() {
		return version;
	}
	public String getSerialnum() {
		return serialnum;
	}
	public void setSerialnum(String serialnum) {
		this.serialnum = serialnum;
	}
	
	
}

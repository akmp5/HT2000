package com.ht2000.util;

import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ht2000.bean.LicenseInfoBean;
import com.ht2000.bean.SystemInfoBean;

public class SystemUtil {

	public static SystemInfoBean parseBaseInfo(SOAPMessage soapMessage){
		SystemInfoBean systemInfoBean = null;
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList baseInfoNodeList = soapBody.getElementsByTagName("baseinfo");
			if(baseInfoNodeList.getLength() > 0){
				systemInfoBean = new SystemInfoBean();
				Node systemInfoNode = baseInfoNodeList.item(0);
				NamedNodeMap attrs = systemInfoNode.getAttributes();
				systemInfoBean.setMacaddr(attrs.getNamedItem("mac").getNodeValue());
				systemInfoBean.setIpaddr(attrs.getNamedItem("ipaddr").getNodeValue());
				systemInfoBean.setNetmask(attrs.getNamedItem("netmask").getNodeValue());
				systemInfoBean.setGateway(attrs.getNamedItem("gateway").getNodeValue());
				systemInfoBean.setVersion(attrs.getNamedItem("version").getNodeValue());
				systemInfoBean.setSerialnum(attrs.getNamedItem("serialnum").getNodeValue());
				systemInfoBean.setDesc(attrs.getNamedItem("desc").getNodeValue());
		}
		} catch (SOAPException e) {
			System.out.println("[parseSystemInfo]soap no body");
		}
		return systemInfoBean;
	}
	
	
	public static LicenseInfoBean parseLicenseInfo(SOAPMessage soapMessage){
		LicenseInfoBean licenseInfoBean = null;
		//TODO Add by yk start 
//		if(soapMessage == null){
//			systemInfoBean = new SystemInfoBean();
//			systemInfoBean.setMacaddr("00.FF.CB.2D.1E.D1");
//			systemInfoBean.setIpaddr("192.168.244.142");
//			systemInfoBean.setNetmask("192.168.244.254");
//			systemInfoBean.setGateway("192.168.244.254");
//			systemInfoBean.setVersion("1.1");
//			systemInfoBean.setLicense("1111");
//			systemInfoBean.setPublished("1");
//			systemInfoBean.setDesc("2222");
//			systemInfoBean.setUsb("1");
////			<baseinfo in_mac="xx.xx.xx.xx.xx.xx" in_ipaddr="xxx.xxx.xxx.xxx" in_netmask="xxx.xxx.xxx.xxx" in_gateway="xxx.xxx.xxx.xxx"  
////			out_mac="xx.xx.xx.xx.xx.xx" out_ipaddr="xxx.xxx.xxx.xxx" out_netmask="xxx.xxx.xxx.xxx" out_gateway="xxx.xxx.xxx.xxx" 
////			desc="%s" version="%d.%d" license="%s" published="0x%x" usb_status=\"%d\" />
//			return systemInfoBean;
//		}
//		//TODO end 
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList licenseInfoNodeList = soapBody.getElementsByTagName("licenseinfo");
			if(licenseInfoNodeList.getLength() > 0){
				licenseInfoBean = new LicenseInfoBean();
				Node systemInfoNode = licenseInfoNodeList.item(0);
				NamedNodeMap attrs = systemInfoNode.getAttributes();
				licenseInfoBean.setDesc(attrs.getNamedItem("desc").getNodeValue());
				licenseInfoBean.setEndTimeAbs(attrs.getNamedItem("end_time_abs").getNodeValue());
				licenseInfoBean.setLicenseLevel(attrs.getNamedItem("license_level").getNodeValue());
				licenseInfoBean.setMaxInputTask(attrs.getNamedItem("max_input_task").getNodeValue());
				licenseInfoBean.setMaxOutputTask(attrs.getNamedItem("max_output_task").getNodeValue());
				licenseInfoBean.setMaxWorkTimes(attrs.getNamedItem("max_work_times").getNodeValue());
				licenseInfoBean.setPublished(attrs.getNamedItem("published").getNodeValue());
		}
		} catch (SOAPException e) {
			System.out.println("[parseSystemInfo]soap no body");
		}
		return licenseInfoBean;
	}
	
	public static String parseCPUInfo(SOAPMessage soapMessage){
		StringBuffer resultJson = new StringBuffer();
		
//		//TODO Add by yk start 
//		if(soapMessage == null){
//				resultJson.append("[");
//					resultJson.append("{\"all\":[{\"label\": \"CPU总使用率\",\"data\": [");
//					for(int i=0; i<3; i++){
//						resultJson.append("["+i+",12345]");
//						if(i != 2){
//							resultJson.append(",");
//						}
//					resultJson.append("]}],\"child\":[");
//				}
//				for(int j=0; j<3; j++){
//						resultJson.append("{\"label\": \"CPU"+j+"使用率\",\"data\": [");
//						for(int k=0; k<3; k++){
//							resultJson.append("["+k+",12345]");
//							if(k != 2){
//								resultJson.append(",");
//							}
//						}
//						resultJson.append("]}");
//						if(j != 2){
//							resultJson.append(",");
//						}
//				}
//				resultJson.append("]}]");
//			return resultJson.toString();
//		}
//		//TODO end 
		try {
			resultJson.append("[");
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList cpuInfoNodeList = soapBody.getElementsByTagName("cpuinfo");
			if(cpuInfoNodeList.getLength() > 0){
				resultJson.append("{\"all\":[{\"label\": \"CPU总使用率\",\"data\": [");
				for(int i=0; i<cpuInfoNodeList.getLength(); i++){
					Node cpuInfoNode = cpuInfoNodeList.item(i);
					NamedNodeMap attrs = cpuInfoNode.getAttributes();
					resultJson.append("["+i+","+attrs.getNamedItem("ef").getNodeValue()+"]");
					if(i != cpuInfoNodeList.getLength()-1){
						resultJson.append(",");
					}
				}
				resultJson.append("]}],\"child\":[");
			}
			for(int j=0; j<16; j++){
				NodeList tempCpuInfoNodeList = soapBody.getElementsByTagName("cpu"+j+"info");
				if(tempCpuInfoNodeList.getLength() > 0){
					resultJson.append("{\"label\": \"CPU"+j+"使用率\",\"data\": [");
					for(int k=0; k<tempCpuInfoNodeList.getLength(); k++){
						Node tempCpuInfoNode = tempCpuInfoNodeList.item(k);
						NamedNodeMap tempAttrs = tempCpuInfoNode.getAttributes();
						resultJson.append("["+k+","+tempAttrs.getNamedItem("ef").getNodeValue()+"]");
						if(k != tempCpuInfoNodeList.getLength()-1){
							resultJson.append(",");
						}
					}
					resultJson.append("]}");
					if(j != 15){
						resultJson.append(",");
					}
				}
			}
			resultJson.append("]}]");
		} catch (SOAPException e) {
			System.out.println("[parseSystemInfo]soap no body");
		}
		return resultJson.toString();
	}
	
	public static String parseNetioInfo(SOAPMessage soapMessage){
		StringBuffer rxsb = new StringBuffer();
		StringBuffer txsb = new StringBuffer();
		

//		//TODO Add by yk start 
//		if(soapMessage == null){
//				rxsb.append("{\"label\": \"接收速率 B/s\",\"color\":0,\"data\": [");
//				txsb.append("{\"label\": \"发送速率 B/s\",\"color\":1,\"data\": [");
//				for(int i=0; i<4; i++){
//					rxsb.append("["+i+",12345]");
//					txsb.append("["+i+",12345]");
//					if(i != 3){
//						rxsb.append(",");
//						txsb.append(",");
//					}
//				}
//				rxsb.append("]}");
//				txsb.append("]}");
//				System.out.println("["+rxsb.toString()+","+txsb.toString()+"]");
//				return "["+rxsb.toString()+","+txsb.toString()+"]";	
//		}
////		<netioinfo rx="12345" tx="12345" />
////		<netioinfo rx="12345" tx="12345" />
////		<netioinfo rx="12345" tx="12345" />
////		<netioinfo rx="12345" tx="12345" />
//		//TODO end 
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList cpuInfoNodeList = soapBody.getElementsByTagName("netioinfo");
			if(cpuInfoNodeList.getLength() > 0){
				rxsb.append("{\"label\": \"接收速率 B/s\",\"color\":0,\"data\": [");
				txsb.append("{\"label\": \"发送速率 B/s\",\"color\":1,\"data\": [");
				for(int i=0; i<cpuInfoNodeList.getLength(); i++){
					Node cpuInfoNode = cpuInfoNodeList.item(i);
					NamedNodeMap attrs = cpuInfoNode.getAttributes();
					rxsb.append("["+i+","+attrs.getNamedItem("rx").getNodeValue()+"]");
					txsb.append("["+i+","+attrs.getNamedItem("tx").getNodeValue()+"]");
					if(i != cpuInfoNodeList.getLength()-1){
						rxsb.append(",");
						txsb.append(",");
					}
				}
				rxsb.append("]}");
				txsb.append("]}");
			}
		} catch (SOAPException e) {
			System.out.println("[parseSystemInfo]soap no body");
		}
		System.out.println("["+rxsb.toString()+","+txsb.toString()+"]");
		return "["+rxsb.toString()+","+txsb.toString()+"]";
	}
	
	public static String parseUpdateInfo(SOAPMessage soapMessage) {
		String result = null;
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			Node upgrateNode = soapBody.getElementsByTagName("system").item(0);
			result = upgrateNode.getAttributes().getNamedItem("desc")
					.getNodeValue();
		} catch (SOAPException e) {
			e.printStackTrace();
		}
		return result;
	}
	
}

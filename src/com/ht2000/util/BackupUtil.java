package com.ht2000.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class BackupUtil {

	public static String parseBackupList(SOAPMessage soapMessage) {
		StringBuffer result = new StringBuffer();
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList backupNodeList = soapBody.getElementsByTagName("target");
			if (backupNodeList.getLength() > 0) {
				for (int i = 0; i < backupNodeList.getLength(); i++) {
					Node backupNode = backupNodeList.item(i);
					result.append("{\"ipaddr\":\""
							+ backupNode.getAttributes().getNamedItem("ipaddr")
									.getNodeValue() + "\"}");
					if (i != backupNodeList.getLength() - 1)
						result.append(",");
				}
			}
		} catch (SOAPException e) {
			System.out.println("[parseTaskList]soap no body");
		}
		return "[" + result.toString() + "]";
	}

	public static String parseTaskList(SOAPMessage soapMessage) {
		StringBuffer result = new StringBuffer();
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList taskNodeList = soapBody.getElementsByTagName("task");
			if (taskNodeList.getLength() > 0) {
				for (int i = 0; i < taskNodeList.getLength(); i++) {
					Node taskNode = taskNodeList.item(i);
					result.append("{target:\""
							+ taskNode.getAttributes().getNamedItem("target")
									.getNodeValue()
							+ "\""
							+ ",id:\""
							+ taskNode.getAttributes().getNamedItem("id")
									.getNodeValue()
							+ "\",startUtc:\""
							+ formatUtc(taskNode.getAttributes()
									.getNamedItem("start_utc").getNodeValue())
							+ "\",desc:\""
							+ taskNode.getAttributes().getNamedItem("desc")
									.getNodeValue() + "\"}");
					if (i != taskNodeList.getLength() - 1)
						result.append(",");
				}
			}
		} catch (SOAPException e) {
			System.out.println("[parseTaskList]soap no body");
		}
		return "[" + result.toString() + "]";
	}

	private static String formatUtc(String start_utc) {
		Date start_date = new Date();
		start_date.setTime(Long.parseLong(start_utc) * 1000);
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return time.format(start_date);
	}
}

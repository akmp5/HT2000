package com.ht2000.util;

import java.util.ArrayList;

import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ht2000.bean.AbrInfoBean;

public class AbrUtil {

	public static ArrayList<AbrInfoBean> parseAbrList(SOAPMessage soapMessage) {
		ArrayList<AbrInfoBean> abrList = null;
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList abrNodeList = soapBody.getElementsByTagName("abr");
			if (abrNodeList.getLength() > 0) {
				abrList = new ArrayList<AbrInfoBean>();
				for (int i = 0; i < abrNodeList.getLength(); i++) {
					AbrInfoBean abrInfoBean = new AbrInfoBean();
					Node abrNode = abrNodeList.item(i);
					abrInfoBean.setId(abrNode.getAttributes()
							.getNamedItem("id").getNodeValue());
					abrInfoBean.setDesc(abrNode.getAttributes().getNamedItem(
							"desc").getNodeValue());
					abrInfoBean.setStart_utc(abrNode.getAttributes()
							.getNamedItem("start_utc").getNodeValue());
					abrList.add(abrInfoBean);
				}
			}
		} catch (SOAPException e) {
			System.out.println("[parseAbrList]soap no body");
		}
		return abrList;
	}

	public static String parseAbrInfo(SOAPMessage soapMessage) {
		StringBuffer resultJson = new StringBuffer();
		try {
			resultJson.append("{");
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList abrList = soapBody.getElementsByTagName("abr");
			Node abrNode = abrList.item(0);
			NamedNodeMap abrAttr = abrNode.getAttributes();
			resultJson.append("id:\""
					+ abrAttr.getNamedItem("id").getNodeValue()
					+ "\",start_utc:\""
					+ abrAttr.getNamedItem("start_utc").getNodeValue()
					+ "\",desc:\""
					+ abrAttr.getNamedItem("desc").getNodeValue() + "\"");
			NodeList inputList = soapBody.getElementsByTagName("input");
			if (inputList.getLength() > 0) {
				resultJson.append(",input:[");
				for (int i = 0; i < inputList.getLength(); i++) {
					Node inputNode = inputList.item(i);
					resultJson.append("{addr:\""
							+ inputNode.getAttributes().getNamedItem("addr")
									.getNodeValue()
							+ "\""
							+ ",bandwidth:\""
							+ inputNode.getAttributes().getNamedItem(
									"bandwidth").getNodeValue() + "\"}");
					if (i != inputList.getLength() - 1) {
						resultJson.append(",");
					}
				}
				resultJson.append("]");
			}

			NodeList outputList = soapBody.getElementsByTagName("output");
			Node outputNode = outputList.item(0);
			resultJson.append(",output:\""
					+ outputNode.getAttributes().getNamedItem("addr")
							.getNodeValue() + "\"}");
		} catch (SOAPException e) {
			System.out.println("[parseAbrInfo]soap no body");
		}
		return resultJson.toString();
	}

	public static String parseService(SOAPMessage soapMessage) {
		StringBuffer serviceJson = new StringBuffer();
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			Node abrNode = soapBody.getElementsByTagName("abr").item(0);
			NamedNodeMap infoAttrs = abrNode.getAttributes();
			if (infoAttrs.getNamedItem("error").getNodeValue().equals("0")) {
				serviceJson.append("{error:\"0\",service:[");
				NodeList serviceNodeList = soapBody
						.getElementsByTagName("stream");
				for (int i = 0; i < serviceNodeList.getLength(); i++) {
					Node serviceNode = serviceNodeList.item(i);
					NamedNodeMap serviceAttrs = serviceNode.getAttributes();
					serviceJson.append("{addr:\""
							+ serviceAttrs.getNamedItem("addr").getNodeValue()
							+ "\""
							+ ",bandwidth:\""
							+ serviceAttrs.getNamedItem("bandwidth")
									.getNodeValue()
							+ "\""
							+ ",service_id:\""
							+ serviceAttrs.getNamedItem("src_service_id")
									.getNodeValue()
							+ "\""
							+ ",service_name:\""
							+ serviceAttrs.getNamedItem("src_service_name")
									.getNodeValue() + "\"" + ",desc:\""
							+ serviceAttrs.getNamedItem("desc").getNodeValue()
							+ "\"}");
					if (i != serviceNodeList.getLength() - 1)
						serviceJson.append(",");
				}
				serviceJson.append("]}");
			} else {
				serviceJson
						.append("{error:\"1\",desc:\""
								+ infoAttrs.getNamedItem("desc").getNodeValue()
								+ "\"}");
			}
		} catch (SOAPException e) {
			System.out.println("[parseService]soap no body");
		}
		return serviceJson.toString();
	}
}

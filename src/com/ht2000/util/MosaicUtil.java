package com.ht2000.util;

import java.util.ArrayList;

import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ht2000.bean.MosaicInfoBean;

public class MosaicUtil {

	public static ArrayList<MosaicInfoBean> parseMosaicList(SOAPMessage soapMessage) {
		ArrayList<MosaicInfoBean> mosaicList = null;
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList mosaicNodeList = soapBody.getElementsByTagName("mosaic");
			if (mosaicNodeList.getLength() > 0) {
				mosaicList = new ArrayList<MosaicInfoBean>();
				for (int i = 0; i < mosaicNodeList.getLength(); i++) {
					MosaicInfoBean mosaicInfoBean = new MosaicInfoBean();
					Node mosaicNode = mosaicNodeList.item(i);
					mosaicInfoBean.setId(mosaicNode.getAttributes()
							.getNamedItem("id").getNodeValue());
					mosaicInfoBean.setDesc(mosaicNode.getAttributes().getNamedItem(
							"desc").getNodeValue());
					mosaicInfoBean.setStart_utc(mosaicNode.getAttributes()
							.getNamedItem("start_utc").getNodeValue());
					mosaicList.add(mosaicInfoBean);
				}
			}
		} catch (SOAPException e) {
			System.out.println("[parseAbrList]soap no body");
		}
		return mosaicList;
	}

	public static String parseMosaicInfo(SOAPMessage soapMessage) {
		StringBuffer resultJson = new StringBuffer();
		try {
			resultJson.append("{");
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList mosaicList = soapBody.getElementsByTagName("mosaic");
			Node mosaicNode = mosaicList.item(0);
			NamedNodeMap mosaicAttr = mosaicNode.getAttributes();
			resultJson.append("id:\""
					+ mosaicAttr.getNamedItem("id").getNodeValue()
					+ "\",mode:\""
					+ mosaicAttr.getNamedItem("mode").getNodeValue()
					+ "\",desc:\""
					+ mosaicAttr.getNamedItem("desc").getNodeValue() + "\"");
			NodeList inputList = soapBody.getElementsByTagName("input");
			if (inputList.getLength() > 0) {
				resultJson.append(",input:[");
				for (int i = 0; i < inputList.getLength(); i++) {
					Node inputNode = inputList.item(i);
					resultJson.append("{addr:\""
							+ inputNode.getAttributes().getNamedItem("addr")
									.getNodeValue()
							+ "\""
							+ ",index:\""
							+ inputNode.getAttributes().getNamedItem(
									"index").getNodeValue()+"\""
							 + ",desc:\""
							 + inputNode.getAttributes().getNamedItem(
											"desc").getNodeValue()+"\""
						     + ",resolution:\""
						      + inputNode.getAttributes().getNamedItem(
								 "resolution").getNodeValue()+"\""
							 + ",service_id:\""
							      + inputNode.getAttributes().getNamedItem(
									 "src_service_id").getNodeValue()+"\""
						     + ",service_name:\""
							  + inputNode.getAttributes().getNamedItem(
										 "src_service_name").getNodeValue()+"\""
							 + ",num:\""
							 + inputNode.getAttributes().getNamedItem(
													 "num").getNodeValue()+"\""
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
			resultJson.append(",out:\""
					+ outputNode.getAttributes().getNamedItem("addr")
							.getNodeValue() +"\""	
					 + ",outputmode:\""
					  + outputNode.getAttributes().getNamedItem(
								 "mode").getNodeValue()+"\""		
				     + ",bitrate:\""
				     + outputNode.getAttributes().getNamedItem(
						  "bitrate").getNodeValue()+"\""	
					 + ",of:\""
					 + outputNode.getAttributes().getNamedItem(
						 "of").getNodeValue()+"\""
						 + ",hls_time:\""
						 + outputNode.getAttributes().getNamedItem(
							 "hls_time").getNodeValue()+"\""
							 + ",hls_list_size:\""
							 + outputNode.getAttributes().getNamedItem(
								 "hls_list_size").getNodeValue()+
			"\"}");
		} catch (SOAPException e) {
			System.out.println("[parseMosaicInfo]soap no body");
		}
		return resultJson.toString();
	}

	public static String parseService(SOAPMessage soapMessage) {
		StringBuffer serviceJson = new StringBuffer();
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			Node abrNode = soapBody.getElementsByTagName("mosaic").item(0);
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
							+ ",index:\""
							+ serviceAttrs.getNamedItem("index")
									.getNodeValue()
//							 + "\""
//							+ ",num:\""
//							+ serviceAttrs.getNamedItem("num")
//									.getNodeValue()
						    + "\""
							+ ",resolution:\""
							+ serviceAttrs.getNamedItem("resolution")
									.getNodeValue()
							+ "\""
							+ ",service_id:\""
							+ serviceAttrs.getNamedItem("src_service_id")
									.getNodeValue()
							+ "\""
							+ ",service_name:\""
							+ serviceAttrs.getNamedItem("src_service_name")
									.getNodeValue() 
//									+ 
//									"\"" + ",desc:\""
//							+ serviceAttrs.getNamedItem("desc").getNodeValue()
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

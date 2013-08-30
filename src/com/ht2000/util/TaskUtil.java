package com.ht2000.util;

import java.util.ArrayList;

import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ht2000.bean.TaskInfoBean;
import com.ht2000.bean.TaskInfoIOBean;
import com.ht2000.bean.DirInfoBean;

public class TaskUtil {

	public static String parseTaskInfo(SOAPMessage soapMessage){
		StringBuffer resultJson = new StringBuffer();
		try {
			resultJson.append("{");
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList taskList = soapBody.getElementsByTagName("task");
			Node taskNode = taskList.item(0);
			NamedNodeMap taskAttr = taskNode.getAttributes();
			resultJson.append("id:\"" + taskAttr.getNamedItem("id").getNodeValue()
					+ "\",start_utc:\"" + taskAttr.getNamedItem("start_utc").getNodeValue()
					+ "\",desc:\"" + taskAttr.getNamedItem("desc").getNodeValue() + "\"");
			NodeList inputList = soapBody.getElementsByTagName("input");
			if (inputList.getLength() > 0) {
				resultJson.append(",input:[");
				for (int i = 0; i < inputList.getLength(); i++) {
					Node inputNode = inputList.item(i);
					resultJson
							.append("{addr:\""
									+ inputNode.getAttributes().getNamedItem("addr").getNodeValue()
									+ "\"}");
					if (i != inputList.getLength() - 1) {
						resultJson.append(",");
					}
				}
				resultJson.append("]");
			}

			NodeList outputList = soapBody.getElementsByTagName("output");
			if (outputList.getLength() > 0) {
				resultJson.append(",output:[");
				for (int j = 0; j < outputList.getLength(); j++) {
					Node outputNode = outputList.item(j);
					Node mosaic = outputNode.getFirstChild();
					Node codingNode = outputNode.getLastChild();
					NamedNodeMap attrs = outputNode.getAttributes();
					resultJson.append("{mode:\""
							+ attrs.getNamedItem("mode").getNodeValue()
							+ "\",bitrate:\""
							+ attrs.getNamedItem("bitrate").getNodeValue()
							+ "\",mode:\""
							+ attrs.getNamedItem("mode").getNodeValue()
							+ "\",of:\""
							+ attrs.getNamedItem("of").getNodeValue()
							+ "\",network_id:\""
							+ attrs.getNamedItem("network_id").getNodeValue()
							+ "\",stream_id:\""
							+ attrs.getNamedItem("stream_id").getNodeValue()
							+ "\",service_id:\""
							+ attrs.getNamedItem("service_id").getNodeValue()
							+ "\",pmt_start_pid:\""
							+ attrs.getNamedItem("pmt_start_pid").getNodeValue()
							+ "\",start_pid:\""
							+ attrs.getNamedItem("start_pid").getNodeValue()
							+ "\",service_provider:\""
							+ attrs.getNamedItem("service_provider").getNodeValue()
							+ "\",service_name:\""
							+ attrs.getNamedItem("service_name").getNodeValue()
							+ "\",out:\""
							+ attrs.getNamedItem("out").getNodeValue()
							+ "\",coding_service_name:\""
							+ codingNode.getAttributes().getNamedItem("service_id")
							.getNodeValue() +"_"
							+ codingNode.getAttributes().getNamedItem("service_name")
									.getNodeValue() + "\"");
					
					resultJson.append(",onlymosaic:\""
					+ mosaic.getAttributes().getNamedItem("onlymosaic").getNodeValue()
					+ "\",resolution:\""	
					+ mosaic.getAttributes().getNamedItem("resolution").getNodeValue()
					+ "\",modes:\""	
					+ mosaic.getAttributes().getNamedItem("mode").getNodeValue()+ "\"");
					
//					resultJson.append(",mosaic:[").append("{onlymosaic:\""
//							+ mosaic.getAttributes().getNamedItem("onlymosaic").getNodeValue()
//							+ "\",resolution:\""	
//							+ mosaic.getAttributes().getNamedItem("resolution").getNodeValue()
//							+ "\",mode:\""	
//							+ mosaic.getAttributes().getNamedItem("mode").getNodeValue()+ "\"}"
//					);
//					resultJson.append("]");
					NodeList streamList = codingNode.getChildNodes();
					if (streamList.getLength() > 0) {
						resultJson.append(",stream:[");
						for (int k = 0; k < streamList.getLength(); k++) {
							Node streamNode = streamList.item(k);
							NamedNodeMap streamAttrs = streamNode.getAttributes();
							String nodeName = streamNode.getNodeName();
							if (nodeName.equals("stream_v")) {
								resultJson.append("{pid:\""
										+ streamAttrs.getNamedItem("pid").getNodeValue()
										+ "\",vcodec:\""
										+ streamAttrs.getNamedItem("vcodec").getNodeValue() + "\""
										+ ",vprofile:\""
										+ streamAttrs.getNamedItem("vprofile").getNodeValue()
										+ "\",level:\""
										+ streamAttrs.getNamedItem("level").getNodeValue() + "\""
										+ ",preset:\""
										+ streamAttrs.getNamedItem("preset").getNodeValue()
										+ "\",fps:\""
										+ streamAttrs.getNamedItem("fps").getNodeValue() + "\""
										+ ",method:\""
										+ streamAttrs.getNamedItem("method").getNodeValue()
										+ "\",resolution:\""
										+ streamAttrs.getNamedItem("resolution").getNodeValue()
										+ "\"" + ",\"gop\":\""
										+ streamAttrs.getNamedItem("gop").getNodeValue() + "\""
										+ ",\"bframe\":\""
										+ streamAttrs.getNamedItem("bframe").getNodeValue() + "\""
										+ ",\"refnum\":\""
										+ streamAttrs.getNamedItem("refnum").getNodeValue() + "\""
										+ ",aspect:\""
										+ streamAttrs.getNamedItem("aspect").getNodeValue() + "\""
										+ ",overlay:\""
										+ streamAttrs.getNamedItem("overlay").getNodeValue()
										+ "\",x:\"" + streamAttrs.getNamedItem("x").getNodeValue()
										+ "\"" + ",y:\""
										+ streamAttrs.getNamedItem("y").getNodeValue()
										+ "\",w:\""
										+ streamAttrs.getNamedItem("w").getNodeValue() + "\""
										+ ",h:\""
										+ streamAttrs.getNamedItem("h").getNodeValue()+ "\""
										+ ",pic:\""
										+ streamAttrs.getNamedItem("pic").getNodeValue()+ "\""
										+ ",delogo:\""
										+ streamAttrs.getNamedItem("delogo").getNodeValue()
										+ "\",dx:\"" + streamAttrs.getNamedItem("dx").getNodeValue()
										+ "\"" + ",dy:\""
										+ streamAttrs.getNamedItem("dy").getNodeValue()
										+ "\",dw:\""
										+ streamAttrs.getNamedItem("dw").getNodeValue() + "\""
										+ ",dh:\""
										+ streamAttrs.getNamedItem("dh").getNodeValue()
										+ "\",type:\"v\"}");
							} else {
								resultJson.append("{pid:\""
										+ streamAttrs.getNamedItem("pid").getNodeValue()
										+ "\",acodec:\""
										+ streamAttrs.getNamedItem("acodec").getNodeValue() + "\""
										+ ",bitrate:\""
										+ streamAttrs.getNamedItem("bitrate").getNodeValue()
										+ "\",ar:\""
										+ streamAttrs.getNamedItem("ar").getNodeValue() + "\""
										+ ",ac:\"" + streamAttrs.getNamedItem("ac").getNodeValue()
										+ "\",volume:\""
										+ streamAttrs.getNamedItem("volume").getNodeValue()
										+ "\",type:\"a\"}");
							}

							if (k != streamList.getLength() - 1) resultJson.append(",");
						}
						resultJson.append("]");
					}
					resultJson.append("}");
					if (j != outputList.getLength() - 1) {
						resultJson.append(",");
					}
				}
				resultJson.append("]}");
			}
		} catch (SOAPException e) {
			System.out.println("[parseTaskInfo]soap no body");
		}
		return resultJson.toString();
	}
	
	public static ArrayList<TaskInfoBean> parseTaskList(SOAPMessage soapMessage){
		ArrayList<TaskInfoBean> taskList = null;
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList taskNodeList = soapBody.getElementsByTagName("task");
			if(taskNodeList.getLength() > 0){
				taskList = new ArrayList<TaskInfoBean>();
				for(int i=0; i<taskNodeList.getLength(); i++){
					TaskInfoBean taskInfoBean = new TaskInfoBean();
					Node taskNode = taskNodeList.item(i);
					taskInfoBean.setTaskId(taskNode.getAttributes().getNamedItem("id").getNodeValue());
					taskInfoBean.setTaskDesc(taskNode.getAttributes().getNamedItem("desc").getNodeValue());
					taskInfoBean.setStart_utc(taskNode.getAttributes().getNamedItem("start_utc").getNodeValue());
					taskList.add(taskInfoBean);
				}
			}
		} catch (SOAPException e) {
			System.out.println("[parseTaskList]soap no body");
		}
		return taskList;
	}
	
	public static String parseService(SOAPMessage soapMessage){
		StringBuffer serviceJson = new StringBuffer();
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			Node taskNode = soapBody.getElementsByTagName("task").item(0);
			NamedNodeMap infoAttrs = taskNode.getAttributes();
			if (infoAttrs.getNamedItem("error").getNodeValue().equals("0")) {
				serviceJson.append("{error:\"0\",service:[");
				NodeList serviceNodeList = soapBody.getElementsByTagName("service");
				for (int i = 0; i < serviceNodeList.getLength(); i++) {
					Node serviceNode = serviceNodeList.item(i);
					NamedNodeMap serviceAttrs = serviceNode.getAttributes();
					serviceJson.append("{name:\""
							+ serviceAttrs.getNamedItem("name").getNodeValue() + "\""
							+ ",provider:\"" + serviceAttrs.getNamedItem("provider").getNodeValue()
							+ "\"" + ",id:\"" + serviceAttrs.getNamedItem("id").getNodeValue()
							+ "\"");
					NodeList streamNodeList = serviceNode.getChildNodes();
					if (streamNodeList.getLength() > 0) {
						serviceJson.append(",stream:[");
						for (int j = 0; j < streamNodeList.getLength(); j++) {
							Node streamNode = streamNodeList.item(j);
							NamedNodeMap streamAttrs = streamNode.getAttributes();
							serviceJson.append("{idx:\""
									+ streamAttrs.getNamedItem("idx").getNodeValue() + "\""
									+ ",pid:\"" + streamAttrs.getNamedItem("pid").getNodeValue()
									+ "\"" + ",type:\""
									+ streamAttrs.getNamedItem("type").getNodeValue() + "\""
									+ ",info:\"" + streamAttrs.getNamedItem("info").getNodeValue()
									+ "\"}");
							if (j != streamNodeList.getLength() - 1) serviceJson.append(",");
						}
						serviceJson.append("]");
					}
					serviceJson.append("}");
					if (i != serviceNodeList.getLength() - 1) serviceJson.append(",");
				}
				serviceJson.append("]}");
			} else {
				serviceJson.append("{error:\"1\",desc:\""
						+ infoAttrs.getNamedItem("desc").getNodeValue() + "\"}");
			}
		} catch (SOAPException e) {
			System.out.println("[parseTaskList]soap no body");
		}
		return serviceJson.toString();
		
//		StringBuffer serviceJson = new StringBuffer();
//		try {
//			SOAPBody soapBody = soapMessage.getSOAPBody();
//			Node taskNode = soapBody.getElementsByTagName("task").item(0);
//			NamedNodeMap infoAttrs = taskNode.getAttributes();
//			if(infoAttrs.getNamedItem("error").getNodeValue().equals("0")){
//				serviceJson.append("{error:\"0\",service:[");
//				NodeList serviceNodeList = soapBody.getElementsByTagName("service");
//				for(int i=0; i<serviceNodeList.getLength(); i++){
//					Node serviceNode = serviceNodeList.item(i);
//					NamedNodeMap serviceAttrs = serviceNode.getAttributes();
//					serviceJson.append("{name:\""+serviceAttrs.getNamedItem("name").getNodeValue()+"\",provider:\""+serviceAttrs.getNamedItem("provider").getNodeValue()+"\"");
//					NodeList streamNodeList = serviceNode.getChildNodes();
//					if(streamNodeList.getLength() > 0){
//						serviceJson.append(",stream:[");
//						for(int j=0; j<streamNodeList.getLength(); j++){
//							Node streamNode = streamNodeList.item(j);
//							NamedNodeMap streamAttrs = streamNode.getAttributes();
//							serviceJson.append("{idx:\""+streamAttrs.getNamedItem("idx").getNodeValue()+"\",pid:\""+streamAttrs.getNamedItem("pid").getNodeValue()+"\",type:\""+streamAttrs.getNamedItem("type").getNodeValue()+"\"," +
//									"info:\""+streamAttrs.getNamedItem("info").getNodeValue()+"\"}");
//							if(j != streamNodeList.getLength()-1) serviceJson.append(",");
//						}
//						serviceJson.append("]");
//					}
//					serviceJson.append("}");
//					if(i != serviceNodeList.getLength()-1) serviceJson.append(",");
//				}
//				serviceJson.append("]}");
//			}else{
//				serviceJson.append("{error:\"1\",desc:\""+infoAttrs.getNamedItem("desc").getNodeValue()+"\"}");
//			}
//		} catch (SOAPException e) {
//			System.out.println("[parseTaskList]soap no body");
//		}
//		return serviceJson.toString();
	}
	
	public static ArrayList<TaskInfoIOBean> parseIOList(SOAPMessage soapMessage) {
		ArrayList<TaskInfoIOBean> taskIOList = null;
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList taskNodeList = soapBody.getElementsByTagName("task");
			for (int i = 0; i < taskNodeList.getLength(); i++) {
				taskIOList = new ArrayList<TaskInfoIOBean>();
				Node taskNode = taskNodeList.item(i);
				Node inputNode = taskNode.getFirstChild();
				TaskInfoIOBean ioBean = new TaskInfoIOBean();
				ioBean.setTaskId(taskNode.getAttributes().getNamedItem("id").getNodeValue());
				ioBean.setStart_utc(taskNode.getAttributes().getNamedItem("start_utc").getNodeValue());
				ioBean.setTaskDesc(taskNode.getAttributes().getNamedItem("desc").getNodeValue());
				ioBean.setInputAddr(inputNode.getAttributes().getNamedItem("addr").getNodeValue());
				NodeList outputNodeList = taskNode.getChildNodes();
				StringBuffer outputStr = new StringBuffer("");
				for (int j = 1; j < outputNodeList.getLength(); j++) {
					Node outputNode = outputNodeList.item(j);
					outputStr.append("地址:"
							+ outputNode.getAttributes().getNamedItem("out").getNodeValue() 
							+ ",比特率:"
							+ outputNode.getAttributes().getNamedItem("bitrate").getNodeValue()
							+ "\n");
				}
				ioBean.setOutputAddr(outputStr.toString());
				taskIOList.add(ioBean);
			}
		} catch (SOAPException e) {
			System.out.println("[parseIOList]soap no body");
		}
		return taskIOList;
	}
	
	public static ArrayList<DirInfoBean> parseDirInfo(SOAPMessage soapMessage) {
		ArrayList<DirInfoBean> result = new ArrayList<DirInfoBean>();
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList dirNodeList = soapBody.getElementsByTagName("dir");
			if (dirNodeList.getLength() > 0) {
				ArrayList<DirInfoBean> dirList = new ArrayList<DirInfoBean>();
				ArrayList<DirInfoBean> fileList = new ArrayList<DirInfoBean>();
				for (int i = 0; i < dirNodeList.getLength(); i++) {
					DirInfoBean dirInfoBean = new DirInfoBean();
					Node dirNode = dirNodeList.item(i);
					NamedNodeMap attrs = dirNode.getAttributes();
					String value = dirNode.getTextContent();
					String[] values = value.split("/");
					dirInfoBean.setName(values[values.length - 1]);
					dirInfoBean.setValue(value);
					dirInfoBean.setDirFlag(attrs.getNamedItem("dirflag")
							.getNodeValue());
					if (dirInfoBean.getDirFlag().equals("1")) {
						dirList.add(dirInfoBean);
					} else {
						fileList.add(dirInfoBean);
					}
				}
				System.out.println("dirList.length:" + dirList.size());
				System.out.println("fileList.length:" + fileList.size());
				result.addAll(dirList);
				result.addAll(fileList);
			}
		} catch (SOAPException e) {
			e.printStackTrace();
		}
		return result;
	}
}

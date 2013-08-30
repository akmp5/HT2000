package com.ht2000.util;

import java.util.ArrayList;

import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ht2000.bean.UserInfoBean;

public class UserUtil {

	public static UserInfoBean parseUserInfo(SOAPMessage soapMessage){
		UserInfoBean userInfo = new UserInfoBean();
//		//TODO Add by yk start 
//		if(soapMessage == null){
//			userInfo.setCheckin(".........");
//			userInfo.setError("1/0");
//			userInfo.setPermission("2");
//			userInfo.setValidity("4294967295");
//			userInfo.setStartUtc("1");
//		//<user error="1/0" checkin="........." permission="2" validity="0xffffffff" private="1" />
//			return userInfo;
//		}
//		//TODO end 
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList userNodeList = soapBody.getElementsByTagName("user");
			Node userNode = userNodeList.item(0);
			NamedNodeMap attrs = userNode.getAttributes();
			if(null != attrs.getNamedItem("name"))
				userInfo.setName(attrs.getNamedItem("name").getNodeValue());
			if(null != attrs.getNamedItem("error"))
				userInfo.setError(attrs.getNamedItem("error").getNodeValue());
			if(null != attrs.getNamedItem("start_utc"))
				userInfo.setStartUtc(attrs.getNamedItem("start_utc").getNodeValue());
			if(null != attrs.getNamedItem("checkin"))
				userInfo.setCheckin(attrs.getNamedItem("checkin").getNodeValue());
			if(null != attrs.getNamedItem("permission"))
				userInfo.setPermission(attrs.getNamedItem("permission").getNodeValue()); 
			if(null != attrs.getNamedItem("validity"))
				userInfo.setValidity(attrs.getNamedItem("validity").getNodeValue());
		} catch (SOAPException e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	
	public static ArrayList<UserInfoBean> parseUserList(SOAPMessage soapMessage){
		ArrayList<UserInfoBean> userList = null;
//		//TODO Add by yk start 
//		if(soapMessage == null){
//				userList = new ArrayList<UserInfoBean>();
//					UserInfoBean userInfoBean = new UserInfoBean();
//					userInfoBean.setName("liaoli");
//					userInfoBean.setStartUtc("123");
//					userInfoBean.setPermission("3");
//					userInfoBean.setValidity("4294967295");
//					userList.add(userInfoBean);
//					UserInfoBean userInfoBean1 = new UserInfoBean();
//					userInfoBean1.setName("liaoli1");
//					userInfoBean1.setStartUtc("123");
//					userInfoBean1.setPermission("3");
//					userInfoBean1.setValidity("4294967295");
//					userList.add(userInfoBean1);
////			<user name="liaoli" start_utc="123" permission="3" validity="0xffffffff" />
////			<user name="liaoli" start_utc="123" permission="3" validity="0xffffffff" />
//			return userList;
//		}
//		//TODO end 
		
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList userNodeList = soapBody.getElementsByTagName("user");
			if(userNodeList.getLength() > 0){
				userList = new ArrayList<UserInfoBean>();
				for(int i=0; i<userNodeList.getLength(); i++){
					UserInfoBean userInfoBean = new UserInfoBean();
					Node userNode = userNodeList.item(i);
					userInfoBean.setName(userNode.getAttributes().getNamedItem("name").getNodeValue());
					userInfoBean.setStartUtc(userNode.getAttributes().getNamedItem("start_utc").getNodeValue());
					userInfoBean.setPermission(userNode.getAttributes().getNamedItem("permission").getNodeValue());
					userInfoBean.setValidity(userNode.getAttributes().getNamedItem("validity").getNodeValue());
					userList.add(userInfoBean);
				}
			}
		} catch (SOAPException e) {
			System.out.println("[parseUserList]soap no body");
		}
		return userList;
	}
	
	public static String parseUserName(SOAPMessage soapMessage){
		String error = "0";
		
		try {
			SOAPBody soapBody = soapMessage.getSOAPBody();
			NodeList userNodeList = soapBody.getElementsByTagName("user");
			Node userNode = userNodeList.item(0);
			error = userNode.getAttributes().getNamedItem("error").getNodeValue();
		} catch (SOAPException e) {
			System.out.println("[parseUserName]soap no body");
		}
		return error;
	}
}

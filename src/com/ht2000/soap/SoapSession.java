package com.ht2000.soap;

import javax.xml.soap.MessageFactory;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPElement;
import javax.xml.soap.SOAPEnvelope;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPHeader;
import javax.xml.soap.SOAPMessage;
import javax.xml.soap.SOAPPart;

import org.w3c.dom.DOMException;

public class SoapSession {
	private MessageFactory m_factory = null;
	private SOAPMessage m_sendMsg = null;
	private SOAPEnvelope m_env=null;
	
	public SoapSession() {
		try {
			m_factory = MessageFactory.newInstance();
			m_sendMsg = m_factory.createMessage();
			
			SOAPPart sp = m_sendMsg.getSOAPPart();
			m_env = sp.getEnvelope();
			
			//删除掉header信息
			SOAPHeader hd = m_env.getHeader();
			hd.detachNode();
							
		} catch (SOAPException e) {
			System.out.println("SoapClient[SoapSession] error!");
			e.printStackTrace();
		}
	}

	//創建body
	public Object createBodyElement(String elementName){
		
		try {
			SOAPBody body = m_env.getBody();
			SOAPElement childElement = body.addChildElement(elementName);
			return childElement;
		} catch (SOAPException e) {
			System.out.println("SoapClient[createBodyElement] error!");
			e.printStackTrace();
		}
		return null;
	}
	
	public Object addElement(Object element, String elementName){
		try {
			SOAPElement parentElement = (SOAPElement)element;
			SOAPElement childElement = parentElement.addChildElement(elementName);
			return childElement;
		} catch (SOAPException e) {
			System.out.println("SoapClient[addElement] error!");
			e.printStackTrace();
		}
		return null;
	}
	
	public void addAttribute(Object elment, String attrName, String attrValue){
		try{
			SOAPElement element = (SOAPElement)elment;
			if(element != null){
				element.setAttribute(attrName, attrValue);
			}
		}catch (DOMException e) {
			System.out.println("SoapClient[addAttribute] error!");
			e.printStackTrace();
		}
	}
	
	public SOAPMessage getMessage(){
		return m_sendMsg;
	}
}

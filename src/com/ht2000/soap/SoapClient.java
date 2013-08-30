package com.ht2000.soap;

import java.io.IOException;
import java.net.URL;

import javax.xml.soap.SOAPConnection;
import javax.xml.soap.SOAPConnectionFactory;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

public class SoapClient {

	private SOAPConnection m_connction;
	public SoapClient(){
		try {
			SOAPConnectionFactory factory = SOAPConnectionFactory.newInstance();
			m_connction = factory.createConnection();
		} catch (SOAPException e) {
			e.printStackTrace();
		}	
	}
		
	public SOAPMessage send(URL url, SoapSession soapSession){
		try {
			SOAPMessage msg = soapSession.getMessage();
			msg.writeTo(System.out);
			SOAPMessage respMsg = m_connction.call(msg, url);
			System.out.println("[ok]SoapClient:Soap send message success!");
			return respMsg;
		} catch (SOAPException e) {
			e.printStackTrace();
			System.out.println("[1]SoapClient: send message error!");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public SOAPMessage send(URL url, SOAPMessage msg){
		try {
			SOAPMessage respMsg = m_connction.call(msg, url);
			System.out.println("[ok]SoapClient:Soap send message success!");
			return respMsg;
		} catch (SOAPException e) {
			System.out.println("[2]SoapClient: send message error!");
		}
		return null;
	}
}

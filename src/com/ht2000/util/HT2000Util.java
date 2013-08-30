package com.ht2000.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class HT2000Util {
	
	private static String soapServerIp = null;
	private static String soapServerPort = null;
	
	public static String getSoapServerAddr(){
		/*InetAddress addr;
		try {
			addr = InetAddress.getLocalHost();
			//soapServerIp = addr.getHostAddress().toString();//获得本机IP
		} catch (UnknownHostException e1) {
			System.out.println("无法获取到本地IP");
		}*/
		
		if(soapServerIp == null || soapServerPort == null){
			Properties prop = new Properties();   
	        InputStream in = HT2000Util.class.getResourceAsStream("/config.properties");
	        try {
	            prop.load(in); 
	            soapServerIp = prop.getProperty("ip").trim(); 
	            soapServerPort = prop.getProperty("port").trim();   
	        } catch (IOException e) {   
	            e.printStackTrace();   
	        } 
		}
		return "http://"+soapServerIp+":"+soapServerPort;
	}
	
	public static String getShowMessage(String message, int type){
		String messageType = "information";
		switch (type){
			case 0:
				messageType = "success";
				break;
			case 1:
				messageType = "information";
				break;
			case 2:
				messageType = "attention";
				break;
			case 3:
				messageType = "error";
				break;
		}
		String messageDiv = "<div id=\"message\" class=\"notification "+messageType+"\"><div>"+message+
			"</div><script type=\"text/javascript\">$(\"#message\").fadeTo(3000, 0, function () {$(this).slideUp(400);});</script></div>";
		return messageDiv;
	}
}

package com.ht2000.struts;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.ht2000.bean.LicenseInfoBean;
import com.ht2000.bean.SystemInfoBean;
import com.ht2000.soap.SoapClient;
import com.ht2000.soap.SoapSession;
import com.ht2000.util.HT2000Util;
import com.ht2000.util.SystemUtil;

public class SystemAction extends DispatchAction {

	private static SoapClient soapClicent = new SoapClient();
	private static String soapServerAddr = HT2000Util.getSoapServerAddr();
	
	public ActionForward getBaseInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/system/baseinfo");
		SoapSession soapSession = new SoapSession();
		Object systemElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(systemElement, "info", "baseinfo");
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if(null == recvMsg){
			response.sendRedirect("./userAction.do?method=logout");
			return null;
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		SystemInfoBean baseInfo = SystemUtil.parseBaseInfo(recvMsg);
//		//TODO add by yk start
//		SystemInfoBean baseInfo = SystemUtil.parseBaseInfo(null);
//		// add by yk end 
		request.getSession().setAttribute("baseInfo", baseInfo);
		return mapping.findForward("baseInfo");
	}
	
	public ActionForward getLicenseInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/system/licenseinfo");
		SoapSession soapSession = new SoapSession();
		Object systemElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(systemElement, "info", "licenseinfo");
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if(null == recvMsg){
			response.sendRedirect("./userAction.do?method=logout");
			return null;
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		LicenseInfoBean licenseInfo = SystemUtil.parseLicenseInfo(recvMsg);
		request.getSession().setAttribute("licenseInfo", licenseInfo);
		return mapping.findForward("licenseInfo");
	}
	
	
	public ActionForward getCPUInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/system/cpuinfo");
		SoapSession soapSession = new SoapSession();
		Object systemElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(systemElement, "info", "cpuinfo");
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String cpuInfo = SystemUtil.parseCPUInfo(recvMsg);
//		//TODO add by yk start
//
//		String cpuInfo = SystemUtil.parseCPUInfo(null);
//		// add by yk end 
		cpuInfo = URLDecoder.decode(cpuInfo,"utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(cpuInfo);
		out.close();
		return null;
	}
	
	public ActionForward getNetioInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/system/netioinfo");
		SoapSession soapSession = new SoapSession();
		Object systemElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(systemElement, "info", "netioinfo");
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String netioInfo = SystemUtil.parseNetioInfo(recvMsg);
		
		//TODO add by yk start
//		String netioInfo = SystemUtil.parseNetioInfo(null);
		// add by yk end 
		netioInfo = URLDecoder.decode(netioInfo,"utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(netioInfo);
		out.close();
		return null;
	}
	
	public ActionForward restart(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/system/restart");
		SoapSession soapSession = new SoapSession();
		Object systemElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(systemElement, "ctrl", "restart");
		soapClicent.send(url, soapSession);
		String message = "正在重启服务";
		message = URLDecoder.decode(message,"utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(message);
		out.close();
		return null;
	}
	
	public ActionForward reboot(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/system/reboot");
		SoapSession soapSession = new SoapSession();
		Object systemElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(systemElement, "ctrl", "reboot");
		soapClicent.send(url, soapSession);
		String message = "正在重启编码器";
		message = URLDecoder.decode(message,"utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(message);
		out.close();
		return null;
	}
	
	public ActionForward reset(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/system/reset");
		SoapSession soapSession = new SoapSession();
		Object systemElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(systemElement, "ctrl", "reset");
		soapClicent.send(url, soapSession);
		String message = "正在复位转码器";
		message = URLDecoder.decode(message, "utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(message);
		out.close();
		return null;
	}
	
	public ActionForward usbctrl(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/system/usbctrl");
		String usb_status = request.getParameter("status");
		SoapSession soapSession = new SoapSession();
		Object systemElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(systemElement, "usb", usb_status);
		soapClicent.send(url, soapSession);
		String message = "";
		if(usb_status.equals("1")){
			message = "打开USB升级成功";
		}else{
			message = "关闭USB升级成功";
		}
		message = URLDecoder.decode(message,"utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(message);
		out.close();
		return null;
	}
}

package com.ht2000.struts;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.ht2000.bean.AbrInfoBean;
import com.ht2000.soap.SoapClient;
import com.ht2000.soap.SoapSession;
import com.ht2000.util.AbrUtil;
import com.ht2000.util.HT2000Util;

public class AbrAction extends DispatchAction {

	private static SoapClient soapClicent = new SoapClient();
	private static String soapServerAddr = HT2000Util.getSoapServerAddr();

	public ActionForward getAllAbrList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/abr/list");
		SoapSession soapSession = new SoapSession();
		Object abrElement = soapSession.createBodyElement("abr");
		soapSession.addAttribute(abrElement, "page_no", "1");
		soapSession.addAttribute(abrElement, "page_size", "20");
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
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
		ArrayList<AbrInfoBean> abrList = AbrUtil.parseAbrList(recvMsg);
		request.getSession().setAttribute("abrList", abrList);
		return mapping.findForward("getAllAbrList");
	}

	public ActionForward getAbrInfoById(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/abr/info");
		SoapSession soapSession = new SoapSession();
		String abrId = request.getParameter("id");
		Object abrElement = soapSession.createBodyElement("abr");
		soapSession.addAttribute(abrElement, "id", abrId);
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
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
		String abrInfo = AbrUtil.parseAbrInfo(recvMsg);
		abrInfo = URLDecoder.decode(abrInfo, "utf-8");
		System.out.println(abrInfo);
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(abrInfo);
		out.close();
		return null;
	}

	public ActionForward checkAbr(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/abr/check");
		SoapSession soapSession = new SoapSession();
		Object infoElement = soapSession.createBodyElement("abr");
		soapSession.addAttribute(infoElement, "check", "addr");
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
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
		String serviceList = AbrUtil.parseService(recvMsg);
		serviceList = URLDecoder.decode(serviceList, "utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write("[" + serviceList + "]");
		out.close();
		return null;
	}

	public ActionForward addAbr(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/abr/add");
		SoapSession soapSession = new SoapSession();
		String name = request.getParameter("name");
		Object infoElement = soapSession.createBodyElement("abr");
		soapSession.addAttribute(infoElement, "desc", name);
		String[] inputs = request.getParameterValues("inputs");
		String outputIp = request.getParameter("outputIp");
		if (inputs != null) {
			for (int i = 0; i < inputs.length; i++) {
				Object inputElement = soapSession.createBodyElement("input");
				soapSession.addAttribute(inputElement, "addr", inputs[i]
						.split("_")[0]);
				soapSession.addAttribute(inputElement, "bandwidth", inputs[i]
						.split("_")[1]);
			}
		}
		Object outputElement = soapSession.createBodyElement("output");
		soapSession.addAttribute(outputElement, "addr", "hls://" + outputIp);
		soapClicent.send(url, soapSession);
		response.sendRedirect("./index.jsp#main4");
		return null;
	}
	

	public ActionForward delAbr(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/abr/delete");
		SoapSession soapSession = new SoapSession();
		String[] abrIds = request.getParameterValues("id");
		for (int i = 0; i < abrIds.length; i++) {
			Object abrElement = soapSession.createBodyElement("abr");
			soapSession.addAttribute(abrElement, "id", abrIds[i]);
		}
		soapClicent.send(url, soapSession);
		response.sendRedirect("./index.jsp#main4");
		return null;
	}
}

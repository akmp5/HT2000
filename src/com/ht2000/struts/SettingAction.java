package com.ht2000.struts;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.soap.SOAPMessage;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.ht2000.soap.SoapClient;
import com.ht2000.soap.SoapSession;
import com.ht2000.util.HT2000Util;
import com.ht2000.util.SystemUtil;

public class SettingAction extends DispatchAction {

	private static SoapClient soapClicent = new SoapClient();
	private static String soapServerAddr = HT2000Util.getSoapServerAddr();

	public ActionForward setNetwork(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String networkInfo = null;
		String networkType = "in";
		String ipMode = request.getParameter("ipMode");
		String ipaddr = request.getParameter("ipaddr");
		String netmask = request.getParameter("netmask");
		String gateway = request.getParameter("gateway");
		String dns1 = request.getParameter("dns1");
		URL url = new URL(soapServerAddr + "/box/system/network");
		SoapSession soapSession = new SoapSession();
		Object networkElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(networkElement, "dev", networkType);
		soapSession.addAttribute(networkElement, "mothed", ipMode);
		soapSession.addAttribute(networkElement, "ipaddr", ipaddr);
		soapSession.addAttribute(networkElement, "netmask", netmask);
		soapSession.addAttribute(networkElement, "gateway", gateway);
		soapSession.addAttribute(networkElement, "dns", dns1);
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
			networkInfo = "连接服务器失败！";
		} else {
			networkInfo = SystemUtil.parseUpdateInfo(recvMsg);
		}
		request.setAttribute("message", networkInfo);
		networkInfo = URLDecoder.decode(networkInfo,"utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(networkInfo);
		out.close();
		request.getRequestDispatcher("/Pages/Setting/networkSetting.jsp").forward(request, response);
		return null;
	}
}

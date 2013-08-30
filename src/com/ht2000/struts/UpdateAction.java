package com.ht2000.struts;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLDecoder;

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

public class UpdateAction extends DispatchAction {

	private static SoapClient soapClicent = new SoapClient();
	private static String soapServerAddr = HT2000Util.getSoapServerAddr();

	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String updateInfo = null;
		URL url = new URL(soapServerAddr + "/box/system/upgrate");
		SoapSession soapSession = new SoapSession();
		Object upgrateElement = soapSession.createBodyElement("system");
		soapSession.addAttribute(upgrateElement, "desc", "1");
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
			updateInfo = "连接服务器失败！";
		} else {
			updateInfo = SystemUtil.parseUpdateInfo(recvMsg);
		}
		updateInfo = URLDecoder.decode(updateInfo, "utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(updateInfo);
		out.close();
		return null;
	}
}

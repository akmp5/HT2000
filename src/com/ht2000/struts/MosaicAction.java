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

import com.ht2000.bean.MosaicInfoBean;
import com.ht2000.soap.SoapClient;
import com.ht2000.soap.SoapSession;
import com.ht2000.util.HT2000Util;
import com.ht2000.util.MosaicUtil;

public class MosaicAction extends DispatchAction {

	private static SoapClient soapClicent = new SoapClient();
	private static String soapServerAddr = HT2000Util.getSoapServerAddr();

	public ActionForward getAllMosaicList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/mosaic/list");
		SoapSession soapSession = new SoapSession();
		Object abrElement = soapSession.createBodyElement("mosaic");
		soapSession.addAttribute(abrElement, "page_no", "1");
		soapSession.addAttribute(abrElement, "page_size", "30");
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
		ArrayList<MosaicInfoBean> abrList = MosaicUtil.parseMosaicList(recvMsg);
		request.getSession().setAttribute("mosaicList", abrList);
		return mapping.findForward("getAllMosaicList");
	}

	public ActionForward getMosaicInfoById(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/mosaic/info");
		SoapSession soapSession = new SoapSession();
		String mosaicId = request.getParameter("id");
		Object mosaicIdElement = soapSession.createBodyElement("mosaic");
		soapSession.addAttribute(mosaicIdElement, "id", mosaicId);
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
		String mosaicInfo = MosaicUtil.parseMosaicInfo(recvMsg);
		mosaicInfo = URLDecoder.decode(mosaicInfo, "utf-8");
		System.out.println(mosaicInfo);
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(mosaicInfo);
		out.close();
		return null;
	}

	public ActionForward checkMosaic(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/mosaic/check");
		SoapSession soapSession = new SoapSession();
		Object infoElement = soapSession.createBodyElement("mosaic");
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
		String serviceList = MosaicUtil.parseService(recvMsg);
		serviceList = URLDecoder.decode(serviceList, "utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write("[" + serviceList + "]");
		out.close();
		return null;
	}

	public ActionForward addMosaic(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/mosaic/add");
		SoapSession soapSession = new SoapSession();
		String name = request.getParameter("name");
		String mode = request.getParameter("mode");
		Object infoElement = soapSession.createBodyElement("mosaic");
		soapSession.addAttribute(infoElement, "desc", name);
		soapSession.addAttribute(infoElement, "mode", mode);
		String[] inputs = request.getParameterValues("inputs");
		String outputIp = request.getParameter("outputIp");
		String outputmode = request.getParameter("outputmode");
		String resolution = request.getParameter("resolution");
		String bitrate = request.getParameter("bitrate");
		String of = request.getParameter("of");
		String hls_time = request.getParameter("hls_time");
		String hls_list_size = request.getParameter("hls_list_size");
		String[] num = request.getParameterValues("num");
		String[] desc = request.getParameterValues("desc");
		String[] resolutions = request.getParameterValues("resolutions");
		
		if (inputs != null) {
			for (int i = 0; i < inputs.length; i++) {
				Object inputElement = soapSession.createBodyElement("input");
				soapSession.addAttribute(inputElement, "addr", inputs[i]
						.split("_")[0]);
				soapSession.addAttribute(inputElement, "index", inputs[i]
				        .split("_")[1]);
				soapSession.addAttribute(inputElement, "src_service_id", inputs[i]
				    .split("_")[2]);
				soapSession.addAttribute(inputElement, "src_service_name", inputs[i]
				    .split("_")[3]);
				soapSession.addAttribute(inputElement, "num", num[i]);
				soapSession.addAttribute(inputElement, "desc", desc[i]);
				soapSession.addAttribute(inputElement, "resolution", resolutions[i]);
			}
		}
		Object outputElement = soapSession.createBodyElement("output");
		soapSession.addAttribute(outputElement, "addr", "hls://" + outputIp);
		soapSession.addAttribute(outputElement, "mode", outputmode);
		soapSession.addAttribute(outputElement, "resolution", resolution);
		soapSession.addAttribute(outputElement, "bitrate", bitrate);
		soapSession.addAttribute(outputElement, "of", of);
		soapSession.addAttribute(outputElement, "hls_time", hls_time);
		soapSession.addAttribute(outputElement, "hls_list_size", hls_list_size);
		
		soapClicent.send(url, soapSession);
		response.sendRedirect("./index.jsp#main4");
		return null;
	}
	
	
	public ActionForward updateMosaic(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/mosaic/mod");
		SoapSession soapSession = new SoapSession();
		String name = request.getParameter("name");
		String mode = request.getParameter("mode");
		String id = request.getParameter("id");
		Object infoElement = soapSession.createBodyElement("mosaic");
		soapSession.addAttribute(infoElement, "desc", name);
		soapSession.addAttribute(infoElement, "mode", mode);
		soapSession.addAttribute(infoElement, "id", id);
		String outputIp = request.getParameter("outputIp");
		String outputmode = request.getParameter("outputmode");
		String resolution = request.getParameter("resolution");
		String bitrate = request.getParameter("bitrate");
		String of = request.getParameter("of");
		String hls_time = request.getParameter("hls_time");
		String hls_list_size = request.getParameter("hls_list_size");
		String[] num = request.getParameterValues("num");
		String[] desc = request.getParameterValues("desc");
		String[] inputAddr = request.getParameterValues("inputAddr");
		String[] bandwidth = request.getParameterValues("bandwidth");
		String[] index = request.getParameterValues("index");
		String[] resolutions = request.getParameterValues("resolutions");
		String[] service_id = request.getParameterValues("service_id");
		String[] service_name = request.getParameterValues("service_name");

		if (num != null) {
			for (int i = 0; i < num.length; i++) {
				Object inputElement = soapSession.createBodyElement("input");
				soapSession.addAttribute(inputElement, "addr", inputAddr[i]);
				soapSession.addAttribute(inputElement, "index", index[i]);
				soapSession.addAttribute(inputElement, "bandwidth", bandwidth[i]);
				soapSession.addAttribute(inputElement, "src_service_id", service_id[i]);
				soapSession.addAttribute(inputElement, "src_service_name", service_name[i]);
				soapSession.addAttribute(inputElement, "num", num[i]);
				soapSession.addAttribute(inputElement, "desc", desc[i]);
				soapSession.addAttribute(inputElement, "resolution", resolutions[i]);
			}
		}
		Object outputElement = soapSession.createBodyElement("output");
		soapSession.addAttribute(outputElement, "addr", "hls://" + outputIp);
		soapSession.addAttribute(outputElement, "mode", outputmode);
		soapSession.addAttribute(outputElement, "resolution", resolution);
		soapSession.addAttribute(outputElement, "bitrate", bitrate);
		soapSession.addAttribute(outputElement, "of", of);
		soapSession.addAttribute(outputElement, "hls_time", hls_time);
		soapSession.addAttribute(outputElement, "hls_list_size", hls_list_size);
		
		soapClicent.send(url, soapSession);
		response.sendRedirect("./index.jsp#main4");
		return null;
	}

	public ActionForward delMosaic(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/mosaic/delete");
		SoapSession soapSession = new SoapSession();
		String[] abrIds = request.getParameterValues("id");
		for (int i = 0; i < abrIds.length; i++) {
			Object abrElement = soapSession.createBodyElement("mosaic");
			soapSession.addAttribute(abrElement, "id", abrIds[i]);
		}
		soapClicent.send(url, soapSession);
		response.sendRedirect("./index.jsp#main4");
		return null;
	}
}

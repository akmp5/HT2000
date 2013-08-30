package com.ht2000.struts;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.w3c.dom.Node;

import com.ht2000.bean.TaskInfoBean;
import com.ht2000.bean.TaskInfoIOBean;
import com.ht2000.soap.SoapClient;
import com.ht2000.soap.SoapSession;
import com.ht2000.util.HT2000Util;
import com.ht2000.util.TaskUtil;
import com.ht2000.bean.DirInfoBean;

public class TaskAction extends DispatchAction {

	private static SoapClient soapClicent = new SoapClient();
	private static String soapServerAddr = HT2000Util.getSoapServerAddr();

	public ActionForward getAllTaskList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/list");
		SoapSession soapSession = new SoapSession();
		Object taskElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(taskElement, "page_no", "1");
		soapSession.addAttribute(taskElement, "page_size", "20");
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
		ArrayList<TaskInfoBean> taskList = TaskUtil.parseTaskList(recvMsg);
		request.getSession().setAttribute("taskList", taskList);
		if (request.getSession().getAttribute("errorMessage") != null) {
			String errorMsg = request.getSession().getAttribute("errorMessage").toString();
			request.getSession().removeAttribute("errorMessage");
			errorMsg = URLDecoder.decode(errorMsg, "utf-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			response.sendRedirect("./Pages/Task/allTaskList.jsp?" + errorMsg);
		} else {
			response.sendRedirect("./Pages/Task/allTaskList.jsp");
		}
		return null;
	}

	public ActionForward addTask(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/add");
		SoapSession soapSession = new SoapSession();
		String name = request.getParameter("name");
		Object infoElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(infoElement, "desc", name);
		String[] inputIp = request.getParameterValues("inputIp");
		
		for (int i = 0; i < inputIp.length; i++) {
			Object inputElement = soapSession.createBodyElement("input");
			soapSession.addAttribute(inputElement, "addr",  inputIp[i]);
		}
		String[] src_service_name = request.getParameterValues("src_service_name");
		String[] outbitrate = request.getParameterValues("outbitrate");
		String[] mode = request.getParameterValues("mode");
		String[] of = request.getParameterValues("of");
		String[] outputType = request.getParameterValues("outputType");
		String[] outputIp = request.getParameterValues("outputIp");
		String[] outputPort = request.getParameterValues("outputPort");
		String[] hlsTime = request.getParameterValues("hls_time");
		String[] hlsListSize = request.getParameterValues("hls_list_size");
		String[] network_id = request.getParameterValues("network_id");
		String[] stream_id = request.getParameterValues("stream_id");
		String[] service_id = request.getParameterValues("service_id");
		String[] pmt_start_pid = request.getParameterValues("pmt_start_pid");
		String[] start_pid = request.getParameterValues("start_pid");
		String[] service_provider = request.getParameterValues("service_provider");
		String[] service_name = request.getParameterValues("service_name");
		for (int i = 0; i < src_service_name.length; i++) {
			Object outputElement = soapSession.createBodyElement("output");
			if (!outbitrate[i].equals("")) soapSession.addAttribute(outputElement, "bitrate",
					outbitrate[i]);
			if (!mode[i].equals("")) soapSession.addAttribute(outputElement, "mode", mode[i]);
			if (!of[i].equals("")) soapSession.addAttribute(outputElement, "of", of[i]);
			if (!outputType[i].equals("")) {
				if (outputType[i].equals("hls")) {
					soapSession.addAttribute(outputElement, "out", outputType[i] + "://"
							+ outputIp[i]);
					soapSession.addAttribute(outputElement, "hls_time", hlsTime[i]);
					soapSession.addAttribute(outputElement, "hls_list_size", hlsListSize[i]);
				} else {
					soapSession.addAttribute(outputElement, "out", outputType[i] + "://"
							+ outputIp[i] + ":" + outputPort[i]);
				}
			}
			if (!network_id[i].equals("")) soapSession.addAttribute(outputElement, "network_id",
					network_id[i]);
			if (!stream_id[i].equals("")) soapSession.addAttribute(outputElement, "stream_id",
					stream_id[i]);
			if (!service_id[i].equals("")) soapSession.addAttribute(outputElement, "service_id",
					service_id[i]);
			if (!pmt_start_pid[i].equals("")) soapSession.addAttribute(outputElement,
					"pmt_start_pid", pmt_start_pid[i]);
			if (!start_pid[i].equals("")) soapSession.addAttribute(outputElement, "start_pid",
					start_pid[i]);
			if (!service_provider[i].equals("")) soapSession.addAttribute(outputElement,
					"service_provider", service_provider[i]);
			if (!service_name[i].equals("")) soapSession.addAttribute(outputElement,
					"service_name", service_name[i]);
			Object srcElement = soapSession.addElement(outputElement, "coding");
			Object mosaicElement = soapSession.addElement(outputElement, "mosaic");

			//TODO 
 			soapSession.addAttribute(srcElement, "service_id", src_service_name[i].split("_")[0]);
 			soapSession.addAttribute(srcElement, "service_name", src_service_name[i].split("_")[1]);
			String[] streamList = request.getParameterValues("streamId" + i);
			for (int j = 0; j < streamList.length; j++) {
				String pid = streamList[j].split("-")[0];
				String type = streamList[j].split("-")[1];
				if (type.equals("v")) {
					Object streamElement = soapSession.addElement(srcElement, "stream_v");

					String preset = request.getParameter(i + pid + "preset");
					String vcodec = request.getParameter(i + pid + "vcodec");
					String level = request.getParameter(i + pid + "level");
					if (level.equals("auto")) level = "";
					String vprofile = request.getParameter(i + pid + "vprofile");
					String resolution = request.getParameter(i + pid + "resolution");
					String fps = request.getParameter(i + pid + "fps");
					if (fps.equals("auto")) fps = "";
					String method = request.getParameter(i + pid + "method");
					String gop = request.getParameter(i + pid + "gop");
					String bframe = request.getParameter(i + pid + "bframe");
					String refnum = request.getParameter(i + pid + "refnum");
					String aspect = request.getParameter(i + pid + "aspect");
					String mosaic = request.getParameter(i + pid + "mosaic");
					if (mosaic != null) {
						String overlay = request.getParameter(i + pid + "overlay");
						String x = request.getParameter(i + pid + "x");
						String y = request.getParameter(i + pid + "y");
						String width = request.getParameter(i + pid + "w");
						String height = request.getParameter(i + pid + "h");
						soapSession.addAttribute(streamElement, "overlay", overlay);
						soapSession.addAttribute(streamElement, "x", x);
						soapSession.addAttribute(streamElement, "y", y);
						soapSession.addAttribute(streamElement, "w", width);
						soapSession.addAttribute(streamElement, "h", height);
					}
					String pic = request.getParameter(i + pid + "pic");
					if (pic != null) {
						String dx = request.getParameter(i + pid + "dx");
						String dy = request.getParameter(i + pid + "dy");
						String dwidth = request.getParameter(i + pid + "dw");
						String dheight = request.getParameter(i + pid + "dh");
						soapSession.addAttribute(streamElement, "delogo", "1");
						soapSession.addAttribute(streamElement, "dx", dx);
						soapSession.addAttribute(streamElement, "dy", dy);
						soapSession.addAttribute(streamElement, "dw", dwidth);
						soapSession.addAttribute(streamElement, "dh", dheight);
						//TODO
						soapSession.addAttribute(streamElement, "pic", "ht2000.png");
					}else{
						soapSession.addAttribute(streamElement, "delogo", "0");
					}
                    String resolutions =  request.getParameter(i + pid + "resolutions");
                    if(resolutions!=null){
						String onlymosaic = request.getParameter(i + pid + "onlymosaic");
						String resolution0 = request.getParameter(i + pid + "resolutions1");
						String modes = request.getParameter(i + pid + "modes");
						soapSession.addAttribute(mosaicElement, "onlymosaic", onlymosaic);
						soapSession.addAttribute(mosaicElement, "resolution", resolution0);
						soapSession.addAttribute(mosaicElement, "mode", modes);
                    }
					soapSession.addAttribute(streamElement, "pid", pid);
					soapSession.addAttribute(streamElement, "preset", preset);
					soapSession.addAttribute(streamElement, "vcodec", vcodec);
					soapSession.addAttribute(streamElement, "level", level);
					soapSession.addAttribute(streamElement, "vprofile", vprofile);
					soapSession.addAttribute(streamElement, "resolution", resolution);
					soapSession.addAttribute(streamElement, "fps", fps);
					soapSession.addAttribute(streamElement, "method", method);
					soapSession.addAttribute(streamElement, "gop", gop);
					soapSession.addAttribute(streamElement, "bframe", bframe);
					soapSession.addAttribute(streamElement, "refnum", refnum);
					soapSession.addAttribute(streamElement, "aspect", aspect);
				} else {
					Object streamElement = soapSession.addElement(srcElement, "stream_a");
					soapSession.addAttribute(streamElement, "pid", pid);
					String acodec = request.getParameter(i + pid + "acodec");
					String ar = request.getParameter(i + pid + "ar");
					String ac = request.getParameter(i + pid + "ac");
					String volume = request.getParameter(i + pid + "volume");
					String bitrate = request.getParameter(i + pid + "bitrate");
					soapSession.addAttribute(streamElement, "pid", pid);
					soapSession.addAttribute(streamElement, "acodec", acodec);
					soapSession.addAttribute(streamElement, "ar", ar);
					soapSession.addAttribute(streamElement, "ac", ac);
					soapSession.addAttribute(streamElement, "bitrate", bitrate);
					soapSession.addAttribute(streamElement, "volume", volume);
				}

			}
		}
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
			response.sendRedirect("./userAction.do?method=logout");
			return null;
		} else {
			try {
				SOAPBody soapBody = recvMsg.getSOAPBody();
				Node taskNode = soapBody.getElementsByTagName("task").item(0);
				String error = taskNode.getAttributes().getNamedItem("error").getNodeValue();
				String desc = taskNode.getAttributes().getNamedItem("desc").getNodeValue();
				if (error.equals("1")) {
					request.getSession().setAttribute("errorMessage", desc);
				}
			} catch (SOAPException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		response.sendRedirect("index.jsp#main4");
		return null;
	}
	
	public ActionForward updateTask(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/mod");
//		Set set = request.getParameterMap().keySet();
//		Object[] s	=set.toArray();
//        for(int i =0;i<s.length;i++){
//        	System.out.println("key:"+s[i]+";value"+request.getParameterMap().get(s[i]));
//        }		
		
		SoapSession soapSession = new SoapSession();
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		Object infoElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(infoElement, "desc", name);
		soapSession.addAttribute(infoElement, "id", id);
//		System.out.println("id+"+id+";name+"+name);
		String[] addr = request.getParameterValues("addr");
//		System.out.println(addr[0]);
		for (int i = 0; i < addr.length; i++) {
			Object inputElement = soapSession.createBodyElement("input");
			soapSession.addAttribute(inputElement, "addr",  addr[i]);
		}
		String[] src_service_name = request.getParameterValues("src_service_name");
		String[] outbitrate = request.getParameterValues("outbitrate");
		String[] mode = request.getParameterValues("mode");
		String[] of = request.getParameterValues("of");
		String[] outputIp = request.getParameterValues("out");
		String[] hlsTime = request.getParameterValues("hls_time");
		String[] hlsListSize = request.getParameterValues("hls_list_size");
		String[] network_id = request.getParameterValues("network_id");
		String[] stream_id = request.getParameterValues("stream_id");
		String[] service_id = request.getParameterValues("service_id");
		String[] pmt_start_pid = request.getParameterValues("pmt_start_pid");
		String[] start_pid = request.getParameterValues("start_pid");
		String[] service_provider = request.getParameterValues("service_provider");
		String[] service_name = request.getParameterValues("service_name");
		for (int i = 0; i < src_service_name.length; i++) {
			Object outputElement = soapSession.createBodyElement("output");
			if (!outbitrate[i].equals("")) soapSession.addAttribute(outputElement, "bitrate",
					outbitrate[i]);
			if (!mode[i].equals("")) soapSession.addAttribute(outputElement, "mode", mode[i]);
			if (!of[i].equals("")) soapSession.addAttribute(outputElement, "of", of[i]);
			if (!outputIp[i].equals("")) {
				if (outputIp[i].contains("hls")) {
					soapSession.addAttribute(outputElement, "out",outputIp[i]);
					soapSession.addAttribute(outputElement, "hls_time", hlsTime[i]);
					soapSession.addAttribute(outputElement, "hls_list_size", hlsListSize[i]);
				} else {
					soapSession.addAttribute(outputElement, "out", outputIp[i]);
				}
			}
			if (!network_id[i].equals("")) soapSession.addAttribute(outputElement, "network_id",
					network_id[i]);
			if (!stream_id[i].equals("")) soapSession.addAttribute(outputElement, "stream_id",
					stream_id[i]);
			if (!service_id[i].equals("")) soapSession.addAttribute(outputElement, "service_id",
					service_id[i]);
			if (!pmt_start_pid[i].equals("")) soapSession.addAttribute(outputElement,
					"pmt_start_pid", pmt_start_pid[i]);
			if (!start_pid[i].equals("")) soapSession.addAttribute(outputElement, "start_pid",
					start_pid[i]);
			if (!service_provider[i].equals("")) soapSession.addAttribute(outputElement,
					"service_provider", service_provider[i]);
			if (!service_name[i].equals("")) soapSession.addAttribute(outputElement,
					"service_name", service_name[i]);
			Object srcElement = soapSession.addElement(outputElement, "coding");
			Object mosaicElement = soapSession.addElement(outputElement, "mosaic");

 			soapSession.addAttribute(srcElement, "service_id", src_service_name[i].split("_")[0]);
 			soapSession.addAttribute(srcElement, "service_name", src_service_name[i].split("_")[0]);
			String[] streamList = request.getParameterValues("streamId" + i);
			for (int j = 0; j < streamList.length; j++) {
				String pid = streamList[j].split("-")[0];
				String type = streamList[j].split("-")[1];
				if (type.equals("v")) {
					Object streamElement = soapSession.addElement(srcElement, "stream_v");
					String preset = request.getParameter(i + pid + "preset");
					String vcodec = request.getParameter(i + pid + "vcodec");
					String level = request.getParameter(i + pid + "level");
					if (level.equals("auto")) level = "";
					String vprofile = request.getParameter(i + pid + "vprofile");
					String resolution = request.getParameter(i + pid + "resolution");
					String fps = request.getParameter(i + pid + "fps");
					if (fps.equals("auto")) fps = "";
					String method = request.getParameter(i + pid + "method");
					String gop = request.getParameter(i + pid + "gop");
					String bframe = request.getParameter(i + pid + "bframe");
					String refnum = request.getParameter(i + pid + "refnum");
					String aspect = request.getParameter(i + pid + "aspect");
					String mosaic = request.getParameter(i + pid + "mosaic");
					if (mosaic != null) {
						String overlay = request.getParameter(i + pid + "overlay");
						String x = request.getParameter(i + pid + "x");
						String y = request.getParameter(i + pid + "y");
						String width = request.getParameter(i + pid + "w");
						String height = request.getParameter(i + pid + "h");
						soapSession.addAttribute(streamElement, "overlay", overlay);
						soapSession.addAttribute(streamElement, "x", x);
						soapSession.addAttribute(streamElement, "y", y);
						soapSession.addAttribute(streamElement, "w", width);
						soapSession.addAttribute(streamElement, "h", height);
					}
					String pic = request.getParameter(i + pid + "pic");
					if (pic != null) {
						String dx = request.getParameter(i + pid + "dx");
						String dy = request.getParameter(i + pid + "dy");
						String dwidth = request.getParameter(i + pid + "dw");
						String dheight = request.getParameter(i + pid + "dh");
						soapSession.addAttribute(streamElement, "delogo", "1");
						soapSession.addAttribute(streamElement, "dx", dx);
						soapSession.addAttribute(streamElement, "dy", dy);
						soapSession.addAttribute(streamElement, "dw", dwidth);
						soapSession.addAttribute(streamElement, "dh", dheight);
						//TODO
						soapSession.addAttribute(streamElement, "pic", pic);

					}else{
						soapSession.addAttribute(streamElement, "delogo", "0");
					}
					String onlymosaic =  request.getParameter(i + pid + "onlymosaic");
                    if(onlymosaic!=null){
						String resolution0 = request.getParameter(i + pid + "resolutions1");
						String modes = request.getParameter(i + pid + "modes");
						soapSession.addAttribute(mosaicElement, "onlymosaic", onlymosaic);
						soapSession.addAttribute(mosaicElement, "resolution", resolution0);
						soapSession.addAttribute(mosaicElement, "mode", modes);
                    }
					soapSession.addAttribute(streamElement, "pid", pid);
					soapSession.addAttribute(streamElement, "preset", preset);
					soapSession.addAttribute(streamElement, "vcodec", vcodec);
					soapSession.addAttribute(streamElement, "level", level);
					soapSession.addAttribute(streamElement, "vprofile", vprofile);
					soapSession.addAttribute(streamElement, "resolution", resolution);
					soapSession.addAttribute(streamElement, "fps", fps);
					soapSession.addAttribute(streamElement, "method", method);
					soapSession.addAttribute(streamElement, "gop", gop);
					soapSession.addAttribute(streamElement, "bframe", bframe);
					soapSession.addAttribute(streamElement, "refnum", refnum);
					soapSession.addAttribute(streamElement, "aspect", aspect);
				} else {
					Object streamElement = soapSession.addElement(srcElement, "stream_a");
					soapSession.addAttribute(streamElement, "pid", pid);
					String acodec = request.getParameter(i + pid + "acodec");
					String ar = request.getParameter(i + pid + "ar");
					String ac = request.getParameter(i + pid + "ac");
					String volume = request.getParameter(i + pid + "volume");
					String bitrate = request.getParameter(i + pid + "bitrate");
					soapSession.addAttribute(streamElement, "pid", pid);
					soapSession.addAttribute(streamElement, "acodec", acodec);
					soapSession.addAttribute(streamElement, "ar", ar);
					soapSession.addAttribute(streamElement, "ac", ac);
					soapSession.addAttribute(streamElement, "bitrate", bitrate);
					soapSession.addAttribute(streamElement, "volume", volume);
				}
			}
		}
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
			response.sendRedirect("./userAction.do?method=logout");
			return null;
		} else {
			try {
				SOAPBody soapBody = recvMsg.getSOAPBody();
				Node taskNode = soapBody.getElementsByTagName("task").item(0);
				String error = taskNode.getAttributes().getNamedItem("error").getNodeValue();
				String desc = taskNode.getAttributes().getNamedItem("desc").getNodeValue();
				if (error.equals("1")) {
					request.getSession().setAttribute("errorMessage", desc);
				}
			} catch (SOAPException e) {
				e.printStackTrace();
			}
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		response.sendRedirect("index.jsp#main4");
		return null;
	}
	

	public ActionForward delTask(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/delete");
		SoapSession soapSession = new SoapSession();
		String[] taskIds = request.getParameterValues("id");
		for (int i = 0; i < taskIds.length; i++) {
			Object taskElement = soapSession.createBodyElement("task");
			soapSession.addAttribute(taskElement, "id", taskIds[i]);
		}
		soapClicent.send(url, soapSession);
		response.sendRedirect("index.jsp#main4");
		return null;
	}

	public ActionForward getTaskInfoById(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/info");
		SoapSession soapSession = new SoapSession();
		String taskId = request.getParameter("id");
		Object taskElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(taskElement, "id", taskId);
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
		String taskInfo = TaskUtil.parseTaskInfo(recvMsg);
		taskInfo = URLDecoder.decode(taskInfo, "utf-8");
		System.out.println(taskInfo);
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(taskInfo);
		out.close();
		return null;
	}

	public ActionForward checkTask(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/check");
		SoapSession soapSession = new SoapSession();
		String desc = request.getParameter("desc");
		String addr = request.getParameter("addr");
		Object infoElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(infoElement, "desc", desc);
		Object inputElement = soapSession.createBodyElement("input");
		soapSession.addAttribute(inputElement, "addr", addr);
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
		String serviceList = TaskUtil.parseService(recvMsg);
		serviceList = URLDecoder.decode(serviceList, "utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write("[" + serviceList + "]");
		out.close();
		return null;
	}

	public ActionForward getTaskIOInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/checkio");
		SoapSession soapSession = new SoapSession();
		Object infoElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(infoElement, "check", "io");
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
		ArrayList<TaskInfoIOBean> taskIOList = TaskUtil.parseIOList(recvMsg);
		request.getSession().setAttribute("taskIOList", taskIOList);
		return mapping.findForward("taskIOInfo");
	}
	
	public ActionForward getDirInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/file/list");
		SoapSession soapSession = new SoapSession();
		Object dirElement = soapSession.createBodyElement("dir");
		soapSession.addAttribute(dirElement, "addr", "/");
		soapSession.addAttribute(dirElement, "flag", "logo");
		Object infoElement = soapSession.createBodyElement("page");
		soapSession.addAttribute(infoElement, "page_no", "1");
		soapSession.addAttribute(infoElement, "page_size", "20");
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
		ArrayList<DirInfoBean> dirInfoList = TaskUtil.parseDirInfo(recvMsg);
		request.getSession().setAttribute("dirList", dirInfoList);
		return mapping.findForward("getDirInfo");
	}
	
	public ActionForward delDirInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/file/delete");
		SoapSession soapSession = new SoapSession();
		String[] Ids = request.getParameterValues("id");
		for (int i = 0; i < Ids.length; i++) {
			Object taskElement = soapSession.createBodyElement("dir");
			soapSession.addAttribute(taskElement, "flag", "logo");
			soapSession.addAttribute(taskElement, "file", Ids[i]);
		}
		soapClicent.send(url, soapSession);
		response.sendRedirect("index.jsp#main10");
		return null;
	}
	
	public ActionForward checkDir(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		URL url = new URL(soapServerAddr + "/box/task/checkdir");
		String addr = request.getParameter("addr");
		SoapSession soapSession = new SoapSession();
		Object dirElement = soapSession.createBodyElement("dir");
		soapSession.addAttribute(dirElement, "inaddr", addr);
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
			request.setAttribute("message", "连接服务器超时");
			try {
				request.getRequestDispatcher("login.jsp").forward(request,
						response);
			} catch (ServletException e) {
				e.printStackTrace();
			}
			return null;
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		}
		List<DirInfoBean> result = TaskUtil.parseDirInfo(recvMsg);
		request.setAttribute("addr", addr);
		request.setAttribute("dirList", result);
		request.getRequestDispatcher("./Pages/Task/dir.jsp").forward(request,
				response);
		return null;
	}

	public ActionForward checkDir2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		URL url = new URL(soapServerAddr + "/box/task/checkdir");
		String addr = request.getParameter("addr");
		SoapSession soapSession = new SoapSession();
		Object dirElement = soapSession.createBodyElement("dir");
		soapSession.addAttribute(dirElement, "outaddr", addr);
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
			request.setAttribute("message", "连接服务器超时");
			try {
				request.getRequestDispatcher("login.jsp").forward(request,
						response);
			} catch (ServletException e) {
				e.printStackTrace();
			}
			return null;
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		}
		List<DirInfoBean> result = TaskUtil.parseDirInfo(recvMsg);
		request.setAttribute("addr", addr);
		request.setAttribute("dirList", result);
		request.getRequestDispatcher("./Pages/LocalFile/dir.jsp").forward(
				request, response);
		return null;
	}
	
	public ActionForward getMaxNum(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/getmax");
		SoapSession soapSession = new SoapSession();
		Object infoElement = soapSession.createBodyElement("max");
		soapSession.addAttribute(infoElement, "num", "max");
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
			request.setAttribute("message", "连接服务器超时");
			try {
				request.getRequestDispatcher("login.jsp").forward(request,
						response);
			} catch (ServletException e) {
				e.printStackTrace();
			}
			return null;
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String result = "2";
		try {
			SOAPBody soapBody = recvMsg.getSOAPBody();
			Node node = soapBody.getElementsByTagName("max").item(0);
			result = node.getAttributes().getNamedItem("num")
					.getNodeValue();
		} catch (SOAPException e) {
			e.printStackTrace();
		}
		result = URLDecoder.decode(result, "utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(result);
		out.close();
		return null;
	}

	public ActionForward setMaxNum(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/task/setmax");
		SoapSession soapSession = new SoapSession();
		String num = request.getParameter("num");
		Object infoElement = soapSession.createBodyElement("max");
		soapSession.addAttribute(infoElement, "num", num);
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if (null == recvMsg) {
			request.setAttribute("message", "连接服务器超时");
			try {
				request.getRequestDispatcher("login.jsp").forward(request,
						response);
			} catch (ServletException e) {
				e.printStackTrace();
			}
			return null;
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String result = "";
		try {
			SOAPBody soapBody = recvMsg.getSOAPBody();
			Node node = soapBody.getElementsByTagName("max").item(0);
			String error = node.getAttributes().getNamedItem("error")
					.getNodeValue();
			if (error.equals("0")) {
				result = "{\"error\":\""+error+"\",\"desc\":\"设置成功！\"}";
			} else {
				result = "{\"error\":\""+error+"\",\"desc\":\"输入值有效范围为：1~5！\"}";
			}
		} catch (SOAPException e) {
			e.printStackTrace();
		}
		result = URLDecoder.decode(result, "utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(result);
		out.close();
		return null;
	}
	
	public ActionForward addDirInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		String file = request.getParameter("image");
		URL url = new URL(soapServerAddr+"/box/file/add");
		SoapSession soapSession = new SoapSession();
		Object dirElement = soapSession.createBodyElement("dir");
		soapSession.addAttribute(dirElement, "flag", "logo");
		soapSession.addAttribute(dirElement, "file", file);
		soapClicent.send(url, soapSession);
		response.sendRedirect("index.jsp#main3");
//		response.sendRedirect("userAction.do?method=getAllUserList");
		return null;
	}
}

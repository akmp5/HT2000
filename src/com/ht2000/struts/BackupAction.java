package com.ht2000.struts;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLDecoder;

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

import com.ht2000.soap.SoapClient;
import com.ht2000.soap.SoapSession;
import com.ht2000.util.BackupUtil;
import com.ht2000.util.HT2000Util;
import com.ht2000.util.TaskUtil;

public class BackupAction extends DispatchAction {
	
	private static SoapClient soapClicent = new SoapClient();
	private static String soapServerAddr = HT2000Util.getSoapServerAddr();

	public ActionForward getAllBackupList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/backup/list");
		SoapSession soapSession = new SoapSession();
		Object targetElement = soapSession.createBodyElement("target");
		soapSession.addAttribute(targetElement, "page_no", "1");
		soapSession.addAttribute(targetElement, "page_size", "20");
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
		String result = BackupUtil.parseBackupList(recvMsg);
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(result);
		out.close();
		return null;
	}
	
	public ActionForward addBackup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/backup/add");
		SoapSession soapSession = new SoapSession();
		String[] ipaddr = request.getParameterValues("ipaddr");
		for (int i=0; i<ipaddr.length; i++) {
			Object targetElement = soapSession.createBodyElement("target");
			soapSession.addAttribute(targetElement, "ipaddr", ipaddr[i]);
		}
		soapClicent.send(url, soapSession);
		response.sendRedirect("./Pages/Backup/allBackupList.jsp");
		return null;
	}
	
	public ActionForward delBackup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/backup/delete");
		SoapSession soapSession = new SoapSession();
		String[] ipaddr = request.getParameterValues("id");
		for (int i=0; i<ipaddr.length; i++) {
			Object targetElement = soapSession.createBodyElement("target");
			soapSession.addAttribute(targetElement, "ipaddr", ipaddr[i]);
		}
		soapClicent.send(url, soapSession);
		String result = URLDecoder.decode("删除成功！", "utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(result);
		out.close();
		return null;
	}
	
	public ActionForward getTotalNum(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, SOAPException {
		URL url = new URL(soapServerAddr + "/box/backup/backupnum");
		SoapSession soapSession = new SoapSession();
		Object taskElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(taskElement, "check", "num");
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
		SOAPBody soapBody = recvMsg.getSOAPBody();
		Node taskNode = soapBody.getElementsByTagName("task").item(0);
		String result = taskNode.getAttributes().getNamedItem("num")
				.getNodeValue();
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(result);
		out.close();
		return null;
	}
	
	public ActionForward getAllTaskList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		URL url = new URL(soapServerAddr + "/box/backup/backuplist");
		SoapSession soapSession = new SoapSession();
		String currPage = request.getParameter("currPage");
		String pageNum = request.getParameter("pageNum");
		Object taskElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(taskElement, "page_no", currPage);
		soapSession.addAttribute(taskElement, "page_size", pageNum);
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
		String result = BackupUtil.parseTaskList(recvMsg);
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(result);
		out.close();
		return null;
	}
	
	public ActionForward getTaskInfoById(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		URL url = new URL(soapServerAddr + "/box/backup/backupinfo");
		SoapSession soapSession = new SoapSession();
		String taskId = request.getParameter("id");
		Object taskElement = soapSession.createBodyElement("task");
		soapSession.addAttribute(taskElement, "id", taskId);
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
		String taskInfo = TaskUtil.parseTaskInfo(recvMsg);
		System.out.println(taskInfo);
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(taskInfo);
		out.close();
		return null;
	}

}

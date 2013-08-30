package com.ht2000.struts;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.ht2000.bean.UserInfoBean;
import com.ht2000.soap.SoapClient;
import com.ht2000.soap.SoapSession;
import com.ht2000.util.Encryption;
import com.ht2000.util.HT2000Util;
import com.ht2000.util.UserUtil;

public class UserAction extends DispatchAction {

	private static SoapClient soapClicent = new SoapClient();
	private static String soapServerAddr = HT2000Util.getSoapServerAddr();
	
	public ActionForward login(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		URL url = new URL(soapServerAddr+"/box/user/checkin");
		SoapSession soapSession = new SoapSession();
		Object userElement = soapSession.createBodyElement("user");
		soapSession.addAttribute(userElement, "name", name);
		soapSession.addAttribute(userElement, "pswd", pwd);
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if(null == recvMsg){
			request.getSession().setAttribute("message", "连接服务器超时");
			response.sendRedirect("./login.jsp");
			return null;
		}
		try {
			recvMsg.writeTo(System.out);
		} catch (SOAPException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		UserInfoBean userInfo = UserUtil.parseUserInfo(recvMsg); 
		if(userInfo.getError().equals("1")){
			request.getSession().setAttribute("message", userInfo.getCheckin());
			return mapping.findForward("login");
		}else{
			userInfo.setName(name);
			userInfo.setPswd(pwd);
			request.getSession().removeAttribute("message");
			request.getSession().setAttribute("AdminInfo", userInfo);
			response.sendRedirect("./index.jsp");
//			response.sendRedirect("./Pages/index.html");
			return null;
		}
	}
	
	public ActionForward logout(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/user/checkout");
		SoapSession soapSession = new SoapSession();
		Object userElement = soapSession.createBodyElement("user");
		UserInfoBean userInfo = (UserInfoBean)request.getSession().getAttribute("AdminInfo");
		soapSession.addAttribute(userElement, "name", userInfo.getName());
		soapClicent.send(url, soapSession);
		request.getSession().removeAttribute("AdminInfo");
		response.sendRedirect("./login.jsp");
		return null;
	}
	
	public ActionForward getAllUserList(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/user/list");
		SoapSession soapSession = new SoapSession();
		Object userElement = soapSession.createBodyElement("user");
		soapSession.addAttribute(userElement, "page_no", "1");
		soapSession.addAttribute(userElement, "page_size", "30");
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
		ArrayList<UserInfoBean> userList = UserUtil.parseUserList(recvMsg);
		request.getSession().setAttribute("userList", userList);
		return mapping.findForward("getAllUserList");
	}
	
	public ActionForward checkName(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		String name = request.getParameter("name");
		URL url = new URL(soapServerAddr+"/box/user/check");
		SoapSession soapSession = new SoapSession();
		Object userElement = soapSession.createBodyElement("user");
		soapSession.addAttribute(userElement, "name", name);
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
		String error = UserUtil.parseUserName(recvMsg);
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(error);
		out.close();
		return null;
	}
	
	public ActionForward addUser(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String validity = request.getParameter("validity");
		String permission = request.getParameter("permission");
		DateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:ss:mm");
		Date date=null;
		try {
			date = sdf.parse(validity+" 00:00:00");
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		URL url = new URL(soapServerAddr+"/box/user/add");
		SoapSession soapSession = new SoapSession();
		Object userElement = soapSession.createBodyElement("user");
		soapSession.addAttribute(userElement, "name", name);
		soapSession.addAttribute(userElement, "pswd", pwd);
		soapSession.addAttribute(userElement, "validity", String.valueOf(date.getTime()/1000));
		soapSession.addAttribute(userElement, "permission", permission);
		soapClicent.send(url, soapSession);
		response.sendRedirect("index.jsp#main3");
		return null;
	}
	
	public ActionForward delUser(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		String[] ids = request.getParameterValues("id");
		URL url = new URL(soapServerAddr+"/box/user/delete");
		SoapSession soapSession = new SoapSession();
		for(int i=0; i<ids.length; i++){
			Object userElement = soapSession.createBodyElement("user");
			soapSession.addAttribute(userElement, "name", ids[i]);
		}
		SOAPMessage recvMsg = soapClicent.send(url, soapSession);
		if(null == recvMsg){
			response.sendRedirect("./userAction.do?method=logout");
			return null;
		}else{
			response.sendRedirect("index.jsp#main3");
		}
		return null;
	}
	
	public ActionForward getUserInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		String name = request.getParameter("name");
		URL url = new URL(soapServerAddr+"/box/user/info");
		SoapSession soapSession = new SoapSession();
		Object userElement = soapSession.createBodyElement("user");
		soapSession.addAttribute(userElement, "name", name);
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
		UserInfoBean userInfo = UserUtil.parseUserInfo(recvMsg);
		
		request.getSession().setAttribute("userInfo", userInfo);
		return mapping.findForward("updateUser");
	}
	
	public ActionForward updateUser(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/user/modify");
		SoapSession soapSession = new SoapSession();
		Object userElement = soapSession.createBodyElement("user");
		String name = request.getParameter("name");
		if(name == null){
			UserInfoBean userInfo = (UserInfoBean)request.getSession().getAttribute("AdminInfo");
			name = userInfo.getName();
		}
		String pwd = request.getParameter("pwd");
		String validity = request.getParameter("validity");
		String permission = request.getParameter("permission");
		if(validity != null){
			DateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:ss:mm");
			Date date=null;
			try {
				date = sdf.parse(validity+" 00:00:00");
				soapSession.addAttribute(userElement, "validity", String.valueOf(date.getTime()/1000));
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
		}else{
			soapSession.addAttribute(userElement, "validity", "");
		}
		soapSession.addAttribute(userElement, "name", name);
		soapSession.addAttribute(userElement, "pswd", pwd);
		soapSession.addAttribute(userElement, "permission", permission);
		soapClicent.send(url, soapSession);
		if(validity == null){
			response.sendRedirect("./userAction.do?method=logout");
			return null;
		}else{
			response.sendRedirect("index.jsp#main3");
		}
		return null;
	}
	
	public ActionForward reset(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		URL url = new URL(soapServerAddr+"/box/user/modify");
		SoapSession soapSession = new SoapSession();
		Object userElement = soapSession.createBodyElement("user");
		String keyCode = request.getParameter("keyCode").trim();
		Date nowDate = new Date();
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		String nowDateStr = dateFormat.format(nowDate);
		System.out.println(Encryption.md5(nowDateStr));
		if(Encryption.md5(nowDateStr).equals(keyCode)){
			soapSession.addAttribute(userElement, "name", "root");
			soapSession.addAttribute(userElement, "pswd", "mcs123456");
			soapSession.addAttribute(userElement, "permission", "");
			soapSession.addAttribute(userElement, "validity", "");
			soapClicent.send(url, soapSession);
			request.getSession().setAttribute("message", "重置密码成功,默认密码为：mcs123456");
			response.sendRedirect("./login.jsp");
		}else{
			request.getSession().setAttribute("message", "验证码不正确");
			response.sendRedirect("./reset.jsp");
		}
		return null;
	}
}

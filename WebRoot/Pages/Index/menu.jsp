<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>menu</title>
<script src="../../Public/Js/prototype.lite.js" type="text/javascript"></script>
<script src="../../Public/Js/moo.fx.js" type="text/javascript"></script>
<script src="../../Public/Js/moo.fx.pack.js" type="text/javascript"></script>
<style>
body {
	font:14px "微软雅黑";
	color: #000;
	background-color: #EEF2FB;
	margin: 0px;
}
H1 {
	font-size: 14px;
	margin: 0px;
	width: 182px;
	cursor: pointer;
	height: 30px;
	line-height: 20px;	
}
H1 a {
	display: block;
	width: 182px;
	color: #000;
	height: 30px;
	text-decoration: none;
	moz-outline-style: none;
	background-image: url(../../Public/Images/menu_bgS.gif);
	background-repeat: no-repeat;
	line-height: 30px;
	text-align: center;
	margin-left: 10px;
	padding: 0px;
}
.content{
	width: 182px;
	margin-left: 10px;
}
.MM ul {
	list-style-type: none;
	margin: 0px;
	padding: 0px;
	display: block;
}
.MM li {
	font-size: 14px;
	line-height: 26px;
	color: #333333;
	list-style-type: none;
	display: block;
	text-decoration: none;
	height: 26px;
	width: 182px;
	padding-left: 0px;
}
.MM {
	width: 182px;
	margin: 0px;
	padding: 0px;
	left: 0px;
	top: 0px;
	right: 0px;
	bottom: 0px;
	clip: rect(0px,0px,0px,0px);
}
.MM a:link {
	font-size: 14px;
	line-height: 26px;
	color: #333333;
	background-image: url(../../Public/Images/menu_bg1.gif);
	background-repeat: no-repeat;
	height: 26px;
	width: 182px;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	overflow: hidden;
	text-decoration: none;
}
.MM a:visited {
	font-size: 14px;
	line-height: 26px;
	color: #333333;
	background-image: url(../../Public/Images/menu_bg1.gif);
	background-repeat: no-repeat;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	height: 26px;
	width: 182px;
	text-decoration: none;
}
.MM a:active {
	font-size: 14px;
	line-height: 26px;
	color: #333333;
	background-image: url(../../Public/Images/menu_bg1.gif);
	background-repeat: no-repeat;
	height: 26px;
	width: 182px;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	overflow: hidden;
	text-decoration: none;
}
.MM a:hover {
	font-size: 14px;
	line-height: 26px;
	font-weight: bold;
	color: #006600;
	background-image: url(../../Public/Images/menu_bg2.gif);
	background-repeat: no-repeat;
	text-align: center;
	display: block;
	margin: 0px;
	padding: 0px;
	height: 26px;
	width: 182px;
	text-decoration: none;
}
.clear {
	clear: both;
}
</style>
</head>

<body>
<table width="100%" height="280" border="0" cellpadding="0" cellspacing="0" bgcolor="#EEF2FB">
  <tr>
    <td width="182" valign="top">
      <h1 class="type"><a href="javascript:void(0)">系统管理</a></h1>
      <div class="content">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><img src="../../Public/Images/menu_topline.gif" width="182" height="5" /></td>
          </tr>
        </table>
        <ul class="MM">
          <li><a href="../../systemAction.do?method=getBaseInfo" target="main">基本信息</a></li>
          <li><a href="../../Pages/SystemInfo/systemInfo.jsp" target="main">系统状态</a></li>
          <c:if test="${AdminInfo.permission == '2'}">
          <li><a href="../../userAction.do?method=getAllUserList" target="main">用户信息</a></li>
          </c:if>
          <li><a href="../../Pages/User/updatePwd.jsp" target="main">修改密码</a></li>
          <li><a href="../../taskAction.do?method=getAllTaskList" target="main">任务信息</a></li>
        </ul>
        <div class="clear"></div>
      </div>
   </td>
  </tr>
</table>
</body>
<script type="text/javascript">
	/*
	var contents = document.getElementsByClassName('content');
	var toggles = document.getElementsByClassName('type');
	
	var myAccordion = new fx.Accordion(
		toggles, contents, {opacity: true, duration: 400}
	);
	myAccordion.showThisHideOpen(contents[0]);
	*/
</script>
</html>
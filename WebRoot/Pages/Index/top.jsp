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
<title>top</title>
<style type="text/css">
.top_bg {
	background-image: url(../../Public/Images/top-bg.gif);
	background-repeat: repeat-x;
}
.top_txt {
	font-family: "微软雅黑";
	font-size: 14px;
	color: #FFFFFF;
	text-align: right;
	text-decoration: none;
	height: 38px;
	width: 100%;
	position: absolut;
	line-height: 38px;
}
</style>
</head>
<body leftmargin="0" topmargin="0">
<table width="100%" height="64" border="0" cellpadding="0" cellspacing="0" class="top_bg">
  <tr>
    <td width="61%" height="64"><img src="../../Public/Images/logo.gif" width="262" height="64"></td>
    <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="74%" height="38" class="top_txt">
        	<b></b>${AdminInfo.name} (
        	<c:if test="${AdminInfo.permission == '0'}">普通用户</c:if>
			<c:if test="${AdminInfo.permission == '1'}">操作员</c:if>
			<c:if test="${AdminInfo.permission == '2'}">管理员</c:if>
			)您好,欢迎登录使用系统！
        </td>
        <td width="22%"><a href="../../userAction.do?method=logout"><img src="../../Public/Images/out.gif" alt="安全退出" width="46" height="20" border="0"></a></td>
        <td width="4%">&nbsp;</td>
      </tr>
      <tr>
        <td height="19" colspan="3">&nbsp;</td>
        </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
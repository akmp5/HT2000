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
<title>main</title>
</head>
  
<body class="main-body" >
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="#" method="post">
	</form>
</div>
<div class="pageContent" style="width:100%;height:100%;overflow:auto;">
	<table class="list" width="100%" targetType="navTab" height="46">
		<thead>
			<tr>
				<th width="120">MAC地址</th>
				<th>IP地址</th>
				<th width="100">网络掩码</th>
				<th width="150">网关</th>
				<th width="60" >版本</th>
				<th width="180">版本信息</th>
				<th width="100">序列编号</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid_user" rel="1">
				<td>${baseInfo.macaddr}</td>
				<td>${baseInfo.ipaddr}</td>
				<td>${baseInfo.netmask}</td>
				<td>${baseInfo.gateway}</td>
				<td>${baseInfo.version}</td>
				<td>${baseInfo.desc}</td>
			    <td>${baseInfo.serialnum}</td>
			</tr>
		</tbody>
	</table>
    <div class="page unitBox">
			 <c:import url="taskIOInfo.jsp"></c:import>
	 </div>
	  <div class="page unitBox">
			 <c:import url="licenseInfo.jsp"></c:import>
	 </div>
 	 <div class="page unitBox">
			 <c:import url="systemInfo.jsp"></c:import>
	 </div>
    
	</div>
</body>
</html>

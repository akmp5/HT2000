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
<script type="text/javascript">
   $(function(){
	showLicenseInfo();
	});
	function showLicenseInfo(){
		$.post("systemAction.do?method=getLicenseInfo","",function(data){
		});
	}
</script>
</head>
<body class="main-body">
<div class="pageContent">
	
		<table class="list" width="100%" targetType="navTab" height="46">
		<thead>
			<tr>
				<th width="80">授权级别</th>
				<th>授权截止日期</th>
				<th width="70">最大任务数</th>
				<th width="70">最大输出数</th>
				<th width="120" >最大连续转码时长</th>
				<th width="120" >授权发布时间</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid_user1" rel="11">
				<td>${licenseInfo.licenseLevel}</td>
				<td>${licenseInfo.endTimeAbs}</td>
				<td>${licenseInfo.maxInputTask}</td>
				<td>${licenseInfo.maxOutputTask}</td>
				<td>${licenseInfo.maxWorkTimes}</td>
				<td>${licenseInfo.published}</td>
			</tr>
		</tbody>
	</table>
	</div>
</body>
</html>

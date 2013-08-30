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
</head>
    
<body class="main-body">
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="#" method="post">
	</form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="Pages/User/addUser.jsp" target="dialog" mask="true"><span>添加</span></a></li>
			<li><a class="edit" href="userAction.do?method=getUserInfo&name={name}" target="dialog" mask="true"><span>修改</span></a></li>
			<li><a class="delete" href="userAction.do?method=delUser&id={name}" target="ajaxTodo" title="确定要删除吗?"><span>删除</span></a></li>
		</ul>
	</div>
<table class="table" width="100%" layoutH="138" class="pageForm required-validate">
		<thead>
		        <tr>
					<th><input class="check-all" type="checkbox" /></th>
					<th>用户名</th>
					<th>注册时间</th>
					<th>权限</th>
					<th>有效期</th>
				</tr>
		</thead>

			<tbody>
			<c:forEach  var="userInfo" items="${userList}">
				<c:if test="${userInfo.name != 'root'}">
				<tr target="name" rel="${userInfo.name}">
					<td>
						<c:if test="${userInfo.name != 'root'}">
						<input name="name" type="checkbox" value="${userInfo.name}" />
						</c:if>
					</td>
					<td>${userInfo.name}</td>
					<td>${userInfo.startUtc}</td>
					<td>
						<c:if test="${userInfo.permission == '0'}">普通用户</c:if>
						<c:if test="${userInfo.permission == '1'}">操作员</c:if>
						<c:if test="${userInfo.permission == '2'}">管理员</c:if>
					</td>
					<td>${userInfo.validity}</td>
				</tr>
				</c:if>
			</c:forEach>
			</tbody>
	</table>
</div>
</body>
</html>
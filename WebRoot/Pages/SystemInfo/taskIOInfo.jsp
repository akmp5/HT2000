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
	showTaskIOInfo();

	function showTaskIOInfo(){
		$.post("taskAction.do?method=getTaskIOInfo","",function(data){
		    
		});
	}
</script>
</head>
<body class="main-body">
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="#" method="post">
	</form>
</div>
<div class="pageContent">
	 <table class="list" width="100%" targetType="navTab" height="46" >
		<thead>
			<tr>
				<th width="120">任务名称</th>
			    <th width="120">任务启动时间</th>
			    <th width="120">任务描述</th>
				<th width="120">输入地址</th>
			    <th width="120">输出地址</th>
			</tr>
		</thead>
		 <tbody>
			<c:forEach  var="taskIOInfo" items="${taskIOList}">
				<tr target="id" rel="${taskIOInfo.taskId}">
					<td>${taskIOInfo.taskId}</td>
					<td>${taskIOInfo.start_utc}</td>
					<td>${taskIOInfo.taskDesc}</td>
					<td>${taskIOInfo.inputAddr}</td>
					<td>${taskIOInfo.outputAddr}</td>
				</tr>
			</c:forEach>
			</tbody>
	</table>
	</div>
</body>
</html>

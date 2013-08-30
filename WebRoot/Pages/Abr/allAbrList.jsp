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
  
<body class="main-body">
<div class="pageContent" style="width:100%;height:100%;overflow:auto;">
	<div class="panelBar">
	  <c:if test="${AdminInfo.permission > 0}">
	  <ul class="toolBar">
		<li><a class="add" href="Pages/Abr/addAbr.jsp" target="dialog"><span>添加</span></a></li>
	    <li><a class="edit" href="Pages/Abr/updateAbr.jsp?id={abrId}" target="dialog" width ="540" height="160"><span>修改</span></a></li>
	    <li><a class="edit" href="Pages/Abr/abrDetail.jsp?id={abrId}" target="dialog" width ="540" height="160"><span>任务详细</span></a></li>
		<c:if test="${AdminInfo.permission > 1}">
		<li><a class="delete" target="ajaxTodo" title="确定要删除吗?" href="abrAction.do?method=delAbr&&id={abrId}"><span>删除</span></a></li>
		</c:if>
	   </ul>
	   </c:if>
	</div>
	 <table class="table" width="100%" height="100%">
			<thead>
				<tr>
					<th><input class="check-all" type="checkbox" /></th>
					<th>任务名称</th>
					<th>启动时间</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach  var="abrInfo" items="${abrList}">
				<tr target="abrId" rel ="${abrInfo.id}">
					<td><input name="name" type="checkbox" value="${abrInfo.id}" /></td>
					<td><input type="hidden" name='id' value="${abrInfo.id}"/>${abrInfo.desc}</td>
					<td>${abrInfo.start_utc}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
	
</body>
<script type="text/javascript">
	function delAbr(__id){
		if(confirm("您确定要删除这个任务？")){
			window.location.href="abrAction.do?method=delAbr&id="+__id;
		}
	}
</script>
</html>

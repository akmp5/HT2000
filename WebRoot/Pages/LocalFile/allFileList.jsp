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
	  <ul class="toolBar">
		<li><a class="add" href="Pages/LocalFile/fileSetting.jsp" target="dialog"  title="添加附件" ><span>添加</span></a></li>
	    <li><a class="delete" href="taskAction.do?method=delDirInfo&id={dirId}" target="ajaxTodo" title="确定要删除吗?"><span>删除</span></a></li>
	   </ul>
	</div>	
	    <table class="table" width="100%" height="100%">
			<thead>
				<tr>
					<th>文件名</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach  var="dirInfo" items="${dirList}">
				<tr target="dirId" rel="${dirInfo.name}">
					<td><input type="hidden" name='id' value="${dirInfo.name}"/>${dirInfo.value}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>


</body>
</html>

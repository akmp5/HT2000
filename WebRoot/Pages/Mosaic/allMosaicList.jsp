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
		<li><a class="add" href="Pages/Mosaic/addMosaic.jsp" target="dialog" width ="940" height="600"><span>添加</span></a></li>
	    <li><a class="edit" href="Pages/Mosaic/updateMosaic.jsp?id={mosaicId}" target="dialog" width ="940" height="500"><span>修改</span></a></li>
	    <li><a class="edit" href="Pages/Mosaic/mosaicDetail.jsp?id={mosaicId}" target="dialog" width ="940" height="500"><span>任务详细</span></a></li>
		<c:if test="${AdminInfo.permission > 1}">
		<li><a class="delete" target="ajaxTodo" title="确定要删除吗?" href="mosaicAction.do?method=delMosaic&&id={mosaicId}"><span>删除</span></a></li>
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
			<c:forEach  var="mosaicInfo" items="${mosaicList}">
				<tr target="mosaicId" rel ="${mosaicInfo.id}">
					<td><input name="name" type="checkbox" value="${mosaicInfo.id}" /></td>
					<td><input type="hidden" name='id' value="${mosaicInfo.id}"/>${mosaicInfo.desc}</td>
					<td>${mosaicInfo.start_utc}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
	
</body>
<script type="text/javascript">
	function delmosaic(__id){
		if(confirm("您确定要删除这个任务？")){
			window.location.href="mosaicAction.do?method=delMosaic&id="+__id;
		}
	}
</script>
</html>

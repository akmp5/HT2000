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
		<li><a class="add" href="Pages/Task/addTask.jsp" target="dialog"  title="新增任务" width="940" height="600"><span>添加</span></a></li>
	    <li><a class="edit" href="Pages/Task/updateTask.jsp?id={taskId}" target="dialog"  title="修改任务" width="940" height="600"><span>修改</span></a></li>
	    <li><a class="edit" href="Pages/Task/taskDetail.jsp?id={taskId}" target="dialog" width="940" height="600"><span>任务详细</span></a></li>
	     <c:if test="${AdminInfo.permission > 1}">
	    <li><a class="delete" href="taskAction.do?method=delTask&id={taskId}" target="ajaxTodo" title="确定要删除吗?"><span>删除</span></a></li>
		<li><a class="edit"  href="javascript:void(null);"  onClick="saveDefault();" ><span>保存默认配置</span></a></li>
	    <li><a class="edit"  href="javascript:void(null);"  onClick="changeDefault();" ><span>修改默认配置</span></a></li>
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
			<c:forEach  var="taskInfo" items="${taskList}">
				<tr target="taskId" rel="${taskInfo.taskId}">
					<td><input name="name" type="checkbox" value="${taskInfo.taskId}" /></td>
					<td><input type="hidden" name='id' value="${taskInfo.taskId }"/>${taskInfo.taskDesc}</td>
					<td>${taskInfo.start_utc}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
</body>
<script type="text/javascript">
	function delTask(__id){
		if(confirm("您确定要删除这个任务？")){
			window.location.href="taskAction.do?method=delTask&id="+__id;
		}
	}
	
	function saveDefault(){
	  if(confirm("您确定要保存默认配置吗？")){
			$.post("taskAction.do?method=setdef","",function(data){
				alert(data);
			});
		}
	}
	
	function  changeDefault(){
	  if(confirm("您确定要恢复默认配置吗？")){
			$.post("taskAction.do?method=restoredef","",function(data){
				alert(data);
			});
		}
	}
	
</script>
</html>

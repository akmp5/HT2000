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
<style type="text/css" media="screen">
.my-uploadify-button {
	background:none;
	border: none;
	text-shadow: none;
	border-radius:0;
}

.uploadify:hover .my-uploadify-button {
	background:none;
	border: none;
}

.fileQueue {
	width: 400px;
	height: 150px;
	overflow: auto;
	border: 1px solid #E5E5E5;
	margin-bottom: 10px;
}
</style>
</head>
<body class="main-body" >
<div class="pageContent">
	<form method="post" action="taskAction.do?method=addDirInfo" >
		<div class="pageFormContent" layoutH="60">
			<p>
				<input id="testFileInput" type="file" name="image" 
					uploaderOption="{
						swf:'Public/uploadify/scripts/uploadify.swf',
						uploader:'demo/common/ajaxDone.html',
						formData:{PHPSESSID:'xxx', ajax:1},
						buttonText:'请选择文件',
						fileSizeLimit:'200KB',
						fileTypeDesc:'*.jpg;*.jpeg;*.gif;*.png;',
						fileTypeExts:'*.jpg;*.jpeg;*.gif;*.png;',
						auto:true,
						multi:true,
						onUploadSuccess:uploadifySuccess,
						onQueueComplete:uploadifyQueueComplete
					}"
	        />
			</p>
			</div>
		<div class="formBar">
			<ul>
				<li><input type="image" src="Public/uploadify/img/upload.jpg" onClick="add();" /></li>
				<li><input type="image" src="Public/uploadify/img/cancel.jpg" onclick="$('#testFileInput2').uploadify('cancel', '*');"/></li>
			</ul>
		</div>
	</form>
</div>

<script type="text/javascript">
	
	function add(){
		document.myForm.submit();
	}
</script>
</body>
</html>

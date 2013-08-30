<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>main</title>
	</head>

	<body class="main-body">
		<div id="main-content">
			<div class="content-box">
				<div class="content-box-header">
					<ul class="content-box-button">
						<li>
							<input class="button" type="button" value="启动升级" onClick="update();" />
						</li>
					</ul>
					<div class="clear"></div>
				</div>
				<div class="content-box-content">
					<div class="tab-content">
						<c:if test="${message != null}">
							<div class="notification information">
								<div>
									${message}
								</div>
								<script type="text/javascript">
									window.setTimeout(function() {
										$(".information").fadeOut(1000);
									}, 3000);
								</script>
							</div>
						</c:if>
						<form action="Upload/upload/fileUpload" method="post"
							enctype="multipart/form-data">
							<fieldset>
								<p>
									<label>
										升级文件：
									</label>
									<input type="file" name="file" />
									<input class="button" type="submit" value="上传" />
								</p>
							</fieldset>
						</form>
						<div class="clear"></div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	function update() {
		if (confirm("您确定要启动升级？")) {
			$.post("updateAction.do?method=update", "", function(data) {
				alert(data);
			});
		}
	}
</script>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title></title>
		<%@include file="common1.jsp" %>
<!-- 导入公用文件 -->

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=8" />
		<script type="text/javascript">
//window.onload = tick;


$(function() {
	DWZ.init("dwz.frag.xml", {
		loginUrl : "login_dialog.html",
		loginTitle : "登录", // 弹出登录对话框
		loginUrl : "login.jsp", // 跳到登录页面
		statusCode : {
			ok : 200,
			error : 300,
			timeout : 301
		}, //【可选】
		pageInfo : {
		    pageNum : "pageNum",
			numPerPage : "numPerPage",
			orderField : "orderField",
			orderDirection : "orderDirection"
		
		}, //【可选】
		debug : true, // 调试模式 【true|false】
		callback : function() {
			initEnv();
			$("#themeList").theme( {
				themeBase : "themes"
			}); // themeBase 相对于index页面的主题base路径
	}
	});
});
function indexTuiChu() {
	var url = "";
	if (confirm("确定退出系统吗？")) {
		$.get(url, function(data) {
		});
		return true;
	} else {
		return false;
	}
}

</script>
	</head>

	<body scroll="yes">
		<div id="layout">
			<div id="header">
				<div class="headerNav">
					<img src="Public/Images/180.png" />
					<ul class="nav">
						<li>
							<a href="<%=path%>/Pages/User/updatePwd.jsp" target="dialog"
								width="400">设置密码</a>
						</li>
						<c:if test="${loginType ne 'client'}">
							<li>
								<a href="login.jsp" onclick="return indexTuiChu()">退出系统</a>
							</li>
						</c:if>
					</ul>
					<ul class="themeList" id="themeList">
						<li theme="default">
							<div class="selected">
								绿色
							</div>
						</li>
						<li theme="green">
							<div>
								蓝色
							</div>
						</li>
						<li theme="purple">
							<div>
								紫色
							</div>
						</li>
						<li theme="silver">
							<div>
								银色
							</div>
						</li>
						<li theme="azure">
							<div>
								天蓝
							</div>
						</li>
					</ul>
					<ul class="nav" style="position: absolute; top: 50px; right: 10px;">
						<li>
							<div id="Clock_index" align="center"
								style="font-size: 12px; color: #15428B"></div>
						</li>
					</ul>
				</div>
				<!-- navMenu -->
			</div>

		<div id="leftside">
			<div id="sidebar_s">
				<div class="collapse">
					<div class="toggleCollapse"><div></div></div>
				</div>
			</div>
			<div id="sidebar">
				<div class="toggleCollapse"><h2>主菜单</h2><div>收缩</div></div>
				<div class="accordion" fillSpace="sidebar">
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<li><a href="" target="navTab">功能</a>
								<ul>
									<li><a href="systemAction.do?method=getBaseInfo" target="navTab" rel="main1">运行状态</a></li>
									<li><a href="userAction.do?method=getAllUserList" target="navTab" rel="main3">用户管理</a></li>
									<li><a href="taskAction.do?method=getAllTaskList" target="navTab" rel="main4">任务管理</a></li>
								    <li><a href="abrAction.do?method=getAllAbrList" target="navTab" rel="main5">ABR管理</a></li>
									<li><a href="taskAction.do?method=getDirInfo" target="navTab" rel="main6">LOGO管理</a></li>
								    <li><a href="Pages/SystemInfo/systemSetting.jsp" target="navTab" rel="main8">系统工具</a></li>
								    <li><a href="Pages/Backup/allBackupList.jsp" target="navTab" rel="main7">备份管理</a></li>
								 <!--<li><a href="backupAction.do?method=getAllBackupList" target="navTab" rel="main7">备份管理</a></li>  -->   
								    <li><a href="mosaicAction.do?method=getAllMosaicList" target="navTab" rel="main10">视频拼接</a></li>
								    <li><a href="right.html" target="navTab" rel="main9">介绍&帮助</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
			<div id="container">
				<div id="navTab" class="tabsPage">
					<div class="tabsPageHeader">
						<div class="tabsPageHeaderContent">
							<!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
							<ul class="navTab-tab" style="left: 0px; ">
								<li tabid="main" class="main selected">
									<a href="javascript:;"><span><span class="home_icon">我的主页</span>
									</span>
									</a>
								</li>
							</ul>
						</div>
						<div class="tabsLeft">
							left
						</div>
						<!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
						<div class="tabsRight">
							right
						</div>
						<!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
						<div class="tabsMore">
							more
						</div>
					</div>
					<ul class="tabsMoreList">
						<li class="selected">
							<a href="javascript:;"></a>
						</li>
					</ul>
					<div class="navTab-panel tabsPageContent layoutBox">
						<div class="page unitBox">
							<c:import url="Pages/SystemInfo/systemSetting.jsp"></c:import>
						</div>
					</div>
				</div>
			</div>
		</div>
			<div id="footer">Copyright &copy; box</div>
	</body>
</html>

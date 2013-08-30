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
<title>top</title>
<script type="text/javascript" src="../../Public/Js/jquery.js"></script>
<style type="text/css">
ul.content-box-button {
	margin-left:0px;
	margin-top:30px;
	padding-left:0px;
	float: right;
	list-style: none;
}

ul.content-box-button li{
	float:left;
	margin-right:10px;
}
/************ Button ************/
.button {
	display: inline-block;
	background: #459300 url('../Images/bg-button-green.gif') top left repeat-x !important;
	border: 1px solid #459300 !important;
	padding: 4px 7px 4px 7px !important;
	color: #fff !important;
	font-size: 12px !important;
	cursor: pointer;
	-moz-border-radius: 4px;
    -webkit-border-radius: 4px;
	border-radius: 4px;
}
                
.button:hover {
	text-decoration: underline;
}
                
.button:active {
	padding: 5px 7px 3px 7px !important;
}
				
a.remove-link {
	color: #bb0000;
}

a.remove-link:hover {
	color: #000;
}
.footer_bg {
	background-image: url(../../Public/Images/footer-bg.gif);
	background-repeat: repeat-x;
}
</style>
</head>
<body leftmargin="0" topmargin="0">
<table width="100%" height="64" border="0" cellpadding="0" cellspacing="0" class="footer_bg">
	<tr>
		<td >
			<c:if test="${AdminInfo.permission == '2'}">
			<ul class="content-box-button">
				<c:if test="${baseInfo.usb == 0}">
				<li><input id="usbButton" type="button" value="开启USB升级" class="button" onclick="changeUsb();"></li>
				</c:if>
				<c:if test="${baseInfo.usb == 1}">
				<li><input id="usbButton" type="button" value="关闭USB升级" class="button" onclick="changeUsb();"></li>
				</c:if>
				<li><input type="button" value="快速重启" class="button" onClick="restart();"></li>
				<li><input type="button" value="重启编码器" class="button" onClick="reboot();"></li>
			</ul>
			</c:if>
		</td>	
	</tr>
</table>
</body>
<script type="text/javascript">
	var usbStatus = "${baseInfo.usb}";

//	console.log(usbStatus);
	if(!Boolean(usbStatus)){
		window.location.reload();
	}
	
	function changeUsb(){
		if(usbStatus == "1"){
			var message = "您确定要关闭USB升级？"
			usbStatus = "0";
		}else{
			var message = "您确定要打开USB升级？"
			usbStatus = "1";
		}
		var self = this;
		if(confirm(message)){
			$.post("../../systemAction.do?method=usbctrl",{status:usbStatus},function(data){
				alert(data);
				if(usbStatus == "0"){
					$("#usbButton").val("开启USB升级");
				}else{
					$("#usbButton").val("关闭USB升级");
				}
			});
		}
	}
	
	function restart(){
		if(confirm("您确定要重启服务？")){
			$.post("../../systemAction.do?method=restart","",function(data){
				alert(data);
			});
		}
	}
	
	function reboot(){
		if(confirm("您确定要重启编码器？")){
			$.post("../../systemAction.do?method=reboot","",function(data){
				alert(data);
			});
		}
	}
</script>
</html>
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
//window.onload = tick;

 var usbStatus = "1";

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
			$.post("systemAction.do?method=usbctrl",{status:usbStatus},function(data){
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
			$.post("systemAction.do?method=restart","",function(data){
				alert(data);
			});
		}
	}
	
	function reboot(){
		if(confirm("您确定要重启编码器？")){
			$.post("systemAction.do?method=reboot","",function(data){
				alert(data);
			});
		}
	}
	
	 function updateVersion(){
	  if(confirm("您确定要进行升级吗？")){
			$.post("systemAction.do?method=upgrate","",function(data){
				alert(data);
			});
		}
	}
	
	var ipMode = "dhcp";

	function changeMode(mode){
		ipMode = mode;
		$('.networkBox').slideToggle();
	}

	function save() {
		var flag = true;
		if (ipMode == "static"){
			$("input[type='text']").each(function(){
				if($(this).attr("name")!="dns1"&&$(this).attr("name")!="gateway"&&$(this).val() == "") flag = false;
			});
		}
		if(!flag){
			alert("请检查参数是否添写完整！");
		}else{
			document.myForms.submit();
		}
	}

</script>
</head>
  
<body class="main-body" >

<div class="pageContent" style="width:100%;height:100%;overflow:auto;">
  <div class="panelBar">
	  <ul class="toolBar">
								  <c:if test="${baseInfo.usb == 0}">
									<li><div class="button"><div class="buttonContent"><button onclick="changeUsb();">开启USB升级模式</button></div></div></li>
								    </c:if>
									<c:if test="${baseInfo.usb == 1}">
									<li><div class="button"><div class="buttonContent"><button onclick="changeUsb();">关闭USD升级模式</button></div></div></li>
								    </c:if>
								    <li><div class="button"><div class="buttonContent"><button onclick="restart();">快速重启编码服务</button></div></div></li>
								    <li><div class="button"><div class="buttonContent"><button onclick="reboot();">重启转码设备</button></div></div></li>
								    <li><div class="button"><div class="buttonContent"><button onclick="reboot();">复位转码设备</button></div></div></li>
		
		                            <c:if test="${baseInfo.usb == 0}">
									<li><div class="button"><div class="buttonContent"><button onclick="changeUsb();">开启USB升级模式</button></div></div></li>
								    </c:if>
									<c:if test="${baseInfo.usb == 1}">
									<li><div class="button"><div class="buttonContent"><button onclick="changeUsb();">关闭USD升级模式</button></div></div></li>
								    </c:if>
								    <li><div class="button"><div class="buttonContent"><button onclick="updateVersion();">系统升级</button></div></div></li>
					                <li><div class="button"><div class="buttonContent"><button onclick="updateVesion();">在线升级（http）</button></div></div></li>
					                
		</ul>
	</div>	
			<form name="myForms" action="settingAction.do?method=setNetwork" method="post">
			<fieldset>
				<p>
					<input name="ipMode" type="radio" value="dhcp" checked="checked" onClick="changeMode('dhcp');" />
					<label style="text-align:left;">自动获得IP地址</label><br>
					<input name="ipMode" type="radio" value="static" onClick="changeMode('static');" />
					<label style="text-align:left;">使用下面的IP地址</label>
				</p>
				<div class="networkBox pragram-box" style="display:none;">
				<p>
					<label>IP地址：</label>
					<input class="text-input small-input" type="text" name="ipaddr" />
					<label>子网掩码：</label>
					<input class="text-input small-input" type="text" name="netmask" />
					<label>默认网关：</label>
					<input class="text-input small-input" type="text" name="gateway" />
				</p>
				<p>
					<label>首选DNS服务器：</label>
					<input class="text-input small-input" type="text" name="dns1" />
				</p>
				</div>
				<p>
					<input class="button" type="button" value="应用" onClick="save();" />
				</p>
			</fieldset>
			</form>
</div>
</body>
</html>

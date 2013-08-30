<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>networkSetting</title>
</head>
  
<body class="main-body">
<div id="main-content">
<div class="content-box">
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
			<form name="myForm" action="settingAction.do?method=setNetwork" method="post">
			<fieldset>
				<p>
					<label>网卡：</label>
					<select name="networkType" class="small-input">
						<option value="in">in</option>
						<option value="out">out</option>
					</select>
				</p>
				<hr>
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
					<label>备用DNS服务器：</label>
					<input class="text-input small-input" type="text" name="dns2" />
				</p>
				</div>
				<p>
					<input class="button" type="button" value="应用" onClick="save();" />
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
	var ipMode = "dhcp";

	function changeMode(mode){
		ipMode = mode;
		$('.networkBox').slideToggle();
	}

	function save() {
		var flag = true;
		if (ipMode == "static"){
			$("input[type='text']").each(function(){
				if($(this).attr("name")!="dns1"&&$(this).attr("name")!="dns2"&&$(this).attr("name")!="gateway"&&$(this).val() == "") flag = false;
			});
		}
		if(!flag){
			alert("请检查参数是否添写完整！");
		}else{
			document.myForm.submit();
		}
	}
</script>
</html>
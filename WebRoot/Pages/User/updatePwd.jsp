<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body class="main-body">
<div class="pageContent">
	<form method="post" action="userAction.do?method=updateUser" >
		<div class="pageFormContent" layoutH="60">
			<p>
				<label>密码：</label>
				<input type="password" name="pwd" value="${userInfo.pswd}" onBlur="checkPwd();"/><label class="pwdMessage"></label>
			</p>
	        <p>
					<label>确认密码：</label>
					<input type="password" name="pwd2" value="${userInfo.pswd}" onBlur="checkPwd2();"/><label class="pwdMessage2"></label>
				</p>
			</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button onClick="update();" >修改</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
<div class="bgDiv">&nbsp;</div>
</body>
<script type="text/javascript">
	var updateFlag = true;
	
	function checkPwd(){
		var pwd = $("input[name='pwd']").val();
		if(pwd == ""){
			updateFlag = false;
			$(".pwdMessage").html("密码不能为空");
			$("input[name='pwd']").get(0).focus();
		}
	}
	
	function checkPwd2(){
		var pwd = $("input[name='pwd']").val();
		var pwd2 = $("input[name='pwd2']").val();
		if(pwd2 == ""){
			updateFlag = false;
			$(".pwdMessage2").html("确认密码不能为空");
			$("input[name='pwd2']").get(0).focus();
			return;
		}
		if(pwd != pwd2){
			updateFlag = false;
			$(".pwdMessage2").html("输入的密码不一致");
			$("input[name='pwd2']").get(0).focus();
		}else{
			$(".pwdMessage2").html("");
			updateFlag = true;
		}
	}
	
	function update(){
		if(updateFlag){
			document.myForm.submit();
		}
	}
</script>
</html>
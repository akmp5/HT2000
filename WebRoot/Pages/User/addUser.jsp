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
</head>
<body class="main-body">
<div class="pageContent">
	<form name="myForm" method="post" action="userAction.do?method=addUser" >
		<div class="pageFormContent" layoutH="60">
			<p>
				<label>用户名：</label>
					<input type="text" name="name" onBlur="checkName();" />
					<label class="nameMessage"></label>
			</p>
				<p>
					<label>密码：</label>
					<input type="password" name="pwd" onBlur="checkPwd();"/>
					<label class="pwdMessage"></label>
				</p>
				<p>
					<label>确认密码：</label>
					<input type="password" name="pwd2" onBlur="checkPwd2();"/>
					<label class="pwdMessage2"></label>
				</p>
				<p>
					<label>有效期：</label>
					<input type="text" name="validity" class="date" size="30" /><a class="inputDateButton" href="javascript:;">选择</a>
				</p>
				<p>
					<label>用户权限：</label>
					<select name="permission" >
						<option value="0">普通用户</option>
						<option value="1">操作员</option>
						<option value="2">管理员</option>
					</select>
				</p>
			</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button onClick="add();" >新增</button></div></div></li>
				<li>
					<div class="buttonActive"><div class="buttonContent"><button class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
<div class="bgDiv">&nbsp;</div>
</body>
<script type="text/javascript">
	var addFlag = true;
	
	function checkName(){
		var userName = $("input[name='name']").val();
		if(userName == ""){
			$(".nameMessage").html("用户名不能为空");
			$("input[name='names']").get(0).focus();
			return;
		}		
		$.post("userAction.do?method=checkName",{name:userName},function(data){
		//	console.log(data);
			if(data == "1"){
				addFlag = false;
				$(".nameMessage").html("该用户名已注册");
			}else{
				$(".nameMessage").html("该用户名可以使用");
				addFlag = true;
			}
		});
	}
	
	function checkPwd(){
		var pwd = $("input[name='pwd']").val();
		if(pwd == ""){
			addFlag = false;
			$(".pwdMessage").html("密码不能为空");
			$("input[name='pwd']").get(0).focus();
		}
	}
	
	function checkPwd2(){
		var pwd = $("input[name='pwd']").val();
		var pwd2 = $("input[name='pwd2']").val();
		if(pwd2 == ""){
			addFlag = false;
			$(".pwdMessage2").html("确认密码不能为空");
			$("input[name='pwd2']").get(0).focus();
			return;
		}
		if(pwd != pwd2){
			addFlag = false;
			$(".pwdMessage2").html("输入的密码不一致");
			$("input[name='pwd2']").get(0).focus();
		}else{
			$(".pwdMessage2").html("");
			addFlag = true;
		}
	}
	
	function add(){
		if(addFlag){
			document.myForm.submit();
		}
	}
</script>
</html>
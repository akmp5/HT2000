<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<title>管理员登陆</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
		<!--
		body {
			font-family: "微软雅黑";
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			background-color: #275274;
		}
		.login_top_bg {
			background-image: url(Public/Images/1.gif);
			background-repeat: repeat-x;
		}
		.login_bg {
			background-image: url(Public/Images/bg1.jpg);
			background-repeat: repeat-x;
		}
		.login-buttom-bg {
			background-image: url(Public/Images/2.gif);
		}
		.login-buttom-txt {
			font-size: 10px;
			color: #ABCAD3;
			text-decoration: none;
			line-height: 20px;
		}
		.login_txt {
			font-size: 14px;
			line-height: 25px;
			color: #333333;
		}
		.login_txt_title{
			font-weight: bold;
			font-size: 32px;
			line-height: 32px;
			color: #333333;
		}
		input{
			padding: 6px;
			font-size: 13px;
			background: #fff url('Public/Images/bg-form-field.gif') top left repeat-x;
			border: 1px solid #d5d5d5;
			color: #333;
			-moz-border-radius: 4px;
		    -webkit-border-radius: 4px;
			border-radius: 4px;
		}
		#verify, #luck{
			vertical-align: middle;
		}
		.submit {
			display: inline-block;
			background: #459300 url('Public/Images/bg-button-green.gif') top left repeat-x !important;
			border: 1px solid #459300 !important;
			padding: 4px 7px 4px 7px !important;
			color: #fff !important;
			font-size: 12px !important;
			cursor: pointer;
		}
		.notification {
			position: relative;
			margin: 15px 0 15px 0;
			padding: 0;
			border: 1px solid;
			background-position: 10px 11px !important;
			background-repeat: no-repeat !important;
			font-size: 13px;
			width: 100%;
			-moz-border-radius: 6px;
			-webkit-border-radius: 6px;
			border-radius: 6px;
		}
		.error {
			background: #ffcece url('Public/Images/icons/cross_circle.png') 10px 11px no-repeat;
			border-color: #df8f8f;
			color: #665252;
		}
		
		.notification div {
			display:block;
			font-style:normal;
			padding: 10px 10px 10px 36px;
			line-height: 1.5em;
		}
		-->
	</style>
	<script type="text/javascript">
		if(top.location != self.location) {
			top.location=self.location;
		}
	</script>
	</head>
	<body>
		<table width="100%" height="186" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td height="42" class="login_top_bg">&nbsp;</td>
		  </tr>
		  <tr>
		    <td align="center" valign="middle" height="532" class="login_bg">
		    <table width="280" border="0" cellpadding="0" cellspacing="0">
		      <tr>
		        <td height="38" align="left">
		        	<span class="login_txt_title">HT2000管理系统</span>
		        </td>
		      </tr>
		      <tr>
		      	<td height="15">
		      		<c:if test="${message != null}">
		        	<div class="notification error">
			            <div>${message}</div>
			        </div>
			        </c:if>
		      	</td>
		      </tr>
		      <tr>
		        <td>
		        	<form name="myform" action="userAction.do?method=login" method="post">
		              <table cellSpacing="0" cellPadding="0" width="100%" border="0" height="143">
		                <tr>
		                  <td width="80" height="38"><span class="login_txt">管理员：</span></td>
		                  <td width="200" align="left"><input name="name" value="" size="20"></td>
		                </tr>
		                <tr>
		                  <td height="35"><span class="login_txt"> 密 &nbsp;&nbsp;码： </span></td>
		                  <td height="35" align="left">
		                  	<input type="password" size="20" name="pwd">
		                  	<img id="luck" src="Public/Images/luck.gif" width="19" height="18">
		                  </td>
		                </tr>
		                <tr>
		                  <td height="35" >&nbsp;</td>
		                  <td width="80%" height="35" align="left">
		                  	<input type="submit" class="submit" value="登 陆">&nbsp;&nbsp;
		                  	<input type="reset" class="submit" value="重置">
		                  </td>
		                </tr>
		              </table>
		              <br>
		            </form>
		         </td>
		      </tr>
		    </table>
		    </td>
		  </tr>
		  <tr>
		    <td height="20"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="login-buttom-bg">
		      <tr>
		        <td align="center"><span class="login-buttom-txt"></span></td>
		      </tr>
		    </table></td>
		  </tr>
		</table>
	</body>
</html>

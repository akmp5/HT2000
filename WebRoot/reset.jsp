<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<title>重置root用户密码</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
		<!--
		body {
			font-family: "微软雅黑";
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			background-color: #1D3647;
		}
		.login_top_bg {
			background-image: url(Public/Images/login-top-bg.gif);
			background-repeat: repeat-x;
		}
		.login_bg {
			background-image: url(Public/Images/bg1.jpg);
			background-repeat: repeat-x;
		}
		.login-buttom-bg {
			background-image: url(Public/Images/login-buttom-bg.gif);
			background-repeat: repeat-x;
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
			font-size: 28px;
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
	</head>
	<body>
		<table width="100%" height="166" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td height="42" class="login_top_bg">&nbsp;</td>
		  </tr>
		  <tr>
		    <td align="center" valign="middle" height="532" class="login_bg">
		    <table width="280" border="0" cellpadding="0" cellspacing="0">
		      <tr>
		        <td height="38" align="left">
		        	<span class="login_txt_title">重置root用户密码</span>
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
		        	<form name="myform" action="userAction.do?method=reset" method="post">
		              <table cellSpacing="0" cellPadding="0" width="100%" border="0" height="143">
		              	<tr><td colspan="2" style="color:red; font-size:12px;">请将时间信息发送给技术支持人员获取验证码！</td></tr>
		              	<tr>
		                  <td height="35"><span class="login_txt"> 时&nbsp;&nbsp;间： </span></td>
		                  <td height="35" align="left" id="nowDate"></td>
		                </tr>
		                <tr>
		                  <td width="80" height="38"><span class="login_txt">验证码：</span></td>
		                  <td width="200" align="left"><input name="keyCode" value="" size="20"></td>
		                </tr>
		                <tr>
		                  <td height="35" >&nbsp;</td>
		                  <td width="80%" height="35" align="left">
		                  	<input type="submit" class="submit" value="修改">
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
	<script type="text/javascript">
		var DateUtil = {
			format: function(d, formatter){
			    if(!formatter || formatter == ""){
			        formatter = "yyyy-MM-dd";
			    }
					
				var weekdays = {
					chi: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
					eng: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
				};
			    var year = d.getFullYear().toString();
			    var month = (d.getMonth() + 1).toString();
			    var date = d.getDate().toString();
			    var day = d.getDay();
				var hour = d.getHours().toString();
				var minute = d.getMinutes().toString();
				var second = d.getSeconds().toString();
			
				var yearMarker = formatter.replace(/[^y|Y]/g,'');
				if(yearMarker.length == 2){
					year = year.substring(2,4);
				}else if(yearMarker.length == 0){
					year = "";
				}
			
				var monthMarker = formatter.replace(/[^M]/g,'');
				if(monthMarker.length > 1){
					if(month.length == 1){
						month = "0" + month;
					}
				}else if(monthMarker.length == 0){
					month = "";
				}
			
				var dateMarker = formatter.replace(/[^d]/g,'');
				if(dateMarker.length > 1){
					if(date.length == 1){
						date = "0" + date;
					}
				}else if(dateMarker.length == 0){
					date = "";
				}
			
				var hourMarker = formatter.replace(/[^h]/g, '');
				if(hourMarker.length > 1){
					if(hour.length == 1){
						hour = "0" + hour;
					}
				}else if(hourMarker.length == 0){
					hour = "";
				}
			
				var minuteMarker = formatter.replace(/[^m]/g, '');
				if(minuteMarker.length > 1){
					if(minute.length == 1){
						minute = "0" + minute;
					}
				}else if(minuteMarker.length == 0){
					minute = "";
				}
			
				var secondMarker = formatter.replace(/[^s]/g, '');
				if(secondMarker.length > 1){
					if(second.length == 1){
						second = "0" + second;
					}
				}else if(secondMarker.length == 0){
					second = "";
				}
			
			    var dayMarker = formatter.replace(/[^w]/g, '');
				var curr_week = "";
				if(dayMarker.length > 0) curr_week = weekdays["chi"][day];
			    var result = formatter.replace(yearMarker,year).replace(monthMarker,month).replace(dateMarker,date).replace(hourMarker,hour).replace(minuteMarker,minute).replace(secondMarker,second).replace(dayMarker,curr_week);
			    return result;
			}
		};
		
		var nowDate = DateUtil.format(new Date(),"yyyy-MM-dd hh:mm:ss");
		document.getElementById("nowDate").innerHTML = nowDate;
	</script>
</html>

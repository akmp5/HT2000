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
<style type="text/css">
.bgDiv{
	display: none;
	position: absolute;
	z-index: 1000;
	top:0px;
	left:0px;
	height: 200%;
	width: 100%;
	background: #333;
	opacity:0.5;
	filter:Alpha(opacity=50);
}
</style>
<script type="text/javascript">
	var flag = true;
	
		$(function(){
		check();
	});
	
	function checkInput(){
		if(!flag) return;
		var flag1 = false;
		$("input[type='checkbox']").each(function(){
			if($(this).get(0).checked == true) flag1 = true;
		});
		if(!flag1) {
			alert("至少选择一项输入源！");
			return;
		}
		var flag2 = true;
		$("input[type='text']").each(function(){
			//if($(this).val() == "") flag2 = false;
		});
		
		if(!flag2){
			alert("请检查参数是否添写完整！");
		}else{
			document.myForm.submit();
		}
	}
	
	function check(){
		$(".bgDiv").show();
		$.post("abrAction.do?method=checkAbr","",function(data){
			//console.log(data);
			var result = eval(data)[0];
			if(result.error == "1"){
				flag = false;
				alert("无可用于创建ABR播放列表的hls地址，请先创建hls转码任务!!!");
			}else{
				var serviceList = result.service;
				var serviceNameHtml = '<div class="pageContent"><span class="pragram-title">流信息</span>'+
					'<p><table class="table" width="100%" height="100%"><thead><tr><th>&nbsp;</th><th>转码任务名称</th><th>service_name</th><th>地址</th><th>码率(kbps)</th></tr></thead><tbody>';
				for(var i=0; i<serviceList.length; i++){
					serviceNameHtml += '<tr><td><input name="inputs" type="checkbox" value="'+serviceList[i].addr+'_'+serviceList[i].bandwidth+'" /></td>'+
						'<td>'+serviceList[i].desc+'</td><td>'+serviceList[i].service_name+'</td>'+
						'<td>'+serviceList[i].addr+'</td><td>'+serviceList[i].bandwidth+'</td>';
				}
				serviceNameHtml += '</tbody></table></p></div>';
				$(".source").html(serviceNameHtml);
			}
			$(".bgDiv").hide();
		});
	}
		
</script>
</head>
<body class="main-body">
<div id="main-content">
<div class="content-box">
	<div class="content-box-content">
		<div class="tab-content">
			<form name="myForm" action="abrAction.do?method=addAbr" method="post" >
			<fieldset>
			<p>
					<label>任务名称：</label>
					<input class="text-input small-input" type="text" name="name" onblur="onblurInput(this,'','任务名称不能够为空!',0);" />
				</p>
				<div id="inputBox" class="pragram-box">
					<span class="pragram-title">源参数</span>
				    <div class="source"><p style="text-align:center">正在加载...</p></div>
				</div>
				<div class="pragram-box">
					<span class="pragram-title">目标参数</span>
					<p>
						<label>输出地址：</label>
						<input class="text-input small-input" type="text" name="outputIp" onblur="onblurInput(this,'','输出地址不能够为空!',0);" />
					</p>
				</div>
				 <p id="boxButton">
					<input class="button" type="button" value="新增任务" onClick="checkInput();" />
				</p>
			</fieldset>
			</form>
			<div class="clear"></div>
		</div>
	</div>
</div>
</div>
<div class="bgDiv">&nbsp;</div>
</body>
</html>
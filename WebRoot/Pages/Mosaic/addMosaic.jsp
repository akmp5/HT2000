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
		$.post("mosaicAction.do?method=checkMosaic","",function(data){
			//console.log(data);
			var result = eval(data)[0];
			if(result.error == "1"){
				flag = false;
				alert("没有拼接源!!!");
			}else{
				var serviceList = result.service;
				var serviceNameHtml = '<div class="pageContent"><span class="pragram-title">流信息</span>'+
					'<p><table class="table"><thead><tr><th>&nbsp;</th><th>num</th><th>desc</th><th>service_name</th><th>resolution</th><th>地址</th><th>码率(kbps)</th></tr></thead><tbody>';
				for(var i=0; i<serviceList.length; i++){
					serviceNameHtml += '<tr><td><input name="inputs" type="checkbox" value="'+serviceList[i].addr+'_'+serviceList[i].index+'_'+serviceList[i].service_id+'_'+serviceList[i].service_name+'" /></td>'+
					'<td><input name="num" type="text" value="" /></td><td><input name="desc" type="text" value="" /></td><td>'+serviceList[i].service_name+'</td><td><input name="resolutions" type="text" value="'+serviceList[i].resolution+'" /></td>'+
						'<td>'+serviceList[i].addr+'</td><td>'+serviceList[i].bandwidth+'</td>';
				}
				serviceNameHtml += '</tbody></table></p></div>';
				$(".source").html(serviceNameHtml);
			}
		});
	}
		
</script>
</head>
<body class="main-body">
<div id="main-content">
<div class="content-box">
	<div class="content-box-content">
		<div class="tab-content">
			<form name="myForm" action="mosaicAction.do?method=addMosaic" method="post" >
			<fieldset>
			<p>
					<label>任务名称：</label>
					<input class="text-input small-input" type="text" name="name" onblur="onblurInput(this,'','任务名称不能够为空!',0);" />
				     <label>mode：</label>
					 <select name="mode" class="small-input"> 
					   <option value="2x2" selected>2x2</option> 
					   <option value="3x3">3x3</option> 
					   <option value="4x4">4x4</option> 
					 </select>
				</p>
				<div id="inputBox" class="pragram-box">
					<span class="pragram-title">源参数</span>
				    <div class="source"><p style="text-align:center">正在加载...</p></div>
				</div>
				<div class="pragram-box">
					<p>
						<label>输出地址：</label>
						<input class="text-input small-input" type="text" name="outputIp" onblur="onblurInput(this,'','输出地址不能够为空!',0);" />
						<label>outputmode：</label>
						 <select name="outputmode" class="small-input"> 
							   <option value="vbr" selected>vbr</option> 
							   <option value="cbr">cbr</option> 
							   <option value="abr">abr</option> 
						 </select>
						 <label>resolution：</label>
						 <select name="resolution" class="small-input"> 
							   <option value="1280x720" selected>1280x720</option> 
							   <option value="720x576">720x576</option> 
						 </select>
					 </p>
				    <p>
						 <label>比特率：</label>
						  <input class="text-input small-input" type="text" name="bitrate"  />

						<label>of：</label>
						<input class="text-input small-input" type="text" name="of"  />
				    </p>
					      <p style="display:none;">
											<label>切片时长：</label> <input class="text-input small-input" 
												type="text" value="10" name="hls_time" /> <label>切片个数：</label>
											<input  type="text" value="10" class="text-input small-input" 
												name="hls_list_size" />
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
</body>
</html>
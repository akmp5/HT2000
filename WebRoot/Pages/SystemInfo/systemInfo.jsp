<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main</title>
</head>

<body class="main-body">
<div id="main-content">
<div class="content-box">
	<div class="content-box-header">
	  <ul class="content-box-tabs">
	    <li><a href="#" class="current" onClick="showCPUInfoBox();">CPU总状态</a></li>
	  </ul>
	  <div class="clear"></div>
	</div>
	<div class="content-box-content">
	  	<div class="tab-content">
	  		<div id="cpuInfo" style="width:100%;height:300px;"></div>
			<div class="clear"></div>
		</div>
	</div>
</div>
<div class="content-box">
	<div class="content-box-header">
	  <ul class="content-box-tabs">
	    <li><a href="#" class="current" onClick="showNetioInfoBox();">网络状态</a></li>
	  </ul>
	  <ul class="content-box-button">
	  	<li><input type="button" value="切换显示数据" class="button" onClick="change();"></li>
	  </ul>
	  <div class="clear"></div>
	</div>
	<div class="content-box-content">
	  	<div class="tab-content">
	  		<div id="netioInfo" style="width:100%;height:300px;"></div>
			<div class="clear"></div>
		</div>
	</div>
</div>
</div>
</body>
<script type="text/javascript">
	showCPUInfo();
	showNetioInfo();

	var cpuInfoShowFlag = true;
	function showCPUInfoBox(){
		window.clearTimeout(showCPUInfoTimeoutFlag);
		if(!cpuInfoShowFlag){
			cpuInfoShowFlag = true;
			$("#cpuInfo").show();
			showCPUInfo();
		}else{
			cpuInfoShowFlag = false;
			$("#cpuInfo").hide();
		}
	}
	
	var netioInfoShowFlag = true;
	function showNetioInfoBox(){
		window.clearTimeout(showNetioTimeoutFlag);
		if(!netioInfoShowFlag){
			netioInfoShowFlag = true;
			$("#netioInfo").show();
			showNetioInfo();
		}else{
			netioInfoShowFlag = false;
			$("#netioInfo").hide();
		}
	}
	
	var options = {
        lines: { show: true },
        points: { show: false },
        xaxis: { tickDecimals: 0, tickSize: 1 }
    };
    
    var showCPUInfoTimeoutFlag = -1;
	function showCPUInfo(){
		$.post("systemAction.do?method=getCPUInfo","",function(data){
//			console.log(data);
			var allCPUInfoData = eval(data)[0].all;
			$.plot($("#cpuInfo"), allCPUInfoData, options);
		});
		showCPUInfoTimeoutFlag = window.setTimeout(function(){showCPUInfo();},10000);
	}
	var showNetioTimeoutFlag = -1;
	function showNetioInfo(){
		$.post("systemAction.do?method=getNetioInfo","",function(data){
//			console.log(data);
			var netioInfoData = new Array();
			if(num == 2){
				netioInfoData = eval(data);
			}else{
				netioInfoData.push(eval(data)[num]);
			}
			$.plot($("#netioInfo"), netioInfoData, options);
		});
		showNetioTimeoutFlag = window.setTimeout(function(){showNetioInfo();},10000);
	}
	
	var num = 2;
	function change(){
		if(num == 2){
			num=0;
		}else{
			num++;
		}
		window.clearTimeout(showNetioTimeoutFlag);
		showNetioInfo();
	}
</script>
</html>

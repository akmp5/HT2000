<%@ page language="java" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title></title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
  
<body class="main-body">
<div id="main-content">
<div class="content-box">
	<div class="content-box-header">
	  <ul class="content-box-tabs">
	    <li><a href="#" class="current">新增备份</a></li>
	  </ul>
	  <div class="clear"></div>
	</div>
	<div class="content-box-content">
		<div class="tab-content">
			<form name="myForm" action="./backupAction.do?method=addBackup" method="post">
				<p>
					<label>备份服务器地址：</label>
					<input class="text-input small-input" type="text" name="ipaddr" />
				</p>
				<p id="boxButton">
					<input class="button" type="button" value="提交" onClick="checkInput();" />
					<input class="button" type="button" value="+" onClick="addInput();" />
				</p>
			</form>
			<div class="clear"></div>
		</div>
	</div>
</div>
</div>
</body>
<script type="text/javascript">
	
	function checkInput(){
		var flag = true;
		$("input[name='ipaddr']").each(function(){
			if($(this).val() == "") flag = false;
		});
		if(flag) document.myForm.submit();
		else alert("请检查参数是否填写完整！");
	}

	function addInput(){
		var inputStr = '<p>'+
		'<label>备份服务器地址：</label>'+
		'<input class="text-input small-input" type="text" name="ipaddr" />'+
		'<input class="button delInput" type="button" value="X" />'+
		'</p>';
		$("#boxButton").before(inputStr);
		$(".delInput").click(function(){
			$(this).parent().remove();
		});
	}
</script>
</html>
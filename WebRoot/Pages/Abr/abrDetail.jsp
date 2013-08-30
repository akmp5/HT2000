<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = request.getParameter("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main</title>
<style type="text/css">
</style>
</head>
<body class="main-body">
<div id="pageContent" style="width:100%;overflow:auto;">
<div class="content-box">
			<form name="myForm" method="post">
						   <div class="source">
									 <p style="text-align:center">正在加载...</p>
				 </div>
			 <div class="formBar">
			<ul>
				<li>
					<div class="buttonActive"><div class="buttonContent"><button class="close">关闭</button></div></div>
				</li>
			</ul>
		</div>
	 </form>
				</div>
			</div>
</body>
<script type="text/javascript">

	$(function(){
	      var ids = <%=id%>;
          showAbrInfo(ids)
	});
	
	function showAbrInfo(__id){
		if(Boolean($(".abrInfo"+__id).get(0))){
			$(".abrInfo"+__id).toggle();
			return;
		}
		$.post("abrAction.do?method=getAbrInfoById",{id:__id},function(data){
			//console.log(data);
			var abrInfo = eval("("+data+")");
			var abrInfoHtml = '<tr class="abrInfo'+abrInfo.id+'"><td colspan="5"><fieldset>';
			var inputList = abrInfo.input;
			for(var i=0; i<inputList.length; i++){
				abrInfoHtml += '<p><label>输入地址：</label><input type="text" value="'+inputList[i].addr+'" disabled />'+
					'<label>码率(kbps)：</label><input type="text" value="'+inputList[i].bandwidth+'" disabled /></p>';
			}
			abrInfoHtml += '<p><label>输出地址：</label><input type="text" value="'+abrInfo.output+'" disabled /></p>';
			abrInfoHtml += '</fieldset></td></tr>';
			$(".source").html(abrInfoHtml)
		});
	}
</script>
</html>
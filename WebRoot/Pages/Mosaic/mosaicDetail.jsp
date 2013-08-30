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
          showMosaicInfo(ids);
	});
	
	function showMosaicInfo(__id){
		if(Boolean($(".mosaicInfo"+__id).get(0))){
			$(".mosaicInfo"+__id).toggle();
			return;
		}
		$.post("mosaicAction.do?method=getMosaicInfoById",{id:__id},function(data){
			//console.log(data);
			var mosaicInfo = eval("("+data+")");
			var mosaicInfoHtml = '<tr class="mosaicInfo'+mosaicInfo.id+'"><td colspan="5"><fieldset><div class="pragram-box"><span class="pragram-title">输入参数</span>';
			var inputList = mosaicInfo.input;
			for(var i=0; i<inputList.length; i++){
				mosaicInfoHtml += '<p><label>输入地址：</label><input type="text" value="'+inputList[i].addr+'" disabled />'
				     +'<label>码率(kbps)：</label><input type="text" value="'+inputList[i].bandwidth+'" disabled /></p>'
					+'<p><label>index：</label><input type="text" value="'+inputList[i].index+'" disabled />'
					 +'<label>resolution：</label><input type="text" value="'+inputList[i].resolution+'" disabled />'
					 +'<label>num：</label><input type="text" value="'+inputList[i].num+'" disabled /></p>'
					 +'<p><label>service_id：</label><input type="text" value="'+inputList[i].service_id+'" disabled />'
					 +'<label>service_name：</label><input type="text" value="'+inputList[i].service_name+'" disabled />'
					+'<label>备注：</label><input type="text" value="'+inputList[i].desc+'" disabled /></p>';
              if(i!= inputList.length-1) mosaicInfoHtml += '<hr style="border:1px dashed #ddd;">';
			}
			mosaicInfoHtml += '</div><div class="pragram-box"><span class="pragram-title">输出参数</span>';
			mosaicInfoHtml += '<p><label>输出地址：</label><input type="text" value="'+mosaicInfo.out+'" disabled /> ';
			mosaicInfoHtml += '<label>outputmode：</label><input type="text" value="'+mosaicInfo.outputmode+'" disabled /> ';
			mosaicInfoHtml += '<label>比特率：</label><input type="text" value="'+mosaicInfo.bitrate+'" disabled /></p>';
		    mosaicInfoHtml += '<p><label>of：</label><input type="text" value="'+mosaicInfo.of+'" disabled /></p>';
			mosaicInfoHtml += '<p style="display:none;"><label>切片时长：</label><input type="text" value="'+mosaicInfo.hls_time+'" disabled />';
		    mosaicInfoHtml += '<label>切片个数：</label><input type="text" value="'+mosaicInfo.hls_list_size+'" disabled /></p>';
			mosaicInfoHtml += '</div></fieldset></td></tr>';
			$(".source").html(mosaicInfoHtml)
		});
	}
</script>
</html>
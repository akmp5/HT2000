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
			<form name="myForm" method="post" action="mosaicAction.do?method=updateMosaic" >
						   <div class="source">
									 <p style="text-align:center">正在加载...</p>
				 </div>
			 <div class="formBar">
			<ul>
			    <li><div class="buttonActive"><div class="buttonContent"><button onClick="update();" >修改</button></div></div></li>
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
			mosaicInfoHtml +='<p><label>名称 ：</label><input type="hidden" value="'+mosaicInfo.id+'" name="id" /><input type="text" value="'+mosaicInfo.desc+'" name="name" /><label>mode ：</label><input type="text" value="'+mosaicInfo.mode+'" name="mode" /></p>';
			for(var i=0; i<inputList.length; i++){
				mosaicInfoHtml += '<p><label>输入地址：</label><input type="text" value="'+inputList[i].addr+'" name="inputAddr" />'
				     +'<label>码率(kbps)：</label><input type="text" value="'+inputList[i].bandwidth+'" name="bandwidth" /></p>'
					+'<p><label>index：</label><input type="text" value="'+inputList[i].index+'" name="index" />'
					 +'<label>resolution：</label><input type="text" value="'+inputList[i].resolution+'" name="resolutions" />'
					 +'<label>num：</label><input type="text" value="'+inputList[i].num+'" name="num" /></p>'
					 +'<p><label>service_id：</label><input type="text" value="'+inputList[i].service_id+'" name="service_id" />'
					 +'<label>service_name：</label><input type="text" value="'+inputList[i].service_name+'" name="service_name" />'
					+'<label>备注：</label><input type="text" value="'+inputList[i].desc+'" name="desc" /></p>';
              if(i!= inputList.length-1) mosaicInfoHtml += '<hr style="border:1px dashed #ddd;">';
			}
			mosaicInfoHtml += '</div><div class="pragram-box"><span class="pragram-title">输出参数</span>';
			mosaicInfoHtml += '<p><label>输出地址：</label><input type="text" value="'+mosaicInfo.out+'" name="outputIp" /> ';
			mosaicInfoHtml += '<label>outputmode：</label><input type="text" value="'+mosaicInfo.outputmode+'" name="outputmode" /> ';
			mosaicInfoHtml += '<label>比特率：</label><input type="text" value="'+mosaicInfo.bitrate+'" name="bitrate" /></p>';
		    mosaicInfoHtml += '<p><label>of：</label><input type="text" value="'+mosaicInfo.of+'" name="of"  /></p>';
			mosaicInfoHtml += '<p style="display:none;"><label>切片时长：</label><input type="text" value="'+mosaicInfo.hls_time+'" name="hls_time" />';
		    mosaicInfoHtml += '<label>切片个数：</label><input type="text" value="'+mosaicInfo.hls_list_size+'" name="hls_list_size"/></p>';
			mosaicInfoHtml += '</div></fieldset></td></tr>';
			$(".source").html(mosaicInfoHtml)
		});
	}
	
	function update(){
			document.myForm.submit();
	}
</script>
</html>
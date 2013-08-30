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
<div id="pageContent" style="width:100%;height:100%;overflow:auto;">
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
          showTaskInfo(ids)
	});
	
   function showTaskInfo(__id){
		if(Boolean($(".taskInfo"+__id).get(0))){
			$(".taskInfo"+__id).toggle();
			return;
		}
		$.post("taskAction.do?method=getTaskInfoById",{id:__id},function(data){
			var taskInfo = eval("("+data+")");
			var taskInfoHtml = '<tr class="taskInfo'+taskInfo.id+'"><td colspan="5"><fieldset>';
			var inputList = taskInfo.input;
			for(var i=0; i<inputList.length; i++){
				taskInfoHtml += '<p><label>输入方式：</label><input type="text" value="'+inputList[i].addr+'" width="60px" disabled /></p>';
			}
			var outputList = taskInfo.output;
			for(var j=0; j<outputList.length; j++){
				taskInfoHtml += 
				'<div class="pragram-box"><span class="pragram-title">源参数</span>'+
				'<p><label>service_name：</label><input class="text-input small-input" type="text" value="'+outputList[j].coding_service_name+'" disabled /></p>'+
				'<div class="pragram-box"><span class="pragram-title">流信息</span>';
			 	//var mosaic = outputList[j].mosaic;
				var streamList = outputList[j].stream;
				for(var k=0; k<streamList.length; k++){
					var stream = streamList[k];
					taskInfoHtml += '<p><label>pid：</label><input class="text-input small-input" type="text" value="'+stream.pid+'" disabled /></p>';
					if(stream.type == "v"){
						var method = "硬转";
						taskInfoHtml += '<p>'+
						'<label>转码预设：</label><input class="text-input small-input" type="text" value="'+stream.preset+'" disabled />'+
						'<label>视频编码方式：</label><input class="text-input small-input" type="text" value="'+stream.vcodec+'" disabled />'+
						'<label>编码等级：</label><input class="text-input small-input" type="text" value="'+stream.level+'" disabled />'+
						'</p><p>'+
						'<label>规格：</label><input class="text-input small-input" type="text" value="'+stream.vprofile+'" disabled />'+
						'<label>分辨率：</label><input class="text-input small-input" type="text" value="'+stream.resolution+'" disabled />'+
						'<label>帧率(fps)：</label><input class="text-input small-input" type="text" value="'+stream.fps+'" disabled />'+
						'<label>参考帧：</label><input class="text-input small-input" type="text" value="'+stream.refnum+'" disabled />'+
						'</p><p>'+
						'<label>转码方式：</label><input class="text-input small-input" type="text" value="'+method+'" disabled />'+
						'<label>GOP大小：</label><input class="text-input small-input" type="text" value="'+stream.gop+'" disabled />'+
						'<label>B帧间距：</label><input class="text-input small-input" type="text" value="'+stream.bframe+'" disabled />'+
						'<label>宽高比：</label><input class="text-input small-input" type="text" value="'+stream.aspect+'" disabled />';
						if(Boolean(stream.overlay)&&stream.overlay!="0"){
							var overlay = "";
							if (stream.overlay == "1"){
								overlay = "左上角对齐";
							}else if(stream.overlay == "2"){
								overlay = "右上角对齐";
							}else if(stream.overlay == "3"){
								overlay = "左下角对齐";
							}else if(stream.overlay == "4"){
								overlay = "右下角对齐";
							}
							taskInfoHtml += '<label>对齐方式：</label><input class="text-input small-input" type="text" value="'+overlay+'" disabled />'+
							'<label>横向偏移量：</label><input class="text-input small-input" type="text" value="'+stream.x+'" disabled />'+
							'<label>纵向偏移量：</label><input class="text-input small-input" type="text" value="'+stream.y+'" disabled />'+
							'<label>马赛克宽度：</label><input class="text-input small-input" type="text" value="'+stream.w+'" disabled />'+
							 '</p><p>'+
							'<label>马赛克高度：</label><input class="text-input small-input" type="text" value="'+stream.h+'" disabled />';
						}
						if(Boolean(stream.delogo)&&stream.delogo!="0"){
							taskInfoHtml += '<label>图片：</label><input class="text-input small-input" type="text" value="'+stream.pic+'" disabled />'+
							'<label>d横向偏移量：</label><input class="text-input small-input" type="text" value="'+stream.dx+'" disabled />'+
							'<label>d纵向偏移量：</label><input class="text-input small-input" type="text" value="'+stream.dy+'" disabled />'+
							'<label>d马赛克宽度：</label><input class="text-input small-input" type="text" value="'+stream.dw+'" disabled />'+
							'<label>d马赛克高度：</label><input class="text-input small-input" type="text" value="'+stream.dh+'" disabled />';
						}
//						if(Boolean(mosaic.onlymosaic)&&mosaic.onlymosaic!="0"){
//						var onlymosaic = "";
//							if (mosaic.onlymosaic == "0"){
//								onlymosaic = "同时转码";
//							}else if(mosaic.onlymosaic == "1"){
//								onlymosaic = "仅做视频拼接";
//							}
//							taskInfoHtml += '<label>onlymosaic：</label><input class="text-input small-input" type="text" value="'+onlymosaic+'" disabled />'+
//							'<label>resolution：</label><input class="text-input small-input" type="text" value="'+mosaic.resolution+'" disabled />'+
//							'<label>mode：</label><input class="text-input small-input" type="text" value="'+mosaic.mode+'" disabled />';
//						}
						
					  if(Boolean(outputList[j].onlymosaic)&&outputList[j].onlymosaic!="0"){
						var onlymosaic = "";
							if (outputList[j].onlymosaic == "0"){
								onlymosaic = "同时转码";
							}else if(outputList[j].onlymosaic == "1"){
								onlymosaic = "仅做视频拼接";
							}
							taskInfoHtml += '<label>onlymosaic：</label><input class="text-input small-input" type="text" value="'+onlymosaic+'" disabled />'+
							'<label>resolution：</label><input class="text-input small-input" type="text" value="'+outputList[j].resolution+'" disabled />'+
							'<label>mode：</label><input class="text-input small-input" type="text" value="'+outputList[j].modes+'" disabled />';
						}
						taskInfoHtml += '</p>';
					}else{
						taskInfoHtml += '<p>'+
						'<label>音频编码方式：</label><input class="text-input small-input" type="text" value="'+stream.acodec+'" disabled />'+
						'<label>采样率(HZ)：</label><input class="text-input small-input" type="text" value="'+stream.ar+'" disabled />'+
						'<label>声道：</label><input class="text-input small-input" type="text" value="'+stream.ac+'" disabled />'+
						'<label>音量：</label><input class="text-input small-input" type="text" value="'+stream.volume+'" disabled />'+
						'</p><p>'+
						'<label>码率(kbps)：</label><input class="text-input small-input" type="text" value="'+stream.bitrate+'" disabled />'+
						'</p>';
					}
					if(k != streamList.length-1) taskInfoHtml += '<hr style="border:1px dashed #ddd;">';
				}
				taskInfoHtml += '</div></div>';
				taskInfoHtml += '<div class="pragram-box"><span class="pragram-title">目标参数</span>'+
					'<p><label>码率(kbps)：</label><input class="text-input small-input" type="text" value="'+outputList[j].bitrate+'" disabled />'+
					'<label>码率控制方式：</label><input class="text-input small-input" type="text" value="'+outputList[j].mode+'" disabled />'+
					'<label>输出封装格式：</label><input class="text-input small-input" type="text" value="'+outputList[j].of+'" disabled />'+
					'<label>network_id：</label><input class="text-input small-input" type="text" value="'+outputList[j].network_id+'" disabled />'+
					'</p><p>'+
					'<label>stream_id：</label><input class="text-input small-input" type="text" value="'+outputList[j].stream_id+'" disabled />'+
					'<label>service_id：</label><input class="text-input small-input" type="text" value="'+outputList[j].service_id+'" disabled />'+
					'<label>service_provider：</label><input class="text-input small-input" type="text" value="'+outputList[j].service_provider+'" disabled />'+
			     	'<label>pmt_start_pid：</label><input class="text-input small-input" type="text" value="'+outputList[j].pmt_start_pid+'" disabled />'+
					'</p><p>'+
					'<label>start_pid：</label><input class="text-input small-input" type="text" value="'+outputList[j].start_pid+'" disabled />'+
					 '<label>service_name：</label><input class="text-input small-input" type="text" value="'+outputList[j].service_name+'" disabled />'+
		       		'<label>输出方式：</label><input type="text" value="'+outputList[j].out+'" width ="60px" disabled />'+
					'</p></div>';
			}
			taskInfoHtml += '</fieldset></td></tr>';
			$(".source").html(taskInfoHtml);
		});
	}
</script>
</html>
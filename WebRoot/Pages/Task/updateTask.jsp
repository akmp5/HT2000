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
			<form name="myForm" method="post" action="taskAction.do?method=updateTask" >
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
          showTaskInfo(ids)
	});
	
   function showTaskInfo(__id){
		if(Boolean($(".taskInfo"+__id).get(0))){
			$(".taskInfo"+__id).toggle();
			return;
		}
		$.post("taskAction.do?method=getTaskInfoById",{id:__id},function(data){
			var taskInfo = eval("("+data+")");
			var taskInfoHtml = '<tr><td colspan="5"><fieldset>';
			var inputList = taskInfo.input;
			for(var i=0; i<inputList.length; i++){
				taskInfoHtml += '<p><label>输入方式：</label><input type="text" value="'+inputList[i].addr+'" name="addr" width="60px" disabled /><input type="hidden" value="'+inputList[i].addr+'" name="addr"/><input type="hidden" value="'+taskInfo.id+'" name="id"/><input type="hidden" value="'+taskInfo.desc+'" name="name"/></p>';
			}
			var outputList = taskInfo.output;
			for(var j=0; j<outputList.length; j++){
				taskInfoHtml += 
				'<div class="pragram-box"><span class="pragram-title">源参数</span>'+
				'<p><label>service_name：</label><input class="text-input small-input" type="text" value="'+outputList[j].coding_service_name+'" name="src_service_name" disabled /><input type="hidden" value="'+outputList[j].coding_service_name+'" name="src_service_name"/></p>'+
				'<div class="pragram-box"><span class="pragram-title">流信息</span>';
				var streamList = outputList[j].stream;
				for(var k=0; k<streamList.length; k++){
					var stream = streamList[k];
					taskInfoHtml += '<p><label>pid：</label><input class="text-input small-input" type="text" value="'+stream.pid+'" disabled /><input type="hidden" value="'+stream.pid+'-'+stream.type+'" name="streamId'+j+'"/></p>';
					if(stream.type == "v"){
						var method = "硬转";
						var preset =stream.preset;
						if(preset=="veryslow"){
						 taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
								+ '<option value="ultrafast">ultrafast</option>'
								+ '<option value="superfast">superfast</option>'
								+ '<option value="veryfast">veryfast</option>'
								+ '<option value="faster">faster</option>'
								+ '<option value="fast">fast</option>'
								+ '<option value="medium">medium</option>'
								+ '<option value="slow">slow</option>'
								+ '<option value="slower">slower</option>'
								+ '<option value="veryslow" selected>veryslow</option>'
								+ '<option value="placebo">placebo</option>'
								+ '</select>';
						}else if(preset=="ultrafast"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast" selected>ultrafast</option>'
									+ '<option value="superfast">superfast</option>'
									+ '<option value="veryfast">veryfast</option>'
									+ '<option value="faster">faster</option>'
									+ '<option value="fast">fast</option>'
									+ '<option value="medium">medium</option>'
									+ '<option value="slow">slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow">veryslow</option>'
									+ '<option value="placebo">placebo</option>'
									+ '</select>';
						 }else if(preset=="superfast"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast">ultrafast</option>'
									+ '<option value="superfast" selected>superfast</option>'
									+ '<option value="veryfast">veryfast</option>'
									+ '<option value="faster">faster</option>'
									+ '<option value="fast">fast</option>'
									+ '<option value="medium">medium</option>'
									+ '<option value="slow">slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow">veryslow</option>'
									+ '<option value="placebo">placebo</option>'
									+ '</select>';
					     }else if(preset=="veryfast"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast">ultrafast</option>'
									+ '<option value="superfast">superfast</option>'
									+ '<option value="veryfast" selected>veryfast</option>'
									+ '<option value="faster">faster</option>'
									+ '<option value="fast">fast</option>'
									+ '<option value="medium">medium</option>'
									+ '<option value="slow">slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow">veryslow</option>'
									+ '<option value="placebo">placebo</option>'
									+ '</select>';
						  }else if(preset=="faster"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast">ultrafast</option>'
									+ '<option value="superfast">superfast</option>'
									+ '<option value="veryfast">veryfast</option>'
									+ '<option value="faster" selected>faster</option>'
									+ '<option value="fast">fast</option>'
									+ '<option value="medium">medium</option>'
									+ '<option value="slow">slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow">veryslow</option>'
									+ '<option value="placebo">placebo</option>'
									+ '</select>';
						 }else if(preset=="fast"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast">ultrafast</option>'
									+ '<option value="superfast">superfast</option>'
									+ '<option value="veryfast">veryfast</option>'
									+ '<option value="faster">faster</option>'
									+ '<option value="fast" selected>fast</option>'
									+ '<option value="medium">medium</option>'
									+ '<option value="slow">slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow">veryslow</option>'
									+ '<option value="placebo">placebo</option>'
									+ '</select>';
						 }else if(preset=="medium"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast">ultrafast</option>'
									+ '<option value="superfast">superfast</option>'
									+ '<option value="veryfast">veryfast</option>'
									+ '<option value="faster">faster</option>'
									+ '<option value="fast">fast</option>'
									+ '<option value="medium" selected>medium</option>'
									+ '<option value="slow">slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow">veryslow</option>'
									+ '<option value="placebo">placebo</option>'
									+ '</select>';
						 }else if(preset=="slow"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast">ultrafast</option>'
									+ '<option value="superfast">superfast</option>'
									+ '<option value="veryfast">veryfast</option>'
									+ '<option value="faster">faster</option>'
									+ '<option value="fast">fast</option>'
									+ '<option value="medium">medium</option>'
									+ '<option value="slow" selected>slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow">veryslow</option>'
									+ '<option value="placebo">placebo</option>'
									+ '</select>';
						 }else if(preset=="slower"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast">ultrafast</option>'
									+ '<option value="superfast">superfast</option>'
									+ '<option value="veryfast">veryfast</option>'
									+ '<option value="faster">faster</option>'
									+ '<option value="fast">fast</option>'
									+ '<option value="medium">medium</option>'
									+ '<option value="slow">slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow" selected>veryslow</option>'
									+ '<option value="placebo">placebo</option>'
									+ '</select>';
						 }else if(preset=="placebo"){
							taskInfoHtml += '<p><label>转码预设：</label><select name="'+j+stream.pid+'preset" class="small-input">'
									+ '<option value="ultrafast">ultrafast</option>'
									+ '<option value="superfast">superfast</option>'
									+ '<option value="veryfast">veryfast</option>'
									+ '<option value="faster">faster</option>'
									+ '<option value="fast">fast</option>'
									+ '<option value="medium">medium</option>'
									+ '<option value="slow">slow</option>'
									+ '<option value="slower">slower</option>'
									+ '<option value="veryslow">veryslow</option>'
									+ '<option value="placebo" selected>placebo</option>'
									+ '</select>';
						}
			      	
		       taskInfoHtml += '<label>视频编码方式：</label><input class="text-input small-input" type="text" value="'+stream.vcodec+'" name="'+j+stream.pid+'vcodec" disabled /><input type="hidden" value="'+stream.vcodec+'" name="'+j+stream.pid+'vcodec"/>'+
								'<label>编码等级：</label><input class="text-input small-input" type="text" value="'+stream.level+'" name="'+j+stream.pid+'level" />'+
								'</p><p>';
					var vprofile = stream.vprofile;
					if(vprofile=="main"){
						taskInfoHtml +='<label>规格：</label>'
							+ '<select name="'+j+stream.pid+'vprofile" class="small-input">'
							+ '<option value="main" selected>main</option>'
							+ '<option value="high">high</option>'
							+ '<option value="baseline">baseline</option>'
							+ '</select>';
					}else if(vprofile=="high"){
							taskInfoHtml +='<label>规格：</label>'
							+ '<select name="'+j+stream.pid+'vprofile" class="small-input">'
							+ '<option value="main">main</option>'
							+ '<option value="high" selected>high</option>'
							+ '<option value="baseline">baseline</option>'
							+ '</select>';
					 }else if(vprofile=="baseline"){
							taskInfoHtml +='<label>规格：</label>'
							+ '<select name="'+j+stream.pid+'vprofile" class="small-input">'
							+ '<option value="main">main</option>'
							+ '<option value="high">high</option>'
							+ '<option value="baseline" selected>baseline</option>'
							+ '</select>';
					}
					var resolution = stream.resolution;
					if(resolution =="176x144"){
							taskInfoHtml +='<label>分辨率：</label>'
							+ '<select name="'+j+stream.pid+'resolution" class="small-input">'
							+ '<option value="176x144" selected>176x144</option>'
							+ '<option value="352x288">352x288</option>'
							+ '<option value="640x360">640x360</option>'
							+ '<option value="720x576">720x576</option>'
							+ '<option value="1280x720">1280x720</option>'
							+ '<option value="1920x1080">1920x1080</option>'
							+ '</select>';
					}else if(resolution =="352x288"){
					   taskInfoHtml +='<label>分辨率：</label>'
							+ '<select name="'+j+stream.pid+'resolution" class="small-input">'
							+ '<option value="176x144">176x144</option>'
							+ '<option value="352x288" selected>352x288</option>'
							+ '<option value="640x360">640x360</option>'
							+ '<option value="720x576">720x576</option>'
							+ '<option value="1280x720">1280x720</option>'
							+ '<option value="1920x1080">1920x1080</option>'
							+ '</select>';
				  }else if(resolution =="640x360"){
					   taskInfoHtml +='<label>分辨率：</label>'
							+ '<select name="'+j+stream.pid+'resolution" class="small-input">'
							+ '<option value="176x144">176x144</option>'
							+ '<option value="352x288">352x288</option>'
							+ '<option value="640x360" selected>640x360</option>'
							+ '<option value="720x576">720x576</option>'
							+ '<option value="1280x720">1280x720</option>'
							+ '<option value="1920x1080">1920x1080</option>'
							+ '</select>';
				    }else if(resolution =="720x576"){
					   taskInfoHtml +='<label>分辨率：</label>'
							+ '<select name="'+j+stream.pid+'resolution" class="small-input">'
							+ '<option value="176x144">176x144</option>'
							+ '<option value="352x288">352x288</option>'
							+ '<option value="640x360">640x360</option>'
							+ '<option value="720x576" selected>720x576</option>'
							+ '<option value="1280x720">1280x720</option>'
							+ '<option value="1920x1080">1920x1080</option>'
							+ '</select>';
					 }else if(resolution =="1280x720"){
					   taskInfoHtml +='<label>分辨率：</label>'
							+ '<select name="'+j+stream.pid+'resolution" class="small-input">'
							+ '<option value="176x144">176x144</option>'
							+ '<option value="352x288">352x288</option>'
							+ '<option value="640x360">640x360</option>'
							+ '<option value="720x576">720x576</option>'
							+ '<option value="1280x720" selected>1280x720</option>'
							+ '<option value="1920x1080">1920x1080</option>'
							+ '</select>';
					 }else if(resolution =="1920x108"){
					   taskInfoHtml +='<label>分辨率：</label>'
							+ '<select name="'+j+stream.pid+'resolution" class="small-input">'
							+ '<option value="176x144">176x144</option>'
							+ '<option value="352x288">352x288</option>'
							+ '<option value="640x360">640x360</option>'
							+ '<option value="720x576">720x576</option>'
							+ '<option value="1280x720">1280x720</option>'
							+ '<option value="1920x1080" selected>1920x1080</option>'
							+ '</select>';
					}
						 taskInfoHtml +='<label>帧率(fps)：</label><input class="text-input small-input" type="text" value="'+stream.fps+'" name="'+j+stream.pid+'fps" />'+
						'<label>参考帧：</label><input class="text-input small-input" type="text" value="'+stream.refnum+'" name="'+j+stream.pid+'refnum" />'+
						'</p><p>'+
						'<label>转码方式：</label><input class="text-input small-input" type="text" value="'+method+'" name="'+j+stream.pid+'method" disabled /><input type="hidden" value="hw" name="'+j+stream.pid+'method"/>'+
						'<label>GOP大小：</label><input class="text-input small-input" type="text" value="'+stream.gop+'" name="'+j+stream.pid+'gop" />'+
						'<label>B帧间距：</label><input class="text-input small-input" type="text" value="'+stream.bframe+'" name="'+j+stream.pid+'bframe"  />';
						var aspect = stream.aspect;
					if(aspect =="auto"){
							taskInfoHtml +='<label>宽高比：</label>'
										+ '<select name="'+j+stream.pid+'aspect" class="small-input">'
										+ '<option value="auto" selected>auto</option>'
										+ '<option value="1:1">1:1</option>'
										+ '<option value="4:3">4:3</option>'
										+ '<option value="16:9">16:9</option>'
										+ '</select>';
					}else if(aspect =="1:1"){
					   taskInfoHtml +='<label>宽高比：</label>'
										+ '<select name="'+j+stream.pid+'aspect" class="small-input">'
										+ '<option value="auto">auto</option>'
										+ '<option value="1:1" selected>1:1</option>'
										+ '<option value="4:3">4:3</option>'
										+ '<option value="16:9">16:9</option>'
										+ '</select>';
					} else if(aspect =="4:3"){
					   taskInfoHtml +='<label>宽高比：</label>'
										+ '<select name="'+j+stream.pid+'aspect" class="small-input">'
										+ '<option value="auto">auto</option>'
										+ '<option value="1:1">1:1</option>'
										+ '<option value="4:3" selected>4:3</option>'
										+ '<option value="16:9">16:9</option>'
										+ '</select>';
					  }else if(aspect =="16:9"){
					   taskInfoHtml +='<label>宽高比：</label>'
										+ '<select name="'+j+stream.pid+'aspect" class="small-input">'
										+ '<option value="auto">auto</option>'
										+ '<option value="1:1">1:1</option>'
										+ '<option value="4:3">4:3</option>'
										+ '<option value="16:9" selected>16:9</option>'
										+ '</select>';
					   }
						if(Boolean(stream.overlay)&&stream.overlay!="0"){
							if (stream.overlay == "1"){
							taskInfoHtml += '<label>对齐方式：</label>'
											+ '<select name="'+j+stream.pid+'overlay" class="small-input">'
											+ '<option value="0">不设置</option>'
											+ '<option value="1" selected>左上角对齐</option>'
											+ '<option value="2">右上角对齐</option>'
											+ '<option value="3">左下角对齐</option>'
											+ '<option value="4">右下角对齐</option>'
											+ '</select>';
							}else if(stream.overlay == "2"){
                              taskInfoHtml += '<label>对齐方式：</label>'
											+ '<select name="'+j+stream.pid+'overlay" class="small-input">'
											+ '<option value="0">不设置</option>'
											+ '<option value="1">左上角对齐</option>'
											+ '<option value="2" selected>右上角对齐</option>'
											+ '<option value="3">左下角对齐</option>'
											+ '<option value="4">右下角对齐</option>'
											+ '</select>';		
							}else if(stream.overlay == "3"){
								 taskInfoHtml += '<label>对齐方式：</label>'
											+ '<select name="'+j+stream.pid+'overlay" class="small-input">'
											+ '<option value="0">不设置</option>'
											+ '<option value="1">左上角对齐</option>'
											+ '<option value="2">右上角对齐</option>'
											+ '<option value="3" selected>左下角对齐</option>'
											+ '<option value="4">右下角对齐</option>'
											+ '</select>';	
							}else if(stream.overlay == "4"){
								taskInfoHtml += '<label>对齐方式：</label>'
											+ '<select name="'+j+stream.pid+'overlay" class="small-input">'
											+ '<option value="0">不设置</option>'
											+ '<option value="1">左上角对齐</option>'
											+ '<option value="2">右上角对齐</option>'
											+ '<option value="3">左下角对齐</option>'
											+ '<option value="4" selected>右下角对齐</option>'
											+ '</select>';	
							 }else if(stream.overlay == "0"){
								taskInfoHtml += '<label>对齐方式：</label>'
											+ '<select name="'+j+stream.pid+'overlay" class="small-input">'
											+ '<option value="0" selected>不设置</option>'
											+ '<option value="1">左上角对齐</option>'
											+ '<option value="2">右上角对齐</option>'
											+ '<option value="3">左下角对齐</option>'
											+ '<option value="4">右下角对齐</option>'
											+ '</select>';	
							}
							taskInfoHtml += '<label>横向偏移量：</label><input class="text-input small-input" type="text" value="'+stream.x+'" name="'+j+stream.pid+'x" />'+
							'<label>纵向偏移量：</label><input class="text-input small-input" type="text" value="'+stream.y+'" name="'+j+stream.pid+'y" />'+
							'<label>马赛克宽度：</label><input class="text-input small-input" type="text" value="'+stream.w+'" name="'+j+stream.pid+'w" />'+
							 '</p><p>'+
							'<label>马赛克高度：</label><input class="text-input small-input" type="text" value="'+stream.h+'" name="'+j+stream.pid+'h" />';
						}
						if(Boolean(stream.delogo)&&stream.delogo!="0"){
							taskInfoHtml += '<label>图片：</label><input class="text-input small-input" type="text" value="'+stream.pic+'" name="'+j+stream.pid+'pic" />'+
							'<label>d横向偏移量：</label><input class="text-input small-input" type="text" value="'+stream.dx+'" name="'+j+stream.pid+'dx" />'+
							'<label>d纵向偏移量：</label><input class="text-input small-input" type="text" value="'+stream.dy+'" name="'+j+stream.pid+'dy" />'+
							'<label>d马赛克宽度：</label><input class="text-input small-input" type="text" value="'+stream.dw+'" name="'+j+stream.pid+'dw" />'+
							'<label>d马赛克高度：</label><input class="text-input small-input" type="text" value="'+stream.dh+'" name="'+j+stream.pid+'dh" />';
						}
						if(Boolean(outputList[j].onlymosaic)&&outputList[j].onlymosaic!="0"){
							if (outputList[j].onlymosaic == "0"){
								taskInfoHtml += '<label>onlymosaic：</label>'
								+ '<select name="'+j+stream.pid+'onlymosaic" class="small-input">'
								+ '<option value="0" selected>同时转码</option>'
								+ '<option value="1">仅做视频拼接</option>'
								+ '</select>';
							}else if(outputList[j].onlymosaic == "1"){
								taskInfoHtml += '<label>onlymosaic：</label>'
								+ '<select name="'+j+stream.pid+'onlymosaic" class="small-input">'
								+ '<option value="0">同时转码</option>'
								+ '<option value="1" selected>仅做视频拼接</option>'
								+ '</select>';
							}
							
							if (outputList[j].resolution == "360x240"){
								taskInfoHtml += '<label>resolution：</label>'
											+ '<select name="'+j+stream.pid+'resolutions1" class="small-input">'
											+ '<option value="360x240" selected>360x240</option>'
											+ '<option value="360x288">360x288</option>'
											+ '<option value="352x288">352x288</option>'
											+ '</select>';
							}else if(outputList[j].resolution == "360x288"){
								taskInfoHtml += '<label>resolution：</label>'
											+ '<select name="'+j+stream.pid+'resolutions1" class="small-input">'
											+ '<option value="360x240">360x240</option>'
											+ '<option value="360x288" selected>360x288</option>'
											+ '<option value="352x288">352x288</option>'
											+ '</select>';
							 }else if(outputList[j].resolution == "352x288"){
								taskInfoHtml += '<label>resolution：</label>'
											+ '<select name="'+j+stream.pid+'resolutions1" class="small-input">'
											+ '<option value="360x240">360x240</option>'
											+ '<option value="360x288">360x288</option>'
											+ '<option value="352x288" selected>352x288</option>'
											+ '</select>';
							}
							
							if (outputList[j].modes == "2x2"){
								taskInfoHtml += '<label>mode：</label>'
											+ '<select name="'+j+stream.pid+'modes" class="small-input">'
											+ '<option value="2x2" selected>2x2</option>'
											+ '<option value="3x3">3x3</option>'
											+ '<option value="4x4">4x4</option>'
											+ '</select>';
							}else if(outputList[j].modes == "3x3"){
							taskInfoHtml += '<label>mode：</label>'
											+ '<select name="'+j+stream.pid+'modes" class="small-input">'
											+ '<option value="2x2">2x2</option>'
											+ '<option value="3x3" selected>3x3</option>'
											+ '<option value="4x4">4x4</option>'
											+ '</select>';
						    }else if(outputList[j].modes == "4x4"){
							taskInfoHtml += '<label>mode：</label>'
											+ '<select name="'+j+stream.pid+'modes" class="small-input">'
											+ '<option value="2x2">2x2</option>'
											+ '<option value="3x3">3x3</option>'
											+ '<option value="4x4" selected>4x4</option>'
											+ '</select>';
							}				
						}
						taskInfoHtml += '</p>';
					}else{
						taskInfoHtml += '<p>'+'<label>音频编码方式：</label><input class="text-input small-input" type="text" value="'+stream.acodec+'" name="'+j+stream.pid+'acodec" disabled /><input type="hidden" value="'+stream.acodec+'" name="'+j+stream.pid+'acodec"/>';
						if (stream.ar == "44100"){
								taskInfoHtml += '<label>采样率(HZ)：</label>'
									+ '<select name="'+j+stream.pid+'ar" class="small-input">'
									+ '<option value="22050">22050</option>'
									+ '<option value="44100" selected>44100</option>'
									+ '<option value="96000">96000</option>'
									+ '</select>';
						}else if(stream.ar == "22050"){
						  taskInfoHtml += '<label>采样率(HZ)：</label>'
									+ '<select name="'+j+stream.pid+'ar" class="small-input">'
									+ '<option value="22050" selected>22050</option>'
									+ '<option value="44100">44100</option>'
									+ '<option value="96000">96000</option>'
									+ '</select>';
					    }else if(stream.ar == "96000"){
						  taskInfoHtml += '<label>采样率(HZ)：</label>'
									+ '<select name="'+j+stream.pid+'ar" class="small-input">'
									+ '<option value="22050">22050</option>'
									+ '<option value="44100">44100</option>'
									+ '<option value="96000" selected>96000</option>'
									+ '</select>';
						}		
						
					   if (stream.ac== "1"){
								taskInfoHtml += '<label>声道：</label>'
									+ '<select name="'+j+stream.pid+'ac" class="small-input">'
									+ '<option value="1" selected>单声道</option>'
									+ '<option value="2">立体声</option>'
									+ '</select>';
						}else if(stream.ac == "2"){
						  	taskInfoHtml += '<label>声道：</label>'
									+ '<select name="'+j+stream.pid+'ac" class="small-input">'
									+ '<option value="1">单声道</option>'
									+ '<option value="2" selected>立体声</option>'
									+ '</select>';
						 }		
						 if (stream.bitrate== "48"){
								taskInfoHtml += '<label>码率(kbps)：</label>'
									+ '<select name="'+j+stream.pid+'bitrate" class="small-input">'
									+ '<option value="48" selected>48</option>'
									+ '<option value="96">96</option>'
									+ '<option value="128">128</option>'
									+ '<option value="192">192</option>'
									+ '</select>';
					    }else if(stream.bitrate== "96"){
							    taskInfoHtml += '<label>码率(kbps)：</label>'
											+ '<select name="'+j+stream.pid+'bitrate" class="small-input">'
											+ '<option value="48">48</option>'
											+ '<option value="96" selected>96</option>'
											+ '<option value="128">128</option>'
											+ '<option value="192">192</option>'
											+ '</select>';
						 }else if(stream.bitrate== "128"){
							    taskInfoHtml += '<label>码率(kbps)：</label>'
											+ '<select name="'+j+stream.pid+'bitrate" class="small-input">'
											+ '<option value="48">48</option>'
											+ '<option value="96">96</option>'
											+ '<option value="128" selected>128</option>'
											+ '<option value="192">192</option>'
											+ '</select>';
						}else if(stream.bitrate== "192"){
							    taskInfoHtml += '<label>码率(kbps)：</label>'
											+ '<select name="'+j+stream.pid+'bitrate" class="small-input">'
											+ '<option value="48">48</option>'
											+ '<option value="96">96</option>'
											+ '<option value="128">128</option>'
											+ '<option value="192" selected>192</option>'
											+ '</select>';
					    }
						taskInfoHtml +='</p><p>'+
						'<label>音量：</label><input class="text-input small-input" type="text" value="'+stream.volume+'" name="'+j+stream.pid+'volume" />'+
						'</p>';
					}
					if(k != streamList.length-1) taskInfoHtml += '<hr style="border:1px dashed #ddd;">';
				}
				taskInfoHtml += '</div></div>';
				taskInfoHtml += '<div class="pragram-box"><span class="pragram-title">目标参数</span>'+
					'<p><label>码率(kbps)：</label><input class="text-input small-input" type="text" value="'+outputList[j].bitrate+'" name="outbitrate" />';
			     if(outputList[j].mode=="abr"){
			           taskInfoHtml += '<label>码率控制方式：</label>'
											+ '<select name="mode" class="small-input">'
											+ '<option value="abr" selected>abr</option>'
											+ '<option value="cbr">cbr</option>'
											+ '<option value="vbr">vbr</option>'
											+ '</select>';
				}else if(outputList[j].mode=="cbr"){
				    taskInfoHtml += '<label>码率控制方式：</label>'
											+ '<select name="mode" class="small-input">'
											+ '<option value="abr">abr</option>'
											+ '<option value="cbr" selected>cbr</option>'
											+ '<option value="vbr">vbr</option>'
											+ '</select>';
				 }else if(outputList[j].mode=="vbr"){
				    taskInfoHtml += '<label>码率控制方式：</label>'
											+ '<select name="mode" class="small-input">'
											+ '<option value="abr">abr</option>'
											+ '<option value="cbr">cbr</option>'
											+ '<option value="vbr" selected>vbr</option>'
											+ '</select>';
			     }
			     
			      if(outputList[j].of=="mpegts"){
			           taskInfoHtml += '<label>输出封装格式：</label>'
											+ '<select name="of" class="small-input">'
											+ '<option value="mpegts" selected>mpegts</option>'
											+ '</select>';
				 }
					taskInfoHtml +='<label>network_id：</label><input class="text-input small-input" type="text" value="'+outputList[j].network_id+'" name="network_id" />'+
					'</p><p>'+
					'<label>stream_id：</label><input class="text-input small-input" type="text" value="'+outputList[j].stream_id+'" name="stream_id" />'+
					'<label>service_id：</label><input class="text-input small-input" type="text" value="'+outputList[j].service_id+'" name="service_id" />'+
					'<label>service_provider：</label><input class="text-input small-input" type="text" value="'+outputList[j].service_provider+'" name="service_provider" />'+
			     	'<label>pmt_start_pid：</label><input class="text-input small-input" type="text" value="'+outputList[j].pmt_start_pid+'" name="pmt_start_pid" />'+
					'</p><p>'+
					'<label>start_pid：</label><input class="text-input small-input" type="text" value="'+outputList[j].start_pid+'" name="start_pid" />'+
					 '<label>service_name：</label><input class="text-input small-input" type="text" value="'+outputList[j].service_name+'" name="service_name" />'+
		       		'<label>输出方式：</label><input type="text" value="'+outputList[j].out+'" width="60px" name="out" />'+
					'</p></div>';
			}
			taskInfoHtml += '</fieldset></td></tr>'
			;
			$(".source").html(taskInfoHtml);
		});
	}
	
	function update(){
			document.myForm.submit();
	}
</script>
</html>
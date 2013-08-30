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
</head>
<body class="main-body">
<div id="main-content"  style="width:100%;height:100%;overflow:auto;">
<div class="content-box">
	<div class="content-box-content">
		<div class="tab-content">
			<form name="myForm" action="taskAction.do?method=addTask" method="post">
			<fieldset id="box0">
			<p>
					<label>任务名称：</label>
					<input type="text" name="name" onblur="onblurInput(this,'','任务名称不能够为空!',0);" />
			</p>
		 	<p>
					<label>输入地址：</label>
					<input type="text" name="inputIp" onblur="onblurInput(this,'','输入地址不能够为空!',0);" />
			</p>
			<p style="color:red;" >
			    说明：请输入正确的接入流IP地址及端口号，并确认该地址已播发节目流，否则无法创建任务！！！
			</p>
				<p id="boxButton1">
					<input class="button" type="button" value="下一步" onClick="goTo(0,1);" />
				</p>
			</fieldset>
						<fieldset id="box1">
							<div class="outBox0">
								<div>
									<div class="pragram-box">
										<span class="pragram-title">源参数</span>
										<div class="source">
											<p style="text-align:center">正在加载...</p>
										</div>
									</div>
									<div class="pragram-box">
										<span class="pragram-title">目标参数</span>
										<p>
											<label><a
												title="转码输出码率，用户自定义,一般根据分辨率设置 例如：352x288->1000;720x576->1500;720x576->2000;1280x720->3000、4000">码率(kbps)：</a></label>
											<input class="text-input small-input" type="text"
												name="outbitrate"
												onblur="onblurInput(this,'','码率不能够为空!',0);" /> <label>码率控制方式：</label>
											<select name="mode" class="small-input">
												<option value="abr">abr</option>
												<option value="cbr" selected>cbr</option>
												<option value="vbr">vbr</option>
											</select> <label>输出封装格式：</label> <select name="of" class="small-input">
												<option value="mpegts">mpegts</option>
											</select>
											<label>network_id：</label> <input class="text-input small-input"
												 type="text" name="network_id"
												value="0x0001" onClick="onclickInput(this);"
												onblur="onblurInput(this,'0x0001','',0);" /> 
										</p>
										<p>
											<label>stream_id：</label>
											<input class="text-input small-input" type="text"
												name="stream_id" value="0x0001"
												onClick="onclickInput(this);"
												onblur="onblurInput(this,'0x0001','',0);" /> <label>service_id：</label>
											<input class="text-input small-input" type="text"
												name="service_id" value="0x0001"
												onClick="onclickInput(this);"
												onblur="onblurInput(this,'0x0001','',0);" />
												<label><a title="设置PMT起始PID (默认 0x1000, 最大值 0x1f00)">pmt_start_pid：</a></label>
											<input class="text-input small-input" type="text"
												name="pmt_start_pid" value="0x1000"
												onClick="onclickInput(this);"
												onblur="onblurInput(this,'0x1000','默认 0x1000, 最大值 0x1f00',1,0x1000,0x1f00);" />
											<label><a title="设置数据起始PID (默认 0x0100, 最大值 0x0f00)">start_pid：</a></label>
											<input class="text-input small-input" type="text"
												name="start_pid" value="0x0100"
												onClick="onclickInput(this);"
												onblur="onblurInput(this,'0x0100','默认 0x0100, 最大值 0x0f00',1,0x0100,0x0f00);" />
										</p>
										<p>
											<label>service_provider：</label> <input
												class="text-input small-input" type="text"
												name="service_provider" value="HT2000"
												onClick="onclickInput(this);"
												onblur="onblurInput(this,'HT2000','',0);" />
												<label><a title="输出流节目名称">service_name：</a></label> <input
												class="text-input small-input" type="text"
												name="service_name" value="Service01"
												onClick="onclickInput(this);"
												onblur="onblurInput(this,'Service01','',0);" />
										</p>
										<p>
											 <label>输出方式：</label>
											<select name="outputType" class="small-input"
												onChange="changeOutputType(this);">
												<option value="udp">udp</option>
												<option value="hls">hls</option>
												<!--  <option value="http">http</option>
								<option value="rtmp">rtmp</option>-->
											</select> <label>输出地址：</label> <input 
												class="text-input small-input" type="text" name="outputIp"
												onblur="onblurInput(this,'','输出地址不能够为空!',0);" />
											<label>输出端口：</label> <input class="text-input small-input"
												type="text" name="outputPort"
												onblur="onblurInput(this,'','输出端口不能够为空!',0);" />
										</p>
										<p style="display:none;">
											<label>切片时长：</label> <input class="text-input small-input" 
												type="text" value="10" name="hls_time" /> <label>切片个数：</label>
											<input  type="text" value="10" class="text-input small-input" 
												name="hls_list_size" />
										</p>
									</div>
								</div>
							</div>
							<p id="boxButton2">
								<input class="button" type="button" value="上一步"
									onClick="goTo(1,-1);" /> <input class="button" type="button"
									value="新增任务" onClick="checkInput();" /> <input class="button"
									type="button" value="+" onClick="addOut();" />
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
<script type="text/javascript">
	var outId = 0;
	var outBoxHtml = $(".outBox0").html();;
	var serviceList = new Array();

	$(function(){
		$("fieldset").hide();
		$("#box0").show();
	});
	
	function checkInput() {
	var flag = true;
	$("input[name='outputType']")
		.each(
			function() {
			    if ($(this).val() == "udp") {
				if ($(this).parent().find(
					"input[name='outputPort']").val() == "")
				    flag = false;
			    } else if ($(this).val() == "hls") {
				var re = new RegExp("([a-z][A-Z])$", "g");
				if (!Boolean($(this).parent().find(
					"input[name='outputIp']").val().match(
					re))) {
				    alert("输入地址最后一个字符只能为字母！");
				    return;
				} else if ($(this).parent().find(
					"input[name='hls_time']").val() == ""
					|| $(this).parent().find(
						"input[name='hls_list_size']")
						.val() == "") {
				    flag = false;
				}
			    }
			});
	$("input[type='text']").each(
		function() {
		    if (($(this).attr("name") != "outputPort"
			    && $(this).attr("name") != "hls_time" && $(this)
			    .attr("name") != "hls_list_size")
			    && $(this).val() == "")
			flag = false;
		});
//	if (!flag) {
//	    alert("请检查参数是否填写完整！");
//	} else {
	    document.myForm.submit();
//	}
    }
	
	function initEvent(){
		$("input[type='checkbox']").click(function(){
			var name = $(this).attr("name");
			var val = $(this).val().split("-")[0];
			if($(this).is(':checked')){
				$("."+name+val).show();
			}else{
				$("."+name+val).hide();
			}  
		});
	}
	
	function goTo(__index,__offset){
		if(__offset > 0){
			var flag = true;
			$("#box0 input[type='text']").each(function(){
				if($(this).val() == "") flag = false;
			});
			if(!flag){
				alert("请检查参数是否添写完整！");
				return;
			}
		}
		if(__offset > 0){
			$(".bgDiv").show();
			var name = $("[name='name']").val();
			var addr = $("[name='inputIp']").val();
			$.post("taskAction.do?method=checkTask",{desc:name,addr:addr},function(data){
		//		console.log(data);
				var result = eval(data)[0];
				if(result.error == "1"){
					goTo(1,-1);
					alert(result.desc);
				}else{
					serviceList = result.service;
					var serviceNameHtml = '<p><label>service_name：</label><select name="src_service_name"  onChange="changeServiceName(this,0);">';
					for(var i=0; i<serviceList.length; i++){
					  serviceNameHtml += '<option value="'+serviceList[i].id+'_'+serviceList[i].name+'">'
						+ serviceList[i].name
						+ '(id:'
						+ serviceList[i].id
						+ ')</option>';
					}
					serviceNameHtml += '</select>【片源】节目名称</p><div class="pragram-box"><span class="pragram-title">流信息</span>'+
						'<p><table><thead><tr><th>&nbsp;</th><th>PID</th><th width="200">类型</th><th>描述信息</th></tr></thead><tbody id="streamList0">';
					var streamList = serviceList[0].stream;
					for(var j=0; j<streamList.length; j++){
						serviceNameHtml += '<tr><td><input class="text-input small-input" name="streamId0" type="checkbox" value="'+streamList[j].pid+'-'+streamList[j].type+'" checked="true" /></td><td>'+streamList[j].pid+'</td>';
						if(streamList[j].type == "v"){
							serviceNameHtml += '<td>【片源】视频流</td><td>'+streamList[j].info+'</td></tr><tr class="streamId0'+streamList[j].pid+'"><td colspan="4">'+getVideoHtml("0"+streamList[j].pid)+'</td></tr>';
						}else if(streamList[j].type == "a"){
							serviceNameHtml += '<td>【片源】音频流</td><td>'+streamList[j].info+'</td></tr><tr class="streamId0'+streamList[j].pid+'"><td colspan="4">'+getAudioHtml("0"+streamList[j].pid)+'</td></tr>';
						}
					}
					serviceNameHtml += '</tbody></table></p></div>';
					$(".source").html(serviceNameHtml);
				}
				$(".bgDiv").hide();
				initEvent();
			});
		}
		$("#box"+__index).hide();
		$("#box"+(__index+__offset)).show();
	}
	
	function addInput(){
		var inputStr = '<p>'+
		'<label>输入地址：</label>'+
		'<input class="text-input small-input" type="text" name="inputIp" onblur="onblurInput(this,\'\',\'输入地址不能够为空!\',0);" />'+
		'<label>输入码率：</label>'+
		'<input class="text-input small-input" type="text" name="bitrate" />'+
		'<input class="button delInput" type="button" value="X" />'+
		'</p>';
		$("#boxButton1").before(inputStr);
		$(".delInput").click(function(){
			$(this).parent().remove();
		});
	}
	
	function addOut(){
		outId++;
		var outStr = '<div><hr/><p><input class="button delOutput" style="float:right; margin-top:-10px;" type="button" value="X" /><input class="button" style="float:right; margin-top:-10px;" type="button" value="收缩/展开" onclick="closeOrOpen(this);" /></p>'+outBoxHtml+'</div>';
		$("#boxButton2").before(outStr);
		var serviceNameHtml = '<p><label>service_name：</label><select name="src_service_name"  onChange="changeServiceName(this,'+outId+');">';
		for(var i=0; i<serviceList.length; i++){
			 serviceNameHtml += '<option value="'+serviceList[i].id+'_'+serviceList[i].name+'">'
						+ serviceList[i].name
						+ '(id:'
						+ serviceList[i].id
						+ ')</option>';
		}
		serviceNameHtml += '</select>【片源】节目名称</p><div class="pragram-box"><span class="pragram-title">流信息</span>'+
			'<p><table><tbody id="streamList'+outId+'">';
		var streamList = serviceList[0].stream;
		for(var j=0; j<streamList.length; j++){
			serviceNameHtml += '<tr><td><input class="text-input small-input" name="streamId'+outId+'" type="checkbox" value="'+streamList[j].pid+'-'+streamList[j].type+'" checked="true" /></td><td>'+streamList[j].pid+'</td>';
			if(streamList[j].type == "v"){
				serviceNameHtml += '<td>【片源】视频流</td><td>'+streamList[j].info+'</td></tr><tr class="streamId'+outId+''+streamList[j].pid+'"><td colspan="4">'+getVideoHtml(outId+""+streamList[j].pid)+'</td></tr>';
			}else if(streamList[j].type == "a"){
				serviceNameHtml += '<td>【片源】音频流</td><td>'+streamList[j].info+'</td></tr><tr class="streamId'+outId+''+streamList[j].pid+'"><td colspan="4">'+getAudioHtml(outId+""+streamList[j].pid)+'</td></tr>';
			}
		}
		serviceNameHtml += '</tbody></table></p></div>';
		$(".source").each(function(i){
		//	console.log(i+"--"+outId);
			if(i == outId) $(this).html(serviceNameHtml);
		});
		
		$(".delOutput").click(function(){
			outId--;
			$(this).parent().parent().remove();
		});
		initEvent();
	}
	
	function closeOrOpen(__obj){
		$(__obj).parent().next().toggle(); 
	}
	
	function changeServiceName(__obj,__index){
		var serviceIndex = $(__obj).get(0).options.selectedIndex;
		var streamList = serviceList[serviceIndex].stream;
		var streamListHtml = "";
		for(var j=0; j<streamList.length; j++){
			streamListHtml += '<tr><td><input class="text-input small-input" name="streamId'+__index+'" type="checkbox" value="'+streamList[j].pid+'-'+streamList[j].type+'" checked /><td>'+streamList[j].pid+'</td></td>';
			if(streamList[j].type == "v"){
				streamListHtml += '<td>【片源】视频流</td><td>'+streamList[j].info+'</td></tr><tr class="streamId'+__index+''+streamList[j].pid+'"><td colspan="4">'+getVideoHtml(__index+""+streamList[j].pid)+'</td></tr>';
			}else if(streamList[j].type == "a"){
				streamListHtml += '<td>【片源】音频流</td><td>'+streamList[j].info+'</td></tr><tr class="streamId'+__index+''+streamList[j].pid+'"><td colspan="4">'+getAudioHtml(__index+""+streamList[j].pid)+'</td></tr>';
			}
		}
		$("#streamList"+__index).html(streamListHtml);
	}
	
  function getVideoHtml(__name) {
	var htmlStr = '<p>'
		+ '<label><a title="推荐使用默认值ultrafast -> placebo 逐级递增, 视频压缩效率越高编码速度越慢系统资源占用率越高">转码预设：</a></label>'
		+ '<select name="'+__name+'preset" class="small-input">'
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
		+ '</select>'
		+ '<label>视频编码方式：</label>'
		+ '<select name="'+__name+'vcodec" class="small-input">'
		+ '<option value="h264">h264</option>'
		+ '</select>'
		+ '<label><a title="auto 表示由系统根据各类参数自动选择等级 推荐参数,有效范围：1.0~5.2">编码等级：</a></label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'level" value="auto" onClick="onclickInput(this);" onblur="onblurInput(this,\'auto\',\'有效值范围为：1.0~5.2!\',1,1.0,5.2);" />'
		+ '</p>'
		+ '<p>'
		+ '<label>规格：</label>'
		+ '<select name="'+__name+'vprofile" class="small-input">'
		+ '<option value="main">main</option>'
		+ '<option value="high" selected>high</option>'
		+ '<option value="baseline">baseline</option>'
		+ '</select>'
		+ '<label>分辨率：</label>'
		+ '<select name="'+__name+'resolution" class="small-input">'
		+ '<option value="176x144">176x144</option>'
		+ '<option value="352x288">352x288</option>'
		+ '<option value="640x360">640x360</option>'
		+ '<option value="720x576">720x576</option>'
		+ '<option value="1280x720">1280x720</option>'
		+ '<option value="1920x1080">1920x1080</option>'
		+ '</select>'
		+ '<label><a title="视频每秒帧率，auto表示系统自定义(一般维持原视频帧率) 推荐参数 25,有效范围：1~30">帧率(fps)：</a></label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'fps" value="auto" onClick="onclickInput(this);" onblur="onblurInput(this,\'auto\',\'有效值范围为：1~30!\',1,1,30);" />'
		+ '<label><a title="有效范围：1~16">参考帧：</a></label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'refnum" value="15" onClick="onclickInput(this);" onblur="onblurInput(this,\'15\',\'有效值范围为：1~16!\',1,1,16);" />'
		+ '</p>'
		+ '<p>'
		+ '<label>转码方式：</label>'
		+ '<select name="'+__name+'method" class="small-input">'
		+ '<option value="hw" selected>硬转</option>'
		+ '<option value="sw">软转</option>'
		+ '</select>'
		+ '<label><a title="有效范围：0~250">GOP大小：</a></label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'gop" value="preset" onClick="onclickInput(this);" onblur="onblurInput(this,\'preset\',\'有效值范围为：0~250!\',1,0,250);" />'
		+ '<label><a title="有效范围：0~8">B帧间距：</a></label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'bframe" value="preset" onClick="onclickInput(this);" onblur="onblurInput(this,\'preset\',\'有效值范围为：0~8!\',1,0,8);" />'
        + '<label>宽高比：</label>'
		+ '<select name="'+__name+'aspect" class="small-input">'
		+ '<option value="auto" selected>auto</option>'
		+ '<option value="1:1">1:1</option>'
		+ '<option value="4:3">4:3</option>'
		+ '<option value="16:9">16:9</option>'
		+ '</select>'
		+ '</p>'
		+ '<p>'
		+ '<label>使用马赛克：</label>'
		+ '<input name="'+__name+'mosaic" value="0-0" type="checkbox"/>'
		+ '<label>使用图像：</label>'
		+ '<input name="'+__name+'pic" value="0-0" type="checkbox"/>'
		+ '<label>使用视屏拼接：</label>'
		+ '<input name="'+__name+'resolutions" value="0-0" type="checkbox"/>'
		+ '</p>'
		+ '<div class="'+__name+'mosaic0" style="display:none;">'
		+ '<p>'
		+ '<label>对齐方式：</label>'
		+ '<select name="'+__name+'overlay" class="small-input">'
		+ '<option value="0">不设置</option>'
		+ '<option value="1">左上角对齐</option>'
		+ '<option value="2">右上角对齐</option>'
		+ '<option value="3">左下角对齐</option>'
		+ '<option value="4">右下角对齐</option>'
		+ '</select>'
		+ '<label>横向偏移量：</label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'x" value="0" onClick="onclickInput(this);" onblur="onblurInput(this,\'\',\'\',0);" />'
		+ '<label>纵向偏移量：</label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'y" value="0" onClick="onclickInput(this);" onblur="onblurInput(this,\'\',\'\',0);" />'
		+ '</p>'
		+ '<p>'
		+ '<label>马赛克宽度：</label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'w" value="0" onClick="onclickInput(this);" onblur="onblurInput(this,\'\',\'\',0);" />'
		+ '<label>马赛克高度：</label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'h" value="0" onClick="onclickInput(this);" onblur="onblurInput(this,\'\',\'\',0);" />'
		+ '</p>' + '</div>'
		+ '<div class="'+__name+'pic0" style="display:none;">'
		+ '<p>'
		+ '<label>对齐方式：</label>'
		+ '<select name="'+__name+'pics" class="small-input">'
		+ '<option value="0">不设置</option>'
		+ '<option value="1">左上角对齐</option>'
		+ '<option value="2">右上角对齐</option>'
		+ '<option value="3">左下角对齐</option>'
		+ '<option value="4">右下角对齐</option>'
		+ '</select>'
		+ '<label>d横向偏移量：</label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'dx" value="0" onClick="onclickInput(this);" onblur="onblurInput(this,\'\',\'\',0);" />'
		+ '<label>d纵向偏移量：</label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'dy" value="0" onClick="onclickInput(this);" onblur="onblurInput(this,\'\',\'\',0);" />'
		+ '</p>'
		+ '<p>'
		+ '<label>d马赛克宽度：</label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'dw" value="0" onClick="onclickInput(this);" onblur="onblurInput(this,\'\',\'\',0);" />'
		+ '<label>d马赛克高度：</label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'dh" value="0" onClick="onclickInput(this);" onblur="onblurInput(this,\'\',\'\',0);" />'
		+ '</p>' + '</div>'
		+ '<div class="'+__name+'resolutions0" style="display:none;">'
		+ '<p>'
		+ '<label>onlymosaic：</label>'
		+ '<select name="'+__name+'onlymosaic" class="small-input">'
		+ '<option value="0">同时转码</option>'
		+ '<option value="1">仅做视频拼接</option>'
		+ '</select>'
		+ '<label>resolution：</label>'
		+ '<select name="'+__name+'resolutions1" class="small-input">'
		+ '<option value="360x240">360x240</option>'
		+ '<option value="360x288">360x288</option>'
		+ '<option value="352x288">352x288</option>'
		+ '</select>'
		+ '<label>mode：</label>'
		+ '<select name="'+__name+'modes" class="small-input">'
		+ '<option value="2x2">2x2</option>'
		+ '<option value="3x3">3x3</option>'
		+ '<option value="4x4">4x4</option>'
		+ '</select>'
		+ '</p>' + '</div>';
	return htmlStr;
    }

    function getAudioHtml(__name) {
	var htmlStr = '<p>'
		+ '<label>音频编码方式：</label>'
		+ '<select name="'+__name+'acodec" class="small-input">'
		+ '<option value="aac">aac</option>'
		+ '</select>'
		+ '<label>采样率(HZ)：</label>'
		+ '<select name="'+__name+'ar" class="small-input">'
		+ '<option value="22050">22050</option>'
		+ '<option value="44100" selected>44100</option>'
		+ '<option value="96000">96000</option>'
		+ '</select>'
		+ '<label>声道：</label>'
		+ '<select name="'+__name+'ac" class="small-input">'
		+ '<option value="1">单声道</option>'
		+ '<option value="2" selected>立体声</option>'
		+ '</select>'
		+ '<label>码率(kbps)：</label>'
		+ '<select name="'+__name+'bitrate" class="small-input">'
		+ '<option value="48">48</option>'
		+ '<option value="96" selected>96</option>'
		+ '<option value="128">128</option>'
		+ '<option value="192">192</option>'
		+ '</select>'
	    + '</p>'
		+ '<p>'
		+ '<label><a title="有效范围：0~300">音量：</a></label>'
		+ '<input class="text-input small-input" type="text" name="'
		+ __name
		+ 'volume" value="100" onClick="onclickInput(this);" onblur="onblurInput(this,\'100\',\'有效值范围为：0~300!\',1,0,300);" />'
		+ '</p>';
	return htmlStr;
    }
</script>
</html>
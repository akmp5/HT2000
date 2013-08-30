<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title></title>
</head>

<body class="main-body">
<div class="pageContent" style="width:100%;height:100%;overflow:auto;">
	<div class="panelBar">
	  <c:if test="${AdminInfo.permission > 0}">
	  <ul class="toolBar">
		<li><a class="add" href="Pages/Backup/addBackup.jsp" target="dialog"  title="新增" ><span>添加</span></a></li>
		<c:if test="${AdminInfo.permission > 1}">
		<li><a class="delete" target="ajaxTodo" title="确定要删除吗?" href="backupAction.do?method=delBackup&id={abrId}"><span>删除</span></a></li>
		</c:if>
	   </ul>
	   </c:if>
	  <div class="clear"></div>
	   
	</div>
		<div class="content-box">
			<div class="content-box-content">
				<div class="tab-content">
					<form id="taskListBox" name="form" action="#" method="post">
					</form>
				</div>
			</div>
		</div>
 </div>
		
</body>
<script type="text/javascript">
	var currPage = 1;
	var totalNum = 0;
	var totalPage = 0;
	var pageNum = 15;
	
	$(function(){
		initBackupList();
		//getTotalNum();
	});
	
	function delBackup(obj){
	    if(confirm("您确定要删除这个任务？")){
	    	$.post("backupAction.do?method=delBackup&id="+obj,{},function(data){
	    		initBackupList();
	    	});
	    }
	}
	
	function initBackupList(){
		$.post("backupAction.do?method=getAllBackupList",{},function(data){
		    var backupList = eval("("+data+")");
			var backupInfoHtml = "";
			if(backupList.length == 0){
				backupInfoHtml += '<div class="notification information"><div>暂无备份记录</div></div>';
				$("#backupListBox").html(backupInfoHtml);
			}else{
				backupInfoHtml += '<table><thead><tr><th><input class="check-all" type="checkbox" /></th>'+
								'<th>备份服务器地址</th><th style="width:100px; text-align:center;">操作</th></tr></thead>'+
								'<tfoot><tr><td colspan="3" style="text-align:right;"></td></tr></tfoot><tbody>';
				for(var i=0; i<backupList.length; i++){
					var backupInfo = backupList[i];
					backupInfoHtml += '<tr target="abrId" rel="'+backupInfo.id+'"><td><input name="id" type="checkbox" value="'+backupInfo.id+'" /></td>'+
									  '<td>'+backupInfo.ipaddr+'</td>';
					backupInfoHtml += '</tr>';
				}
				backupInfoHtml += '</tbody></table>';
				$("#backupListBox").html(backupInfoHtml);
				$('.check-all').click(function(){
						$("input[type='checkbox']").attr('checked', $(this).is(':checked')); 
				});
			}
		});
	}
	
//	function getTotalNum(){
//		$.post("backupAction.do?method=getTotalNum",{},function(data){
//			currPage = 1;
//			totalNum = eval("("+data+")");
//			totalPage = totalNum%pageNum==0?totalNum/pageNum:Math.floor(totalNum/pageNum)+1;
//			initTaskList();
//		});
//	}
	
	function initTaskList(){
		$.post("backupAction.do?method=getAllTaskList",{status:status,currPage:currPage,pageNum:pageNum},function(data){
			var taskList = eval("("+data+")");
			var taskInfoHtml = "";
			if(taskList.length == 0){
				taskInfoHtml += '<div class="notification information"><div>暂无任务</div></div>';
				$("#taskListBox").html(taskInfoHtml);
			}else{
				taskInfoHtml += '<table><thead><tr><th>服务器地址</th><th>任务名称</th><th>启动时间</th>'+
								'<th style="width:100px; text-align:center;">操作</th></tr></thead>'+
								'<tfoot><tr><td colspan="4" style="text-align:right;">';
			//	taskInfoHtml += '&nbsp;共<b>'+totalNum+'</b>条记录&nbsp;本页 <b>'+(currPage*pageNum>totalNum?totalNum%pageNum:pageNum)+'</b> 条&nbsp;'+
			//					'&nbsp;本页从 <b>'+((currPage-1)*pageNum+1)+'-'+(currPage*pageNum<totalNum?currPage*pageNum:totalNum)+'</b> 条&nbsp;'+
			//					'&nbsp;<b>'+currPage+'/'+totalPage+'</b>页&nbsp;';
			//	if(currPage > 1){
			//		taskInfoHtml += '&nbsp;<a href="javascript:void(null);" onClick="goTo(1);">首页</a>'+
			//						'&nbsp;<a href="javascript:void(null);" onClick="goTo('+(currPage-1)+');">上一页</a>&nbsp;<b>';
			//	}
				for(var i=4; i>=1; i--){
					if(currPage-i>=1)
						taskInfoHtml += '<a href="javascript:void(null);" onClick="goTo('+(currPage-i)+');">'+(currPage-i)+'</a>&nbsp;';
				}
				if(totalPage>1)
					taskInfoHtml += '<span style="padding:1px 2px;background:#BBB;color:white">'+currPage+'</span>&nbsp';
				for(var j=1; j<4; j++){
					if(currPage+j<=totalPage)
						taskInfoHtml += '<a href="javascript:void(null);" onClick="goTo('+(currPage+j)+');">'+(currPage+j)+'</a>&nbsp;';
				}
				taskInfoHtml +='</b>';
				if(currPage != totalPage){
					taskInfoHtml += '&nbsp;<a href="javascript:void(null);" onClick="goTo('+(currPage+1)+');">下一页</a>&nbsp;<b>'+
									'&nbsp;<a href="javascript:void(null);" onClick="goTo('+totalPage+');">末页</a>';
				}
				taskInfoHtml += '</td></tr></tfoot><tbody>';
				for(var i=0; i<taskList.length; i++){
					var taskInfo = taskList[i];
					taskInfoHtml += '<tr target="taskId" rel="taskInfo'+taskInfo.id+'">'+
									'<td>'+taskInfo.target+'</td><td>'+taskInfo.desc+'</td><td>'+taskInfo.startUtc+'</td>'+
									'<td></td></tr>';
				}
				taskInfoHtml += '</tbody></table>';
				$("#taskListBox").html(taskInfoHtml);
			}
		});
	}
	
	function goTo(toPage){
		currPage = toPage;
		initTaskList();
	}
	
	function showTaskInfo(__id){
		if(Boolean($(".taskInfo"+__id).get(0))){
			$(".taskInfo"+__id).toggle();
			return;
		}
		$.post("backupAction.do?method=getTaskInfoById",{id:__id},function(data){
			var taskInfo = eval("("+data+")");
			var taskInfoHtml = '<tr class="taskInfo'+taskInfo.id+'"><td colspan="5"><fieldset>';
			var inputList = taskInfo.input;
			for(var i=0; i<inputList.length; i++){
				taskInfoHtml += '<hr/><p><label>输入方式：</label><input type="text" value="'+inputList[i].addr+'" disabled /></p>';
			}
			var outputList = taskInfo.output;
			for(var j=0; j<outputList.length; j++){
				taskInfoHtml += '<hr/>'+
				'<div class="pragram-box"><span class="pragram-title">源参数</span>'+
				'<p><label>service_name：</label><input type="text" value="'+outputList[j].coding_service_name+'" disabled /></p>'+
				'<div class="pragram-box"><span class="pragram-title">流信息</span>';
				var streamList = outputList[j].stream;
				for(var k=0; k<streamList.length; k++){
					var stream = streamList[k];
					taskInfoHtml += '<p><label>pid：</label><input type="text" value="'+stream.pid+'" disabled /></p>';
					if(stream.type == "v"){
						var method = "";
						if (stream.method == "hw"){
							method = "硬转";
						}else{
							method = "软转";
						}
						taskInfoHtml += '<p>'+
						'<label>转码预设：</label><input type="text" value="'+stream.preset+'" disabled />'+
						'<label>视频编码方式：</label><input type="text" value="'+stream.vcodec+'" disabled />'+
						'<label>编码等级：</label><input type="text" value="'+stream.level+'" disabled />'+
						'</p><p>'+
						'<label>规格：</label><input type="text" value="'+stream.vprofile+'" disabled />'+
						'<label>分辨率：</label><input type="text" value="'+stream.resolution+'" disabled />'+
						'<label>帧率(fps)：</label><input type="text" value="'+stream.fps+'" disabled />'+
						'</p><p>'+
						'<label>转码方式：</label><input type="text" value="'+method+'" disabled />'+
						'<label>GOP大小：</label><input type="text" value="'+stream.gop+'" disabled />'+
						'<label>B帧间距：</label><input type="text" value="'+stream.bframe+'" disabled />'+
						'</p><p>'+
						'<label>参考帧：</label><input type="text" value="'+stream.refnum+'" disabled />'+
						'<label>宽高比：</label><input type="text" value="'+stream.aspect+'" disabled />';
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
							taskInfoHtml += '<label>对齐方式：</label><input type="text" value="'+overlay+'" disabled />'+
							'<label>横向偏移量：</label><input type="text" value="'+stream.x+'" disabled />'+
							'</p><p>'+
							'<label>纵向偏移量：</label><input type="text" value="'+stream.y+'" disabled />'+
							'<label>马赛克宽度：</label><input type="text" value="'+stream.width+'" disabled />'+
							'<label>马赛克高度：</label><input type="text" value="'+stream.height+'" disabled />';
						}
						taskInfoHtml += '</p>';
					}else{
						taskInfoHtml += '<p>'+
						'<label>音频编码方式：</label><input type="text" value="'+stream.acodec+'" disabled />'+
						'<label>采样率(HZ)：</label><input type="text" value="'+stream.ar+'" disabled />'+
						'<label>声道：</label><input type="text" value="'+stream.ac+'" disabled />'+
						'</p><p>'+
						'<label>码率(kbps)：</label><input type="text" value="'+stream.bitrate+'" disabled />'+
						'<label>音量：</label><input type="text" value="'+stream.volume+'" disabled />'+
						'</p>';
					}
					if(k != streamList.length-1) taskInfoHtml += '<hr style="border:1px dashed #ddd;">';
				}
				taskInfoHtml += '</div></div>';
				taskInfoHtml += '<div class="pragram-box"><span class="pragram-title">目标参数</span>'+
					'<p><label>码率(kbps)：</label><input type="text" value="'+outputList[j].bitrate+'" disabled />'+
					'<label>码率控制方式：</label><input type="text" value="'+outputList[j].mode+'" disabled />'+
					'<label>输出封装格式：</label><input type="text" value="'+outputList[j].of+'" disabled />'+
					'</p><p>'+
					'<label>network_id：</label><input type="text" value="'+outputList[j].network_id+'" disabled />'+
					'<label>stream_id：</label><input type="text" value="'+outputList[j].stream_id+'" disabled />'+
					'<label>service_id：</label><input type="text" value="'+outputList[j].service_id+'" disabled />'+
					'</p><p>'+
					'<label>pmt_start_pid：</label><input type="text" value="'+outputList[j].pmt_start_pid+'" disabled />'+
					'<label>start_pid：</label><input type="text" value="'+outputList[j].start_pid+'" disabled />'+
					'<label>service_provider：</label><input  type="text" value="'+outputList[j].service_provider+'" disabled />'+
					'</p><p>'+
					'<label>service_name：</label><input type="text" value="'+outputList[j].service_name+'" disabled />'+
					'<label>输出方式：</label><input type="text" value="'+outputList[j].out+'" disabled />'+
					'</p></div>';
			}
			taskInfoHtml += '</fieldset></td></tr>';
			$("#taskInfo"+taskInfo.id).after(taskInfoHtml);
		});
	}
</script>
</html>
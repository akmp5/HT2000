<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- Jstl 标签 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 去除网页空格 -->
<%@ page trimDirectiveWhitespaces="true" %>
<!-- Css + Javascript -->
<link href="Public/themes/default/style.css" rel="stylesheet" type="text/css" />
<link href="Public/themes/css/core.css" rel="stylesheet" type="text/css" />
<link href="Public/uploadify/css/uploadify.css" rel="stylesheet" type="text/css" />
<!-- <link href="Public/Css/invalid.css" rel="stylesheet" type="text/css">
<link href="Public/Css/reset.css" rel="stylesheet" type="text/css">
<link href="Public/Css/admin.css" rel="stylesheet" type="text/css">
 -->
<link rel="stylesheet" type="text/css" href="Public/keditor/themes/default/default.css">
<link rel="stylesheet" href="Public/keditor/plugins/code/prettify.css" />
<!--<link rel="stylesheet" href="Public/Css/admin.css" /> -->
<script type="text/javascript" src="Public/keditor/kindeditor.js"></script>
<script type="text/javascript" src="Public/keditor/lang/zh_CN.js"></script>
<script type="text/javascript" src="Public/keditor/plugins/code/prettify.js"></script>
<!--[if IE]>
<link href="themes/css/ieHack.css" rel="stylesheet" type="text/css" />
<![endif]-->

<script src="Public/Js/dwz/speedup.js" type="text/javascript"></script>
<script src="Public/Js/dwz/jquery-1.7.1.js" type="text/javascript"></script>
<script type="text/javascript" src="Public/Js/jquery-1.7.2.min.js"></script>

<script src="Public/Js/dwz/jquery.cookie.js" type="text/javascript"></script>
<script src="Public/Js/dwz/jquery.validate.js" type="text/javascript"></script>
<script src="Public/Js/dwz/jquery.bgiframe.js" type="text/javascript"></script>
<!--<script src="js/dwz/xheditor-1.1.12-zh-cn.min.js" type="text/javascript"></script>-->
<script src="Public/uploadify/scripts/swfobject.js" type="text/javascript"></script>
<script src="Public/uploadify/scripts/jquery.uploadify.v2.1.0.js" type="text/javascript"></script>

<!-- svg图表  supports Firefox 3.0+, Safari 3.0+, Chrome 5.0+, Opera 9.5+ and Internet Explorer 6.0+ -->
<!--<script type="text/javascript" src="chart/raphael.js"></script>-->
<!--<script type="text/javascript" src="chart/g.raphael.js"></script>-->
<!---->
<!--<script type="text/javascript" src="chart/g.bar.js"></script>-->
<!--<script type="text/javascript" src="chart/g.line.js"></script>-->
<!--<script type="text/javascript" src="chart/g.pie.js"></script>-->
<!--<script type="text/javascript" src="chart/g.dot.js"></script>-->

<script src="Public/Js/dwz/dwz.core.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.util.date.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.validate.method.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.regional.zh.js" type="text/javascript"></script>

<script src="Public/Js/dwz/dwz.barDrag.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.drag.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.tree.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.accordion.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.ui.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.theme.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.switchEnv.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.alertMsg.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.contextmenu.js" type="text/javascript"></script>

<script src="Public/Js/dwz/dwz.navTab.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.tab.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.resize.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.dialog.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.dialogDrag.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.sortDrag.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.cssTable.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.stable.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.taskBar.js" type="text/javascript"></script>

<script src="Public/Js/dwz/dwz.ajax.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.pagination.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.database.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.datepicker.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.effects.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.panel.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.checkbox.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.history.js" type="text/javascript"></script>
<script src="Public/Js/dwz/dwz.combox.js" type="text/javascript"></script>

<script src="Public/Js/dwz/dwz.print.js" type="text/javascript"></script>
<script src="Public/Js/admin.js" type="text/javascript"></script>
<script src="Public/Js/jquery.flot.js" type="text/javascript"></script>

<!--
<script src="bin/dwz.min.js" type="text/javascript"></script>
-->







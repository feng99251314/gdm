<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=SystemContext.PROJECTNAME %></title>
<meta name="renderer" content="webkit" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="<%=path%>/images/favicon.ico">
    <script type="text/javascript" src="<%=path%>/third/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>
</head>
<frameset rows="88,*" cols="*" frameborder="no" framespacing="0">
<frame src="<%=path %>/sys/login_view.action?view=top" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" title="topFrame" />
   <frameset cols="187,*" frameborder="no" id="mainFrameset">
    <frame src="<%=path %>/sys/login_view.action?view=left" name="leftFrame" scrolling="no"   noresize="noresize" id="leftFrame" title="leftFrame" />
    <frame src="<%=path %>/sys/login_view.action?view=right" name="rightFrame" id="rightFrame" title="rightFrame" />
  </frameset>
</frameset>
<noframes><body><h2>你的浏览器不支持FRAME,请更换浏览器使用！</h2></body></noframes>
</html>

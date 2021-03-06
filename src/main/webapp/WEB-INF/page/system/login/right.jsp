<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.gxwzu.config.WebConfig" %>
<%@ include file="/WEB-INF/common/common.jsp" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>--%>
<!-- basename为不带properties扩展名的文件名；var为存储该配置文件的变量名 -->
<%--<fmt:setBundle basename="application" var="serverConfig" />--%>
<!-- key为配置文件中的属性名；var为存储该配置值的变量名；bundle为上一步中存储配置文件的变量名 -->
<%--<fmt:message key="chat.server.url" var="chat-server-url" bundle="${serverConfig}" />--%>
<%
//    ServletContext context = request.getSession().getServletContext();
//    ApplicationContext ctx= WebApplicationContextUtils.getWebApplicationContext(context);
//    WebConfig webConfig=(WebConfig)ctx.getBean("WebConfig");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>欢迎页</title>
    <meta http-equiv=Content-Type content="text/html; charset=utf-8">
    <link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="<%=basePath %>/third/layui/css/layui.css" type="text/css">

    <script type="text/javascript" src="<%=path%>/third/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=path%>/third/jquery.validate.js"></script>

<%--    maybe unuse--%>
<%--    <link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css" type="text/css"/>--%>
<%--    <link rel="stylesheet" href="<%=basePath %>/third/layer/skin/layer.css" id="layui_layer_skinlayercss"><link id="layuicss-skinlayercss" rel="stylesheet" href="<%=basePath %>/third/layui/css/modules/layer/default/layer.css?v=3.0.3303" media="all">--%>
<%--    <script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>--%>
<%--    <link id="layuicss-skinlayimcss" rel="stylesheet" href="<%=basePath %>/third/layui/css/modules/layim/layim.css?v=3.60Pro" media="all">--%>
<%--    <link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css">--%>
<%--    <script type="text/javascript" src="<%=path%>/third/layui/layui.js"></script>--%>
<%--    <script type="text/javascript" src="<%=path%>/third/layui/lay/modules/layim.js"></script>--%>


    <script type="text/javascript" src="<%=path%>/js/core/dialog/dialog.js"></script>
    <script type="text/javascript" src="<%=path%>/js/core/dialog/enable.js"></script>
    <script type="text/javascript" src="<%=path%>/datePicket/WdatePicker.js"></script>
    <%--    聊天--%>
    <script type="text/javascript" src="<%=path%>/third/layui/layui.js"></script>

    <script type="text/javascript">

        /*打开公告通知页面  */
        function openNotice(noticeId) {
            layer.open({
                type: 2,
                area: ['99%', '99%'],
                offset: '10px',
                fix: false, //不固定
                title: false,
                maxmin: true,
                content: '<%=path%>/sys/notice_openNotice.action?view=detail&model.noticeId=' + noticeId,
                //去除最大化最小化
                success: function (layero) {
                    layero.find('.layui-layer-min').remove();
                    layero.find('.layui-layer-max').remove();
                }
            });

        }

        /*打开公告通知列表*/
        function openNoticeList() {

            layer.open({
                type: 2,
                area: ['99%', '99%'],
                offset: '10px',
                fix: false, //不固定
                title: false,
                maxmin: true,
                content: '<%=path%>/sys/notice_list.action?view=list',
                //去除最大化最小化
                success: function (layero) {
                    layero.find('.layui-layer-min').remove();
                    layero.find('.layui-layer-max').remove();
                }
            });

        }
    </script>

    <style type="text/css">
        #chatbutton {
            margin-top: 163px;
            margin-left: 100px;
        }

        #notime {
            float: right;
        }

        a {
            font-size: 14px;
        }

        a:hover {
            cursor: pointer;
            color: red;
        }
    </style>
</head>
<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="<%=path%>/sys/login_view.action?view=right" target="rightFrame">首页</a></li>
        </li>
        <li><a href="<%=path%>/sys/login_view.action?view=right" target="rightFrame">工作台</a></li>
    </ul>
</div>
<c:choose>
    <c:when test="${userType==1}">
        <%@ include file="/WEB-INF/common/right_student.jsp" %>
    </c:when>
    <c:when test="${userType==2}">
        <%@ include file="/WEB-INF/common/right_teacher.jsp" %>
    </c:when>
    <c:when test="${userType==3}">
        <%@ include file="/WEB-INF/common/right_admin.jsp" %>
    </c:when>
</c:choose>
</body>

<script type="text/javascript">
    //传入从数据库中取出的日期类型数据
    function getformatdate(startTime) {
        var formate_datetime;
        if (startTime == undefined) {
            // return formate_datetime;
            return "";
        }
        var array = startTime.split(" ");
        var date = array[0];
        var time = array[1];
        var array_date = date.split("-");
        var array_time = time.split(":");
        var second = array_time[2].split(".")[0];
        formate_datetime = array_date[0] + " 年 "
            + removeZero(array_date[1]) + " 月  "
            + removeZero(array_date[2]) + " 日   "
            + removeZero(array_time[0]) + "点";
        return formate_datetime;
    }

    //去掉月、日、时、分前的0
    function removeZero(data) {
        if (data.charAt(0) == "0") {
            return data.charAt(1);
        } else {
            return data;
        }
    }


    function Todate(num) { //Fri Oct 31 18:00:00 UTC+0800 2008  Dec 29, 2017 10:29:23 PM
        num = num + "";
        var date = "";
        var month = new Array();
        month["Jan"] = 1;
        month["Feb"] = 2;
        month["Mar"] = 3;
        month["Apr"] = 4;
        month["May"] = 5;
        month["Jan"] = 6;
        month["Jul"] = 7;
        month["Aug"] = 8;
        month["Sep"] = 9;
        month["Oct"] = 10;
        month["Nov"] = 11;
        month["Dec"] = 12;
        var week = new Array();
        week["Mon"] = "一";
        week["Tue"] = "二";
        week["Wed"] = "三";
        week["Thu"] = "四";
        week["Fri"] = "五";
        week["Sat"] = "六";
        week["Sun"] = "日";

        str = num.split(" ");

        date = str[2] + "-";
        date = date + month[str[0]] + "-" + str[1].replace(/,/g, '') + " " + str[3];
        return date;
    }

    $(function () {

        loadPlanProgress();
        loadScore();
        loadNotice();
        // loadChatInfo();
        // loadGroupChat();

        /* 时间安排 */
        function loadPlanProgress() {
            $.post('<%=path%>/biz/PlanProgress_loadPlanProgressList.action', function (res) {
                var timeline = $('#planProgress');
                var result = eval('(' + res + ')');
                $.each(result, function (index, con) {

                    var timeline_li = $('<li class=\"layui-timeline-item\"> </li>');
                    var timeline_i = $('<i class=\"layui-icon layui-timeline-axis\">&#xe63f;</i>');
                    var timeline_div = $('<div class=\"layui-timeline-content layui-text\"></div>');
                    var timeline_h3 = $('<h3 class=\"layui-timeline-title\">' + con.progressName + '&nbsp;'
                        + (con.progressStart == 1 ? '<font color=\"#5FB878\" class=\"layui-btn  layui-btn-mini layui-btn-radius  layui-btn-danger\">已开始</font>'
                            : '<font color=\"#5FB878\" class=\"layui-btn  layui-btn-mini layui-btn-radius layui-btn-primary\">未开始</font>') + '</h3>');
                    var timeline_p = $('<p>&nbsp开始时间：&nbsp;' + getformatdate(con.startTime) + '<p>&nbsp;结束时间 ：&nbsp;' + getformatdate(con.endTime) + '</p>');

                    timeline_h3.appendTo(timeline_div);
                    timeline_p.appendTo(timeline_div);
                    timeline_i.appendTo(timeline_li);
                    timeline_div.appendTo(timeline_li);
                    timeline_li.appendTo(timeline);

                });
            });
        }

        /*毕业设计成绩  */
        function loadScore() {
            $.post('<%=path%>/biz/replyScore_loadReplyScoreList.action', function (res) {
                if (res === null) return;
                var scoreMenu =[
                    '开题报告',
                    '规范审查',
                    '指导教师评阅打分',
                    '评阅人评阅打分',
                    '答辩成绩',
                    '最终成绩',
                    '等级'
                ];
                var scorelist = $('#gradscore');
                var result = eval('(' + res + ')');
                if (result.replyType == 1) {
                    scorelist.find("li").each(function (index, con) {
                        var timeline_title_div = $(this).children("div").children("div");
                        switch (index) {
                            case 0:
                                timeline_title_div.html(result.openReport);
                                break;
                            case 1:
                                timeline_title_div.html(result.checkScore);
                                break;
                            case 2:
                                timeline_title_div.html(result.guideScore);
                                break;
                            case 3:
                                timeline_title_div.html(result.readScore);
                                break;
                            case 4:
                                timeline_title_div.html(result.replyScore);
                                break;
                            case 5:
                                timeline_title_div.html(result.replyScoreFinish);
                                break;
                            case 6:
                                timeline_title_div.html(result.grade);
                                break;
                        }
                    });
                }
            });
        }

        /*公告信息  */
        function loadNotice() {
            $.post('<%=path%>/sys/notice_loadNoticeList.action?newNum=16', function (res) {
                // console.log(res)
                var noticelist = $('#sysNotice');
                var result = eval('(' + res + ')');
                $.each(result, function (index, con) {
                    // var noticelist_li = $('<li onclick="openNotice(' + con.noticeId + ')" class="noli"></li>');
                    var noticelist_li = $('<li class="noli"></li>');

                    var noticeName = con.noticeName
                    if (noticeName.length > 25) {//通知名称超出用...代替
                        noticeName = noticeName.substring(0, 25) + "..."
                    }

                    var noticelist_a = $('<a id="noa" href="javascript:dialog(\'100%\',\'100%\',\'通知详情\',\'<%=path%>/sys/notice_openNotice.action?view=detail&model.noticeId=' + con.noticeId + '\', \'true\',\'0\');">&nbsp;&nbsp;' + noticeName + '</a>');
                    var dataArray = Todate(con.noticeTime).split(' ');
                    var noticelist_time = $('<span id="notime" >' + dataArray[0] + '</span>');//date.getFullYear()

                    noticelist_a.appendTo(noticelist_li);
                    noticelist_time.appendTo(noticelist_li);
                    noticelist_li.appendTo(noticelist);
                });
            });
        }


        <%--/*群聊条数  */--%>
        <%--function loadGroupChat() {--%>
        <%--    $.post('<%=path%>/biz/chatInfo_loadGroupChat.action', function (res) {--%>
        <%--        var result = eval('(' + res + ')');--%>
        <%--        if (!result.success) {--%>
        <%--            return;--%>
        <%--        } else {--%>
        <%--            var chatinfolist = $('#groupChatIl');//--%>
        <%--            var chatinfolist_img = $('<img src=\"<%=path%>/images/charqun.jpg\">');--%>
        <%--            var chatinfolist_span1 = $('<span>交流群</span>');--%>
        <%--            if (result.obj[0] > 0) {--%>
        <%--                var chatinfolist_span2 = $('<span class=\"layui-badge\">' + result.obj[0] + '</span>');--%>
        <%--                chatinfolist_span2.appendTo(chatinfolist);--%>
        <%--            } else {--%>
        <%--                // var chatinfolist_span2 = $('<font color="#5FB878" class=\"layui-btn  layui-btn-mini layui-btn-radius layui-btn-primary\"><b>' + result.obj[0] + '</b></font>');--%>
        <%--                // var chatinfolist_span2 = $('<font color="#5FB878" class=\"layui-btn  layui-btn-mini layui-btn-radius layui-btn-primary\"><b>' + result.obj[0] + '</b></font>');--%>
        <%--            }--%>
        <%--            chatinfolist_img.appendTo(chatinfolist);--%>
        <%--            chatinfolist_span1.appendTo(chatinfolist);--%>

        <%--        }--%>

        <%--    });--%>
        <%--}--%>

        <%--/* 交流互动 */--%>
        <%--function loadChatInfo() {--%>
        <%--    $.post('<%=path%>/biz/chatInfo_loadChatInfoList.action', function (res) {--%>
        <%--        var result = eval('(' + res + ')');--%>
        <%--        if (!result.success) {--%>
        <%--            return;--%>
        <%--        } else {--%>
        <%--            var thisId = result.obj[2];--%>
        <%--            var userType = result.obj[3];--%>
        <%--            if (userType == 2) {--%>
        <%--                $.each(result.obj[0], function (index, con) {--%>
        <%--                    setChatinfoItem(con.student.stuId, 1, con.student.stuName, con.student.userImg, con.student.majorName, con.classId, con.categoryId, 0);--%>
        <%--                });--%>
        <%--            } else {--%>
        <%--                var teacher = result.obj[1];--%>
        <%--                if (teacher==null)return;--%>
        <%--                setChatinfoItem(teacher.teacherId, 2, teacher.teacherName, teacher.userImg, teacher.staffName, 0, 0, teacher.technicalId);--%>
        <%--                $.each(result.obj[0], function (index, con) {--%>
        <%--                    if (con.student.stuId != thisId) {--%>
        <%--                        // console.log(con.student.majorName);--%>
        <%--                        setChatinfoItem(con.student.stuId, 1, con.student.stuName, con.student.userImg, con.student.majorName, con.classId, con.categoryId, 0);--%>
        <%--                    }--%>
        <%--                });--%>
        <%--            }--%>
        <%--        }--%>
        <%--    });--%>
        <%--}--%>

        <%--function setChatinfoItem(thisId, type, name, icon, contents, classId, categoryId, technicalId) {--%>
        <%--    var chatinfolist = $('#openpeoul');//src='+icon+'--%>
        <%--    var chatinfolist_img = $('<img src="<%=path%>/images/qq.jpg" />');--%>
        <%--    if (type == 1) {--%>
        <%--        if (classId > 0) {--%>
        <%--            var chatinfolist_span = $('<span>' + name + '</span><span class="layui-badge">' + classId + '</span>');--%>
        <%--        } else {--%>
        <%--            // var chatinfolist_span = $('<span>' + name + '</span><font color="#5FB878" class=\"layui-btn  layui-btn-mini layui-btn-radius layui-btn-primary\"><b>' + classId + '</b></font>');--%>
        <%--            var chatinfolist_span = $('<span>' + name + '</span>');--%>
        <%--        }--%>
        <%--    } else {--%>
        <%--        if (classId > 0) {--%>
        <%--            var chatinfolist_span = $('<span>' + name + '</span><span class="layui-badge">' + technicalId + '</span>');//有消息--%>
        <%--        } else {--%>
        <%--            // var chatinfolist_span = $('<span>' + name + '</span><font color="#5FB878" class=\"layui-btn  layui-btn-mini layui-btn-radius layui-btn-primary\"><b>' + technicalId + '</b></font>');//无消息--%>
        <%--            var chatinfolist_span = $('<span>' + name + '</span>');//无消息--%>
        <%--        }--%>
        <%--    }--%>
        <%--    var chatinfolist_p = $('<p>' + contents + '</p>');--%>
        <%--    var chatinfolist_span2 = $('<span class="layim-msg-status">new</span>');--%>
        <%--    var chatType = '1';//私聊标志（0-群聊，1-私聊）--%>
        <%--    var chatinfolist_li = $('<li onclick="openChat(' + thisId + ',' + type + ',' + chatType + ')" layim-event="chat" data-type="friend" data-index="0" class="layim-friend100001"></li>');--%>
        <%--    var chatinfolist_ul = $('#openpeolist');--%>
        <%--    chatinfolist_img.appendTo(chatinfolist_li);--%>
        <%--    chatinfolist_span.appendTo(chatinfolist_li);--%>
        <%--    chatinfolist_p.appendTo(chatinfolist_li);--%>
        <%--    chatinfolist_span2.appendTo(chatinfolist_li);--%>
        <%--    chatinfolist_li.appendTo(chatinfolist_ul);--%>
        <%--}--%>
    });
</script>

<script type="text/javascript">
    setWidth();
    $(window).resize(function () {
        setWidth();
    });

    function setWidth() {
        var width = ($(window).width() - $('.mainright').width() - 16);
        $('.leftinfos').width(width);

        var width = ($('.leftinfos').width() - 12) / 2;
        $('.infoleft,.inforight').width(width);
    }

    function loginOutTip() {
        layer.open({
            title: '系统提示'
            , content: '您确认退出吗？'
            , offset: ['40%', '40%']
            , btn: ['确定退出', '取消']
            , shadeClose: true
            , yes: function (index, layero) {
                //按钮【按钮一】的回调
                layer.msg('退出成功', {icon: 1})
                top.location = "<%=path%>/Userlogin_logout.action";
            }
            , btn2: function (index, layero) {
                //按钮【按钮二】的回调

                //return false 开启该代码可禁止点击该按钮关闭
            }
            , cancel: function () {
                //右上角关闭回调

                //return false 开启该代码可禁止点击该按钮关闭
            }
        });
    }

    if (!/^http(s*):\/\//.test(location.href)) {
        alert('请部署到localhost上查看该演示');
    }

    layui.use('layim', function (layim) {

        //基础配置
        layim.config({
            //初始化接口
            init: {
                url: '<%=path%>/biz/chatInfo_loadChatFriend.action'
                , data: {}
            }
            //查看群员接口
            , members: {
                url: '<%=path%>/biz/chatInfo_loadGroupMembers.action'
                , data: {
                    // id: 1//群号id
                }
            }
            //上传图片接口
            , uploadImage: {
                url: '<%=path%>/biz/chatInfo_uploadChatFile.action' //（返回的数据格式见下文）
                , type: 'post' //默认post
            }

            //上传文件接口
            , uploadFile: {
                url: '<%=path%>/biz/chatInfo_uploadChatFile.action' //（返回的数据格式见下文）
                , type: 'post' //默认post
            }
            //扩展工具栏
            , tool: [{
                alias: 'code'
                , title: '代码'
                , icon: '&#xe64e;'
            }]

            //,brief: true //是否简约模式（若开启则不显示主面板）

            //,title: 'WebIM' //自定义主面板最小化时的标题
            //,right: '100px' //主面板相对浏览器右侧距离
            //,minRight: '90px' //聊天面板最小化时相对浏览器右侧距离
            , initSkin: '4.jpg' //1-5 设置初始背景
            //,skin: ['aaa.jpg'] //新增皮肤
            //,isfriend: false //是否开启好友
            //,isgroup: false //是否开启群组
            //,min: true //是否始终最小化主面板，默认false
            , notice: true //是否开启桌面消息提醒，默认false
            //,voice: false //声音提醒，默认开启，声音文件为：default.wav

            , msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.html' //消息盒子页面地址，若不开启，剔除该项即可
            , find: layui.cache.dir + 'css/modules/layim/html/find.html' //发现页面地址，若不开启，剔除该项即可
            , chatLog: layui.cache.dir + 'css/modules/layim/html/chatlog.jsp' //聊天记录页面地址，若不开启，剔除该项即可
            <%--, chatLog: '<%=path%>/biz/chatInfo_loadChatLog.action' //聊天记录页面地址，若不开启，剔除该项即可--%>

        });

        /*
        layim.chat({
          name: '在线客服-小苍'
          ,type: 'kefu'
          ,avatar: 'http://tva3.sinaimg.cn/crop.0.0.180.180.180/7f5f6861jw1e8qgp5bmzyj2050050aa8.jpg'
          ,id: -1
        });
        layim.chat({
          name: '在线客服-心心'
          ,type: 'kefu'
          ,avatar: 'http://tva1.sinaimg.cn/crop.219.144.555.555.180/0068iARejw8esk724mra6j30rs0rstap.jpg'
          ,id: -2
        });
        layim.setChatMin();*/

        //监听在线状态的切换事件
        layim.on('online', function (data) {
            //console.log(data);
            if (data == 'online') {//TODO:上线

            }else if (data == 'hide') {//TODO:下线

            }
        });

        //监听签名修改
        layim.on('sign', function (value) {
            //console.log(value);
            $.post('<%=path%>/sys/userHelp_updateSign.action?model.sign=' + value, function (res) {
                var r = JSON.parse(res)
                if (r.code == 200){
                    layer.msg('修改成功')
                }
            });
        });

        //监听自定义工具栏点击，以添加代码为例
        layim.on('tool(code)', function (insert) {
            layer.prompt({
                title: '插入代码'
                , formType: 2
                , shade: 0
            }, function (text, index) {
                layer.close(index);
                insert('[pre class=layui-code]' + text + '[/pre]'); //将内容插入到编辑器
            });
        });

        var socket
        //监听layim建立就绪
        layim.on('ready', function (res) {

            if (!window.WebSocket) {
                window.WebSocket = window.MozWebSocket;
            }
            if (window.WebSocket) {
                socket = new WebSocket('<%=session.getAttribute(SystemContext.CHAT_SERVER_URL)%>');
                // socket = new WebSocket("ws://localhost:8888");
                // 接收到服务器发回消息
                socket.onmessage = function (event) {
                    var json = JSON.parse(event.data);
                    if (json.code == 200) {
                        var type = json.data.type;
                        console.log("收到一条新信息，类型为：" + type);
                        switch (type) {
                            case "REGISTER":
                                //初始化消息列表
                                ws.initMessagePage(json);
                                break;
                            case "SINGLE_SENDING":
                                ws.singleReceive(json);
                                break;
                            case "GROUP_SENDING":
                                ws.groupReceive(json);
                                break;
                            default:
                                console.log("不正确的类型！");
                        }
                    } else {
                        layer.msg(json.msg);
                        console.log(json.msg);
                    }
                };
                // 连接成功1秒后，将用户信息注册到服务器在线用户表
                socket.onopen = setTimeout(function (event) {
                    if (socket.readyState == WebSocket.OPEN) {
                        var data = {
                            "userId": "REGISTER",
                            "type": "REGISTER",
                            "username": "<%=session.getAttribute(SystemContext.LOGINNAME) %>"
                        };
                        socket.send(JSON.stringify(data));
                    } else {
                        layer.alert("Websocket连接没有开启！");
                    }
                }, 1000)
                // 关闭连接
                socket.onclose = function (event) {
                    console.log("WebSocket已关闭");
                };
            } else {
                layer.error("您的浏览器不支持WebSocket,无法使用聊天功能!");
            }


            var ws = {
                register: function () {
                    if (!window.WebSocket) {
                        return;
                    }
                    if (socket.readyState == WebSocket.OPEN) {
                        var data = {
                            "userId": userId,
                            "type": "REGISTER"
                        };
                        socket.send(JSON.stringify(data));
                    } else {
                        layer.alert("Websocket连接没有开启！");
                    }
                },
                //初始化聊天面板
                initMessagePage: function (json) {
                    //console.log('init:'+JSON.stringify(json))
                    //私聊消息
                    json.data.data.forEach(function (value, index, array) {
                        layim.getMessage({
                            username: value.senderName //消息来源用户名
                            , avatar: value.avatar //消息来源用户头像
                            , id: value.senderId //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
                            , type: "friend" //聊天窗口来源类型，从发送消息传递的to里面获取
                            , content: value.senderContent //消息内容
                            , cid: 0 //消息id，可不传。除非你要对消息进行一些操作（如撤回）
                            , mine: false //是否我发送的消息，如果为true，则会显示在右方
                            , fromid: value.senderId //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题
                            , timestamp: value.sendTime //服务端时间戳毫秒数。注意：如果你返回的是标准的 unix 时间戳，记得要 *1000
                        });
                    })
                    //群聊消息
                    json.data.group.forEach(function (value, index, array) {
                        // console.log(value)
                        layim.getMessage({
                            username: value.senderName //消息来源用户名
                            , avatar: value.avatar //消息来源用户头像
                            , id: value.answerId //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
                            , type: "group" //聊天窗口来源类型，从发送消息传递的to里面获取
                            , content: value.senderContent //消息内容
                            , cid: 0 //消息id，可不传。除非你要对消息进行一些操作（如撤回）
                            , mine: false //是否我发送的消息，如果为true，则会显示在右方
                            , fromid: value.senderId //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题
                            , timestamp: value.sendTime //服务端时间戳毫秒数。注意：如果你返回的是标准的 unix 时间戳，记得要 *1000
                        });
                    })
                },
                //接收私聊消息
                singleReceive: function (res) {
                    //私聊消息
                    layim.getMessage({
                        username: res.data.data.senderName //消息来源用户名
                        , avatar: res.data.data.avatar //消息来源用户头像
                        , id: res.data.data.senderId //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
                        , type: "friend" //聊天窗口来源类型，从发送消息传递的to里面获取
                        , content: res.data.data.senderContent //消息内容
                        , cid: 0 //消息id，可不传。除非你要对消息进行一些操作（如撤回）
                        , mine: false //是否我发送的消息，如果为true，则会显示在右方
                        , fromid: res.data.data.senderId //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题
                        , timestamp: res.data.data.sendTime //服务端时间戳毫秒数。注意：如果你返回的是标准的 unix 时间戳，记得要 *1000
                    });
                    //调用已读接口
                    var data = {
                        "type": "READ_CHAT",
                        "answer-id": "<%=session.getAttribute(SystemContext.USERID) %>",
                        "chat-type": "SINGLE_CHAT",
                        "send-id": res.data.data.senderId
                    };
                    socket.send(JSON.stringify(data))
                },
                //接收群聊消息
                groupReceive: function (res) {
                    //console.log('group chat message:'+JSON.stringify(res))
                    layim.getMessage({
                        username: res.data.data.senderName //消息来源用户名
                        , avatar: res.data.data.avatar //消息来源用户头像
                        , id: res.data.data.answerId //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
                        , type: "group" //聊天窗口来源类型，从发送消息传递的to里面获取
                        , content: res.data.data.senderContent //消息内容
                        , cid: 0 //消息id，可不传。除非你要对消息进行一些操作（如撤回）
                        , mine: false //是否我发送的消息，如果为true，则会显示在右方
                        , fromid: res.data.data.senderId //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题
                        , timestamp: res.data.data.sendTime //服务端时间戳毫秒数。注意：如果你返回的是标准的 unix 时间戳，记得要 *1000
                    });
                    //调用已读接口
                    var data = {
                        "type": "READ_CHAT",
                        "answer-id": "<%=session.getAttribute(SystemContext.USERID) %>",
                        "chat-type": "GROUP_CHAT",
                        "group-id": res.data.data.answerId
                    };
                    socket.send(JSON.stringify(data))
                }
            }
            //console.log(res.mine);

            // layim.msgbox(5); //模拟消息盒子有新消息，实际使用时，一般是动态获得

            //添加好友（如果检测到该socket）
            // layim.addList({
            //     type: 'group'
            //     ,avatar: "http://tva3.sinaimg.cn/crop.64.106.361.361.50/7181dbb3jw8evfbtem8edj20ci0dpq3a.jpg"
            //     ,groupname: 'Angular开发'
            //     ,id: "12333333"
            //     ,members: 0
            // });
            // layim.addList({
            //     type: 'friend'
            //     ,avatar: "http://tp2.sinaimg.cn/2386568184/180/40050524279/0"
            //     ,username: '冲田杏梨'
            //     ,groupid: 2
            //     ,id: "1233333312121212"
            //     ,remark: "本人冲田杏梨将结束AV女优的工作"
            // });

            // setTimeout(function(){
            //     //接受消息（如果检测到该socket）
            //     layim.getMessage({
            //         username: "Hi"
            //         ,avatar: "http://qzapp.qlogo.cn/qzapp/100280987/56ADC83E78CEC046F8DF2C5D0DD63CDE/100"
            //         ,id: "10000111"
            //         ,type: "friend"
            //         ,content: "临时："+ new Date().getTime()
            //     });

            /*layim.getMessage({
              username: "贤心"
              ,avatar: "http://tp1.sinaimg.cn/1571889140/180/40030060651/1"
              ,id: "100001"
              ,type: "friend"
              ,content: "嗨，你好！欢迎体验LayIM。演示标记："+ new Date().getTime()
            });*/

            // }, 3000);


        });

        //监听发送消息
        layim.on('sendMessage', function (data) {

            //判断是否已经离线
            // if (socket.readyState == WebSocket.OPEN) {

                var To = data.to;

                //console.log('监听发送消息：' + JSON.stringify(data.to));

                var sendData
                if (To.type === 'friend') {//私聊
                    sendData = {
                        "type": "SINGLE_SENDING",//发送消息类型
                        "send_id": data.mine.id.toString(),//发送者id
                        "send_name": data.mine.username,//发送者名称
                        "chat_content": data.mine.content,//消息内容
                        "answer_id": data.to.id.toString(),//接收者id
                        "answer_name": data.to.username,//接收者姓名
                        "chat_type": "0",//消息类型:０私聊，１群聊
                        "content_type": "0"//消息内容，文件，图片，文本
                    }
                }
                if (To.type === 'group') {//群聊
                    sendData = {
                        "type": "GROUP_SENDING",//发送消息类型
                        "send_id": data.mine.id.toString(),//发送者id
                        "send_name": data.mine.username,//发送者名称
                        "chat_content": data.mine.content,//消息内容
                        "answer_id": data.to.id.toString(),//接收者id
                        "answer_name": data.to.username,//接收者姓名
                        "chat_type": "1",//消息类型:０私聊，１群聊
                        "content_type": "0"//消息内容，文件，图片，文本
                    }
                }

                socket.send(JSON.stringify(sendData));
            // }else {
            //     layer.msg('你已经断开连接，请刷新重新连接')
            //     return
            // }
            // if(To.type === 'friend'){
            //     layim.setChatStatus('<span style="color:#FF5722;">对方正在输入。。。</span>');
            // }

            //演示自动回复
            // setTimeout(function () {
            //     var obj = {};
            //     if (To.type === 'group') {
            //         obj = {
            //             username: '模拟群员' + (Math.random() * 100 | 0)
            //             , avatar: layui.cache.dir + 'images/face/' + (Math.random() * 72 | 0) + '.gif'
            //             , id: To.id
            //             , type: To.type
            //             , content: autoReplay[Math.random() * 9 | 0]
            //         }
            //     } else {
            //         obj = {
            //             username: To.name
            //             , avatar: To.avatar
            //             , id: To.id
            //             , type: To.type
            //             , content: autoReplay[Math.random() * 9 | 0]
            //         }
            //         layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
            //     }
            //     layim.getMessage(obj);
            // }, 1000);
        });

        //监听查看群员
        layim.on('members', function (data) {
            //console.log(data);
        });

        //监听聊天窗口的切换
        layim.on('chatChange', function (res) {
            var type = res.data.type;
            // console.log('监听聊天窗口的切换' + JSON.stringify(res))
            //一旦打开聊天面板就标记为已读
            var data

            if (type === 'friend') {
                //模拟标注好友状态
                //layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
                data = {
                    "type": "READ_CHAT",
                    "answer-id": "<%=session.getAttribute(SystemContext.USERID) %>",
                    "chat-type": "SINGLE_CHAT",
                    "send-id": res.data.id
                };

            } else if (type === 'group') {
                //模拟系统消息
                <%--layim.getMessage({--%>
                <%--    system: true--%>
                <%--    , id: res.data.id--%>
                <%--    , type: "group"--%>
                <%--    , content: "<%=session.getAttribute(SystemContext.USERNAME) %>" + '加入群聊'--%>
                <%--});--%>
                data = {
                    "type": "READ_CHAT",
                    "answer-id": "<%=session.getAttribute(SystemContext.USERID) %>",
                    "chat-type": "GROUP_CHAT",
                    "group-id": res.data.id
                };
            }
            // layer.alert(JSON.stringify(data))
            socket.send(JSON.stringify(data));
        });
        // layim.setFriendStatus(11111, 'online'); //设置指定好友在线，即头像取消置灰
        // layim.setFriendStatus(11111, 'offline'); //设置指定好友在线，即头像置灰


    });

</script>
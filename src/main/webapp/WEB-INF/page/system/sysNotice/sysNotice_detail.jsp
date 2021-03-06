<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>添加通知</title>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/newStyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css" type="text/css" />

<script type="text/javascript" src="<%=path%>/third/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=path%>/third/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/third/layui/layui.js"></script>
<style type="text/css">
    .outer-container,.content {
        width: 100%; height: calc(100vh);
    }
    .outer-container {
        position: relative;
        overflow: hidden;
    }
    .inner-container {
        /*position: absolute; */
        left: 0;
        overflow-x: hidden;
        overflow-y: scroll;
    }

    /* for Chrome */
    .inner-container::-webkit-scrollbar {
        display: none;
    }
</style>

</head>
<body style="min-width: 200px">
<div class="outer-container">
    <div class="inner-container">
        <div class="content">

            <div align="center">
                <table>
                    <tr>
                        <td valign="top" align="left">
                            <table border="0" width="100%" cellspacing="0" cellpadding="10">
                                <tbody>
                                <tr>
                                    <td style="font-size: 14pt; font-weight: bold" align="center" valign="bottom" height="80">
                                        ${model.noticeName}
                                        <%--关于信息与电子工程学院毕业设计的通知--%>
                                        <hr size="1" width="96%">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" style="font-size: 9pt" valign="top" height="36">
                                        <%--公告来源：学院通知&nbsp;&nbsp;发布日期：2017-09-29--%>
                                        公告来源：${sysDepartment.deptName}&nbsp;&nbsp;发布日期：${model.noticeTime}
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <p style="text-align:center;" align="center">&nbsp;</p>
                                        <p style="text-align:center;" align="center">&nbsp;</p>
                                        <p style="text-indent:33pt;margin: 5% 5%;margin-top: 10px;margin-bottom: 5px">
                                        <span style="font-size:18px;font-family:宋体;line-height:2;">
                                            <span style="font-size:18px;line-height:2;">
                                                <%--全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：全校师生员工：--%>
                                                ${model.noticeContent}
                                            </span>
                                        </span>
                                        </p>

                                        <p style="text-indent:33pt;"></p>
                                        <p style="text-indent:33pt;"></p>
                                        <%--                                    <p style="text-indent:465pt;">--%>
                                        <%--                                        <span style="font-size:18px;font-family:宋体;line-height:2;">--%>
                                        <%--                                            <span style="font-size:18px;line-height:2;">学院通知</span>--%>
                                        <%--                                            <span style="font-size:18px;line-height:2;" >${sysDepartment.deptName}</span>--%>
                                        <%--                                        </span>--%>
                                        <%--                                    </p>--%>
                                        <p style="text-indent:450pt;padding-right: 50px" align="right">
                                        <span style="font-size:26pt;font-family:宋体;">
                                        <span style="font-size:18px;line-height:2;">
                                            <span style="font-size:18px;line-height:2;" >${sysDepartment.deptName}</span>
                                        <s:property value="%{getText('{0,date,yyyy-MM-dd}',{model.noticeTime})}"></s:property>
                                        </span>
                                        </span>
                                        </p>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>


</body>
</html>

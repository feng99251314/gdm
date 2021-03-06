<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/common/common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>修改开题报告</title>
    <meta http-equiv=Content-Type content="text/html; charset=utf-8">
    <link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/css/newStyle.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="<%=path%>/third/ueditor/themes/default/css/ueditor.css" type="text/css"/>

    <script type="text/javascript" src="<%=path%>/third/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=path%>/third/jquery.validate.js"></script>
    <script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>
    <script type="text/javascript" src="<%=path%>/third/layui/layui.js"></script>
    <script type="text/javascript" src="<%=path%>/third/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="<%=path%>/third/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.idTabs.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/core/dialog/dialog.js"></script>
    <script type="text/javascript" src="<%=path%>/js/core/dialog/enable.js"></script>
    <script type="text/javascript" src="<%=path%>/datePicket/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=path%>/js/select-ui.min.js"></script>


    <script type="text/javascript">

        $(function () {

            $("#form1").validate({
                errorClass: "errorInfo", //默认为错误的样式类为：error
                errorElement: "em",
                focusInvalid: false, //当为false时，验证无效时，没有焦点响应
                onkeyup: false,
                submitHandler: function (form) {   //表单提交句柄,为一回调函数，带一个参数：form
                    // if (confirm("是否要保存信息？")) {
                        form.submit();   //提交表单
                        // var index = layer.load(2, {time: 10 * 1000}); //又换了种风格，并且设定最长等待10秒
                    // }
                },
                rules: {},
                messages: {},
                errorPlacement: function (error, element) { //错误信息位置设置方法
                    error.appendTo(element.parent()); //这里的element是录入数据的对象
                }
            });
        });

        $(function () {
            var flag = "${mark}";
            if (flag != '' && flag != undefined) {
                if (flag == "1") {
                    layer.msg('保存成功', {icon: 1});
                    setTimeout(function () {
                    }, 500);
                } else if (flag == "0") {
                    layer.msg('保存失败', {icon: 2});
                }
            }
        });

        function getData() {
            $("#background").val(getBackground());
            $("#reportContent").val(getReportContent());
            $("#reportMethod").val(getReportMethod());
            $("#reportDocument").val(getReportDocument());
        }

        layui.use('form', function () {
            // var form = layui.form();
            var form = layui.form;
        });
    </script>

    <script type="text/javascript">
        $("#usual1 ul").idTabs();

        //搜索
        function openSearch(name) {
            // $("#form1").submit();
        }
    </script>

    <style type="text/css">
        .rightText {
            text-align: right;
            width: 120px;;
        }

        td {
            padding: 4px;
            font-size: 14px;
            font-size: 14px;
            border: 1px solid #C1DAD7;
        }

        .inputfrom {
            width: 78%;
            height: 40px;
            border: 1px solid #C1DAD7;
            font-size: 14px;
        }

        .title {
            height: 40px;
        }

        .warn {
            color: red;
            font-size: 25px;
        }
    </style>
</head>
<body style="min-width: 200px;">
<%--http://localhost:8080/gdm_war_exploded/biz/openReport_openEdit.action?view=edit&=3448&thisId=8--%>
<form id="forms" name="forms" action="<%=path%>/biz/openReport_openEdit.action?view=edit&thisYear=${thisYear}&tabFlag=02&flag=04&thisStuId=${thisStuId}&page=${pageResult.page}" method="post">
    <div class="place">
        <ul class="placeul">
            <li><span>院系：</span>${deptName }</li>
            <li>当前年度：
                <input class="dfinput" type="text"
                       id="issueInfo.year" name="thisYear" readonly value="${thisYear}"
                       style="text-align: center;"
                       onClick="WdatePicker({dateFmt:'yyyy'});"></td>
            </li>
            <li class="click">
                <a href="javascript:void(0);" onclick="openSearch(this);"><img src="<%=path%>/images/search.png"/>搜索</a>
            </li>
        </ul>
    </div>
</form>

<div class="formbody">
    <div id="usual1" class="usual">
<%--        <%@ include file="/WEB-INF/page/business/materialInfo/select_tab.jsp" %>--%>
        <div id="tab2" class="tabson">

            <div class="rightinfo" style="text-align: center;">
                <fieldset class="layui-elem-field">
                    <legend>修改开题报告</legend>
                    <div class="layui-field-box">
                        <div class="formtitle">
                            <ul>
                                <%-- <li class="line">
                                    <a href="<%= basePath%>/biz/openReport_uploadOpenReport.action?thisId=${model.reportId }">
                                    <font> <img src="<%=path%>/images/ico04.png" width="20px" />论文上传</font></a>
                                </li> --%>
                                <li class="line"><a
                                        href="<%=path%>/biz/openReport_outOpenReport.action?thisId=${model.reportId }">
                                    <font> <img src="<%=path%>/images/i01.png" width="20px"/>一键导出</font></a></li>
                            </ul>
                        </div>
<%--                        <form action="<%=path%>/biz/openReport_edit.action?view=detail" method="post" name="form1" id="form1">--%>
                            <form action="<%=path%>/biz/openReport_edit.action?view=edit" method="post" name="form1" id="form1">
                            <input name="thisStuId" type="hidden" value="${thisStuId }">
                            <input type="hidden" name="thisId" value="${thisId }">
                            <input type="hidden" name="thisYear" value="${thisYear }">
                            <ul>
                                <li>
                                    <table border="10" cellspacing="0" cellpadding="0" width="980px"
                                           style="width: 65%;margin:auto"
                                    >
                                        <tr class="title">
                                            <td class="rightText">学院：</td>
                                            <td>${student.deptName }
                                            </td>
                                            <td class="rightText">专业：</td>
                                            <td>
                                                ${student.majorName }
                                            </td>
                                            <td class="rightText">班级：</td>
                                            <td>
                                                ${student.className }
                                                </select>
                                            </td>
                                        </tr>

                                        <tr class="title">
                                            <td class="rightText">学号：</td>
                                            <td>${student.stuNo }</td>
                                            <td class="rightText">姓名：</td>
                                            <td>${student.stuName }</td>
                                            <td class="rightText">指导 老师：</td>
                                            <td>${teacher.teacherName }</td>
                                        </tr>
                                        <tr class="title">
                                            <td class="rightText">题目：</td>
                                            <td colspan="10">
                                                ${issueInfo.issueName }
                                        </tr>
                                        <tr class="title">
                                            <td class="rightText" align="left">是否进入答辩环节：</td>
                                            <td colspan="10" id="replyLink">
                                                <s:if test="#session.userType==1">
                                                    <s:select disabled="true" cssClass="dfinput" list="#{0:'未审核',1:'是',2:'否'}"
                                                              listKey="key" listValue="value" value="model.replyLink"
                                                              id="model.replyLink" name="model.replyLink"/>
                                                </s:if>
                                                <s:if test="#session.userType==2">
                                                    <s:select cssClass="dfinput" list="#{0:'未审核',1:'是',2:'否'}"
                                                              listKey="key" listValue="value" value="model.replyLink"
                                                              name="model.replyLink"/>
                                                </s:if>
                                            </td>
                                        </tr>
                                        <tr>
                                        <tr class="title">
                                            <td colspan="10" style="padding-top: 40px;">课题研究的背景及意义：</td>
                                        </tr>
                                        <tr>
                                            <td colspan="10">
                                                <div id="backgroundEditor"></div>
                                                <script type="text/javascript">
                                                    var background = UE.getEditor('backgroundEditor');
                                                    background.ready(function () {
                                                        background.setContent('${model.background}');
                                                    });

                                                    function getBackground() {
                                                        return background.getContent();
                                                    }
                                                </script>
                                                <input type="hidden" name="model.background" id="background">
                                            </td>
                                        </tr>

                                        <tr class="title">
                                            <td colspan="10" style="padding-top: 40px;">毕业论文研究内容、拟解决的主要问题：</td>
                                        </tr>
                                        <tr>
                                            <td colspan="10">
                                                <div id="reportContentEditor"></div>
                                                <script type="text/javascript">
                                                    var reportContent = UE.getEditor('reportContentEditor');
                                                    reportContent.ready(function () {
                                                        reportContent.setContent('${model.reportContent}');
                                                    });

                                                    function getReportContent() {
                                                        return reportContent.getContent();
                                                    }
                                                </script>
                                                <input type="hidden" name="model.reportContent" id="reportContent">
                                            </td>
                                        </tr>
                                        <tr class="title">
                                            <td colspan="10" style="padding-top: 40px;">论文研究方法、步骤及措施：</td>
                                        </tr>
                                        <tr>
                                            <td colspan="10">
                                                <div id="reportMethodEditor"></div>
                                                <script type="text/javascript">
                                                    var reportMethod = UE.getEditor('reportMethodEditor');
                                                    reportMethod.ready(function () {
                                                        reportMethod.setContent('${model.reportMethod}');
                                                    });

                                                    function getReportMethod() {
                                                        return reportMethod.getContent();
                                                    }
                                                </script>
                                                <input type="hidden" name="model.reportMethod" id="reportMethod">
                                            </td>
                                        </tr>
                                        <tr class="title">
                                            <td colspan="10" style="padding-top: 40px;">主要参考文献：</td>
                                        </tr>
                                        <tr>
                                            <td colspan="10">
                                                <div id="reportDocumentEditor"></div>
                                                <script type="text/javascript">
                                                    var reportDocument = UE.getEditor('reportDocumentEditor');
                                                    reportDocument.ready(function () {
                                                        reportDocument.setContent('${model.reportDocument}');
                                                    });

                                                    function getReportDocument() {
                                                        return reportDocument.getContent();
                                                    }
                                                </script>
                                                <input type="hidden" name="model.reportDocument" id="reportDocument">
                                            </td>
                                        </tr>
                                    </table>
                                <li>
                                    <div style="text-align: center;">
                                        <input name="" type="submit" class="scbtn" value="提交" onClick="getData();"/>
                                    </div>
                                </li>
                            </ul>
                        </form>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
</body>
</html>

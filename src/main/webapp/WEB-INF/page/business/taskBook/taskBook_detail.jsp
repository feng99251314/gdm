<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>任务书详情</title>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/newStyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css" type="text/css" />
<link rel="stylesheet" href="<%=path%>/third/ueditor/themes/default/css/ueditor.css" type="text/css" />

<script type="text/javascript" src="<%=path%>/third/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=path%>/third/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=path%>/third/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="<%=path%>/third/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/third/layui/layui.js"></script>

<script type="text/javascript">
	$(function() {
		var flag = "${mark}";
		if (flag != '' && flag != undefined) {
			if (flag == "1") {
				layer.msg('保存成功', {
					icon : 1
				});
				setTimeout(function() {
					parent.location.reload();
				}, 1000);
			} else if (flag == "0") {
				layer.msg('保存失败', {
					icon : 2
				});
			}
		}
	});

</script>
<style type="text/css">
.rightText {text-align: right;width: 120px;;}
td {padding: 4px;font-size: 14px;font-size: 14px;border: 1px  solid #C1DAD7;}
.inputfrom{width: 78%;height: 40px;border: 1px  solid #C1DAD7;font-size: 14px;}
.title{height: 40px;}
.warn{color: red;font-size: 25px;}
</style>
</head>
<body style="min-width: 200px;">

    <form id="form1" name="form1"  action="<%=path%>/biz/issueInfo_info.action?view=info&page=${pageResult.page}" method="post">
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
	        		<a href="javascript:void();"  onclick="openSearch(this);"><img src="<%=path%>/images/search.png"  />搜索</a>
				</li> 
		</ul>
		</div>
     </form>

    <div class="formbody">
      <div id="usual1" class="usual"> 
   <div id="tab2" class="tabson">

   <div class="rightinfo" style="text-align: center;">
	<fieldset class="layui-elem-field">
    <legend>任务书</legend>	
    <div class="layui-field-box" >
    		<div class="formtitle" >
			<ul>
			    <%-- <li class="line">
				    <a href="<%= basePath%>/biz/taskBook_uploadTaskBook.action?thisId=${model.taskId }">
				    <font> <img src="<%=path%>/images/ico04.png" width="20px" />论文上传</font></a>
				</li> --%>
				<li class="line"> <a href="<%=path%>/biz/taskBook_outTaskBook.action?thisId=${model.taskId }">
				<font> <img src="<%=path%>/images/i01.png" width="20px" />一键导出</font></a></li>
			</ul>
		</div>
			<ul>
				<li>
					<table  border="10" cellspacing="0" cellpadding="0" width="980px" style="width: 65%;margin:auto"
						>
						<tr  class="title">
						<td  class="rightText" >学院：</td>
							<td >${student.deptName } 
               	         </td>
               	         <td  class="rightText" >专业：</td>
							<td > 
               	        		${student.majorName }
               	        	 </td>
							 <td  class="rightText" >班级：</td>
							 <td>
               	        		${student.className }
               	        		 </select>
               	        		 </td>
						</tr>
						
						<tr class="title">
							<td  class="rightText">学号：</td>
							<td >${student.stuNo }</td>
							<td  class="rightText" >姓名：</td>
							<td >${student.stuName }</td>
							<td  class="rightText" >指导 老师：</td>
							<td >${teacher.teacherName }</td>
						</tr> 
						<tr class="title" >
							<td  class="rightText">题目：</td>
							<td colspan="10">
							${issueInfo.issueName }
        		  		   </td>
        		  			</tr>
						
						<tr >
						<tr class="title">
							<td colspan="10" style="padding-top: 40px;">一、论文的内容和要求：</td>
						</tr>
						<tr>
						<td colspan="10">
							<div id="contextEditor"></div>
                            <script type="text/javascript">
                            var context =  UE.getEditor('contextEditor'); 
                            context.ready(function() {
                            	context.setContent('${model.taskContent}');
                            });
                               function getCon(){return  context.getContent(); }
                              </script>
                              <input type="hidden" name="model.taskContent" id="taskContent">
							</td>
							</tr>
				
				     <tr class="title">
							<td colspan="10"  style="padding-top: 40px;">二、进度计划与应完成的工作：</td>
						</tr>
						<tr >
						<td colspan="10" >
							<div id="planEditor"></div>
                            <script type="text/javascript">
                            var plan = UE.getEditor('planEditor');
                            plan.ready(function() {
                            	plan.setContent('${model.taskPlanJob}');
                            });
                            function getPlan(){return  plan.getContent(); }
                              </script>
                              <input type="hidden" name="model.taskPlanJob" id="taskPlanJob">
							</td>
						</tr>
				       <tr class="title">
							<td colspan="10"  style="padding-top: 40px;">三、主要参考文献、资料：（标明）</td>
						</tr>
						<tr>
						<td colspan="10" >
							<div id="taskDocumentEditor"></div>
                            <script type="text/javascript">
                             var docue =UE.getEditor('taskDocumentEditor'); 
                             docue.ready(function() {
                            	 docue.setContent('${model.taskDocument}');
                             });
                               function getDocue(){return  docue.getContent(); }
                              </script>
							<input type="hidden" name="model.taskDocument" id="taskDocument">
							</td>
						</tr>
					</table>
			</ul>
  </div>
</fieldset>
	</div>
   </div>
  </div>
</body>
</html>

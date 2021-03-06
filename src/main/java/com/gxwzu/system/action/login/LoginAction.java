package com.gxwzu.system.action.login;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.gxwzu.business.model.openReport.OpenReport;
import com.gxwzu.business.model.paln.PlanYear;
import com.gxwzu.business.service.chatInfo.IChatInfoService;
import com.gxwzu.business.service.openReport.IOpenReportSerivce;
import com.gxwzu.business.service.plan.IPlanYearSerivce;
import com.gxwzu.business.service.replyScore.IReplyScoreSerivce;
import com.gxwzu.business.service.review.IReviewSerivce;
import com.gxwzu.config.WebConfig;
import com.gxwzu.sysVO.ListReplyScore;
import com.gxwzu.sysVO.ListReview;
import com.gxwzu.system.model.sysStudent.SysStudent;
import com.gxwzu.system.model.sysTeacher.SysTeacher;
import com.gxwzu.system.service.sysStudent.ISysStudentService;
import com.gxwzu.system.service.sysTeacher.ISysTeacherService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextImpl;

import com.gxwzu.core.context.SystemContext;
import com.gxwzu.core.util.SysConstant;
import com.gxwzu.core.web.action.BaseAction;
import com.gxwzu.system.model.sysMenu.SysMenu;
import com.gxwzu.system.model.userHelp.UserHelp;
import com.gxwzu.system.service.login.ILoginService;
import com.gxwzu.system.service.sysMenu.ISysMenuService;
import com.gxwzu.system.service.userHelp.IUserHelpService;
import org.springframework.stereotype.Component;

@Component
public class LoginAction extends BaseAction {

    private static final long serialVersionUID = -2874663229964813880L;

    protected final Log logger = LogFactory.getLog(getClass());

    private static final String VIEW = "view";

    /*********************** 注入Service ******************************/
    @Autowired
    private IUserHelpService userHelpService;
    @Autowired
    private ISysMenuService sysMenuService;
    @Autowired
    private IOpenReportSerivce iOpenReportSerivce;//开题报告
    @Autowired
    private ISysStudentService iSysStudentService;//学生
    @Autowired
    private ISysTeacherService iSysTeacherService;//教师
    @Autowired
    private IReviewSerivce iReviewSerivce;//评阅：评阅审查表类型：00 指导老师评阅 01评阅人评阅 02指导老师审查
    @Autowired
    private IReplyScoreSerivce iReplyScoreSerivce;//成绩
    @Autowired
    private IPlanYearSerivce iPlanYearSerivce;
    @Autowired
    private WebConfig webConfig;


    /*********************** 参数列表 ******************************/
    private List<SysMenu> menuList = new ArrayList<SysMenu>(); //左侧菜单
    private OpenReport openReport = new OpenReport();// 开题报告
    private ListReview normativeReview = new ListReview();//审查规范
    private ListReview teacherReview = new ListReview();//指导老师评阅
    private ListReview reviewerReview = new ListReview();//评阅人评阅
    private ListReplyScore studentScore = new ListReplyScore();//学生成绩
    private Integer chatCount;

    /************************** 方法类Start **************************/
    /**
     * 安全框架登录
     */
    @Override
    public String execute() throws Exception {

        HttpServletRequest request = ServletActionContext.getRequest();
        SecurityContextImpl securityContextImpl = (SecurityContextImpl) request.getSession().getAttribute(SystemContext.SPRING_SECURITY_CONTEXT);
        if (securityContextImpl != null) {
            String name = securityContextImpl.getAuthentication().getName();
            UserHelp user = new UserHelp();
            user.setLoginName(name);
            List<UserHelp> listAdmin = userHelpService.findByExample(user);
            if (listAdmin.size() > 0) {
                logger.info("用户登录："+name);
                UserHelp userHelp = listAdmin.get(0);
                // 用户id
                getSession().setAttribute(SystemContext.USERID, userHelp.getId());
                // 用户姓名
                getSession().setAttribute(SystemContext.USERNAME, userHelp.getUserName());
                // 用户登录名
                getSession().setAttribute(SystemContext.LOGINNAME, userHelp.getLoginName());
                // 用户类型
                getSession().setAttribute(SystemContext.USERTYPE, userHelp.getUserType());
                //
                getSession().setAttribute(SysConstant.GRANT, SysConstant.GRANT);
                // chat server url
                getSession().setAttribute(SystemContext.CHAT_SERVER_URL, webConfig.getChatServerUrlAndPort());
            }
        }
        return SUCCESS;
    }

    /**
     * 错误提示
     *
     * @param loginName 登陆账号
     * @param password  密码
     * @param errorInfo 错误提示信息
     * @return
     */
    @SuppressWarnings("unused")
    private String errorHint(String loginName, String password, String errorInfo) {
        getRequest().setAttribute("LoginName", loginName);
        getRequest().setAttribute("Password", password);
        getRequest().setAttribute("errorInfo", errorInfo);
        return LOGOUT;
    }

    /**
     * 系统页面跳转
     *
     * @return
     * @throws Exception
     */
    public String view() throws Exception {

        Object currentUserId = getSession().getAttribute(SystemContext.USERID);
        Object currentUserType = getSession().getAttribute(SystemContext.USERTYPE);
        PlanYear planYear = iPlanYearSerivce.findPlanYear();

        if (null != currentUserId) {
            if ("left".equals(view))menuList = sysMenuService.findByExample(new SysMenu());
            //学生
            if (currentUserType.equals(SystemContext.USER_STUDENT_TYPE)) {
                SysStudent student = iSysStudentService.findByUserId((Integer) currentUserId);
                //开题报告:
                openReport = iOpenReportSerivce.findByStuIdAndYear(student.getStuId(), planYear.getYear());
                logger.info("openReport:"+openReport);
                //规范审查
                normativeReview = iReviewSerivce.findByStuIdAndReviewTypeAndYear(student.getStuId(), SystemContext.REVIEW_TYPE_CHECK, planYear.getYear());
                logger.info("normativeReview:"+normativeReview);
                //指导教师评阅打分
                teacherReview = iReviewSerivce.findByStuIdAndReviewTypeAndYear(student.getStuId(),SystemContext.REVIEW_TYPE_TEACHER,planYear.getYear());
                logger.info("teacherReview:"+teacherReview);
                //评阅人评阅打分
                reviewerReview = iReviewSerivce.findByStuIdAndReviewTypeAndYear(student.getStuId(),SystemContext.REVIEW_TYPE_REVIEWER,planYear.getYear());
                logger.info("reviewReview:"+reviewerReview);
                //答辩成绩//最终成绩//等级
                studentScore = iReplyScoreSerivce.findByStuIdAndReplyTypeAndYear(student.getStuId(),SystemContext.REPLY_TYPE_SMALL_GROUP,planYear.getYear());
                logger.info("studentScore:"+studentScore);
            }
            return VIEW;
        } else {
            return ERROR;
        }
    }

    public String toIndex() {
        return "toIndex";
    }

    /**
     * 检查用户是否存在
     */
    public void checkLoginName(){
        logger.info("检查用户是否存在");
        try {
            boolean idTrue = false;
            PrintWriter out = getResponse().getWriter();
            //查询
            List<UserHelp> exist = userHelpService.findByLoginName(getParameters("LoginName"));
            if (null != exist && exist.size() > 0) {// 不可用
                idTrue = true;
            }
            out.print(idTrue);
            out.flush();
            out.close();
        } catch (Exception e) {
            logger.info("检查用户出错");
        }
    }

    /**
     * 退出
     *
     * @return
     * @throws Exception
     * @log：1.创建方法（liqing）
     */
    public String logout() throws Exception {
        getSession().removeAttribute(SystemContext.USERID); // 用户ID
        getSession().removeAttribute(SystemContext.USERNAME); // 用户姓名
        getSession().removeAttribute(SystemContext.LOGINNAME); // 用户登录名
        getSession().removeAttribute(SystemContext.USERTYPE); // 用户电话号码
        getSession().removeAttribute(SysConstant.GRANT);
        return LOGOUT;
    }
    /************************** 方法类End **************************/


    /**************** 参数的getter和setter方法Start ****************/
    public List<SysMenu> getMenuList() {
        return menuList;
    }

    public void setMenuList(List<SysMenu> menuList) {
        this.menuList = menuList;
    }

    public OpenReport getOpenReport() {
        return openReport;
    }

    public void setOpenReport(OpenReport openReport) {
        this.openReport = openReport;
    }

    public ListReview getNormativeReview() {
        return normativeReview;
    }

    public void setNormativeReview(ListReview normativeReview) {
        this.normativeReview = normativeReview;
    }

    public ListReview getTeacherReview() {
        return teacherReview;
    }

    public void setTeacherReview(ListReview teacherReview) {
        this.teacherReview = teacherReview;
    }

    public ListReview getReviewerReview() {
        return reviewerReview;
    }

    public void setReviewerReview(ListReview reviewerReview) {
        this.reviewerReview = reviewerReview;
    }

    public ListReplyScore getStudentScore() {
        return studentScore;
    }

    public void setStudentScore(ListReplyScore studentScore) {
        this.studentScore = studentScore;
    }

    public Integer getChatCount() {
        return chatCount;
    }

    public void setChatCount(Integer chatCount) {
        this.chatCount = chatCount;
    }
}

package com.resume.interceptor;

import com.resume.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * 登陆拦截器
 *
 * @author danny
 * @date 2020/1/28
 */
public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 发出请求的时候进行拦截，此处对session中的用户名进行判断，在有用户名的前提下才予以放行
     * FIXME: danny 2020-1-29 2020-1-30
     *
     * @param request  请求
     * @param response 响应
     * @param handler  handler
     * @return true/false表示是否放行
     * @throws Exception 异常
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 获取请求的URI：去除http:localhost:8080这部分剩下的
        String uri = request.getRequestURI();
        // 不被拦截的地址
        boolean result = uri.contains("/") || uri.contains("/login.jsp") || uri.contains("/register.jsp");
        // 如果是首页，注册页或者是登陆页，则允许放行
        if (uri.contains("/login.jsp")) {
            return true;
        }
        // 从session中获取用户名
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // 有用户名，则放行
        if (user != null) {
            return true;
        }
        // 不符合条件的给出提示信息，并转发到登录页面
        request.setAttribute("msg", "您还没有登录，请先登录！");
        request.getRequestDispatcher("/login.jsp").forward(request, response);

        return false;
    }

    /**
     * 得到响应是的操作，此处不必要实现
     *
     * @param request      请求
     * @param response     响应
     * @param handler      handler
     * @param modelAndView 视图
     * @throws Exception 异常
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }

    /**
     * 拦截后的操作，此处不必要实现
     *
     * @param request  请求
     * @param response 响应
     * @param handler  handler
     * @param ex       异常
     * @throws Exception 异常
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
}

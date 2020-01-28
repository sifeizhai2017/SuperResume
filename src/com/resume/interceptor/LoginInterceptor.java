package com.resume.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * 登陆拦截器
 * @author danny
 * @date 2020/1/28
 */
public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 发出请求的时候进行拦截，此处对session中的用户名进行判断，在有用户名的前提下才予以放行
     * @param request 请求
     * @param response 响应
     * @param handler handler
     * @return true/false表示是否放行
     * @throws Exception 异常
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();

        return true;
    }

    /**
     * 得到响应是的操作，此处不必要实现
     * @param request 请求
     * @param response 响应
     * @param handler handler
     * @param modelAndView 视图
     * @throws Exception 异常
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception { }

    /**
     * 拦截后的操作，此处不必要实现
     * @param request 请求
     * @param response 响应
     * @param handler handler
     * @param ex 异常
     * @throws Exception 异常
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception { }
}

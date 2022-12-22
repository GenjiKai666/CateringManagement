package cn.edu.usst.cateringManagement.controller.filter;


import cn.edu.usst.cateringManagement.bean.po.CustomerPO;
import cn.edu.usst.cateringManagement.utils.Constant;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
public class LoginCheckFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        if (servletRequest instanceof HttpServletRequest httpServletRequest &&
                servletResponse instanceof HttpServletResponse httpServletResponse) {
            HttpSession session = httpServletRequest.getSession();
            CustomerPO user = (CustomerPO) session.getAttribute(Constant.USER);
            String role = (String) session.getAttribute(Constant.ROLE);
            String path = httpServletRequest.getServletPath();

            // 静态资源访问，直接放行
            if (path.startsWith("/static")) {
                filterChain.doFilter(httpServletRequest, httpServletResponse);
                return;
            }

            // 非静态资源访问
            // 已经登陆用户
            if (user != null && role != null) {
                // 登陆注册页面，已经登陆的不用访问
                if (isLoginOrRegister(path)) {
                    httpServletResponse.sendRedirect("/user");
                }
                // 特殊管理员页面，只有管理员可以登陆
                else if (path.startsWith("/management") || path.startsWith("/report")) {
                    if (role.equals(Constant.ADMIN)) {
                        filterChain.doFilter(httpServletRequest, httpServletResponse);
                    } else {
                        httpServletResponse.setStatus(403);
                    }
                }
                // 其他页面，都是普通用户页面，只允许普通用户访问
                else {
                    if (role.equals(Constant.NORMAL)) {
                        filterChain.doFilter(httpServletRequest, httpServletResponse);
                    } else {
                        httpServletResponse.setStatus(403);
                    }
                }
            }
            // 未登录用户
            else {
                // 未登录用户访问登陆注册页面，放行
                if (isLoginOrRegister(path)) {
                    filterChain.doFilter(httpServletRequest, httpServletResponse);
                }
                // 其他页跳转到登陆页面
                else {
                    httpServletResponse.sendRedirect("/user/login.html");
                }
            }
        }
    }

    private boolean isLoginOrRegister(String path) {
        String[] preLoginPages = {"/user/login", "/user/login.html", "/user/register", "/user/register.html"};
        return anyEquals(path, preLoginPages);
    }

    private boolean anyEquals(String str, String[] targets) {
        if (targets != null && str != null) {
            for (String target : targets) {
                if (str.equals(target)) {
                    return true;
                }
            }
        }
        return false;
    }

}

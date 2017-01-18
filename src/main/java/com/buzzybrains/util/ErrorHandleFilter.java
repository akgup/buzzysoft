package com.buzzybrains.util;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ErrorHandleFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();


		String[] restricted = { "/validate", "/WEB-INF/jsp/login.jsp", "/static", "/login" ,"/app"};


		String loginURL = req.getContextPath() + "/login";

      //String url = ((HttpServletRequest) request).getRequestURL().toString();
        //System.out.println("@@@@@@@@@@@@@@@"+ url);
		
		try {

			if ((session != null && session.getAttribute("SessionUsername") != null)
					|| Arrays.stream(restricted).parallel().anyMatch(req.getRequestURI()::contains)) {
				System.out.println("iiiiiiiiiiiiiif");
				
				chain.doFilter(request, response);

			}
			
		/*	else if((session != null && session.getAttribute("SessionUsername") != null) && url.equals("/")){
				
				String userId = (String) session.getAttribute("SessionUserid");
				request.setAttribute("mode", "MODE_HOME");
				res.sendRedirect("home?userid=" + userId);
			}*/
			
			else {
				System.out.println("eeeeeeeeelll");
				res.sendRedirect(loginURL);

			}
		} catch (Exception ex) {

			ex.printStackTrace();
		}
		
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}

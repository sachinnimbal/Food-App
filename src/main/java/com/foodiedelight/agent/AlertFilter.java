package com.foodiedelight.agent;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.AgentsDaoImpl;
import com.foodiedelight.model.Users;

@WebFilter("/*")
public class AlertFilter implements Filter {

	private AgentsDaoImpl agentDao;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		agentDao = new AgentsDaoImpl();
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession(false);

		if (session != null && session.getAttribute("user") != null) {
			Users user = (Users) session.getAttribute("user");
			if ("DeliveryPerson".equals(user.getUserRole()) && agentDao.agentNeedsUpdate(user.getUserID())) {
				session.setAttribute("needsUpdate", true);
			} else {
				session.removeAttribute("needsUpdate");
			}
		}

		chain.doFilter(request, response);
	}

}
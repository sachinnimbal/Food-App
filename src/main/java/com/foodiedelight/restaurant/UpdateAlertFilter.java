package com.foodiedelight.restaurant;

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
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Users;

@WebFilter("/*")
public class UpdateAlertFilter implements Filter {

	private RestaurantsDaoImpl restaurantsDao;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		restaurantsDao = new RestaurantsDaoImpl();
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession(false);

		if (session != null && session.getAttribute("user") != null) {
			Users user = (Users) session.getAttribute("user");
			if ("RestaurantOwner".equals(user.getUserRole())
					&& restaurantsDao.restaurantNeedsUpdate(user.getUserID())) {
				session.setAttribute("needsUpdate", true);
			} else {
				session.removeAttribute("needsUpdate");
			}
		}

		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		if (restaurantsDao != null) {
			restaurantsDao.closeConnection();
		}
	}
}

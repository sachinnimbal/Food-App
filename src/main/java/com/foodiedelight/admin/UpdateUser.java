package com.foodiedelight.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/UpdateUser")
@SuppressWarnings("serial")
public class UpdateUser extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            Users currentUser = (Users) session.getAttribute("user");
            if (currentUser != null && "SuperAdmin".equals(currentUser.getUserRole())) {
                resp.setContentType("text/html; charset=UTF-8");
                UsersDaoImpl usersDaoImpl = new UsersDaoImpl();

                // Fetching the user to update from the database
                int userId = Integer.parseInt(req.getParameter("userId"));
                Users userToUpdate = usersDaoImpl.getUserById(userId);
                String name = req.getParameter("name");
                String phone = req.getParameter("phone");
                String address = req.getParameter("address");
                String street = req.getParameter("street");
                String city = req.getParameter("city");
                String state = req.getParameter("state");
                String pincode = req.getParameter("pincode");
                String role = req.getParameter("role");
                String status = req.getParameter("status");

                if (name != null) userToUpdate.setName(name);
                if (phone != null) userToUpdate.setPhoneNumber(phone);
                if (address != null) userToUpdate.setAddress(address);
                if (street != null) userToUpdate.setStreet(street);
                if (city != null) userToUpdate.setCityName(city);
                if (state != null) userToUpdate.setState(state);
                if (pincode != null) userToUpdate.setPinCode(pincode);
                if (role != null) userToUpdate.setUserRole(role);
                if (status != null) userToUpdate.setStatus(status);
                
                usersDaoImpl.updateUser(userToUpdate);
                session.setAttribute("notification", "User updated successfully. 🎉");

                // Update role if provided
                if (req.getParameter("Role") != null) {
                    String newRole = req.getParameter("Role");
                    userToUpdate.setUserRole(newRole); 
                    usersDaoImpl.updateUserRole(userToUpdate); 
                    session.setAttribute("notification", "User role updated successfully. 🎉");
                }

                // Update status if provided
                if (req.getParameter("Status") != null) {
                    String newStatus = req.getParameter("Status");
                    userToUpdate.setStatus(newStatus); 
                    usersDaoImpl.updateUserStatus(userToUpdate); 
                    session.setAttribute("notification", "User status updated successfully. 🎉");
                }

                resp.sendRedirect("UsersList");
            } else {
                resp.sendRedirect("UserHome");
            }
        } else {
            resp.sendRedirect("UserHome");
        }
    }
}


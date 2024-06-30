package com.foodiedelight.restaurant;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.AgentsDaoImpl;
import com.foodiedelight.daoimpl.DeliveryInfoDaoImpl;
import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.OrderItemsDaoImpl;
import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.daoimpl.PaymentDetailsDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.Agents;
import com.foodiedelight.model.DeliveryInfo;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.OrderItems;
import com.foodiedelight.model.Orders;
import com.foodiedelight.model.PaymentDetails;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@SuppressWarnings("serial")
@WebServlet("/RestaurantHome")
public class RestaurantHome extends HttpServlet {

    private RestaurantsDaoImpl restaurantsDao;

    @Override
    public void init() throws ServletException {
        restaurantsDao = new RestaurantsDaoImpl();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        resp.setContentType("text/html; charset=UTF-8");
        if (session != null) {
            Users user = (Users) session.getAttribute("user");
            if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
                boolean needsUpdate = restaurantsDao.restaurantNeedsUpdate(user.getUserID());
                session.setAttribute("needsUpdate", needsUpdate); 
                if (needsUpdate) {
                    req.setAttribute("alert", "Please update your restaurant details immediately.");
                    req.getRequestDispatcher("restaurant/index.jsp").forward(req, resp);
                } else {
                    Restaurants restaurant = restaurantsDao.getRestaurantByOwnerId(user.getUserID());
                    if (restaurant != null) {
                        int restaurantID = restaurant.getRestaurantID();
                        MenuItemsDaoImpl menuItemsDao = new MenuItemsDaoImpl();
                        OrdersDaoImpl ordersDao = new OrdersDaoImpl();
                        OrderItemsDaoImpl orderItemsDao = new OrderItemsDaoImpl();
                        PaymentDetailsDaoImpl paymentDetailsDao = new PaymentDetailsDaoImpl();
                        UsersDaoImpl userDao = new UsersDaoImpl();
                        DeliveryInfoDaoImpl deliveryInfoDao = new DeliveryInfoDaoImpl();
                        AgentsDaoImpl agentsDao = new AgentsDaoImpl();

                        List<Users> deliveryAgents = userDao.getUserByRole("DeliveryPerson");
                        List<Orders> allOrdersList = ordersDao.getOrdersByRestaurantId(restaurantID);
                        List<Orders> ordersList = allOrdersList.size() > 9 ? allOrdersList.subList(0, 9) : allOrdersList;
                        List<MenuItems> menuItemsByRestaurantId = menuItemsDao.getMenuItemsByRestaurantId(restaurantID);
                        int totalOrders = ordersDao.countOrdersByRestaurantId(restaurantID);
                        int totalMenuItems = menuItemsByRestaurantId.size();
                        int totalPending = ordersDao.countOrdersByStatus(restaurant.getRestaurantID(), "Pending");
                        int totalInProgress = ordersDao.countOrdersByStatus(restaurant.getRestaurantID(), "In Progress");
                        int totalCancelled = ordersDao.countOrdersByStatus(restaurant.getRestaurantID(), "Cancelled");
                        int totalDelivered = ordersDao.countOrdersByStatus(restaurant.getRestaurantID(), "Delivered");

                        Map<Integer, List<OrderItems>> orderItemsMap = new HashMap<>();
                        Map<Integer, MenuItems> menuItemsMap = new HashMap<>();
                        Map<Integer, PaymentDetails> paymentDetailsMap = new HashMap<>();
                        Map<Integer, Users> userMap = new HashMap<>();
                        Map<Integer, DeliveryInfo> deliveryInfoMap = new HashMap<>();
                        Map<Integer, Users> deliveryPersonnelMap = new HashMap<>();
                        Map<Integer, Agents> agentMap = new HashMap<>();

                        for (Orders order : ordersList) {
                            List<OrderItems> orderItems = orderItemsDao.getOrderItemsByOrderId(order.getOrderID());
                            orderItemsMap.put(order.getOrderID(), orderItems);

                            for (OrderItems item : orderItems) {
                                MenuItems menuItem = menuItemsDao.getMenuItemById(item.getItemID());
                                if (menuItem != null) {
                                    menuItemsMap.put(item.getItemID(), menuItem);
                                }
                            }

                            PaymentDetails paymentDetails = paymentDetailsDao.getPaymentDetailsByOrderId(order.getOrderID());
                            if (paymentDetails != null) {
                                paymentDetailsMap.put(order.getOrderID(), paymentDetails);
                            }

                            Users customer = userDao.getUserById(order.getUserID());
                            if (customer != null) {
                                userMap.put(order.getUserID(), customer);
                            }

                            for (Users agentUser : deliveryAgents) {
                                Agents agent = agentsDao.getAgentByUserId(agentUser.getUserID());
                                if (agent != null) {
                                    agentMap.put(agentUser.getUserID(), agent);
                                }
                            }

                            DeliveryInfo deliveryInfo = deliveryInfoDao.getDeliveryInfoByOrderId(order.getOrderID());
                            if (deliveryInfo != null) {
                                deliveryInfoMap.put(order.getOrderID(), deliveryInfo);
                                int deliveryPersonnelId = deliveryInfo.getDeliveryPersonnelID();
                                if (deliveryPersonnelId != 0 && !deliveryPersonnelMap.containsKey(deliveryPersonnelId)) {
                                    Users deliveryPersonnel = userDao.getUserById(deliveryPersonnelId);
                                    if (deliveryPersonnel != null) {
                                        deliveryPersonnelMap.put(deliveryPersonnelId, deliveryPersonnel);
                                    }
                                }
                            }
                        }

                        req.setAttribute("totalMenuItem", totalMenuItems);
                        req.setAttribute("totalOrder", totalOrders);
                        req.setAttribute("totalPending", totalPending);
                        req.setAttribute("totalInProgress", totalInProgress);
                        req.setAttribute("totalCancelled", totalCancelled);
                        req.setAttribute("totalDelivered", totalDelivered);
                        req.setAttribute("orders", ordersList);
                        req.setAttribute("orderItemsMap", orderItemsMap);
                        req.setAttribute("menuItemsMap", menuItemsMap);
                        req.setAttribute("paymentDetailsMap", paymentDetailsMap);
                        req.setAttribute("userMap", userMap);
                        req.setAttribute("restaurant", restaurant);
                        req.setAttribute("deliveryInfoMap", deliveryInfoMap);
                        req.setAttribute("deliveryPersonnelMap", deliveryPersonnelMap);
                        req.setAttribute("deliveryAgents", deliveryAgents);
                        req.setAttribute("agentMap", agentMap);
        				req.setAttribute("hideAlert", true);
                        req.getRequestDispatcher("restaurant/index.jsp").forward(req, resp);
                    } else {
                        System.out.println("No restaurant found for the current user.");
                        req.getRequestDispatcher("restaurant/index.jsp").forward(req, resp);
                    }
                }
            } else {
                resp.sendRedirect("UserHome");
            }
        } else {
            resp.sendRedirect("UserHome");
        }
    }

    @Override
    public void destroy() {
        if (restaurantsDao != null) {
            restaurantsDao.closeConnection();
        }
    }
}

package com.foodiedelight.daoimpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.OrdersDao;
import com.foodiedelight.model.Orders;
import com.foodiedelight.util.DBConnectionUtil;

public class OrdersDaoImpl implements OrdersDao {

	private Connection connection;
	public static final String INSERT_QUERY = "INSERT INTO `Orders` "
			+ "(`RestaurantID`, `UserID`, `OrderDateTime`, `DeliveryAddress`, `Subtotal`, "
			+ "`GST`, `TotalAmount`, `Status`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	public static final String UPDATE_QUERY = "UPDATE `Orders` SET "
			+ "`RestaurantID` = ?, `UserID` = ?, `OrderDateTime` = ?, `DeliveryAddress` = ?, "
			+ "`Subtotal` = ?, `GST` = ?, `TotalAmount` = ?, `Status` = ? WHERE `OrderID` = ?";
	public static final String SELECT_QUERY = "SELECT * FROM `Orders` WHERE `OrderID` = ?";
	public static final String SELECT_USER_ID_QUERY = "SELECT * FROM `Orders` WHERE `UserID` = ?";
	public static final String SELECT_BY_RESTAURANT_ID_QUERY = "SELECT * FROM `Orders` WHERE `RestaurantID` = ?";
	public static final String DELETE_QUERY = "DELETE FROM `Orders` WHERE `OrderID` = ?";
	public static final String SELECT_ALL_QUERY = "SELECT * FROM `Orders`";
	public static final String COUNT_BY_RESTO_ID = "SELECT COUNT(*) FROM `Orders` WHERE `RestaurantID` = ?";
	public static final String UPDATE_STATUS = "UPDATE `Orders` SET `Status` = ? WHERE `OrderID` = ?";
	public static final String SELECT_BY_RESTAURANT_STATUS = "SELECT * FROM `Orders` WHERE `RestaurantID` = ? AND `Status` = ?";
	public static final String SELECT_BY_STATUS = "SELECT * FROM `Orders` WHERE `Status` = ?";
	public static final String COUNT_BY_STATUS = "SELECT COUNT(*) FROM `Orders` WHERE `Status` = ?";
	public static final String COUNT_ORDERS = "SELECT COUNT(*) FROM `Orders` WHERE `RestaurantID` = ? AND `Status` = ?";

	public OrdersDaoImpl() {
		connection = DBConnectionUtil.getConnection();
	}

	@Override
	public int addOrder(Orders order) {
		PreparedStatement preparedStatement = null;
		ResultSet generatedKeys = null;
		int orderId = 0;

		try {
			preparedStatement = connection.prepareStatement(INSERT_QUERY, Statement.RETURN_GENERATED_KEYS);

			preparedStatement.setInt(1, order.getRestaurantID());
			preparedStatement.setInt(2, order.getUserID());
			preparedStatement.setTimestamp(3, Timestamp.valueOf(order.getOrderDateTime()));
			preparedStatement.setString(4, order.getDeliveryAddress());
			preparedStatement.setBigDecimal(5, order.getSubtotal());
			preparedStatement.setBigDecimal(6, order.getGst());
			preparedStatement.setBigDecimal(7, order.getTotalAmount());
			preparedStatement.setString(8, order.getStatus());

			int affectedRows = preparedStatement.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Creating order failed, no rows affected.");
			}

			generatedKeys = preparedStatement.getGeneratedKeys();
			if (generatedKeys.next()) {
				orderId = generatedKeys.getInt(1);
			} else {
				throw new SQLException("Creating order failed, no ID obtained.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (generatedKeys != null)
				try {
					generatedKeys.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}

		return orderId;
	}

	@Override
	public Orders getOrderById(int orderID) {
		PreparedStatement statement = null;
		Orders order = null;
		ResultSet set = null;
		try {
			statement = connection.prepareStatement(SELECT_QUERY);
			statement.setInt(1, orderID);
			set = statement.executeQuery();

			if (set.next()) {
				order = extractedOrders(orderID, set);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return order;
	}

	@Override
	public List<Orders> getOrdersByUserId(int userID) {
		ResultSet set = null;
		Orders orders = null;
		PreparedStatement statement = null;
		ArrayList<Orders> ordersList = new ArrayList<Orders>();

		try {
			statement = connection.prepareStatement(SELECT_USER_ID_QUERY);
			statement.setInt(1, userID);
			set = statement.executeQuery();
			while (set.next()) {
				int orderID = set.getInt("OrderID");
				int restaurantID = set.getInt("RestaurantID");
				LocalDateTime orderDateTime = null;
				Timestamp createdAtTimestamp = set.getTimestamp("OrderDateTime");
				if (createdAtTimestamp != null) {
					orderDateTime = createdAtTimestamp.toLocalDateTime();
				}
				String deliveryAddress = set.getString("DeliveryAddress");
				BigDecimal subtotal = set.getBigDecimal("Subtotal");
				BigDecimal gst = set.getBigDecimal("GST");
				BigDecimal totalAmount = set.getBigDecimal("TotalAmount");
				String status = set.getString("Status");

				orders = new Orders(orderID, restaurantID, userID, orderDateTime, deliveryAddress, subtotal, gst,
						totalAmount, status);
				ordersList.add(orders);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return ordersList;
	}

	@Override
	public void updateOrder(Orders order) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(UPDATE_QUERY);
			preparedStatement.setInt(1, order.getRestaurantID());
			preparedStatement.setInt(2, order.getUserID());
			preparedStatement.setTimestamp(3, Timestamp.valueOf(order.getOrderDateTime()));
			preparedStatement.setString(4, order.getDeliveryAddress());
			preparedStatement.setBigDecimal(5, order.getSubtotal());
			preparedStatement.setBigDecimal(6, order.getGst());
			preparedStatement.setBigDecimal(7, order.getTotalAmount());
			preparedStatement.setString(8, order.getStatus());
			preparedStatement.setInt(9, order.getOrderID());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public void deleteOrder(int orderID) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(DELETE_QUERY);
			preparedStatement.setInt(1, orderID);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public List<Orders> getAllOrders() {

		ResultSet set = null;
		Orders orders = null;
		Statement statement = null;
		ArrayList<Orders> ordersList = new ArrayList<Orders>();

		try {
			statement = connection.createStatement();
			set = statement.executeQuery(SELECT_ALL_QUERY);
			while (set.next()) {
				int OrderID = set.getInt("OrderID");
				orders = extractedOrders(OrderID, set);
				ordersList.add(orders);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(statement);
		}
		return ordersList;
	}

	public Orders extractedOrders(int orderID, ResultSet set) throws SQLException {
		Orders order;
		int userID = set.getInt("UserID");
		int restaurantID = set.getInt("RestaurantID");
		LocalDateTime orderDateTime = null;
		Timestamp createdAtTimestamp = set.getTimestamp("OrderDateTime");
		if (createdAtTimestamp != null) {
			orderDateTime = createdAtTimestamp.toLocalDateTime();
		}
		String deliveryAddress = set.getString("DeliveryAddress");
		BigDecimal subtotal = set.getBigDecimal("Subtotal");
		BigDecimal gst = set.getBigDecimal("GST");
		BigDecimal totalAmount = set.getBigDecimal("TotalAmount");
		String status = set.getString("Status");

		order = new Orders(orderID, restaurantID, userID, orderDateTime, deliveryAddress, subtotal, gst, totalAmount,
				status);
		return order;
	}

	@Override
	public List<Orders> getOrdersByRestaurantId(int restaurantID) {
		ResultSet set = null;
		Orders orders = null;
		PreparedStatement statement = null;
		ArrayList<Orders> ordersList = new ArrayList<Orders>();

		try {
			statement = connection.prepareStatement(SELECT_BY_RESTAURANT_ID_QUERY);
			statement.setInt(1, restaurantID);
			set = statement.executeQuery();
			while (set.next()) {
				int orderID = set.getInt("OrderID");
				int userID = set.getInt("UserID");
				LocalDateTime orderDateTime = null;
				Timestamp createdAtTimestamp = set.getTimestamp("OrderDateTime");
				if (createdAtTimestamp != null) {
					orderDateTime = createdAtTimestamp.toLocalDateTime();
				}
				String deliveryAddress = set.getString("DeliveryAddress");
				BigDecimal subtotal = set.getBigDecimal("Subtotal");
				BigDecimal gst = set.getBigDecimal("GST");
				BigDecimal totalAmount = set.getBigDecimal("TotalAmount");
				String status = set.getString("Status");

				orders = new Orders(orderID, restaurantID, userID, orderDateTime, deliveryAddress, subtotal, gst,
						totalAmount, status);
				ordersList.add(orders);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return ordersList;
	}

	@Override
	public int countOrdersByRestaurantId(int restaurantId) {
		PreparedStatement statement = null;
		ResultSet set = null;

		try {
			statement = connection.prepareStatement(COUNT_BY_RESTO_ID);
			statement.setInt(1, restaurantId);
			set = statement.executeQuery();
			if (set.next()) {
				return set.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return 0;
	}

	@Override
	public boolean updateOrderStatus(int orderId, String status) {
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(UPDATE_STATUS);
			statement.setString(1, status);
			statement.setInt(2, orderId);
			int affectedRows = statement.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DBConnectionUtil.closePreparedStatement(statement);
		}
	}

	@Override
	public int countOrdersByStatus(int restaurantID, String status) {
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		int count = 0;
		try {
			preparedStatement = connection.prepareStatement(COUNT_ORDERS);
			preparedStatement.setInt(1, restaurantID);
			preparedStatement.setString(2, status);
			rs = preparedStatement.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(rs);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return count;
	}

	@Override
	public List<Orders> getOrdersByRestaurantAndStatus(int restaurantID, String status) {
		ResultSet set = null;
		Orders order = null;
		PreparedStatement statement = null;
		ArrayList<Orders> ordersList = new ArrayList<Orders>();

		try {
			statement = connection.prepareStatement(SELECT_BY_RESTAURANT_STATUS);
			statement.setInt(1, restaurantID);
			statement.setString(2, status);
			set = statement.executeQuery();
			while (set.next()) {
				int orderID = set.getInt("OrderID");
				int userID = set.getInt("UserID");
				LocalDateTime orderDateTime = null;
				Timestamp createdAtTimestamp = set.getTimestamp("OrderDateTime");
				if (createdAtTimestamp != null) {
					orderDateTime = createdAtTimestamp.toLocalDateTime();
				}
				String deliveryAddress = set.getString("DeliveryAddress");
				BigDecimal subtotal = set.getBigDecimal("Subtotal");
				BigDecimal gst = set.getBigDecimal("GST");
				BigDecimal totalAmount = set.getBigDecimal("TotalAmount");

				order = new Orders(orderID, restaurantID, userID, orderDateTime, deliveryAddress, subtotal, gst,
						totalAmount, status);
				ordersList.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return ordersList;
	}

	@Override
	public int countOrdersByStatus(String status) {
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		int count = 0;
		try {
			preparedStatement = connection.prepareStatement(COUNT_BY_STATUS);
			preparedStatement.setString(1, status);
			rs = preparedStatement.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(rs);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return count;
	}

	@Override
	public List<Orders> getOrdersByStatus(String status) {
		ResultSet set = null;
		Orders order = null;
		PreparedStatement statement = null;
		ArrayList<Orders> ordersList = new ArrayList<Orders>();

		try {
			statement = connection.prepareStatement(SELECT_BY_STATUS);
			statement.setString(1, status);
			set = statement.executeQuery();
			while (set.next()) {
				int orderID = set.getInt("OrderID");
				int restaurantID = set.getInt("RestaurantID");
				int userID = set.getInt("UserID");
				LocalDateTime orderDateTime = null;
				Timestamp createdAtTimestamp = set.getTimestamp("OrderDateTime");
				if (createdAtTimestamp != null) {
					orderDateTime = createdAtTimestamp.toLocalDateTime();
				}
				String deliveryAddress = set.getString("DeliveryAddress");
				BigDecimal subtotal = set.getBigDecimal("Subtotal");
				BigDecimal gst = set.getBigDecimal("GST");
				BigDecimal totalAmount = set.getBigDecimal("TotalAmount");

				order = new Orders(orderID, restaurantID, userID, orderDateTime, deliveryAddress, subtotal, gst,
						totalAmount, status);
				ordersList.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return ordersList;
	}

	public void closeConnection() {
		DBConnectionUtil.closeConnection(connection);
	}

}

package com.foodiedelight.daoimpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.OrderItemsDao;
import com.foodiedelight.model.OrderItems;
import com.foodiedelight.util.DBConnectionUtil;

public class OrderItemsDaoImpl implements OrderItemsDao {

    private Connection connection;

    public static final String INSERT_QUERY = "INSERT INTO `OrderItems` "
            + "(`OrderID`, `ItemID`, `Price`, `Quantity`, `ItemTotalPrice`) VALUES (?, ?, ?, ?, ?)";
    public static final String UPDATE_QUERY = "UPDATE `OrderItems` SET `Quantity` = ?, "
            + "`ItemTotalPrice` = ?, `Rating` = ? WHERE `OrderItemID` = ?";
    public static final String SELECT_QUERY = "SELECT * FROM `OrderItems` WHERE `OrderItemID` = ?";
    public static final String DELETE_QUERY = "DELETE FROM `OrderItems` WHERE `OrderItemID` = ?";
    public static final String SELECT_ALL_QUERY = "SELECT * FROM `OrderItems`";
    public static final String SELECT_BY_ORDERID = "SELECT * FROM `OrderItems` WHERE `OrderID` = ?";

    public OrderItemsDaoImpl() {
        connection = DBConnectionUtil.getConnection();
    }

    @Override
    public void addOrderItem(OrderItems orderItem) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(INSERT_QUERY);
            connection.setAutoCommit(false);

            preparedStatement.setInt(1, orderItem.getOrderID());
            preparedStatement.setInt(2, orderItem.getItemID());
            preparedStatement.setBigDecimal(3, orderItem.getPrice());
            preparedStatement.setInt(4, orderItem.getQuantity());
            preparedStatement.setBigDecimal(5, orderItem.getItemTotalPrice());

            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                connection.commit();
                System.out.println("OrderItem added successfully");
            } else {
                System.out.println("OrderItem insertion failed");
            }
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    System.out.println("Error during transaction rollback");
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public List<OrderItems> getOrderItemsByOrderId(int orderId) {
        List<OrderItems> orderItemsList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet set = null;
        try {
            statement = connection.prepareStatement(SELECT_BY_ORDERID);
            statement.setInt(1, orderId);
            set = statement.executeQuery();
            while (set.next()) {
                OrderItems orderItem = new OrderItems(set.getInt("OrderItemID"), set.getInt("OrderID"),
                        set.getInt("ItemID"), set.getBigDecimal("Price"), set.getInt("Quantity"),
                        set.getBigDecimal("ItemTotalPrice"));
                orderItemsList.add(orderItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closePreparedStatement(statement);
        }
        return orderItemsList;
    }

    @Override
    public void updateOrderItem(OrderItems orderItems) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_QUERY);
            preparedStatement.setInt(1, orderItems.getQuantity());
            preparedStatement.setBigDecimal(2, orderItems.getItemTotalPrice());
            preparedStatement.setInt(3, orderItems.getRating());
            preparedStatement.setInt(4, orderItems.getOrderItemID());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(DELETE_QUERY);
            preparedStatement.setInt(1, orderItemId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public OrderItems getOrderItemById(int orderItemId) {
        PreparedStatement statement = null;
        ResultSet set = null;
        OrderItems orderItem = null;
        try {
            statement = connection.prepareStatement(SELECT_QUERY);
            statement.setInt(1, orderItemId);
            set = statement.executeQuery();
            if (set.next()) {
                orderItem = extractedOrderItems(orderItemId, set);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closePreparedStatement(statement);
        }
        return orderItem;
    }

    public OrderItems extractedOrderItems(int orderItemId, ResultSet set) throws SQLException {
        OrderItems orderItem;
        int OrderID = set.getInt("OrderID");
        int ItemID = set.getInt("ItemID");
        BigDecimal Price = set.getBigDecimal("Price");
        int Quantity = set.getInt("Quantity");
        BigDecimal ItemTotalPrice = set.getBigDecimal("ItemTotalPrice");

        orderItem = new OrderItems(orderItemId, OrderID, ItemID, Price, Quantity, ItemTotalPrice);
        return orderItem;
    }

    @Override
    public void addOrderItems(List<OrderItems> orderItemsList) {
        PreparedStatement preparedStatement = null;
        try {
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(INSERT_QUERY);

            for (OrderItems orderItem : orderItemsList) {
                preparedStatement.setInt(1, orderItem.getOrderID());
                preparedStatement.setInt(2, orderItem.getItemID());
                preparedStatement.setBigDecimal(3, orderItem.getPrice());
                preparedStatement.setInt(4, orderItem.getQuantity());
                preparedStatement.setBigDecimal(5, orderItem.getItemTotalPrice());
                preparedStatement.addBatch();
            }

            preparedStatement.executeBatch();
            connection.commit();

            System.out.println("All OrderItems added successfully");
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                    System.out.println("Transaction rolled back due to an error");
                } catch (SQLException ex) {
                    System.out.println("Error during transaction rollback");
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    public void closeConnection() {
        DBConnectionUtil.closeConnection(connection);
    }
}

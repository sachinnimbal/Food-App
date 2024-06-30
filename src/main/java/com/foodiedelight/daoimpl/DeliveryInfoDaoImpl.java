package com.foodiedelight.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.DeliveryInfoDao;
import com.foodiedelight.model.DeliveryInfo;
import com.foodiedelight.util.DBConnectionUtil;

public class DeliveryInfoDaoImpl implements DeliveryInfoDao {

    private Connection connection;
    public static final String INSERT_QUERY = "INSERT INTO `DeliveryInfo` (`OrderID`, `DeliveryPersonnelID`, `Status`) VALUES (?, ?, ?)";
    public static final String UPDATE_QUERY = "UPDATE `DeliveryInfo` SET `OrderID` = ?, `DeliveryPersonnelID` = ?, `EstimatedDeliveryTime` = ?, `Status` = ? WHERE `DeliveryID` = ?";
    public static final String DELETE_QUERY = "DELETE FROM `DeliveryInfo` WHERE `DeliveryID` = ?";
    public static final String SELECT_QUERY = "SELECT * FROM `DeliveryInfo` WHERE `DeliveryID` = ?";
    public static final String SELECT_ALL_QUERY = "SELECT * FROM `DeliveryInfo`";
    public static final String UPDATE_ESTIMATED = "UPDATE `DeliveryInfo` SET `EstimatedDeliveryTime` = ? WHERE `DeliveryID` = ?";
    public static final String UPDATE_DELIVERED = "UPDATE `DeliveryInfo` SET `Status` = ?, `DeliverDateTime` = ? WHERE `DeliveryID` = ?";

    public DeliveryInfoDaoImpl() {
        connection = DBConnectionUtil.getConnection();
    }

    @Override
    public void addDeliveryInfo(DeliveryInfo deliveryInfo) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(INSERT_QUERY);
            preparedStatement.setInt(1, deliveryInfo.getOrderID());
            preparedStatement.setInt(2, deliveryInfo.getDeliveryPersonnelID());
            preparedStatement.setString(3, deliveryInfo.getStatus());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public DeliveryInfo getDeliveryInfoByID(int deliveryID) {
        DeliveryInfo deliveryInfo = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement(SELECT_QUERY);
            preparedStatement.setInt(1, deliveryID);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                deliveryInfo = extractDeliveryInfo(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(resultSet);
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return deliveryInfo;
    }

    @Override
    public List<DeliveryInfo> getDeliveriesByOrderID(int orderID) {
        List<DeliveryInfo> deliveryInfoList = new ArrayList<>();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement(SELECT_ALL_QUERY);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                deliveryInfoList.add(extractDeliveryInfo(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(resultSet);
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return deliveryInfoList;
    }

    @Override
    public void updateDeliveryInfo(DeliveryInfo deliveryInfo) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_QUERY);
            preparedStatement.setInt(1, deliveryInfo.getOrderID());
            preparedStatement.setInt(2, deliveryInfo.getDeliveryPersonnelID());
            preparedStatement.setTime(3, Time.valueOf(deliveryInfo.getEstimatedDeliveryTime()));
            preparedStatement.setString(4, deliveryInfo.getStatus());
            preparedStatement.setInt(5, deliveryInfo.getDeliveryID());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public void deleteDeliveryInfo(int deliveryID) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(DELETE_QUERY);
            preparedStatement.setInt(1, deliveryID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public DeliveryInfo getDeliveryInfoByOrderId(int orderId) {
        String query = "SELECT * FROM `DeliveryInfo` WHERE `OrderID` = ?";
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, orderId);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return extractDeliveryInfo(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(resultSet);
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return null;
    }

    public List<DeliveryInfo> getDeliveriesByDeliveryPersonnelID(int userID) {
        String query = "SELECT * FROM `DeliveryInfo` WHERE `DeliveryPersonnelID` = ?";
        List<DeliveryInfo> deliveries = new ArrayList<>();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userID);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                deliveries.add(extractDeliveryInfo(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(resultSet);
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return deliveries;
    }

    public void updateEstimatedDeliveryTime(int deliveryID, String estimatedTime) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_ESTIMATED);
            preparedStatement.setString(1, estimatedTime);
            preparedStatement.setInt(2, deliveryID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    public void updateDeliveredTime(int deliveryID, String status, LocalDateTime deliveredTime) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_DELIVERED);
            preparedStatement.setString(1, status);
            preparedStatement.setTimestamp(2, Timestamp.valueOf(deliveredTime));
            preparedStatement.setInt(3, deliveryID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    private DeliveryInfo extractDeliveryInfo(ResultSet resultSet) throws SQLException {
        int deliveryID = resultSet.getInt("DeliveryID");
        int orderID = resultSet.getInt("OrderID");
        int deliveryPersonnelID = resultSet.getInt("DeliveryPersonnelID");
        Time time = resultSet.getTime("EstimatedDeliveryTime");
        LocalTime estimatedDeliveryTime = time != null ? time.toLocalTime() : null;
        String status = resultSet.getString("Status");
        Timestamp delivered = resultSet.getTimestamp("DeliverDateTime");
        LocalDateTime deliveredTime = delivered != null ? delivered.toLocalDateTime() : null;
        return new DeliveryInfo(deliveryID, orderID, deliveryPersonnelID, estimatedDeliveryTime, status, deliveredTime);
    }
    
    public void closeConnection() {
        DBConnectionUtil.closeConnection(connection);
    }
}

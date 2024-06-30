package com.foodiedelight.daoimpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.PaymentDetailsDao;
import com.foodiedelight.model.PaymentDetails;
import com.foodiedelight.util.DBConnectionUtil;

public class PaymentDetailsDaoImpl implements PaymentDetailsDao {

	private Connection connection;
	public static final String INSERT_QUERY = "INSERT INTO `PaymentDetails` (`OrderID`, `Amount`, `PaymentMethod`, `Status`, `TransactionDate`) VALUES (?, ?, ?, ?, ?)";
	public static final String UPDATE_QUERY = "UPDATE `PaymentDetails` SET "
			+ "`OrderID` = ?, `Amount` = ?, `PaymentMethod` = ?, `Status` = ?, `TransactionDate` = ? "
			+ "WHERE `PaymentID` = ?";
	public static final String SELECT_QUERY = "SELECT * FROM `PaymentDetails` WHERE `PaymentID` = ?";
	public static final String DELETE_QUERY = "DELETE FROM `PaymentDetails` WHERE `PaymentID` = ?";
	public static final String SELECT_ALL_QUERY = "SELECT * FROM `PaymentDetails`";
	public static final String SELECT_BY_OrderID_QUERY = "SELECT * FROM `PaymentDetails` WHERE `OrderID` = ?";

	public PaymentDetailsDaoImpl() {
		connection = DBConnectionUtil.getConnection();
	}

	@Override
	public void addPaymentDetail(PaymentDetails paymentDetail) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(INSERT_QUERY);
			preparedStatement.setInt(1, paymentDetail.getOrderID());
			preparedStatement.setBigDecimal(2, paymentDetail.getAmount());
			preparedStatement.setString(3, paymentDetail.getPaymentMethod());
			preparedStatement.setString(4, paymentDetail.getStatus());
			preparedStatement.setTimestamp(5, Timestamp.valueOf(paymentDetail.getTransactionDate()));
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public List<PaymentDetails> getPaymentsByOrderID(int orderID) {
		PreparedStatement statement = null;
		ResultSet set = null;
		PaymentDetails paymentDetails = null;
		ArrayList<PaymentDetails> paymentList = new ArrayList<PaymentDetails>();

		try {
			statement = connection.prepareStatement(SELECT_BY_OrderID_QUERY);
			statement.setInt(1, orderID);
			set = statement.executeQuery();
			while (set.next()) {
				int PaymentID = set.getInt("PaymentID");
				BigDecimal Amount = set.getBigDecimal("Amount");
				String PaymentMethod = set.getString("PaymentMethod");
				String Status = set.getString("Status");
				LocalDateTime TransactionDate = null;
				Timestamp dateTransaction = set.getTimestamp("TransactionDate");
				if (dateTransaction != null) {
					TransactionDate = dateTransaction.toLocalDateTime();
				}
				paymentDetails = new PaymentDetails(PaymentID, orderID, Amount, PaymentMethod, Status, TransactionDate);
				paymentList.add(paymentDetails);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}

		return paymentList;
	}

	@Override
	public PaymentDetails getPaymentDetailsByOrderId(int orderID) {
		PreparedStatement statement = null;
		ResultSet set = null;
		PaymentDetails paymentDetails = null;
		try {
			statement = connection.prepareStatement(SELECT_BY_OrderID_QUERY);
			statement.setInt(1, orderID);
			set = statement.executeQuery();
			while (set.next()) {
				int PaymentID = set.getInt("PaymentID");
				BigDecimal Amount = set.getBigDecimal("Amount");
				String PaymentMethod = set.getString("PaymentMethod");
				String Status = set.getString("Status");
				LocalDateTime TransactionDate = null;
				Timestamp dateTransaction = set.getTimestamp("TransactionDate");
				if (dateTransaction != null) {
					TransactionDate = dateTransaction.toLocalDateTime();
				}
				paymentDetails = new PaymentDetails(PaymentID, orderID, Amount, PaymentMethod, Status, TransactionDate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}

		return paymentDetails;
	}
	
    
    public void closeConnection() {
        DBConnectionUtil.closeConnection(connection);
    }

}

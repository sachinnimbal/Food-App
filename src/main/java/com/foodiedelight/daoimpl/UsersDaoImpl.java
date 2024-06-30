package com.foodiedelight.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.UsersDao;
import com.foodiedelight.model.Users;
import com.foodiedelight.util.DBConnectionUtil;

public class UsersDaoImpl implements UsersDao {

	private Connection connection;
	public static final String INSERT_QUERY = "INSERT INTO `Users` (`Name`, `PhoneNumber`,"
			+ " `UserName`, `Password`) VALUES (?, ?, ?, ?)";
	public static final String UPDATE_QUERY = "UPDATE `Users` SET `Name` = ?, `PhoneNumber` = ?, "
			+ "`UserRole` = ?, `Status` = ?, `Address` = ?, `Street`= ?, "
			+ "`CityName` = ?, `State` = ?, `PinCode` = ? WHERE `UserID` = ?";
	public static final String DELETE_QUERY = "DELETE FROM `Users` WHERE `UserID` = ?";
	public static final String SELECT_QUERY = "SELECT * FROM `Users` WHERE `UserID` = ?";
	public static final String SELECT_ALL_QUERY = "SELECT * FROM `Users`";
	public static final String UPDATE_ROLE_QUERY = "UPDATE `Users` SET `UserRole` = ? WHERE `UserID` = ?";
	public static final String UPDATE_STATUS_QUERY = "UPDATE `Users` SET `Status` = ? WHERE `UserID` = ?";
	public static final String COUNT_BY_STATUS = "SELECT COUNT(*) FROM `Users` WHERE `Status` = ?";
	public static final String SELECT_BY_STATUS = "SELECT * FROM `Users` WHERE `Status` = ?";
	public final static String VALIDATE_USER = "SELECT * FROM `Users` WHERE `UserName` = ?";
	public final static String SELECT_BY_ROLE = "SELECT * FROM `Users` WHERE `UserRole` = ?";
	public final static String updateDeliveryInfoQuery = "UPDATE `Users` SET `Address` = ?, `Street` = ?, `CityName` = ?, `State` = ?, `PinCode` = ? WHERE `UserID` = ?";

	public UsersDaoImpl() {
		connection = DBConnectionUtil.getConnection();
	}

	@Override
	public boolean addUser(Users user) {
		boolean success = false;
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(INSERT_QUERY);
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getPhoneNumber());
			preparedStatement.setString(3, user.getUserName());
			preparedStatement.setString(4, user.getPassword());
			int register = preparedStatement.executeUpdate();
			if (register > 0) {
				success = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return success;

	}

	@Override
	public Users getUserById(int userID) {
		Users user = null;
		ResultSet set = null;
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(SELECT_QUERY);
			statement.setInt(1, userID);
			set = statement.executeQuery();
			if (set.next()) {
				user = extractedUser(set);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return user;
	}

	@Override
	public List<Users> getAllUsers() {
		Statement statement = null;
		ResultSet set = null;
		Users users = null;
		ArrayList<Users> usersList = new ArrayList<Users>();
		try {
			statement = connection.createStatement();
			set = statement.executeQuery(SELECT_ALL_QUERY);
			while (set.next()) {
				users = extractedUser(set);
				usersList.add(users);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(statement);
		}
		return usersList;
	}

	@Override
	public void updateUser(Users user) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(UPDATE_QUERY);
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getPhoneNumber());
			preparedStatement.setString(3, user.getUserRole());
			preparedStatement.setString(4, user.getStatus());
			preparedStatement.setString(5, user.getAddress());
			preparedStatement.setString(6, user.getStreet());
			preparedStatement.setString(7, user.getCityName());
			preparedStatement.setString(8, user.getState());
			preparedStatement.setString(9, user.getPinCode());
			preparedStatement.setInt(10, user.getUserID());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public void deleteUser(int userID) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(DELETE_QUERY);
			preparedStatement.setInt(1, userID);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);

		}
	}

	@Override
	public void updateUserRole(Users user) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(UPDATE_ROLE_QUERY);
			preparedStatement.setString(1, user.getUserRole());
			preparedStatement.setInt(2, user.getUserID());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);

		}
	}

	@Override
	public void updateUserStatus(Users user) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(UPDATE_STATUS_QUERY);
			preparedStatement.setString(1, user.getStatus());
			preparedStatement.setInt(2, user.getUserID());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);

		}
	}

	public Users extractedUser(ResultSet set) throws SQLException {
		Users user;
		int userId = set.getInt("UserID");
		String Name = set.getString("Name");
		String PhoneNumber = set.getString("PhoneNumber");
		String UserName = set.getString("UserName");
		String Password = set.getString("Password");
		String UserRole = set.getString("UserRole");
		String Status = set.getString("Status");
		String Address = set.getString("Address");
		String Street = set.getString("Street");
		String CityName = set.getString("CityName");
		String State = set.getString("State");
		String PinCode = set.getString("PinCode");
		LocalDateTime createdAt = null;
		Timestamp createdAtTimestamp = set.getTimestamp("CreatedAt");
		if (createdAtTimestamp != null) {
			createdAt = createdAtTimestamp.toLocalDateTime();
		}

		LocalDateTime lastLogin = null;
		Timestamp lastLoginTimestamp = set.getTimestamp("LastLogin");
		if (lastLoginTimestamp != null) {
			lastLogin = lastLoginTimestamp.toLocalDateTime();
		}

		user = new Users(userId, Name, PhoneNumber, UserName, Password, UserRole, Status, Address, Street, CityName,
				State, PinCode, createdAt, lastLogin);
		return user;
	}

	@Override
	public Users validUser(String username) {
		Users user = null;
		PreparedStatement preparedStatement = null;
		ResultSet res = null;

		try {
			preparedStatement = connection.prepareStatement(VALIDATE_USER);
			preparedStatement.setString(1, username);
			res = preparedStatement.executeQuery();

			if (res.next()) {
				user = new Users();
				user.setUserID(res.getInt("UserID"));
				user.setName(res.getString("Name"));
				user.setPhoneNumber(res.getString("PhoneNumber"));
				user.setUserName(res.getString("UserName"));
				user.setPassword(res.getString("Password"));
				user.setUserRole(res.getString("UserRole"));
				user.setStatus(res.getString("Status"));
				user.setAddress(res.getString("Address"));
				user.setStreet(res.getString("Street"));
				user.setCityName(res.getString("CityName"));
				user.setState(res.getString("State"));
				user.setPinCode(res.getString("PinCode"));

				Timestamp createdAtTimestamp = res.getTimestamp("CreatedAt");
				if (createdAtTimestamp != null) {
					user.setCreatedAt(createdAtTimestamp.toLocalDateTime());
				}

				Timestamp lastLoginTimestamp = res.getTimestamp("LastLogin");
				if (lastLoginTimestamp != null) {
					user.setLastLogin(lastLoginTimestamp.toLocalDateTime());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(res);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return user;
	}

	@Override
	public List<Users> getUserByRole(String role) {
		PreparedStatement preparedStatement = null;
		ResultSet set = null;
		Users users = null;
		ArrayList<Users> usersList = new ArrayList<Users>();
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_ROLE);
			preparedStatement.setString(1, role);
			set = preparedStatement.executeQuery();
			while (set.next()) {
				users = extractedUser(set);
				usersList.add(users);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return usersList;
	}

	@Override
	public boolean updateDeliveryInfo(Users user) {
		boolean success = false;
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(updateDeliveryInfoQuery);
			preparedStatement.setString(1, user.getAddress());
			preparedStatement.setString(2, user.getStreet());
			preparedStatement.setString(3, user.getCityName());
			preparedStatement.setString(4, user.getState());
			preparedStatement.setString(5, user.getPinCode());
			preparedStatement.setInt(6, user.getUserID());

			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				success = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return success;
	}

	@Override
	public int countUsersByStatus(String status) {
		PreparedStatement statement = null;
		int count = 0;
		ResultSet set = null;

		try {
			statement = connection.prepareStatement(COUNT_BY_STATUS);
			statement.setString(1, status);
			set = statement.executeQuery();
			if (set.next()) {
				count = set.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return count;
	}

	@Override
	public List<Users> getUsersByStatus(String status) {
		PreparedStatement preparedStatement = null;
		ResultSet set = null;
		Users users = null;
		ArrayList<Users> usersList = new ArrayList<Users>();
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_STATUS);
			preparedStatement.setString(1, status);
			set = preparedStatement.executeQuery();
			while (set.next()) {
				users = extractedUser(set);
				usersList.add(users);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return usersList;
	}

	public boolean usernameExists(String username) {
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		try {
			preparedStatement = connection.prepareStatement("SELECT COUNT(*) FROM `Users` WHERE username = ?");
			preparedStatement.setString(1, username);
			rs = preparedStatement.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(rs);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return false;
	}

	public void closeConnection() {
		DBConnectionUtil.closeConnection(connection);
	}

}

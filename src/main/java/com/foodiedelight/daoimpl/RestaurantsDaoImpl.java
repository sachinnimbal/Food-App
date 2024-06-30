package com.foodiedelight.daoimpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.RestaurantsDao;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.util.DBConnectionUtil;

public class RestaurantsDaoImpl implements RestaurantsDao {

	private Connection connection;
	public static final String INSERT_QUERY = "INSERT INTO `Restaurants` (`OwnerID`, `Name`, "
			+ "`ContactInfo`, `ETA`, `AverageCost`, `CuisineTypes`, `Discounts`, `Street`, "
			+ "`CityName`, `State`, `PinCode`, `Type`,`ImageURL`,`Description`, `OpeningTime` , `ClosingTime`, `Tags`) VALUES (?, ?, ?, ?, ?, ?, ? ,? ,? ,? ,? ,? ,? ,?, ?, ?, ?)";
	public static final String UPDATE_QUERY = "UPDATE Restaurants SET "
			+ "`Name` = ?, `ContactInfo` = ?, `AverageRating` = ?, `ETA` = ?, `AverageCost` = ?, "
			+ "`CuisineTypes` = ?, `Status` = ?, `OrderStatus` = ?, `Discounts` = ?, `Street` = ?, `CityName` = ?, "
			+ "`State` = ?, `PinCode` = ?, `Type` = ?, `ImageURL` = ?, `Description` = ?, `OpeningTime` = ?, `ClosingTime` = ?, `Tags` = ? "
			+ "WHERE RestaurantID = ?";
	public static final String DELETE_QUERY = "DELETE FROM `Restaurants` WHERE `RestaurantID` = ?";
	public static final String SELECT_QUERY = "SELECT * FROM `Restaurants` WHERE `RestaurantID` = ?";
	public static final String SELECT_ALL_QUERY = "SELECT * FROM `Restaurants`";
	public static final String SELECT_BY_STATUS_QUERY = "SELECT * FROM `Restaurants` WHERE `Status` = ?";
	public static final String SELECT_BY_ORDER_STATUS_QUERY = "SELECT * FROM `Restaurants` WHERE `OrderStatus` = ?";
	public static final String SELECT_BY_CITY_QUERY = "SELECT * FROM `Restaurants` WHERE `CityName` = ?";
	public static final String SEARCH_RESTAURANTS_QUERY = "SELECT * FROM `Restaurants` WHERE "
			+ "`Name` LIKE ? OR `Description` LIKE ?";
	public static final String UPDATE_STATUS_QUERY = "UPDATE `Restaurants` SET `Status` = ? WHERE `RestaurantID` = ?";
	public static final String UPDATE_ORDER_STATUS_QUERY = "UPDATE `Restaurants` SET `OrderStatus` = ? WHERE `RestaurantID` = ?";
	public static final String TOP_RATING = "SELECT * FROM `Restaurants` ORDER BY `AverageRating` DESC LIMIT 10";
	public static final String RESTAURANT_TYPE = "SELECT * FROM `Restaurants` WHERE `Type` = ?";
	public static final String SELECT_BY_OWNERID_QUERY = "SELECT * FROM `Restaurants` WHERE `OwnerID` = ?";
	public static final String CHECK_UPDATE_NEED_QUERY = "SELECT COUNT(*) FROM `Restaurants` WHERE `OwnerID` = ?";

	public RestaurantsDaoImpl() {
		connection = DBConnectionUtil.getConnection();
	}

	@Override
	public void addRestaurant(Restaurants restaurant) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(INSERT_QUERY);
			preparedStatement.setInt(1, restaurant.getOwnerID());
			preparedStatement.setString(2, restaurant.getName());
			preparedStatement.setString(3, restaurant.getContactInfo());
			preparedStatement.setString(4, restaurant.getETA());
			preparedStatement.setBigDecimal(5, restaurant.getAverageCost());
			preparedStatement.setString(6, restaurant.getCuisineTypes());
			preparedStatement.setString(7, restaurant.getDiscounts());
			preparedStatement.setString(8, restaurant.getStreet());
			preparedStatement.setString(9, restaurant.getCity());
			preparedStatement.setString(10, restaurant.getState());
			preparedStatement.setString(11, restaurant.getPinCode());
			preparedStatement.setString(12, restaurant.getType());
			preparedStatement.setString(13, restaurant.getImageURL());
			preparedStatement.setString(14, restaurant.getDescription());
			preparedStatement.setString(15, restaurant.getOpeningTime());
			preparedStatement.setString(16, restaurant.getClosingTime());
			preparedStatement.setString(17, restaurant.getTags());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public Restaurants getRestaurantById(int restaurantId) {
		Restaurants restaurant = null;
		ResultSet set = null;
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(SELECT_QUERY);
			statement.setInt(1, restaurantId);
			set = statement.executeQuery();
			if (set.next()) {
				int RestaurantID = set.getInt("RestaurantID");
				int OwnerID = set.getInt("OwnerID");
				String Name = set.getString("Name");
				String ContactInfo = set.getString("ContactInfo");
				float AverageRating = set.getFloat("AverageRating");
				String ETA = set.getString("ETA");
				BigDecimal AverageCost = set.getBigDecimal("AverageCost");
				String CuisineTypes = set.getString("CuisineTypes");
				String Status = set.getString("Status");
				String OrderStatus = set.getString("OrderStatus");
				String Discounts = set.getString("Discounts");
				String Street = set.getString("Street");
				String string = set.getString("CityName");
				String State = set.getString("State");
				String PinCode = set.getString("PinCode");
				String Type = set.getString("Type");
				String ImageURL = set.getString("ImageURL");
				String Description = set.getString("Description");
				String OpeningTime = set.getString("OpeningTime");
				String ClosingTime = set.getString("ClosingTime");
				String Tags = set.getString("Tags");

				restaurant = new Restaurants(RestaurantID, OwnerID, Name, ContactInfo, AverageRating, ETA, AverageCost,
						CuisineTypes, Status, OrderStatus, Discounts, Street, string, State, PinCode, Type, ImageURL,
						Description, OpeningTime, ClosingTime, Tags);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closePreparedStatement(statement);
		}
		return restaurant;
	}

	@Override
	public List<Restaurants> getAllRestaurants() {
		ResultSet set = null;
		Statement statement = null;
		Restaurants restaurants = null;
		ArrayList<Restaurants> restaurantsList = new ArrayList<Restaurants>();

		try {
			statement = connection.createStatement();
			set = statement.executeQuery(SELECT_ALL_QUERY);
			while (set.next()) {
				int RestaurantID = set.getInt("RestaurantID");
				int OwnerID = set.getInt("OwnerID");
				String Name = set.getString("Name");
				String ContactInfo = set.getString("ContactInfo");
				float AverageRating = set.getFloat("AverageRating");
				String ETA = set.getString("ETA");
				BigDecimal AverageCost = set.getBigDecimal("AverageCost");
				String CuisineTypes = set.getString("CuisineTypes");
				String Status = set.getString("Status");
				String OrderStatus = set.getString("OrderStatus");
				String Discounts = set.getString("Discounts");
				String Street = set.getString("Street");
				String string = set.getString("CityName");
				String State = set.getString("State");
				String PinCode = set.getString("PinCode");
				String Type = set.getString("Type");
				String ImageURL = set.getString("ImageURL");
				String Description = set.getString("Description");
				String OpeningTime = set.getString("OpeningTime");
				String ClosingTime = set.getString("ClosingTime");
				String Tags = set.getString("Tags");

				restaurants = new Restaurants(RestaurantID, OwnerID, Name, ContactInfo, AverageRating, ETA, AverageCost,
						CuisineTypes, Status, OrderStatus, Discounts, Street, string, State, PinCode, Type, ImageURL,
						Description, OpeningTime, ClosingTime, Tags);
				restaurantsList.add(restaurants);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(statement);
		}
		return restaurantsList;
	}

	@Override
	public void updateRestaurant(Restaurants restaurant) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(UPDATE_QUERY);
			preparedStatement.setString(1, restaurant.getName());
			preparedStatement.setString(2, restaurant.getContactInfo());
			preparedStatement.setFloat(3, restaurant.getAverageRating());
			preparedStatement.setString(4, restaurant.getETA());
			preparedStatement.setBigDecimal(5, restaurant.getAverageCost());
			preparedStatement.setString(6, restaurant.getCuisineTypes());
			preparedStatement.setString(7, restaurant.getStatus());
			preparedStatement.setString(8, restaurant.getOrderStatus());
			preparedStatement.setString(9, restaurant.getDiscounts());
			preparedStatement.setString(10, restaurant.getStreet());
			preparedStatement.setString(11, restaurant.getCity());
			preparedStatement.setString(12, restaurant.getState());
			preparedStatement.setString(13, restaurant.getPinCode());
			preparedStatement.setString(14, restaurant.getType());
			preparedStatement.setString(15, restaurant.getImageURL());
			preparedStatement.setString(16, restaurant.getDescription());
			preparedStatement.setString(17, restaurant.getOpeningTime());
			preparedStatement.setString(18, restaurant.getClosingTime());
			preparedStatement.setString(19, restaurant.getTags());
			preparedStatement.setInt(20, restaurant.getRestaurantID());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public void deleteRestaurant(int restaurantId) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(DELETE_QUERY);
			preparedStatement.setInt(1, restaurantId);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public List<Restaurants> findRestaurantsByStatus(String status) {
		List<Restaurants> restaurants = new ArrayList<Restaurants>();
		PreparedStatement preparedStatement = null;
		ResultSet set = null;
		Restaurants restaurant = null;
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_ORDER_STATUS_QUERY);
			preparedStatement.setString(1, status);
			set = preparedStatement.executeQuery();
			while (set.next()) {
				int RestaurantID = set.getInt("RestaurantID");
				int OwnerID = set.getInt("OwnerID");
				String Name = set.getString("Name");
				String ContactInfo = set.getString("ContactInfo");
				float AverageRating = set.getFloat("AverageRating");
				String ETA = set.getString("ETA");
				BigDecimal AverageCost = set.getBigDecimal("AverageCost");
				String CuisineTypes = set.getString("CuisineTypes");
				String Status = set.getString("Status");
				String OrderStatus = set.getString("OrderStatus");
				String Discounts = set.getString("Discounts");
				String Street = set.getString("Street");
				String string = set.getString("CityName");
				String State = set.getString("State");
				String PinCode = set.getString("PinCode");
				String Type = set.getString("Type");
				String ImageURL = set.getString("ImageURL");
				String Description = set.getString("Description");
				String OpeningTime = set.getString("OpeningTime");
				String ClosingTime = set.getString("ClosingTime");
				String Tags = set.getString("Tags");

				restaurant = new Restaurants(RestaurantID, OwnerID, Name, ContactInfo, AverageRating, ETA, AverageCost,
						CuisineTypes, Status, OrderStatus, Discounts, Street, string, State, PinCode, Type, ImageURL,
						Description, OpeningTime, ClosingTime, Tags);
				restaurants.add(restaurant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(preparedStatement);
		}
		return restaurants;
	}

	public List<Restaurants> findRestaurantsByOrderStatus(String orderStatus) {
		List<Restaurants> restaurants = new ArrayList<Restaurants>();
		PreparedStatement preparedStatement = null;
		ResultSet set = null;
		Restaurants restaurant = null;
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_STATUS_QUERY);
			preparedStatement.setString(1, orderStatus);
			set = preparedStatement.executeQuery();
			while (set.next()) {
				int RestaurantID = set.getInt("RestaurantID");
				int OwnerID = set.getInt("OwnerID");
				String Name = set.getString("Name");
				String ContactInfo = set.getString("ContactInfo");
				float AverageRating = set.getFloat("AverageRating");
				String ETA = set.getString("ETA");
				BigDecimal AverageCost = set.getBigDecimal("AverageCost");
				String CuisineTypes = set.getString("CuisineTypes");
				String Status = set.getString("Status");
				String OrderStatus = set.getString("OrderStatus");
				String Discounts = set.getString("Discounts");
				String Street = set.getString("Street");
				String string = set.getString("CityName");
				String State = set.getString("State");
				String PinCode = set.getString("PinCode");
				String Type = set.getString("Type");
				String ImageURL = set.getString("ImageURL");
				String Description = set.getString("Description");
				String OpeningTime = set.getString("OpeningTime");
				String ClosingTime = set.getString("ClosingTime");
				String Tags = set.getString("Tags");

				restaurant = new Restaurants(RestaurantID, OwnerID, Name, ContactInfo, AverageRating, ETA, AverageCost,
						CuisineTypes, Status, OrderStatus, Discounts, Street, string, State, PinCode, Type, ImageURL,
						Description, OpeningTime, ClosingTime, Tags);
				restaurants.add(restaurant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(preparedStatement);
		}
		return restaurants;
	}

	@Override
	public List<Restaurants> searchRestaurants(String keyword) {
		List<Restaurants> restaurants = new ArrayList<Restaurants>();
		PreparedStatement preparedStatement = null;
		ResultSet set = null;
		try {
			preparedStatement = connection.prepareStatement(SEARCH_RESTAURANTS_QUERY);
			preparedStatement.setString(1, "%" + keyword + "%");
			preparedStatement.setString(2, "%" + keyword + "%");
			set = preparedStatement.executeQuery();
			while (set.next()) {
				int RestaurantID = set.getInt("RestaurantID");
				int OwnerID = set.getInt("OwnerID");
				String Name = set.getString("Name");
				String ContactInfo = set.getString("ContactInfo");
				float AverageRating = set.getFloat("AverageRating");
				String ETA = set.getString("ETA");
				BigDecimal AverageCost = set.getBigDecimal("AverageCost");
				String CuisineTypes = set.getString("CuisineTypes");
				String Status = set.getString("Status");
				String OrderStatus = set.getString("OrderStatus");
				String Discounts = set.getString("Discounts");
				String Street = set.getString("Street");
				String string = set.getString("CityName");
				String State = set.getString("State");
				String PinCode = set.getString("PinCode");
				String Type = set.getString("Type");
				String ImageURL = set.getString("ImageURL");
				String Description = set.getString("Description");
				String OpeningTime = set.getString("OpeningTime");
				String ClosingTime = set.getString("ClosingTime");
				String Tags = set.getString("Tags");

				new Restaurants(RestaurantID, OwnerID, Name, ContactInfo, AverageRating, ETA, AverageCost, CuisineTypes,
						Status, OrderStatus, Discounts, Street, string, State, PinCode, Type, ImageURL, Description,
						OpeningTime, ClosingTime, Tags);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(preparedStatement);
		}
		return restaurants;
	}

	@Override
	public void updateRestaurantStatus(int restaurantId, String status) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(UPDATE_STATUS_QUERY);
			preparedStatement.setString(1, status);
			preparedStatement.setInt(2, restaurantId);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeStatement(preparedStatement);
		}
	}

	public void updateRestaurantOrderStatus(int restaurantId, String orderStatus) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(UPDATE_ORDER_STATUS_QUERY);
			preparedStatement.setString(1, orderStatus);
			preparedStatement.setInt(2, restaurantId);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeStatement(preparedStatement);
		}
	}

	@Override
	public List<Restaurants> findTopRatedRestaurants() {
		ResultSet set = null;
		Statement statement = null;
		Restaurants restaurants = null;
		ArrayList<Restaurants> topRestaurantsList = new ArrayList<Restaurants>();

		try {
			statement = connection.createStatement();
			set = statement.executeQuery(TOP_RATING);
			while (set.next()) {
				int RestaurantID = set.getInt("RestaurantID");
				int OwnerID = set.getInt("OwnerID");
				String Name = set.getString("Name");
				String ContactInfo = set.getString("ContactInfo");
				float AverageRating = set.getFloat("AverageRating");
				String ETA = set.getString("ETA");
				BigDecimal AverageCost = set.getBigDecimal("AverageCost");
				String CuisineTypes = set.getString("CuisineTypes");
				String Status = set.getString("Status");
				String OrderStatus = set.getString("OrderStatus");
				String Discounts = set.getString("Discounts");
				String Street = set.getString("Street");
				String string = set.getString("CityName");
				String State = set.getString("State");
				String PinCode = set.getString("PinCode");
				String Type = set.getString("Type");
				String ImageURL = set.getString("ImageURL");
				String Description = set.getString("Description");
				String OpeningTime = set.getString("OpeningTime");
				String ClosingTime = set.getString("ClosingTime");
				String Tags = set.getString("Tags");

				restaurants = new Restaurants(RestaurantID, OwnerID, Name, ContactInfo, AverageRating, ETA, AverageCost,
						CuisineTypes, Status, OrderStatus, Discounts, Street, string, State, PinCode, Type, ImageURL,
						Description, OpeningTime, ClosingTime, Tags);
				topRestaurantsList.add(restaurants);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(statement);
		}
		return topRestaurantsList;
	}

	@Override
	public List<Restaurants> findRestaurantsByType(String type) {
		List<Restaurants> restaurants = new ArrayList<Restaurants>();
		PreparedStatement preparedStatement = null;
		ResultSet set = null;
		Restaurants restaurant = null;
		try {
			preparedStatement = connection.prepareStatement(RESTAURANT_TYPE);
			preparedStatement.setString(1, type);
			set = preparedStatement.executeQuery();
			while (set.next()) {
				int RestaurantID = set.getInt("RestaurantID");
				int OwnerID = set.getInt("OwnerID");
				String Name = set.getString("Name");
				String ContactInfo = set.getString("ContactInfo");
				float AverageRating = set.getFloat("AverageRating");
				String ETA = set.getString("ETA");
				BigDecimal AverageCost = set.getBigDecimal("AverageCost");
				String CuisineTypes = set.getString("CuisineTypes");
				String Status = set.getString("Status");
				String OrderStatus = set.getString("OrderStatus");
				String Discounts = set.getString("Discounts");
				String Street = set.getString("Street");
				String string = set.getString("CityName");
				String State = set.getString("State");
				String PinCode = set.getString("PinCode");
				String Type = set.getString("Type");
				String ImageURL = set.getString("ImageURL");
				String Description = set.getString("Description");
				String OpeningTime = set.getString("OpeningTime");
				String ClosingTime = set.getString("ClosingTime");
				String Tags = set.getString("Tags");

				restaurant = new Restaurants(RestaurantID, OwnerID, Name, ContactInfo, AverageRating, ETA, AverageCost,
						CuisineTypes, Status, OrderStatus, Discounts, Street, string, State, PinCode, Type, ImageURL,
						Description, OpeningTime, ClosingTime, Tags);
				restaurants.add(restaurant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(preparedStatement);
		}
		return restaurants;
	}

	@Override
	public boolean restaurantNeedsUpdate(int ownerId) {
		PreparedStatement preparedStatement = null;
		ResultSet set = null;
		try {
			preparedStatement = connection.prepareStatement(CHECK_UPDATE_NEED_QUERY);
			preparedStatement.setInt(1, ownerId);
			set = preparedStatement.executeQuery();
			if (set.next()) {
				int count = set.getInt(1);
				return count == 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(preparedStatement);
		}
		return false;
	}

	@Override
	public Restaurants getRestaurantByOwnerId(int ownerId) {
		PreparedStatement preparedStatement = null;
		ResultSet set = null;
		Restaurants restaurant = null;
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_OWNERID_QUERY);
			preparedStatement.setInt(1, ownerId);
			set = preparedStatement.executeQuery();
			if (set.next()) {
				int RestaurantID = set.getInt("RestaurantID");
				int OwnerID = set.getInt("OwnerID");
				String Name = set.getString("Name");
				String ContactInfo = set.getString("ContactInfo");
				float AverageRating = set.getFloat("AverageRating");
				String ETA = set.getString("ETA");
				BigDecimal AverageCost = set.getBigDecimal("AverageCost");
				String CuisineTypes = set.getString("CuisineTypes");
				String Status = set.getString("Status");
				String OrderStatus = set.getString("OrderStatus");
				String Discounts = set.getString("Discounts");
				String Street = set.getString("Street");
				String string = set.getString("CityName");
				String State = set.getString("State");
				String PinCode = set.getString("PinCode");
				String Type = set.getString("Type");
				String ImageURL = set.getString("ImageURL");
				String Description = set.getString("Description");
				String OpeningTime = set.getString("OpeningTime");
				String ClosingTime = set.getString("ClosingTime");
				String Tags = set.getString("Tags");

				restaurant = new Restaurants(RestaurantID, OwnerID, Name, ContactInfo, AverageRating, ETA, AverageCost,
						CuisineTypes, Status, OrderStatus, Discounts, Street, string, State, PinCode, Type, ImageURL,
						Description, OpeningTime, ClosingTime, Tags);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(set);
			DBConnectionUtil.closeStatement(preparedStatement);
		}
		return restaurant;
	}

	public void closeConnection() {
		DBConnectionUtil.closeConnection(connection);
	}
}

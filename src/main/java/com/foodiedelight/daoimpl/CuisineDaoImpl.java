package com.foodiedelight.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.CuisineDao;
import com.foodiedelight.model.Cuisine;
import com.foodiedelight.util.DBConnectionUtil;

public class CuisineDaoImpl implements CuisineDao {
    
    private Connection connection;
    public static final String INSERT_QUERY = "INSERT INTO `Cuisines` (`CuisineName`, `CuisineDescription`, `CuisineUrl`) VALUES (?, ?, ?)";
    public static final String UPDATE_QUERY = "UPDATE `Cuisines` SET `CuisineName` = ?, `CuisineDescription` = ?, `CuisineUrl` = ? WHERE `CuisineID` = ?";
    public static final String DELETE_QUERY = "DELETE FROM `Cuisines` WHERE `CuisineID` = ?";
    public static final String SELECT_QUERY = "SELECT * FROM `Cuisines` WHERE `CuisineID` = ?";
    public static final String SELECT_ALL_QUERY = "SELECT * FROM `Cuisines`";

    public CuisineDaoImpl() {
        connection = DBConnectionUtil.getConnection(); 
    }
    
    @Override
    public void addCuisine(Cuisine cuisine) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(INSERT_QUERY);
            preparedStatement.setString(1, cuisine.getCuisineName());
            preparedStatement.setString(2, cuisine.getCuisineDescription());
            preparedStatement.setString(3, cuisine.getCuisineUrl());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public boolean updateCuisine(Cuisine cuisine) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_QUERY);
            preparedStatement.setString(1, cuisine.getCuisineName());
            preparedStatement.setString(2, cuisine.getCuisineDescription());
            preparedStatement.setString(3, cuisine.getCuisineUrl());
            preparedStatement.setInt(4, cuisine.getCuisineID());
            int rowsUpdated = preparedStatement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return false;
    }

    @Override
    public boolean deleteCuisine(int cuisineID) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(DELETE_QUERY);
            preparedStatement.setInt(1, cuisineID);
            int rowsDeleted = preparedStatement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return false;
    }

    @Override
    public Cuisine getCuisineByID(int cuisineID) {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        Cuisine cuisine = null;
        try {
            preparedStatement = connection.prepareStatement(SELECT_QUERY);
            preparedStatement.setInt(1, cuisineID);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                cuisine = extractCuisine(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
			DBConnectionUtil.closeResultSet(resultSet);
        	DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return cuisine;
    }

    @Override
    public List<Cuisine> getAllCuisines() {
        Statement statement = null;
        ResultSet resultSet = null;
        List<Cuisine> cuisineList = new ArrayList<>();
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(SELECT_ALL_QUERY);
            while (resultSet.next()) {
                cuisineList.add(extractCuisine(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
			DBConnectionUtil.closeResultSet(resultSet);
        	DBConnectionUtil.closeStatement(statement);
        }
        return cuisineList;
    }

    private Cuisine extractCuisine(ResultSet resultSet) throws SQLException {
        int cuisineID = resultSet.getInt("CuisineID");
        String cuisineName = resultSet.getString("CuisineName");
        String cuisineDescription = resultSet.getString("CuisineDescription");
        String cuisineUrl = resultSet.getString("CuisineUrl");
        return new Cuisine(cuisineID, cuisineName, cuisineDescription, cuisineUrl);
    }

    public boolean cuisineExists(String cuisineName) {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String query = "SELECT COUNT(*) FROM Cuisines WHERE CuisineName = ?";
        try {
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, cuisineName);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
			DBConnectionUtil.closeResultSet(resultSet);
        	DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return false;
    }
    
    public void closeConnection() {
        DBConnectionUtil.closeConnection(connection);
    }
}

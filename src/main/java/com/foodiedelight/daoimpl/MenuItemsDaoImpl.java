package com.foodiedelight.daoimpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.MenuItemsDao;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.util.DBConnectionUtil; 

public class MenuItemsDaoImpl implements MenuItemsDao {

    private Connection connection;
    public static final String INSERT_QUERY = "INSERT INTO `MenuItems` (`RestaurantID`, `Name`, `Description`, `Price`, `PhotoURL`, `Status`, `Type`)"
            + "VALUES (?, ?, ?, ?, ?, ?, ?)";
    public static final String UPDATE_QUERY = "UPDATE `MenuItems` SET `Name` = ?, `Description` = ?, "
            + "`Price` = ?, `PhotoURL` = ?, `Status` = ?, `Type` = ? WHERE `ItemID` = ?";
    public static final String UPDATE_BYID_QUERY = "UPDATE `MenuItems` SET `Name` = ?, `Description` = ?, "
            + "`Price` = ?, `PhotoURL` = ?, `Status` = ?, `Type` = ?, `RestaurantID` = ? WHERE ItemID = ?";
    public static final String DELETE_QUERY = "DELETE FROM `MenuItems` WHERE `ItemID` = ?";
    public static final String SELECT_QUERY = "SELECT * FROM `MenuItems` WHERE `ItemID` = ?";
    public static final String SELECT_ALL_QUERY = "SELECT * FROM `MenuItems`";
    public static final String SELECT_PARTICULAR_QUERY = "SELECT * FROM `MenuItems` WHERE `RestaurantID` = ?";

    public MenuItemsDaoImpl() {
        connection = DBConnectionUtil.getConnection(); 
    }

    @Override
    public void addMenuItem(MenuItems menuItems) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(INSERT_QUERY);
            preparedStatement.setInt(1, menuItems.getRestaurantID());
            preparedStatement.setString(2, menuItems.getName());
            preparedStatement.setString(3, menuItems.getDescription());
            preparedStatement.setBigDecimal(4, menuItems.getPrice());
            preparedStatement.setString(5, menuItems.getPhotoURL());
            preparedStatement.setString(6, menuItems.getStatus());
            preparedStatement.setString(7, menuItems.getType());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public MenuItems getMenuItemById(int itemID) {
        MenuItems menuItems = null;
        ResultSet set = null;
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement(SELECT_QUERY);
            statement.setInt(1, itemID);
            set = statement.executeQuery();
            if (set.next()) {
                menuItems = extractedMenuItems(set, itemID);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closePreparedStatement(statement);
        }
        return menuItems;
    }

    @Override
    public List<MenuItems> getMenuItemsByRestaurantId(int restaurantID) {
        ResultSet set = null;
        PreparedStatement statement = null;
        ArrayList<MenuItems> menuItemsList = new ArrayList<>();

        try {
            statement = connection.prepareStatement(SELECT_PARTICULAR_QUERY);
            statement.setInt(1, restaurantID);
            set = statement.executeQuery();
            while (set.next()) {
                int ItemID = set.getInt("ItemID");
                MenuItems menuItems = extractedMenuItems(set, ItemID);
                menuItemsList.add(menuItems);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closePreparedStatement(statement);
        }

        return menuItemsList;
    }

    @Override
    public void updateMenuItem(MenuItems menuItems) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_QUERY);
            preparedStatement.setString(1, menuItems.getName());
            preparedStatement.setString(2, menuItems.getDescription());
            preparedStatement.setBigDecimal(3, menuItems.getPrice());
            preparedStatement.setString(4, menuItems.getPhotoURL());
            preparedStatement.setString(5, menuItems.getStatus());
            preparedStatement.setString(6, menuItems.getType());
            preparedStatement.setInt(7, menuItems.getItemID());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public void updateMenuItemByID(MenuItems menuItems) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_BYID_QUERY);
            preparedStatement.setString(1, menuItems.getName());
            preparedStatement.setString(2, menuItems.getDescription());
            preparedStatement.setBigDecimal(3, menuItems.getPrice());
            preparedStatement.setString(4, menuItems.getPhotoURL());
            preparedStatement.setString(5, menuItems.getStatus());
            preparedStatement.setString(6, menuItems.getType());
            preparedStatement.setInt(7, menuItems.getRestaurantID());
            preparedStatement.setInt(8, menuItems.getItemID());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public void deleteMenuItem(int itemID) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(DELETE_QUERY);
            preparedStatement.setInt(1, itemID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    public MenuItems extractedMenuItems(ResultSet set, int ItemID) throws SQLException {
        int restaurantID = set.getInt("RestaurantID");
        String Name = set.getString("Name");
        String Description = set.getString("Description");
        BigDecimal Price = set.getBigDecimal("Price");
        String PhotoURL = set.getString("PhotoURL");
        String Status = set.getString("Status");
        String Type = set.getString("Type");

        return new MenuItems(ItemID, restaurantID, Name, Description, Price, PhotoURL, Status, Type);
    }

    @Override
    public int countMenuItemsByRestaurantId(int restaurantID) {
        PreparedStatement preparedStatement = null;
        ResultSet set = null;
        String sql = "SELECT COUNT(*) AS item_count FROM `MenuItems` WHERE `RestaurantID` = ?";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, restaurantID);
            set = preparedStatement.executeQuery();
            if (set.next()) {
                return set.getInt("item_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return 0;
    }

    @Override
    public List<MenuItems> getAllMenuItems() {
        ResultSet set = null;
        Statement statement = null;
        ArrayList<MenuItems> menuItemsList = new ArrayList<>();

        try {
            statement = connection.createStatement();
            set = statement.executeQuery(SELECT_ALL_QUERY);
            while (set.next()) {
                int ItemID = set.getInt("ItemID");
                MenuItems menuItems = extractedMenuItems(set, ItemID);
                menuItemsList.add(menuItems);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closeStatement(statement);
        }

        return menuItemsList;
    }

    public void updateStatus(int itemId, String status) {
        PreparedStatement preparedStatement = null;
        try {
            String sql = "UPDATE `MenuItems` SET `Status` = ? WHERE `ItemID` = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, itemId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    public String getStatus(int itemId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String status = null;
        try {
            String sql = "SELECT `Status` FROM `MenuItems` WHERE `ItemID` = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, itemId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                status = rs.getString("Status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(rs);
            DBConnectionUtil.closePreparedStatement(stmt);
        }
        return status;
    }
    
    public void closeConnection() {
        DBConnectionUtil.closeConnection(connection);
    }
}

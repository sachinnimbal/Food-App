package com.foodiedelight.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.AgentsDao;
import com.foodiedelight.model.Agents;
import com.foodiedelight.util.DBConnectionUtil;

public class AgentsDaoImpl implements AgentsDao {

    private Connection connection;
    public static final String INSERT_QUERY = "INSERT INTO `Agents` (`UserId`, `ProfileURL`, `Status`) VALUES (?, ?, ?)";
    public static final String SELECT_BY_USERID = "SELECT * FROM `Agents` WHERE `UserID` = ?";
    public static final String SELECT_BY_STATUS = "UPDATE `Agents` SET `Status` = ? WHERE `AgentID` = ?";
    public static final String UPDATE_QUERY = "SELECT COUNT(*) FROM `Agents` WHERE `UserID` = ?";

    public AgentsDaoImpl() {
        connection = DBConnectionUtil.getConnection();
    }

    @Override
    public void addAgent(Agents agent) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(INSERT_QUERY);
            preparedStatement.setInt(1, agent.getUserID());
            preparedStatement.setString(2, agent.getProfileURL());
            preparedStatement.setString(3, agent.getStatus());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public Agents getAgentByUserId(int userID) {
        Agents agent = null;
        ResultSet set = null;
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement(SELECT_BY_USERID);
            statement.setInt(1, userID);
            set = statement.executeQuery();
            if (set.next()) {
                agent = extractAgent(set);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closePreparedStatement(statement);
        }
        return agent;
    }

    @Override
    public List<Agents> getAllAgents() {
        ResultSet set = null;
        PreparedStatement statement = null;
        ArrayList<Agents> agentsList = new ArrayList<>();
        try {
            statement = connection.prepareStatement("SELECT * FROM `Agents`");
            set = statement.executeQuery();
            while (set.next()) {
                Agents agent = extractAgent(set);
                agentsList.add(agent);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closePreparedStatement(statement);
        }
        return agentsList;
    }

    @Override
    public void updateAgent(Agents agent) {
        // Implement updateAgent method similar to addAgent
    }

    @Override
    public void deleteAgent(int agentId) {
        // Implement deleteAgent method similar to addAgent
    }

    @Override
    public void updateAgentStatus(int agentId, String status) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(SELECT_BY_STATUS);
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, agentId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
    }

    @Override
    public boolean agentNeedsUpdate(int userId) {
        PreparedStatement preparedStatement = null;
        ResultSet set = null;
        try {
            preparedStatement = connection.prepareStatement(UPDATE_QUERY);
            preparedStatement.setInt(1, userId);
            set = preparedStatement.executeQuery();
            if (set.next()) {
                int count = set.getInt(1);
                return count == 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnectionUtil.closeResultSet(set);
            DBConnectionUtil.closePreparedStatement(preparedStatement);
        }
        return false;
    }

    private Agents extractAgent(ResultSet set) throws SQLException {
        int AgentID = set.getInt("AgentID");
        int UserID = set.getInt("UserID");
        String ProfileURL = set.getString("ProfileURL");
        String Status = set.getString("Status");
        float AverageRatings = set.getFloat("AverageRatings");
        return new Agents(AgentID, UserID, ProfileURL, Status, AverageRatings);
    }
    
    public void closeConnection() {
        DBConnectionUtil.closeConnection(connection);
    }
}

package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.Users;

public interface UsersDao {

	boolean addUser(Users user);

	Users getUserById(int userID);

	List<Users> getAllUsers();

	List<Users> getUserByRole(String role);

	void updateUser(Users user);

	void updateUserRole(Users user);

	void deleteUser(int userID);

	boolean updateDeliveryInfo(Users user);

	void updateUserStatus(Users user);

	int countUsersByStatus(String status);

	List<Users> getUsersByStatus(String status);

	Users validUser(String username);
}

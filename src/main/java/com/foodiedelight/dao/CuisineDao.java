package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.Cuisine;

public interface CuisineDao {

	void addCuisine(Cuisine cuisine);

	Cuisine getCuisineByID(int cuisineID);

	List<Cuisine> getAllCuisines();

	boolean updateCuisine(Cuisine cuisine);

	boolean deleteCuisine(int cuisineID);

}

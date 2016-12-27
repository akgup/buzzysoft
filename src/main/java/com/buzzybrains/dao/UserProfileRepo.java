package com.buzzybrains.dao;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.buzzybrains.model.UserProfile;



public interface UserProfileRepo extends CrudRepository<UserProfile, Integer> {

	
	@Query(value = "SELECT * FROM user_profile  where user_id=?1", nativeQuery = true)
	UserProfile findByUserId(int userid);
	
	
	
}

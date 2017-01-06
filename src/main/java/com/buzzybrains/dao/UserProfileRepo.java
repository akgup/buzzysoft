package com.buzzybrains.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.buzzybrains.model.UserProfile;



public interface UserProfileRepo extends CrudRepository<UserProfile, Integer> {

	
	@Query(value = "SELECT * FROM user_profile  where user_id=?1", nativeQuery = true)
	UserProfile findByUserId(int userid);
	
	
	
	@Query(value = "SELECT * FROM user_profile  where supervisor_id=?1", nativeQuery = true)
	List<UserProfile> findTeamBySupervisorId(int userid);
	
	
}

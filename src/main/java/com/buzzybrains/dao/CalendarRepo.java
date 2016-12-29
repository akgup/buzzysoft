package com.buzzybrains.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.buzzybrains.model.Calendar;

public interface CalendarRepo extends CrudRepository<Calendar, Integer> {

	
	
	@Query(value="SELECT * FROM calendar  where user_id=?1 ", nativeQuery = true)
	List<Calendar> findCalendarByUserId(int userid);
}

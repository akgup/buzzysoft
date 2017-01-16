package com.buzzybrains.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.buzzybrains.model.Calendar;

public interface CalendarRepo extends CrudRepository<Calendar, Integer> {

	@Query(value = "SELECT * FROM calendar  where user_id=?1 ", nativeQuery = true)
	List<Calendar> findCalendarByUserId(int userid);

	@Query(value = "select count(1) from calendar c where (c.start >= :fromDate AND c.start <= :endDate )and c.title='Leave' and c.user_id=  :userid", nativeQuery = true)

	int findLeaveCountByUserId(@Param("userid") int userid, @Param("fromDate") Date from, @Param("endDate") Date end);

	@Query(value = "SELECT count(1) FROM calendar  where start= :inDate ", nativeQuery = true)
	int checkIfPresent(@Param("inDate") Date date);

	@Query(value = "SELECT count(1) FROM calendar  where start= :inDate and user_id=:userId", nativeQuery = true)
	int checkIfPresent(@Param("inDate") Date date, @Param("userId") int userid);

}

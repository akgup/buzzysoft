package com.buzzybrains.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buzzybrains.dao.CalendarRepo;
import com.buzzybrains.model.Calendar;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class CalendarController {

	@Autowired
	CalendarRepo calendarRepo;

	@GetMapping("/home")
	public String showCalendar(HttpServletRequest request, int userid) {
		List<Calendar> dataArray = calendarRepo.findCalendarByUserId(userid);
		ObjectMapper mapper = new ObjectMapper();

		try {
			String calData = mapper.writeValueAsString(dataArray);

			request.setAttribute("caldata", calData);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "calendar";
	}

	@PostMapping("/calendar-data")
	@ResponseBody
	public Calendar insertCalDatar(@ModelAttribute Calendar calendar, BindingResult bindingResult,
			HttpServletRequest request) {
		Calendar caldata = calendarRepo.save(calendar);
		return caldata;
	}

	@GetMapping("/calendar-data-remove")
	@ResponseBody
	public String removeCalData(int id) {
		calendarRepo.delete(calendarRepo.findOne(id));
		return "success";
	}

}

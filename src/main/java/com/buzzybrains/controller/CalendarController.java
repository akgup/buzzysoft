package com.buzzybrains.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CalendarController {
	

	@GetMapping("/attendance")
	public String showCalendar(HttpServletRequest request) {

		return "calendar";
	}

}

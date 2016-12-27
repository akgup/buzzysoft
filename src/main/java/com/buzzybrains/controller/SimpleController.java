package com.buzzybrains.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SimpleController {

	@GetMapping("/hello")
	public String getAllTasks() {
		return "hello world";
	}


}

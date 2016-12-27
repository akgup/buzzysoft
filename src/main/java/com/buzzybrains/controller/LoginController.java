package com.buzzybrains.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.buzzybrains.dao.UserCredentialsRepository;
import com.buzzybrains.model.UserCredentials;

@Controller
public class LoginController {

	@Autowired
	UserCredentialsRepository userCredentialsRepository;

	@GetMapping("/")
	public String home(HttpServletRequest request) {

		return "login";
	}

	@PostMapping("/validate")
	public String validateLoginDetails(@ModelAttribute UserCredentials userCredentials, BindingResult bindingResult, HttpServletRequest request,
			HttpServletResponse response) {
		String username = userCredentials.getUserName();
		String password = userCredentials.getPassword();
		String redirect="";

		UserCredentials userObject = userCredentialsRepository.findByUserName(username);

		if (userObject != null) {
			if (userObject.getPassword().equals(password)) {
				Cookie usernameCookie = new Cookie("username", username);
				Cookie useridCookie = new Cookie("userid", Integer.toString(userObject.getUserId()));
				response.addCookie(usernameCookie);
				response.addCookie(useridCookie);
				request.setAttribute("mode", "MODE_HOME");
				redirect= "redirect:" + "/home";
			}
			
			else
			{
				redirect=  "redirect:" + "/";
			}
		}
return redirect;
	}



	@GetMapping("/home")
	public String homepage(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_HOME");
		return "index";
	}
	
	
	@GetMapping("/logout")
	private String eraseCookie(HttpServletRequest req, HttpServletResponse resp) {
	    Cookie[] cookies = req.getCookies();
	    if (cookies != null)
	        for (int i = 0; i < cookies.length; i++) {
	            cookies[i].setValue("");
	            cookies[i].setPath("/");
	            cookies[i].setMaxAge(0);
	            resp.addCookie(cookies[i]);
	        }
	    
	   	    return  "redirect:" + "/";
	}



}

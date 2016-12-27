package com.buzzybrains.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.buzzybrains.dao.UserProfileRepo;
import com.buzzybrains.model.UserProfile;

@Controller
public class ProfileController {

	
	@Autowired
	UserProfileRepo userProfileRepo;
	
	
	
	@GetMapping("/myProfile")
	public String displayProfile(HttpServletRequest request, int userid) {
		request.setAttribute("userProfile", userProfileRepo.findByUserId(userid));

		return "profile";
	}
	

	@PostMapping("/saveProfile")
	public String saveProfile(@ModelAttribute UserProfile userProfile, BindingResult bindingResult,HttpServletRequest request) {
		
		System.out.println(userProfile);
			userProfileRepo.save(userProfile);

		return "profile";
	}
}

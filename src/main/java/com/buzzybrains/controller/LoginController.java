package com.buzzybrains.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buzzybrains.dao.UserCredentialsRepository;
import com.buzzybrains.model.UserCredentials;

@Controller
public class LoginController {

	@Autowired
	UserCredentialsRepository userCredentialsRepository;
	
    @RequestMapping("/hi")
    public @ResponseBody String hiThere(){
        return "hello world!";
    }

	@GetMapping("/")
	public String home(HttpServletRequest request) {

		String redirect = "login";
		int uid = 0;
		String uname = null;

		Cookie[] cookies = request.getCookies();
		if (cookies != null)
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username"))
					uname = cookie.getValue();
				if (cookie.getName().equals("userid")) {
					uid = Integer.parseInt(cookie.getValue());

				}

			}
		if (uname != null) {
			redirect = "redirect:home?userid=" + uid;
		} 

		return redirect;
	}
	
/*	@GetMapping("/")
	public String home(HttpServletRequest request) {
		return "test";
	}*/

	@PostMapping("/validate")
	public String validateLoginDetails(@ModelAttribute UserCredentials userCredentials, BindingResult bindingResult,
			HttpServletRequest request, HttpServletResponse response) {
		String username = userCredentials.getUserName();
		String password = userCredentials.getPassword();
		String redirect = "";

		UserCredentials userObject = userCredentialsRepository.findByUserName(username);

		if (userObject != null) {
			if (userObject.getPassword().equals(password)) {

				// creating a session
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				session.setAttribute("userid", Integer.toString(userObject.getUserId()));

				Cookie usernameCookie = new Cookie("username", username);
				Cookie useridCookie = new Cookie("userid", Integer.toString(userObject.getUserId()));
				response.addCookie(usernameCookie);
				response.addCookie(useridCookie);
				request.setAttribute("mode", "MODE_HOME");
				redirect = "redirect:" + "/home?userid=" + userObject.getUserId();
			}

			else {
				redirect = "redirect:/";
			}
		} else {
			redirect = "redirect:/";

		}
		return redirect;
	}

	@GetMapping("/logout")
	private String eraseCookie(HttpServletRequest req, HttpServletResponse resp) {

		HttpSession session = req.getSession();
		session.invalidate();

		Cookie[] cookies = req.getCookies();
		if (cookies != null)
			for (int i = 0; i < cookies.length; i++) {
				cookies[i].setValue("");
				cookies[i].setPath("/");
				cookies[i].setMaxAge(0);
				resp.addCookie(cookies[i]);
			}

		return "redirect:" + "/";
	}

}

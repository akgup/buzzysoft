package com.buzzybrains.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.buzzybrains.dao.TaskRepository;
import com.buzzybrains.model.Task;

@Controller
public class TaskController {

	@Autowired
	TaskRepository taskRepository;

	@PostMapping("/save-task")
	public String saveTask(@ModelAttribute Task task, BindingResult bindingResult, HttpServletRequest request) {

		task.setStatus(request.getParameter("status").toString());

			if(task.getTaskDate()!=null)
		{
			taskRepository.save(task);
		}
		else
		{
			taskRepository.updateTask(task.getId(), task.getName(), task.getDescription(), task.getStatus(), task.getComments());
			
		}
	
		request.setAttribute("tasks", taskRepository.findTaskListByuserId(task.getUserId()));
		request.setAttribute("mode", "MODE_TASKS");
		return "task";
	}

	@GetMapping("/new-task")
	public String newTask(@ModelAttribute Task task, HttpServletRequest request) {
		request.setAttribute("mode", "MODE_NEW");
		return "task";
	}

	@GetMapping("/update-task")
	public String updateTask(@RequestParam int id, HttpServletRequest request) {

		request.setAttribute("task", taskRepository.findOne(id));
		request.setAttribute("mode", "MODE_UPDATE");
		return "task";
	}

	@GetMapping("/delete-task")
	public String deleteTask(@RequestParam int id, @RequestParam int userid, HttpServletRequest request) {
		taskRepository.delete(id);
		request.setAttribute("mode", "MODE_TASKS");
		return "redirect:/all-tasks?userid=" + userid;
	}

	@GetMapping("/all-tasks")
	public String allTasks(HttpServletRequest request, int userid) {
		request.setAttribute("tasks", taskRepository.findTaskListByuserId(userid));
		request.setAttribute("mode", "MODE_TASKS");
		return "task";
	}
}

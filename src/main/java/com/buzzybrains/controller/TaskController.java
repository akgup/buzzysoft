package com.buzzybrains.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buzzybrains.dao.TaskRepository;
import com.buzzybrains.model.Task;

@Controller
public class TaskController {

	@Autowired
	TaskRepository taskRepository;

	@PostMapping("/save-task")
	@ResponseBody
	public Task  saveTask(@ModelAttribute Task task, BindingResult bindingResult, HttpServletRequest request) {

		task.setStatus(request.getParameter("status").toString());

			if(task.getTaskDate()!=null)
		{
			taskRepository.save(task);
		}
		else
		{
			taskRepository.updateTask(task.getId(), task.getName(), task.getDescription(), task.getStatus(), task.getComments());
			
		}
	
		
		return task;
	}


	@GetMapping("/delete-task")
	@ResponseBody
	public String deleteTask(@RequestParam int id, @RequestParam int userid, HttpServletRequest request) {
		taskRepository.delete(id);
		return "Successfully deleted";
	}

	@GetMapping("/all-tasks")
	public String allTasks(HttpServletRequest request, int userid) {
		request.setAttribute("tasks", taskRepository.findTaskListByuserId(userid));
		request.setAttribute("mode", "MODE_TASKS");
		return "task";
	}
	
	@GetMapping("/task-list")
	@ResponseBody
	public List<Task> taskList( int userid) {
		return taskRepository.findTaskListByuserId(userid);
	}

}

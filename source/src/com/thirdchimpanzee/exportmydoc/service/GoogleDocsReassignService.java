package com.thirdchimpanzee.exportmydoc.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import com.thirdchimpanzee.exportmydoc.entity.GoogleDocsReassignTask;

public class GoogleDocsReassignService {
	public static final Logger _logger = Logger.getLogger(GoogleDocsReassignService.class.toString());

	private static GoogleDocsReassignService _self = null;

	private GoogleDocsReassignService() {
	}

	public static GoogleDocsReassignService getInstance() {
		if (_self == null) {
			_self = new GoogleDocsReassignService();
			ObjectifyService.register(GoogleDocsReassignTask.class);
		}
		return _self;
	}
	
	public String addReassignTask(String emailAddress,String newOwner,String msg, String conversionResult, Date requestDate, String status) throws Exception {
		Objectify obj = ObjectifyService.begin();
		GoogleDocsReassignTask _record = new GoogleDocsReassignTask();
		_record.setEmailAddress(emailAddress);
		_record.setNewOwner(newOwner);
		_record.setMsg(msg);
		_record.setConversionResult(conversionResult);
		_record.setStatus(status);
		_record.setRequestDate(requestDate);
		obj.put(_record);
		return "success";
	}
	
	public GoogleDocsReassignTask findReassignTaskByID(String taskId) {
		try {
			Objectify obj = ObjectifyService.begin();
			GoogleDocsReassignTask r = obj.query(GoogleDocsReassignTask.class).filter("id",taskId).get();
			if (r != null)
				return r;
			return null;
		} catch (Exception ex) {
			return null;
		}
	}
	
	public List<GoogleDocsReassignTask> getAllReassignTasksByEmailId(String emailId, String status) throws Exception {
		List<GoogleDocsReassignTask> _results = new ArrayList<GoogleDocsReassignTask>();
		Objectify obj = ObjectifyService.begin();
		_results = obj.query(GoogleDocsReassignTask.class).filter("emailAddress",emailId).filter("status",status).list();
		return _results;
	}

	public List<GoogleDocsReassignTask> getAllReminders(String status) throws Exception {
		List<GoogleDocsReassignTask> _results = new ArrayList<GoogleDocsReassignTask>();
		Objectify obj = ObjectifyService.begin();
		_results = obj.query(GoogleDocsReassignTask.class).filter("status",status).list();
		return _results;
	}	
}

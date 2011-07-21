package com.thirdchimpanzee.exportmydoc.entity;

import java.util.Date;

import javax.persistence.Id;

/**
 * Entity class for Reassign Google Docs Task object
 * 
 * @author irani_r
 * @version 1.0
 * 
 */
public class GoogleDocsReassignTask {
	@Id private Long id;
	private String emailAddress;
	private String newOwner;
	private String msg;
	private String conversionResult;
	private Date requestDate;
	private String status;
	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}
	
	/**
	 * @return the emailAddress
	 */
	public String getEmailAddress() {
		return emailAddress;
	}
	/**
	 * @param emailAddress the emailAddress to set
	 */
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	/**
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}
	/**
	 * @param msg the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}
	/**
	 * @return the requestDate
	 */
	public Date getRequestDate() {
		return requestDate;
	}
	/**
	 * @param requestDate the requestDate to set
	 */
	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the conversionResult
	 */
	public String getConversionResult() {
		return conversionResult;
	}
	/**
	 * @param conversionResult the conversionResult to set
	 */
	public void setConversionResult(String conversionResult) {
		this.conversionResult = conversionResult;
	}
	/**
	 * @return the newOwner
	 */
	public String getNewOwner() {
		return newOwner;
	}
	/**
	 * @param newOwner the newOwner to set
	 */
	public void setNewOwner(String newOwner) {
		this.newOwner = newOwner;
	}
	

}

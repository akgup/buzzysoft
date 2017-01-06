package com.buzzybrains.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity(name = "user_profile")
public class UserProfile {

	public UserProfile() {

	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int userProfileId;

	private int userId;

	private String employeeId;
	private String employeeName;
	private String employeeMail;

	private String employeePhone;
	private String bloodGroup;
	private String dateOfBirth;
	private String dateOfJoining;
	private String emergencyContact;
	private String panNumber;
	private String currentAddress;
	private int supervisorId;
	
	public int getSupervisorId() {
		return supervisorId;
	}

	public void setSupervisorId(int supervisorId) {
		this.supervisorId = supervisorId;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getDateOfJoining() {
		return dateOfJoining;
	}

	public void setDateOfJoining(String dateOfJoining) {
		this.dateOfJoining = dateOfJoining;
	}

	public String getEmergencyContact() {
		return emergencyContact;
	}

	public void setEmergencyContact(String emergencyContact) {
		this.emergencyContact = emergencyContact;
	}

	public String getPanNumber() {
		return panNumber;
	}

	public void setPanNumber(String panNumber) {
		this.panNumber = panNumber;
	}

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmployeeMail() {
		return employeeMail;
	}

	public void setEmployeeMail(String employeeMail) {
		this.employeeMail = employeeMail;
	}

	public String getEmployeePhone() {
		return employeePhone;
	}

	public void setEmployeePhone(String employeePhone) {
		this.employeePhone = employeePhone;
	}

	public String getBloodGroup() {
		return bloodGroup;
	}

	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getUserProfileId() {
		return userProfileId;
	}

	public void setUserProfileId(int userProfileId) {
		this.userProfileId = userProfileId;
	}

	@Override
	public String toString() {
		return "UserProfile [userProfileId=" + userProfileId + ", userId=" + userId + ", employeeId=" + employeeId
				+ ", employeeName=" + employeeName + ", employeeMail=" + employeeMail + ", employeePhone="
				+ employeePhone + ", bloodGroup=" + bloodGroup + ", dateOfBirth=" + dateOfBirth + ", dateOfJoining="
				+ dateOfJoining + ", emergencyContact=" + emergencyContact + ", panNumber=" + panNumber
				+ ", currentAddress=" + currentAddress + "]";
	}

}

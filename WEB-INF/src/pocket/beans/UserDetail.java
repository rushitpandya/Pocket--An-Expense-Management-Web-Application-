package pocket.beans;

import java.util.Date;

public class UserDetail {


	private String firstName;
	private String lastName;
	private String emailId;
	private String password;
	private double expenseLimit;
	private String activationFlag;
	private String verificationToken;
	private String signupFlag;
	private String fbId;
	private String gmailId;
	private String profilePic;
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public double getExpenseLimit() {
		return expenseLimit;
	}
	public void setExpenseLimit(double expenseLimit) {
		this.expenseLimit = expenseLimit;
	}

	public String getActivationFlag() {
		return activationFlag;
	}
	public void setActivationFlag(String activationFlag) {
		this.activationFlag = activationFlag;
	}

	public String getVerificationToken() {
		return verificationToken;
	}
	public void setVerificationToken(String verificationToken) {
		this.verificationToken = verificationToken;
	}

	public String getFbId() {
		return fbId;
	}
	public void setFbId(String fbId) {
		this.fbId = fbId;
	}
	public String getGmailId() {
		return gmailId;
	}
	public void setGmailId(String gmailId) {
		this.gmailId = gmailId;
	}

	public String getProfilePic() {
		return profilePic;
	}
	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}
	public String getSignupFlag() {
		return signupFlag;
	}
	public void setSignupFlag(String signupFlag) {
		this.signupFlag = signupFlag;
	}		
	
}

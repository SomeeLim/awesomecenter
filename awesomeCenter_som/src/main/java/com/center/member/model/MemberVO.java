package com.center.member.model;

import java.util.Calendar;

public class MemberVO {
	
	String userno;
	String userid;
	String userpw;
	String username;
	String rrn1;
	String rrn2;
	String post;
	String addr1;
	String addr2;
	String hp1;
	String hp2;
	String hp3;
	String email;
	String marketing_sms;
	String marketing_email;
	String registerday;
	String editday;
	String lastloginday;
	String status;
	String withdrawalday;
	String fromwithdrawalday;
	String gender; 
	
	public String getUserno() {
		return userno;
	}
	public void setUserno(String userno) {
		this.userno = userno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getRrn1() {
		return rrn1;
	}
	public void setRrn1(String rrn1) {
		this.rrn1 = rrn1;
	}
	public String getRrn2() {
		return rrn2;
	}
	public void setRrn2(String rrn2) {
		this.rrn2 = rrn2;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getHp1() {
		return hp1;
	}
	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}
	public String getHp2() {
		return hp2;
	}
	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}
	public String getHp3() {
		return hp3;
	}
	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMarketing_sms() {
		return marketing_sms;
	}
	public void setMarketing_sms(String marketing_sms) {
		this.marketing_sms = marketing_sms;
	}
	public String getMarketing_email() {
		return marketing_email;
	}
	public void setMarketing_email(String marketing_email) {
		this.marketing_email = marketing_email;
	}
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	public String getEditday() {
		return editday;
	}
	public void setEditday(String editday) {
		this.editday = editday;
	}
	public String getLastloginday() {
		return lastloginday;
	}
	public void setLastloginday(String lastloginday) {
		this.lastloginday = lastloginday;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getWithdrawalday() {
		return withdrawalday;
	}
	public void setWithdrawalday(String withdrawalday) {
		this.withdrawalday = withdrawalday;
	}
	public String getRrn() {
		return rrn1+"-"+rrn2;
	}
	public String getAddr() {
		return addr1+" "+addr2;
	}
	public String getHp() {
		return hp1+"-"+hp2+"-"+hp3;
	}
	
	public String getFromwithdrawalday() {
		return fromwithdrawalday;
	}
	
	public void setFromwithdrawalday(String fromwithdrawalday) {
		this.fromwithdrawalday = fromwithdrawalday;
	}
	
	public String getGender() {
		return gender;
	}
	public void getGender(String gender) {
		this.gender = gender;
	}
	
	public String getBirthday() {
		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		String yearstr = String.valueOf(year);
		
		String birthyear = "";
		
		if( Integer.parseInt(yearstr.substring(2,4)) <= Integer.parseInt(rrn1.substring(0,2)) ) {
			birthyear = "19"+rrn1.substring(0,2);
		} else {
			birthyear = "20"+rrn1.substring(0,2);
		}
		
		String birthmm = rrn1.substring(2,4);
		String birthdd = rrn1.substring(4,6);
		
		return birthyear+"."+birthmm+"."+birthdd;
	}
}

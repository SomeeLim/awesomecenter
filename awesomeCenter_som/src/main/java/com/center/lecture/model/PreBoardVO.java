package com.center.lecture.model;

import org.springframework.web.multipart.MultipartFile;

public class PreBoardVO {
	
	private String preSeq;
	private String fk_class_seq;
	private String preTitle;
	private String preContent;
	private String preWriteDate;
	private String preCommentCount;
	private String preStatus;
	private String preFileName;
	private String preOrgFilename; 
	private String preFileSize;
	private String teacher_name;
	private String rno;
	
	private MultipartFile attach;
	
	public PreBoardVO() {}

	public PreBoardVO(String preSeq, String fk_class_seq, String preTitle, String preContent, String preWriteDate,
			String preCommentCount, String preStatus, String preFileName, String preOrgFilename, String preFileSize) {
		this.preSeq = preSeq;
		this.fk_class_seq = fk_class_seq;
		this.preTitle = preTitle;
		this.preContent = preContent;
		this.preWriteDate = preWriteDate;
		this.preCommentCount = preCommentCount;
		this.preStatus = preStatus;
		this.preFileName = preFileName;
		this.preOrgFilename = preOrgFilename;
		this.preFileSize = preFileSize;
	}

	public String getPreSeq() {
		return preSeq;
	}

	public void setPreSeq(String preSeq) {
		this.preSeq = preSeq;
	}

	public String getFk_class_seq() {
		return fk_class_seq;
	}

	public void setFk_class_seq(String fk_class_seq) {
		this.fk_class_seq = fk_class_seq;
	}

	public String getPreTitle() {
		return preTitle;
	}

	public void setPreTitle(String preTitle) {
		this.preTitle = preTitle;
	}

	public String getPreContent() {
		return preContent;
	}

	public void setPreContent(String preContent) {
		this.preContent = preContent;
	}

	public String getPreWriteDate() {
		return preWriteDate;
	}

	public void setPreWriteDate(String preWriteDate) {
		this.preWriteDate = preWriteDate;
	}

	public String getPreCommentCount() {
		return preCommentCount;
	}

	public void setPreCommentCount(String preCommentCount) {
		this.preCommentCount = preCommentCount;
	}

	public String getPreStatus() {
		return preStatus;
	}

	public void setPreStatus(String preStatus) {
		this.preStatus = preStatus;
	}

	public String getPreFileName() {
		return preFileName;
	}

	public void setPreFileName(String preFileName) {
		this.preFileName = preFileName;
	}

	public String getPreOrgFilename() {
		return preOrgFilename;
	}

	public void setPreOrgFilename(String preOrgFilename) {
		this.preOrgFilename = preOrgFilename;
	}

	public String getPreFileSize() {
		return preFileSize;
	}

	public void setPreFileSize(String preFileSize) {
		this.preFileSize = preFileSize;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}

	public String getRno() {
		return rno;
	}

	public void setRno(String rno) {
		this.rno = rno;
	}
	
	
	
	

}

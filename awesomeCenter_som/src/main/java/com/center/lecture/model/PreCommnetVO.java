package com.center.lecture.model;

public class PreCommnetVO {
	
	private String preComSeq;
	private String fk_class_seq;
	private String fk_preSeq;
	private String fk_USERNO;
	private String username;
	private String preComContent;
	private String preComWriteDate;
	private String preComStatus;
	private String preComGroupno;
	private String fk_preComseq;
	private String preComdepthno;
	private String preComSecret;
	private String orginuserno;
	
	public PreCommnetVO() {}

	public PreCommnetVO(String preComSeq, String fk_class_seq, String fk_preSeq, String fk_USERNO, String preComContent,
			String preComWriteDate, String preComStatus, String preComGroupno, String fk_preComseq,
			String preComdepthno, String preComSecret) {
		this.preComSeq = preComSeq;
		this.fk_class_seq = fk_class_seq;
		this.fk_preSeq = fk_preSeq;
		this.fk_USERNO = fk_USERNO;
		this.preComContent = preComContent;
		this.preComWriteDate = preComWriteDate;
		this.preComStatus = preComStatus;
		this.preComGroupno = preComGroupno;
		this.fk_preComseq = fk_preComseq;
		this.preComdepthno = preComdepthno;
		this.preComSecret = preComSecret;
	}

	public String getPreComSeq() {
		return preComSeq;
	}

	public void setPreComSeq(String preComSeq) {
		this.preComSeq = preComSeq;
	}

	public String getFk_class_seq() {
		return fk_class_seq;
	}

	public void setFk_class_seq(String fk_class_seq) {
		this.fk_class_seq = fk_class_seq;
	}

	public String getFk_preSeq() {
		return fk_preSeq;
	}

	public void setFk_preSeq(String fk_preSeq) {
		this.fk_preSeq = fk_preSeq;
	}

	public String getFk_USERNO() {
		return fk_USERNO;
	}

	public void setFk_USERNO(String fk_USERNO) {
		this.fk_USERNO = fk_USERNO;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPreComContent() {
		return preComContent;
	}

	public void setPreComContent(String preComContent) {
		this.preComContent = preComContent;
	}

	public String getPreComWriteDate() {
		return preComWriteDate;
	}

	public void setPreComWriteDate(String preComWriteDate) {
		this.preComWriteDate = preComWriteDate;
	}

	public String getPreComStatus() {
		return preComStatus;
	}

	public void setPreComStatus(String preComStatus) {
		this.preComStatus = preComStatus;
	}

	public String getPreComGroupno() {
		return preComGroupno;
	}

	public void setPreComGroupno(String preComGroupno) {
		this.preComGroupno = preComGroupno;
	}

	public String getFk_preComseq() {
		return fk_preComseq;
	}

	public void setFk_preComseq(String fk_preComseq) {
		this.fk_preComseq = fk_preComseq;
	}

	public String getPreComdepthno() {
		return preComdepthno;
	}

	public void setPreComdepthno(String preComdepthno) {
		this.preComdepthno = preComdepthno;
	}

	public String getPreComSecret() {
		return preComSecret;
	}

	public void setPreComSecret(String preComSecret) {
		this.preComSecret = preComSecret;
	}

	public String getOrginuserno() {
		return orginuserno;
	}

	public void setOrginuserno(String orginuserno) {
		this.orginuserno = orginuserno;
	}

	
	
	
}

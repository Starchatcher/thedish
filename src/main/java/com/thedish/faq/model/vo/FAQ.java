package com.thedish.faq.model.vo;

public class FAQ implements java.io.Serializable {
	private static final long serialVersionUID = -7042587165779330986L;

	//Field 
	private int faqId;			    //FAQ_ID
	private String question;			//QUESTION
	private String answer;			//ANSWER
	
	//Constructor
	public FAQ() {
		super();
	}

	public FAQ(int faqId, String question, String answer) {
		super();
		this.faqId = faqId;
		this.question = question;
		this.answer = answer;
	}

	//getters and setters
	public int getFaqId() {
		return faqId;
	}

	public void setFaqId(int faqId) {
		this.faqId = faqId;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Override
	public String toString() {
		return "FAQ [faqId=" + faqId + ", question=" + question + ", answer=" + answer + "]";
	}
	
}

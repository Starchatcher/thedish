package com.thedish.postFile.model.vo;


public class PostFile implements java.io.Serializable{
	private static final long serialVersionUID = 2130685481703690499L;
	
	private int fileId;
	private int targetId;
	private String targetType;
	private String originalFileName;
	private String storedFileName;
	
	public PostFile() {
		super();
	}

	public PostFile(int fileId, int targetId, String targetType, String originalFileName, String storedFileName) {
		super();
		this.fileId = fileId;
		this.targetId = targetId;
		this.targetType = targetType;
		this.originalFileName = originalFileName;
		this.storedFileName = storedFileName;
	}

	@Override
	public String toString() {
		return "PostFile [fileId=" + fileId + ", targetId=" + targetId + ", targetType=" + targetType
				+ ", originalFileName=" + originalFileName + ", storedFileName=" + storedFileName + "]";
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public int getTargetId() {
		return targetId;
	}

	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}

	public String getTargetType() {
		return targetType;
	}

	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getStoredFileName() {
		return storedFileName;
	}

	public void setStoredFileName(String storedFileName) {
		this.storedFileName = storedFileName;
	}
	
	
	
}

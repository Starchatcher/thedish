package com.thedish.image.vo;

public class Image {
    private int imageId;
    private int targetId;       // 연관된 레시피 ID 등
    private String targetType;   // 예: "recipe"
    private String  imageUrl;// private String imageUrl;  // URL 저장 필드: DB 저장 방식 변경 시 불필요하면 제거 가능
    private byte[] imageData;    // 이미지 바이트 배열 (BLOB 저장용)
    private String description;  // 이미지 설명
    private String imageType;
    
    
    public Image() {
        super();
    }

    public String getImageType() {
        return imageType;
    }

    public void setImageType(String imageType) {
        this.imageType = imageType;
    }

    public String getImageUrl() {
		return imageUrl;
	}



	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}



	public Image(int imageId, int targetId, String targetType, String imageUrl, byte[] imageData, String description) {
		super();
		this.imageId = imageId;
		this.targetId = targetId;
		this.targetType = targetType;
		this.imageUrl = imageUrl;
		this.imageData = imageData;
		this.description = description;
	}



	public int getImageId() {
        return imageId;
    }
    public void setImageId(int imageId) {
        this.imageId = imageId;
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

    public byte[] getImageData() {
        return imageData;
    }
    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Image [imageId=" + imageId + ", targetId=" + targetId 
            + ", targetType=" + targetType + ", imageData=" 
            + (imageData != null ? ("[size=" + imageData.length + "]") : "null")
            + ", description=" + description + "]";
    }
}

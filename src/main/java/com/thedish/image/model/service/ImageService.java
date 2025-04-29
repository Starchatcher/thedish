package com.thedish.image.model.service;

import com.thedish.image.model.vo.Image;

public interface ImageService {
	int insertImage(Image image);
	
	 Image selectImageById(int imageId);
	 
	 int deleteImageByTargetIdAndType(int targetId, String targetType);
}

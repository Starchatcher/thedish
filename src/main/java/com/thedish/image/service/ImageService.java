package com.thedish.image.service;

import com.thedish.image.vo.Image;

public interface ImageService {
	int insertImage(Image image);
	
	 Image selectImageById(int imageId);
	 
	 int deleteImageByTargetIdAndType(int targetId, String targetType);
}

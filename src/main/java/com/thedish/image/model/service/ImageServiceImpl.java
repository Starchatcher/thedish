package com.thedish.image.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.image.dao.ImageDao;
import com.thedish.image.model.vo.Image;

@Service("ImageService")
public class ImageServiceImpl implements ImageService {

	  @Autowired
	    private ImageDao imageDao;
	
	@Override
	public int insertImage(Image image) {
		
		return imageDao.insertImage(image);
	}

	@Override
	public Image selectImageById(int imageId) {
	    Image image = imageDao.selectImageById(imageId);
	    if (image == null) {
	        System.out.println("이미지 없음: imageId=" + imageId);
	    } else {
	        System.out.println("이미지 조회 성공: imageId=" + imageId + ", 데이터 크기=" 
	            + (image.getImageData() != null ? image.getImageData().length : "null"));
	    }
	    return image;
	}

	@Override
	public int deleteImageByTargetIdAndType(int targetId, String targetType) {		
		return imageDao.deleteImageByTargetIdAndType(targetId, targetType);
	}

	@Override
	public Image selectImageByTarget(int targetId, String targetType) {
		return imageDao.selectImageByTarget(targetId, targetType);
	}


}

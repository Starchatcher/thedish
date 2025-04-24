package com.thedish.image;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("ImageService")
public class ImageServiceImpl implements ImageService {

	  @Autowired
	    private ImageDao imageDao;
	
	@Override
	public int insertImage(Image image) {
		
		return imageDao.insertImage(image);
	}

}

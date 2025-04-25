package com.thedish.postFile.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.postFile.model.dao.PostFileDao;

@Service("PostFileService")
public class PostFileServiceImpl implements PostFileService{

	@Autowired
	private PostFileDao postFileDao;
}

package com.thedish.image.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.image.vo.Image;

@Repository("imageDao")
public class ImageDao {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
   
    public int insertImage(Image image) {
        return sqlSessionTemplate.insert("imageMapper.insertImage", image);
    }

    public Image selectImageById(int imageId) {
        return sqlSessionTemplate.selectOne("imageMapper.selectImageById", imageId);
    }
    public int deleteImageByTargetIdAndType(int targetId, String targetType) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("targetId", targetId);
        paramMap.put("targetType", targetType);
        return sqlSessionTemplate.delete("imageMapper.deleteImageByTargetIdAndType", paramMap);
    }


}

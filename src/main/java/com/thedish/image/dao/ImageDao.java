package com.thedish.image.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.image.model.vo.Image;

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

    public Image selectImageByTarget(int targetId, String targetType) {
        // 파라미터를 Map 또는 별도의 객체로 전달
        Map<String, Object> params = new HashMap<>();
        params.put("targetId", targetId);
        params.put("targetType", targetType);
        // MyBatis 매퍼 파일(imageMapper.xml)의 selectImageByTarget 쿼리 호출
        return sqlSessionTemplate.selectOne("imageMapper.selectImageByTarget", params);
    }
}

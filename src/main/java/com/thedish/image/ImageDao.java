package com.thedish.image;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("imageDao")
public class ImageDao {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
   
    public int insertImage(Image image) {
        return sqlSessionTemplate.insert("imageMapper.insertImage", image);
    }

    // 필요시 다른 메서드 추가 가능
}

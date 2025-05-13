package com.thedish.faq.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.faq.model.vo.FAQ;

@Repository("faqDao")
public class FAQDao {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public List<FAQ> selectFAQList() {
        return sqlSessionTemplate.selectList("faqMapper.selectFAQList");
    }

    public FAQ selectFAQ(int faqId) {
        return sqlSessionTemplate.selectOne("faqMapper.selectFAQ", faqId);
    }

    public int insertFAQ(FAQ faq) {
        return sqlSessionTemplate.insert("faqMapper.insertFAQ", faq);
    }

    public int updateFAQ(FAQ faq) {
        return sqlSessionTemplate.update("faqMapper.updateFAQ", faq);
    }

    public int deleteFAQ(int faqId) {
        return sqlSessionTemplate.delete("faqMapper.deleteFAQ", faqId);
    }
} 
package com.thedish.faq.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.faq.model.dao.FAQDao;
import com.thedish.faq.model.vo.FAQ;

@Service("FAQService")
public class FAQServiceImpl implements FAQService {

	    @Autowired
	    private FAQDao faqDao;

	    @Override
	    public List<FAQ> selectFAQList() {
	        return faqDao.selectFAQList();
	    }

	    @Override
	    public FAQ selectFAQ(int faqId) {
	        return faqDao.selectFAQ(faqId);
	    }

	    @Override
	    public int insertFAQ(FAQ faq) {
	        return faqDao.insertFAQ(faq);
	    }

	    @Override
	    public int updateFAQ(FAQ faq) {
	        return faqDao.updateFAQ(faq);
	    }

	    @Override
	    public int deleteFAQ(int faqId) {
	        return faqDao.deleteFAQ(faqId);
	    }
	}
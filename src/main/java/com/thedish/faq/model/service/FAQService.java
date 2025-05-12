package com.thedish.faq.model.service;

import java.util.List;

import com.thedish.faq.model.vo.FAQ;

public interface FAQService {
    List<FAQ> selectFAQList();
    FAQ selectFAQ(int faqId);
    int insertFAQ(FAQ faq);
    int updateFAQ(FAQ faq);
    int deleteFAQ(int faqId);
}

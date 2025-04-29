package com.thedish.faq.model.service;

import java.util.List;

import com.thedish.faq.model.vo.FAQ;

public interface FAQService {
	
	List<FAQ> selectFAQList();
}

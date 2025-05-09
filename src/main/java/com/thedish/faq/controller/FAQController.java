package com.thedish.faq.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.faq.model.service.FAQService;
import com.thedish.faq.model.vo.FAQ;

@Controller
public class FAQController {

	private static final Logger logger = LoggerFactory.getLogger(FAQController.class);
	
	@Autowired
	private FAQService faqService;
	
	@RequestMapping("FAQList.do")
	public ModelAndView faqListMethod(ModelAndView mv) {
		
		logger.info("FAQ 목록 페이지 요청"); // 로그 추가
		
		// 1. FAQ 목록 조회
		List<FAQ> faqList = faqService.selectFAQList();
		
		// 2. ModelAndView에 FAQ 목록 추가
		mv.addObject("faqList", faqList);
		
		// 3. View 이름 설정
		mv.setViewName("faq/FAQListView");
		
		logger.debug("조회된 FAQ 항목 수: " + faqList.size()); 
		
		// 4. ModelAndView 반환
		return mv;
	}
}

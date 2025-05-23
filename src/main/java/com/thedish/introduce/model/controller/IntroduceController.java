package com.thedish.introduce.model.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IntroduceController {
	
	private static final Logger logger = LoggerFactory.getLogger(IntroduceController.class);
	
	@RequestMapping("theDishIntroduce.do")
	public String moveIntroduceMethod() {
		return "introduce/introduce";
	}
}

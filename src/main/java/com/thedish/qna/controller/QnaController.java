package com.thedish.qna.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.qna.model.service.QnaService;
import com.thedish.qna.model.vo.Qna;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	// qna 작성 폼 내보내기용 메소드
	@RequestMapping("qnaWriteForm.do")
	public ModelAndView moveQnaWritePage(ModelAndView mv, HttpSession session) {
		Users loginUser = (Users) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			mv.setViewName("loginPage.do");
			return mv;
		}
		
		mv.setViewName("qna/qnaWriteForm");
		return mv;
	}
	
	// 내 문의 목록 출력 처리용 메소드
	@RequestMapping("qnaList.do")
	public ModelAndView selectListQnaMethod(ModelAndView mv,
			HttpSession session) {
	Users loginUser = (Users) session.getAttribute("loginUser");
	
	if(loginUser == null) {
		mv.setViewName("redirect:loginPage.do");	// 비회원은 로그인 페이지로 이동
		return mv;
	}
	String userId = loginUser.getUserId();
	List<Qna> qnaList = qnaService.selectQnaList(userId);
	
	mv.addObject("qnaList", qnaList);
	mv.setViewName("qna/qnaListView");
	
	return mv;
	
	}
}
